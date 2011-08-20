import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;

/*
 Copyright Jim Brain and Brain Innovations, 2005.

 This file is part of QLinkServer.

 QLinkServer is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

 QLinkServer is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with QLinkServer; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

 @author Jim Brain
 Created on Sep 25, 2005
 
 */

public class Test {
	public static Connection getDBConnection() throws SQLException {
		
	    	return DriverManager.getConnection("jdbc:mysql://localhost/clink?user=clinkuser&password=clink");
		}

	public static void main(String args[]) throws Exception {
		ArrayList a=new ArrayList(5);
		a.add(3,new Test());
		System.out.println(a.get(0));
        /*Connection conn;
        Statement stmt = null;
        ResultSet rs = null;
		Class.forName("com.mysql.jdbc.Driver").newInstance();
        
    	conn=getDBConnection();
        stmt = conn.createStatement();
        try {
        	stmt.execute("insert into accounts_fix (account_id) VALUES (5)",Statement.RETURN_GENERATED_KEYS);
        } catch (Exception e) {
        	e.printStackTrace();
        }*/
	}
}
