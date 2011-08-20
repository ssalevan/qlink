using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace IpTest
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class IpServer
	{
		const Byte PacketHeader = 0x5A;
		const Byte PacketTrailer = 0x0D;

		static void HandleClient(NetworkStream clientStream) 
		{
			Byte[] clientBuffer = new Byte[256];

			clientBuffer = Encoding.ASCII.GetBytes("IDENTIFIER\xBA\xBA+");
			clientBuffer[10] = 0xBA;
			clientBuffer[11] = 0xBA;

			Int32 i;
			Int32 nextSpot = 0;
			clientStream.Write(clientBuffer, 0, 13);

			QLinkLayer2 pL2Handler = new QLinkLayer2(clientStream);

			clientBuffer = new Byte[256];

			try 
			{
				while((i = clientStream.Read(clientBuffer, nextSpot, 256 - nextSpot)) != 0) 
				{

					nextSpot += i;

					int FirstPacket = Array.IndexOf(clientBuffer, PacketHeader);
					if (FirstPacket	>= 0) 
					{
						// We found a packet
						int EndPacket = Array.IndexOf(clientBuffer, PacketTrailer, FirstPacket, nextSpot-FirstPacket);
						if (EndPacket >= 0) 
						{
							Byte[] packetBuffer = new Byte[EndPacket-FirstPacket];
							Array.Copy(clientBuffer, FirstPacket, packetBuffer, 0, EndPacket - FirstPacket); 
							pL2Handler.ProcessPacket(packetBuffer);
							nextSpot = nextSpot - EndPacket - 1;
							Array.Copy(clientBuffer, EndPacket + 1, clientBuffer, EndPacket, nextSpot);
						}
					} 
				}
			}
			catch (System.IO.IOException except) 
			{
				except = except;
				clientStream.Close();
			}
		}

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			Int32 serverPort = 8888;
			IPAddress serverAddr = IPAddress.Loopback;

			TcpListener serverListener = new TcpListener(serverAddr, serverPort);

			serverListener.Start();

			while (true) 
			{
				TcpClient client = serverListener.AcceptTcpClient();
				NetworkStream clientStream = client.GetStream();

				HandleClient(clientStream);
			}			
		}
	}
}
