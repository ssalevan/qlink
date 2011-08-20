import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;

class Menu {
	static int id=4000;
	private String _name;
	private ArrayList _l=new ArrayList();
	private int _iIndent;

	public Menu(String name, int indent) {
		_name=name;
		_iIndent=indent;
	}
	
	public void add(Menu m) {
		_l.add(m);
	}
	
	/**
	 * @return
	 */
	public int getIndent() {
		return _iIndent;
	}
	
	private String pad(int i) {
		return "                 ".substring(0,i+1);
	}
	
	public String toString() {
		return toString(0);
	}
	
	public String toString(int level) {
		StringBuffer sb=new StringBuffer();
		sb.append(pad(level));
		sb.append(_name);
		sb.append(" (");
		sb.append(_iIndent);
		sb.append(")\n");
		for(int i=0;i<_l.size();i++)
			sb.append(((Menu)_l.get(i)).toString(level+1));
		return sb.toString();
	}
	
	public String getSQL(int parent) {
		int u=id++;
		StringBuffer sb=new StringBuffer();
		sb.append("INSERT INTO toc (menu_id,reference_id,title,sort_order,active) VALUES (");
		sb.append(parent);
		sb.append(",");
		sb.append(u);
		sb.append(",'");
		sb.append(_name.replaceAll("'","\\\\'"));
		sb.append("',1,'Y');\n");
		sb.append("INSERT INTO entry_types (reference_id,cost,entry_type) VALUES (");
		sb.append(u);
		sb.append(",'NORMAL',129);\n");
		for(int i=0;i<_l.size();i++)
			sb.append(((Menu)_l.get(i)).getSQL(u));
		return sb.toString();
	}
	
}

public class ImportMenus {
	public static Connection getDBConnection() throws SQLException {
		
	    	return DriverManager.getConnection("jdbc:mysql://localhost/clink?user=clinkuser&password=clink");
		}

	public static void main(String[] args) throws Exception {
		
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(args[0])));
			Menu.id=Integer.parseInt(args[1]);
			StringBuffer sb=new StringBuffer();
			int mid;
			String line;
			int pos;
			
			Menu m=new Menu("root",-1);
			
			readMenus(br,m);
			
			br.close();
			
			int i=0;
			System.out.println(m.toString());

			System.out.println(m.getSQL(4));

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * @param br
	 * @throws IOException
	 */
	private static Menu readMenus(BufferedReader br, Menu m) throws IOException {
		String line;
		int pos;
		
		while((line=br.readLine())!=null) {
			//System.out.println("Handling: " + line);
			
			for(pos=0;pos<line.length() && line.charAt(pos)==' ';pos++);
			Menu m2=new Menu(line.trim(),pos);
			if(pos>m.getIndent()) {
				// submenu, add to me
				do {
					m.add(m2);
					m2=readMenus(br,m2);
				} while(m2 != null && m2.getIndent()>m.getIndent());
				return m2;
			} else {
				return m2;
			}
		}
		return null;
	}

} 