import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class TestServer {
	static String cr=new StringBuffer().append((char)0x7f).toString();
	static String cr0=new StringBuffer().append((char)0xff).toString();

	protected static int decode(byte[] data,int pos) {
		int i=(data[pos++]&0x3f)<<18;
		i|=(data[pos++]&0x3f)<<12;
		i|=(data[pos++]&0x3f)<<6;
		i|=(data[pos++]&0x3f);
		return i;
	}
	private static String _hex="0123456789ABCDEF";

	static String makeHex(int j) {
		StringBuffer sb=new StringBuffer();
		int d;
		for(int i=3;i>-1;i--) {
			d=(j>>(i*8))&0xff;
			sb.append(_hex.charAt((d>>4)&0x0f));
			sb.append(_hex.charAt(d&0x0f));
		}
		return sb.toString();
	}

	public static Connection getDBConnection() throws SQLException {
		
	    	return DriverManager.getConnection("jdbc:mysql://localhost/clink?user=clinkuser&password=clink");
		}

	private static void saveMenuItem(String string, int id, int i, int j) throws Exception {
        Connection conn;
        Statement stmt = null;
        ResultSet rs = null;
        int rc=-1;
        String cost="NORMAL";
        
        switch(i) {
        	case 0:
        		cost="NOCHARGE";
        		break;
        	case 1:
        		cost="PREMIUM";
        		break;
        }
        if(i==1 && string.endsWith("(+)"))
        	string=string.substring(0,string.length()-4);
        if(string.startsWith("    "))
        	string=string.trim();
        else
        	j=0;
    	conn=getDBConnection();
        stmt = conn.createStatement();
        //rs=stmt.executeQuery("SELECT reference_id from toc where reference_id=" + id + " AND type = " + j + " AND code = '" + cost + "' and title='" + string + "'");
        String q="INSERT into toc (reference_id,menu_id, type,cost,title,sort_order,active) VALUES (" + id + ",0," + j + ",'" + cost + "','" + string.replaceAll("'","\\\\'") + "',1,'Y')";
        System.out.println(q + ";");
        try {
            //if(!rs.next())
            	stmt.execute(q);
	        	if(stmt.getUpdateCount()==0) {
	        		System.err.println("DB Error");
	        	}
        } catch (Exception e) {
        	if(e.getMessage().startsWith("Duplicate")) {
        		System.err.println("Cannot insert: " + string);
        	}
        }
	    stmt.close();
	}
	public static void saveArticle(String text, int prev, int next, int id) throws Exception {
        Connection conn;
        Statement stmt = null;
        ResultSet rs = null;
        int rc=-1;
        
    	conn=getDBConnection();
        stmt = conn.createStatement();
        String q="INSERT into articles (article_id,next_id,prev_id,data) VALUES (" + id + "," + next + "," + prev + ",'" + text.replaceAll("'","\\\\'") + "')";
        //System.out.println(q);
        try {
        	stmt.execute(q);
        	if(stmt.getUpdateCount()==0) {
        		System.err.println("DB Error");
        	}
        } catch (Exception e) {
        	if(e.getMessage().startsWith("Duplicate")) {
        		System.err.println("Cannot insert: " + text);
        	}
        }
	    stmt.close();
	}
	
	public static void main(String[] args) throws Exception {
		
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(args[0])));
			StringBuffer sb=new StringBuffer();
			StringBuffer sb1=new StringBuffer();
			StringBuffer sbMenu=new StringBuffer();
			StringBuffer sbRefs=new StringBuffer();
			String line;
			String a;
			int id=0,prev=0,next=0,b1,b2,b3;
			byte b[];
			while((line=br.readLine())!=null) {
				b=line.getBytes();
				if(line.length()>=8) {
					if(line.charAt(7)==0x20) {
						a=line.substring(8,10);
						if(a.equals("KD") || a.equals("KM")) {
							sb.append(line.substring(10));
						} else if(a.equals("KE")) {
							sb.append(line.substring(10));
							//saveArticle(sb.toString().replaceAll(cr,"\n"),prev,next,id);
							save("Text (" + makeHex(id) + ")", sb1.toString() + sb.toString().replaceAll(cr,"\n"));
							prev=0;
							next=0;
							id=0;
							sb.setLength(0);
							sb1.setLength(0);
						} else if(a.equals("D3")) {
							// ignore
						} else if(a.equals("SS")) {
							// ignore
						} else if(a.equals("OT")) {
							save("SYSOLM",line.substring(10));
							// ignore
						} else if(a.equals("MC")) {
							// ignore
						} else if(a.equals("KC")) {
							prev=decode(b,10);
							sb1.append(makeHex(prev));
							sb1.append(", ");
							next=decode(b,14);
							sb1.append(makeHex(next));
							sb1.append(", ");
							sb1.append(makeHex(decode(b,18)));
							sb1.append(", ");
							sb1.append(makeHex(decode(b,22)));
							sb1.append(", ");
							sb1.append(makeHex(decode(b,26)));
							id=decode(b,26);
							sb1.append("\n");
							sb1.append(decode(b,10));
							sb1.append(", ");
							sb1.append(decode(b,14));
							sb1.append(", ");
							sb1.append(decode(b,18));
							sb1.append(", ");
							sb1.append(decode(b,22));
							sb1.append(", ");
							sb1.append(decode(b,26));
							sb1.append("\n-------------------------\n");
							sbRefs.append(makeHex(decode(b,10)));
							sbRefs.append(", ");
							sbRefs.append(makeHex(decode(b,14)));
							sbRefs.append(", ");
							sbRefs.append(makeHex(decode(b,18)));
							sbRefs.append(", ");
							sbRefs.append(makeHex(decode(b,22)));
							sbRefs.append(", ");
							sbRefs.append(makeHex(decode(b,26)));
							sbRefs.append("\n");
						} else if(a.equals("SM") || a.equals("SE")) {
							sb.append(line.substring(10));
							sb.append("\n(end of packet)\n");
							if(a.equals("SE")) {
								save("Bulletin",sb.toString().replaceAll(cr0,"\n"));
								sb.setLength(0);
							}
						} else if(a.equals("KB") || a.equals("KA")) {
							id=decode(b,11);
							b3=decode(b,15);
							//b1=(b3& 0xff0000)>>16;
							//b2=(b3& 0xff00)>>8;
							//b1=(b3& 0xff);
							sbMenu.append("Item ID=" + makeHex(id) + "," + makeHex(b3));
							if(line.length()>19) {
								sbMenu.append("," + line.substring(20));
								saveMenuItem(line.substring(20),id,(b3&3),((b3>>16)&0xff));
							}
							sbMenu.append("\n");
							if(a.equals("KB")) {
								sbMenu.append("--------------\n");
								//save("Menu",sb.toString());
							}
						} else {
							System.out.println(a + ", " + line);
						}
					}
				} else {
					System.out.println(line + " is not a valid packet");
				}
			}
			save("Menu",sbMenu.toString());
			save("References",sbRefs.toString());
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	static int file=0;
	private static void save(String pre, String string) {
		String name="QLink " + pre + " "+ Integer.toString(file++);
		System.out.println("Saving: " + name);
		try {
			FileOutputStream o=new FileOutputStream(name);
			o.write(string.getBytes());
			o.flush();
			o.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
} 