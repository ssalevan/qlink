import java.io.BufferedReader;
import java.io.FileReader;
import java.util.HashMap;

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
 Created on Oct 26, 2005
 
 */

class Seat {
	private int _iSeat;
	private String _sName;
	private Room _room;

	public Seat(int seat, String name, Room room) {
		_iSeat=seat;
		_sName=name;
		_room=room;
	}

	/**
	 * @return
	 */
	public int getSeat() {
		return _iSeat;
	}

	/**
	 * @return
	 */
	public Room getRoom() {
		return _room;
	}
}

class Room {

	private boolean _bPublic;
	private String _sName;

	/**
	 * @param public1
	 */
	public Room(boolean public1,String name) {
		_bPublic=public1;
		_sName=name;
	}

	/**
	 * @return
	 */
	public boolean isPublicRoom() {
		return _bPublic;
	}

	/**
	 * @return
	 */
	public String getName() {
		return _sName;
	}
	
}

public class ReadLog {
	
	private static HashMap _hex=new HashMap();
	private static HashMap _hmRooms=new HashMap();
	private static HashMap _hmUsers=new HashMap();
	private static boolean bPrint=true;
	
	
	static {
		_hex.put("01","0");
		_hex.put("02","1");
		_hex.put("03","2");
		_hex.put("04","3");
		_hex.put("05","4");
		_hex.put("06","5");
		_hex.put("07","6");
		_hex.put("08","7");
		_hex.put("09","8");
		_hex.put("0A","9");
		_hex.put("0B","10");
		_hex.put("0C","11");
		_hex.put("0E","12");
		_hex.put("0F","13");
		_hex.put("10","14");
		_hex.put("11","15");
		_hex.put("12","16");
		_hex.put("13","17");
		_hex.put("14","18");
		_hex.put("15","19");
		_hex.put("16","20");
		_hex.put("17","21");
		_hex.put("18","22");
		_hex.put("19","23");
		_hex.put("1A","24");
		_hex.put("1B","25");
		_hex.put("1C","26");
		_hex.put("1D","27");
		_hex.put("1E","28");
		_hex.put("1F","29");
	}
	public static void read(String file) throws Exception {
		BufferedReader b=new BufferedReader(new FileReader(file));
		String line;
		String date;
		String name=null;
		String handle=null;
		Boolean bool;
		String text;
		int seat;
		boolean bPublic=false;
		boolean bJoining=false;
		Room room;
		String handle1 = null;
		String name1 = null;
		boolean bPublic1 = false;
		boolean bValid;
		while((line=b.readLine())!=null) {
			if(line.length()>19) {
				bValid=true;
				date=line.substring(0,19);
				Seat user;
				if(line.indexOf("RoomDelegate  - Creating")>-1) {
					if(line.indexOf("public room")>-1) {
						bPublic=true;
					} else if(line.indexOf("private room")>-1) {
						bPublic=false;
					}
					name=line.substring(line.indexOf("room: ")+ 6);
					room=new Room(bPublic,name);
					_hmRooms.put(name,room);
					sql(true, name,bPublic,-1,"","CREATE","",date);
				} else if(line.indexOf("RoomDelegate  - Adding ")>-1) {
					handle1=line.substring(line.indexOf('\'')+1,line.lastIndexOf('\''));
					name1=line.substring(line.indexOf("room: ")+6);
					room=(Room)_hmRooms.get(name1);
					bPublic1=room.isPublicRoom();
					bJoining=true;
				} else if(bJoining && line.indexOf(" enters room in seat ")>-1) {
					seat=Integer.parseInt(line.substring(line.indexOf("seat ")+5));
					room=(Room)_hmRooms.get(name1);
					addUser(room,name1,bPublic1,seat,handle1,date);
					bJoining=false;
				} else if(bJoining && line.indexOf("Sending packet data: 5A ")>1 && line.indexOf(" 20 43 45")>-1) {
					if(date.equals("2005-09-26 23:37:49")) {
						int j=0;
					}
					int i = line.indexOf(" 20 43 45");
					seat=Integer.parseInt((String)_hex.get(line.substring(i+9,i+12).trim()));
					room=(Room)_hmRooms.get(name1);
					addUser(room,name1,bPublic1,seat,handle1,date);
					bJoining=false;
				} else if(line.indexOf("RoomDelegate  - Removing '")>-1) {
					handle=line.substring(line.indexOf('\'')+1,line.lastIndexOf('\''));
					name=line.substring(line.indexOf("room: ")+6);
					room=(Room)_hmRooms.get(name);
					user=(Seat)_hmUsers.get(handle);
					if(user==null) {
						warn("User: '" + handle + "' not found.");
						warn(line);
						sql(false, name,true,-1,handle,"LEAVE","",date);
						//System.exit(-1);
					} else {
						seat=user.getSeat();
						bPublic=room.isPublicRoom();
						sql(true, name,bPublic,seat,handle,"LEAVE","",date);
						if(user.getRoom() == room) {
							_hmUsers.remove(handle);
						}
					}
				} else if(line.indexOf("Chat  - Seat: ")>-1) {
					// ignore.
				} else if(((line.indexOf("Chat  - ")>-1) || (line.indexOf("AbstractChatState  - ")>-1)) && line.indexOf(" says: '")> -1) {
					name=null;
					// said something.
					handle=line.substring(line.indexOf("  - ")+4,line.indexOf(" says: \'"));
					text=line.substring(line.indexOf('\'')+1,line.lastIndexOf('\''));
					if(handle.indexOf('.')>-1) {
						name=handle.substring(0,handle.indexOf('.'));
						handle=handle.substring(handle.indexOf('.')+1);
					}
					if(handle.equals("")) {
					} else {
						if(handle.equals("System")) {
							seat=-1;
							name="";
							bPublic=true;
						} else {
							user=(Seat)_hmUsers.get(handle);
							if(user==null) {
								warn("User: '" + handle + "' not found.");
								warn(line);
								//System.exit(-1);
								seat=-1;
								bPublic=true;
								if(name==null)
									name="Lobby";
								bValid=false;
							} else {
								seat=user.getSeat();
								bPublic=user.getRoom().isPublicRoom();
								if(name!=null && !name.equals(user.getRoom().getName())) {
									warn("New naming convention, room name mismatch: " + name + "!=" + user.getRoom().getName());
								} else if(name==null){
									name=user.getRoom().getName();
								}
							}
						}
						if(text.startsWith("//me ")) {
							text="*" + handle + " " + text.substring(5);
							handle="";
							seat=-1;
						}
						if(name !=null && !text.startsWith("//msg"))
							sql(bValid, name,bPublic,seat,handle,"SAY",text,date);
					}
				} else if(line.indexOf("QLinkServer  - Starting server")>-1) {
					_hmUsers.clear();
					_hmRooms.clear();
				} else {
				//System.out.println(date + ":" + line);
				}
			}
			
		}
		b.close();
	}

	/**
	 * @param b
	 * @param name
	 * @param public1
	 * @param seat
	 * @param handle
	 * @param string
	 * @param text
	 * @param date
	 */
	private static void sql(boolean b, String name, boolean bPublic, int seat, String handle, String string, String text, String date) {
		if(bPrint && !text.startsWith("//")) {
			if(!b) {
				System.out.println("# The next line may have issues");
			}
			System.out.println("INSERT INTO room_log (room, public_ind, seat, handle, action, text, timestamp) VALUES ('" + name + "','" + (bPublic?"Y":"N") + "'," + seat + ",'" + handle + "','" + string + "','" + text.replaceAll("\'","\\\\'") + "','" + date + "');");
		}
	}

	/**
	 * @param name1
	 * @param public1
	 * @param seat
	 * @param handle1
	 * @param date
	 */
	private static void addUser(Room room, String name1, boolean bPublic1, int seat, String handle1, String date) {
		sql(true, name1,bPublic1,seat,handle1,"JOIN","",date);
		_hmUsers.put(handle1,new Seat(seat,handle1,room));
	}

	/**
	 * @param string
	 */
	private static void warn(String string) {
		System.err.println(string);
		
	}

	public static void main(String[] args) throws Exception {
		read("qlink.log.2005-09-15");
		read("qlink.log.2005-09-16");
		read("qlink.log.2005-09-17");
		read("qlink.log.2005-09-18");
		read("qlink.log.2005-09-19");
		read("qlink.log.2005-09-20");
		read("qlink.log.2005-09-21");
		read("qlink.log.2005-09-22");
		read("qlink.log.2005-09-23");
		read("qlink.log.2005-09-24");
		read("qlink.log.2005-09-25");
		read("qlink.log.2005-09-26");
		read("qlink.log.2005-09-27");
		read("qlink.log.2005-09-28");
		read("qlink.log.2005-09-29");
		read("qlink.log.2005-09-30");
		read("qlink.log.2005-10-01");
		read("qlink.log.2005-10-02");
		read("qlink.log.2005-10-03");
		read("qlink.log.2005-10-04");
		read("qlink.log.2005-10-05");
		read("qlink.log.2005-10-06");
		read("qlink.log.2005-10-07");
		read("qlink.log.2005-10-08");
		read("qlink.log.2005-10-09");
		read("qlink.log.2005-10-10");
		read("qlink.log.2005-10-11");
		read("qlink.log.2005-10-12");
		read("qlink.log.2005-10-13");
		read("qlink.log.2005-10-14");
		read("qlink.log.2005-10-15");
		read("qlink.log.2005-10-16");
		read("qlink.log.2005-10-17");
		read("qlink.log.2005-10-18");
		read("qlink.log.2005-10-19");
		read("qlink.log.2005-10-20");
		read("qlink.log.2005-10-21");
		read("qlink.log.2005-10-22");
		read("qlink.log.2005-10-23");
		read("qlink.log.2005-10-24");
		read("qlink.log.2005-10-25");
		read("qlink.log.2005-10-26");
		read("qlink.log");
	}
}
