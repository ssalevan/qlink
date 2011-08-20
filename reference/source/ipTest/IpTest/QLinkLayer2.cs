using System;
using System.Net;
using System.Net.Sockets;

namespace IpTest
{
	/// <summary>
	/// 
	/// </summary>
	public class QLinkLayer2
	{
		enum L2PacketType : byte
		{
			l2ptData          = 0x20,
			l2ptWindowFull    = 0x21,
			l2ptClearWindow   = 0x22,
			l2ptProtocolReset = 0x23,
			l2ptProtocolAck   = 0x24,
			l2ptTimeout       = 0x26,
		}

		const int L2HeaderOffset = 0;
		const int L2CRC1Offset = 1;
		const int L2CRC2Offset = 2;
		const int L2CRC3Offset = 3;
		const int L2CRC4Offset = 4;
		const int L2PacketNumOffset = 5;
		const int L2PacketAckOffset = 6;
		const int L2TypeOffset = 7;
		const int L2ParameterOffset = 8;
		const int L2PacketHeader = 0x5A;
		const int L2PacketFooter = 0x0D;

		private int nPacketLastSeen;
		private int nPacketLastSent;
		private NetworkStream clientStream;
		private int nClientVersionMajor;
		private int nClientVersionMinor;

		private UInt16 compute_CRC(Byte[] PacketDataBuf)
		{
			UInt16 nCalcCRC = 0;

			int nByteCounter;
			int nBitCounter;

			for (nByteCounter = L2PacketNumOffset; nByteCounter < PacketDataBuf.Length; nByteCounter++)
			{
				for (nBitCounter = 0; nBitCounter < 8; nBitCounter++) 
				{
					nCalcCRC ^= (UInt16)((PacketDataBuf[nByteCounter] & (1 << nBitCounter)) >> nBitCounter);
					if (1 == (nCalcCRC & 0x0001)) 
					{
						nCalcCRC >>= 1;
						nCalcCRC ^= 0xA001;
					} 
					else 
					{
						nCalcCRC >>= 1;
					}
				}
			}
			return nCalcCRC;
		}

		private void IncrementLastSent () 
		{
			nPacketLastSent++;
			if (nPacketLastSent > 0x7F) 
			{
				nPacketLastSent = 0x10;
			}
		}

		private void ResetPacketCounters ()
		{
			nPacketLastSeen = 0x7F;
			nPacketLastSent = 0x7F;
		}

		private void HandlePacketData (Byte[] Parameter) 
		{
			TokenParser myToken = new TokenParser(Parameter);
			if (myToken.sTokenName == "DD") 
			{
				Console.WriteLine("User account: {0}", myToken.GetStringToken(10));
				Console.WriteLine("PIN: {0}", myToken.GetAsciiIntToken(4));
				TokenParser outToken = new TokenParser();
				outToken.PutAsciiIntToken(1234, 4);
				Byte[] ToSend = outToken.DoParseOutput("D3");
				TransmitPacket(ToSend);
			} 
			else if (myToken.sTokenName == "SS")
			{
				TokenParser outToken = new TokenParser();
				Byte[] ToSend = outToken.DoParseOutput("SS");
				TransmitPacket(ToSend);
			}
			else if (myToken.sTokenName == "D6")
			{
				TokenParser outToken = new TokenParser();
				Byte[] ToSend = outToken.DoParseOutput("D1");
				TransmitPacket(ToSend);
			}
			else if (myToken.sTokenName == "D1")
			{
				TokenParser outToken = new TokenParser();
				outToken.PutStringToken("SCREENNAME", true);
				Byte[] ToSend = outToken.DoParseOutput("ZM");
				TransmitPacket(ToSend);
			}
			else if (myToken.sTokenName == "MR")
			{
				TokenParser outToken = new TokenParser();
				outToken.PutStringToken("Lobby", false);
				Byte[] ToSend = outToken.DoParseOutput("CM");
				TransmitPacket(ToSend);
				outToken = new TokenParser();
				outToken.PutStringToken("\x01SCREENNAME", false);
				ToSend = outToken.DoParseOutput("CE");
				TransmitPacket(ToSend);
			}
			else if (myToken.sTokenName == "cE")
			{
				TokenParser outToken = new TokenParser();
				outToken.PutStringToken("Auditorium", false);
				Byte[] ToSend = outToken.DoParseOutput("cZ");
				TransmitPacket(ToSend);
			}
			else if (myToken.sTokenName == "ZO")
			{
				TokenParser outToken = new TokenParser();
				outToken.PutStringToken("SCREENNAME", true);
				outToken.PutStringToken("Are you really cool?", false);
				Byte[] ToSend = outToken.DoParseOutput("ZT");
				TransmitPacket(ToSend);
				outToken = new TokenParser();
				outToken.PutStringToken("SCREENNAME", true);
				outToken.PutStringToken("Enter YES or NO.", false);
				ToSend = outToken.DoParseOutput("ZE");
				TransmitPacket(ToSend);
			}
			else if (myToken.sTokenName == "ZN")
			{
				TokenParser outToken = new TokenParser();
				Byte[] ToSend = outToken.DoParseOutput("DO");
				TransmitPacket(ToSend);
			}
			else if (myToken.sTokenName == "ZY")
			{
				TokenParser outToken = new TokenParser();
				Byte[] ToSend = outToken.DoParseOutput("DO");
				TransmitPacket(ToSend);
			}
			else if (myToken.sTokenName == "ZM")
			{
				TokenParser outToken = new TokenParser();
				Byte[] ToSend = outToken.DoParseOutput("DO");
				TransmitPacket(ToSend);
			}
			else if (myToken.sTokenName == "D2")
			{
				TokenParser outToken = new TokenParser();
				Byte[] ToSend = outToken.DoParseOutput("DO");
				TransmitPacket(ToSend);
			}
			else if (myToken.sTokenName == "ML")
			{
				TokenParser outToken = new TokenParser();
				Byte[] ToSend = outToken.DoParseOutput("MC");
				TransmitPacket(ToSend);
				outToken = new TokenParser();
				ToSend = outToken.DoParseOutput("EW");
				TransmitPacket(ToSend);
			}
		}

		private void HandleClientWindowFull () 
		{
			TransmitL2Packet(L2PacketType.l2ptClearWindow);
		}

		private void HandleProtocolReset (Byte[] Parameter) 
		{
			ResetPacketCounters();
			nClientVersionMajor = Parameter[0];
			nClientVersionMinor = Parameter[1];
			TransmitL2Packet(L2PacketType.l2ptProtocolAck);
		}

		private void HandleProtocolTimer () 
		{
			TransmitL2Packet(L2PacketType.l2ptProtocolAck);
		}

		private void TransmitL2Packet (L2PacketType PacketType) 
		{
			TransmitL2Packet(PacketType, new Byte[0]);
		}

		private void TransmitL2Packet (L2PacketType PacketType, Byte[] Parameter) 
		{
			Byte[] OutgoingPacket = new Byte[8 + Parameter.Length];

			OutgoingPacket[L2HeaderOffset] = L2PacketHeader;
			OutgoingPacket[L2PacketNumOffset] = (Byte)nPacketLastSent;
			OutgoingPacket[L2PacketAckOffset] = (Byte)nPacketLastSeen;
			OutgoingPacket[L2TypeOffset] = (Byte)PacketType;
			Parameter.CopyTo(OutgoingPacket, L2ParameterOffset);

			int nCalcCRC = compute_CRC(OutgoingPacket);
			OutgoingPacket[L2CRC1Offset] = (Byte)(((nCalcCRC >> 8) & 0xF0) | 0x01);
			OutgoingPacket[L2CRC2Offset] = (Byte)(((nCalcCRC >> 8) & 0x0F) | 0x40);
			OutgoingPacket[L2CRC3Offset] = (Byte)((nCalcCRC & 0xF0) | 0x01);
			OutgoingPacket[L2CRC4Offset] = (Byte)((nCalcCRC & 0x0F) | 0x40);

			Console.Write("Sending packet: ");
			for (Int32 i = 0; i < OutgoingPacket.Length; i++) 
			{
				Console.Write("{0,02:X} ",OutgoingPacket[i]); 
			}
			Console.WriteLine();

			clientStream.Write(OutgoingPacket, 0, OutgoingPacket.Length);
			clientStream.WriteByte(L2PacketFooter);
		}

		public void TransmitPacket(Byte[] Payload) 
		{
			IncrementLastSent();
			TransmitL2Packet(L2PacketType.l2ptData, Payload);
		}

		public void ProcessPacket(Byte[] NextPacket) 
		{
			Console.Write("Packet: ");
			for (Int32 i = 0; i < NextPacket.Length; i++) 
			{
				Console.Write("{0,02:X} ",NextPacket[i]); 
			}
			Console.WriteLine();
			UInt16 nPacketCRC = (UInt16)((((UInt16)(NextPacket[L2CRC1Offset] & 0xF0)) | ((UInt16)(NextPacket[L2CRC2Offset] & 0x0F))) << 8);
			nPacketCRC |= (UInt16)(((UInt16)(NextPacket[L2CRC3Offset] & 0xF0)) | ((UInt16)(NextPacket[L2CRC4Offset] & 0x0F)));
			UInt16 nCalcCRC = compute_CRC(NextPacket);
			if ((nPacketCRC != nCalcCRC) && (0 != nPacketCRC))
			{
				// Officially, this packet did NOT happen!
				Console.WriteLine("CRC error!  Got {0,04:X} and expected {1,04:X}", nCalcCRC, nPacketCRC);
				return;
			}

			nPacketLastSeen = NextPacket[L2PacketNumOffset]; // Keep track of the packet # we have seen

			L2PacketType CurrentPacketType = (L2PacketType)NextPacket[L2TypeOffset];
			Byte[] OutgoingParameter = new Byte[NextPacket.Length - L2ParameterOffset];
			Array.Copy(NextPacket, L2ParameterOffset, OutgoingParameter, 0, NextPacket.Length - L2ParameterOffset);

			switch (CurrentPacketType) 
			{
				case L2PacketType.l2ptData:
					HandlePacketData(OutgoingParameter);
					break;
				case L2PacketType.l2ptWindowFull:
					HandleClientWindowFull();
					break;
				case L2PacketType.l2ptProtocolReset:
					HandleProtocolReset(OutgoingParameter);
					break;
				case L2PacketType.l2ptTimeout:
					HandleProtocolTimer();
					break;
			}
		}

		public QLinkLayer2(NetworkStream InClientStream)
		{
			ResetPacketCounters();
			clientStream = InClientStream;
		}
	}
}
