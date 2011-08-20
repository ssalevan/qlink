using System;
using System.Collections;
using System.Text;

namespace IpTest
{
	/// <summary>
	/// 
	/// </summary>
	public class TokenParser
	{
		private Byte[] CurrentParameter;
		private Int32 nParameterPointer;
		private string TokenName;

		public string GetStringToken(Int32 nMaxLength) 
		{
			Int32 nCurrentCharacter;
			StringBuilder sTemporaryString = new StringBuilder(0);

			for (nCurrentCharacter = 0; nCurrentCharacter < nMaxLength; nCurrentCharacter++) 
			{
				if (nParameterPointer >= CurrentParameter.Length) 
				{
					return sTemporaryString.ToString();
				}
				if (0x90 == CurrentParameter[nParameterPointer]) 
				{
					nParameterPointer++;
					return sTemporaryString.ToString();
				}
				sTemporaryString.Append((char)CurrentParameter[nParameterPointer]);
				nParameterPointer++;
			}
			return sTemporaryString.ToString();
		}

		public void PutStringToken(string sOutputString, bool bTerminated) 
		{
			ASCIIEncoding enc = new ASCIIEncoding();
			enc.GetBytes(sOutputString, 0, sOutputString.Length, CurrentParameter, nParameterPointer);
			nParameterPointer += sOutputString.Length;
			if (bTerminated) 
			{
				CurrentParameter[nParameterPointer] = 0x90;
				nParameterPointer++;
			}
		}

		public Int32 GetAsciiIntToken(Int32 nEncodedLength) 
		{
			Int32 nCurrentCharacter;
			Int32 nTempValue = 0;

			for (nCurrentCharacter = 0; nCurrentCharacter < nEncodedLength; nCurrentCharacter++) 
			{
				nTempValue = (nTempValue * 10) + (CurrentParameter[nParameterPointer] - 0x30);
				nParameterPointer++;
			}
			return nTempValue;
		}

		public void PutAsciiIntToken(Int32 nValue, Int32 nEncodedLength) 
		{
			string sTempString = String.Format("{0:D"+nEncodedLength+"}", nValue);
			ASCIIEncoding enc = new ASCIIEncoding();
			enc.GetBytes(sTempString, 0, sTempString.Length, CurrentParameter, nParameterPointer);
			nParameterPointer += nEncodedLength;
		}

		public Byte[] DoParseOutput(string sNewTokenName) 
		{
			Byte[] bOutputBuffer;

			ASCIIEncoding enc = new ASCIIEncoding();
			enc.GetBytes(sNewTokenName, 0, 2, CurrentParameter, 0);

			bOutputBuffer = new Byte[nParameterPointer];
			Array.Copy(CurrentParameter, 0, bOutputBuffer, 0, nParameterPointer);
			return bOutputBuffer;
		}

		public TokenParser(Byte[] TokenParameter)
		{
			CurrentParameter = new Byte[TokenParameter.Length];
			TokenParameter.CopyTo(CurrentParameter, 0);

			ASCIIEncoding enc = new ASCIIEncoding();
			TokenName = enc.GetString(CurrentParameter, 0, 2);

			nParameterPointer = 2;
		}

		public TokenParser()
		{
			CurrentParameter = new Byte[128];
			nParameterPointer = 2;
		}

		public string sTokenName
		{
			get
			{
				return TokenName;
			}
		}
	}
}
