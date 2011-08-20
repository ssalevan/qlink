/*
	Copyright Jim Brain and Brain Innovations, 2005.

	This file is part of QLinkServer.

	QLink is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	QLink is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with QLink; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

	@author Jim Brain
	Created on Jul 18, 2005
	
 */
package org.jbrain.qlink.cmd.action;

import org.jbrain.qlink.cmd.CRCException;
import org.jbrain.qlink.cmd.Command;

public class ActionFactory {
	public ActionFactory() {
	}
	public Command newInstance(byte[] b, int start, int len) throws CRCException {
		if(len<10) {
			return null;
		}
		String action=new String(b,start+8,2);
		if(action.equals(Login.MNEMONIC)) {
			return new Login(b,start,len);
		}
		if(action.equals(UpdatedCode.MNEMONIC)) {
			return new UpdatedCode(b,start,len);
		}
		if(action.equals(SuspendServiceAck.MNEMONIC)) {
			return new SuspendServiceAck(b,start,len);
		}
		if(action.equals(EnterMessageBoard.MNEMONIC)) {
			return new EnterMessageBoard(b,start,len);
		}
		if(action.equals(SelectMenuItem.MNEMONIC)) {
			return new SelectMenuItem(b,start,len);
		}
		if(action.equals(EnterChat.MNEMONIC)) {
			return new EnterChat(b,start,len);
		}
		if(action.equals(ChatSay.MNEMONIC)) {
			return new ChatSay(b,start,len);
		}
		if(action.equals(ListRooms.MNEMONIC)) {
			return new ListRooms(b,start,len);
		}
		if(action.equals(EnterPublicRoom.MNEMONIC)) {
			return new EnterPublicRoom(b,start,len);
		}
		if(action.equals(EnterPrivateRoom.MNEMONIC)) {
			return new EnterPrivateRoom(b,start,len);
		}
		if(action.equals(ClearScreen.MNEMONIC)) {
			return new ClearScreen(b,start,len);
		}
		if(action.equals(DialogAllocated.MNEMONIC)) {
			return new DialogAllocated(b,start,len);
		}
		if(action.equals(ZA.MNEMONIC)) {
			return new ZA(b,start,len);
		}
		if(action.equals(D2.MNEMONIC)) {
			return new D2(b,start,len);
		}
		if(action.equals(Logoff.MNEMONIC)) {
			return new Logoff(b,start,len);
		}
		if(action.equals(IdentifyUser.MNEMONIC)) {
			return new IdentifyUser(b,start,len);
		}
		if(action.equals(LeaveChat.MNEMONIC)) {
			return new LeaveChat(b,start,len);
		}
		if(action.equals(SelectList.MNEMONIC)) {
			return new SelectList(b,start,len);
		}
		if(action.equals(ResumeService.MNEMONIC)) {
			return new ResumeService(b,start,len);
		}
		if(action.equals(IgnoreUser.MNEMONIC)) {
			return new IgnoreUser(b,start,len);
		}
		if(action.equals(DeIgnoreUser.MNEMONIC)) {
			return new DeIgnoreUser(b,start,len);
		}
		if(action.equals(SendEmail.MNEMONIC)) {
			return new SendEmail(b,start,len);
		}
		if(action.equals(EmailNextLine.MNEMONIC)) {
			return new EmailNextLine(b,start,len);
		}
		if(action.equals(EmailLastLine.MNEMONIC)) {
			return new EmailLastLine(b,start,len);
		}
		if(action.equals(QuestionNextLine.MNEMONIC)) {
			return new QuestionNextLine(b,start,len);
		}
		if(action.equals(QuestionLastLine.MNEMONIC)) {
			return new QuestionLastLine(b,start,len);
		}
		if(action.equals(ReadEmail.MNEMONIC)) {
			return new ReadEmail(b,start,len);
		}
		if(action.equals(EmailCanceled.MNEMONIC)) {
			return new EmailCanceled(b,start,len);
		}
		if(action.equals(SendOLM.MNEMONIC)) {
			return new SendOLM(b,start,len);
		}
		if(action.equals(OM.MNEMONIC)) {
			return new OM(b,start,len);
		}
		if(action.equals(OE.MNEMONIC)) {
			return new OE(b,start,len);
		}
		if(action.equals(EnterAuditorium.MNEMONIC)) {
			return new EnterAuditorium(b,start,len);
		}
		if(action.equals(EnterBoxOffice.MNEMONIC)) {
			return new EnterBoxOffice(b,start,len);
		}
		if(action.equals(SendOLM.MNEMONIC)) {
			return new SendOLM(b,start,len);
		}
		if(action.equals(ReadOLM.MNEMONIC)) {
			return new ReadOLM(b,start,len);
		}
		if(action.equals(OLMCancelled.MNEMONIC)) {
			return new OLMCancelled(b,start,len);
		}
		if(action.equals(EventInfo.MNEMONIC)) {
			return new EventInfo(b,start,len);
		}
		if(action.equals(GatewayRecv.MNEMONIC)) {
			return new GatewayRecv(b,start,len);
		}
		if(action.equals(GatewayMoreAck.MNEMONIC)) {
			return new GatewayMoreAck(b,start,len);
		}
		if(action.equals(GatewayDisconnect.MNEMONIC)) {
			return new GatewayDisconnect(b,start,len);
		}
		if(action.equals(LocateUser.MNEMONIC)) {
			return new LocateUser(b,start,len);
		}
		if(action.equals(FileTextAck.MNEMONIC)) {
			return new FileTextAck(b,start,len);
		}
		if(action.equals(RequestItemPost.MNEMONIC)) {
			return new RequestItemPost(b,start,len);
		}
		if(action.equals(AbortPosting.MNEMONIC)) {
			return new AbortPosting(b,start,len);
		}
		if(action.equals(NextPostingLine.MNEMONIC)) {
			return new NextPostingLine(b,start,len);
		}
		if(action.equals(LastPostingLine.MNEMONIC)) {
			return new LastPostingLine(b,start,len);
		}
		if(action.equals(ListMoreRooms.MNEMONIC)) {
			return new ListMoreRooms(b,start,len);
		}
		if(action.equals(SelectMoreList.MNEMONIC)) {
			return new SelectMoreList(b,start,len);
		}
		if(action.equals(ListSearch.MNEMONIC)) {
			return new ListSearch(b,start,len);
		}
		if(action.equals(SelectDateReply.MNEMONIC)) {
			return new SelectDateReply(b,start,len);
		}
		if(action.equals(DownloadFile.MNEMONIC)) {
			return new DownloadFile(b,start,len);
		}
		if(action.equals(StartDownload.MNEMONIC)) {
			return new StartDownload(b,start,len);
		}
		if(action.equals(RequestGame.MNEMONIC)) {
			return new RequestGame(b,start,len);
		}
		if(action.equals(GameNextPlayer.MNEMONIC)) {
			return new GameNextPlayer(b,start,len);
		}
		if(action.equals(GameLastPlayer.MNEMONIC)) {
			return new GameLastPlayer(b,start,len);
		}
		if(action.equals(RequestGameStart.MNEMONIC)) {
			return new RequestGameStart(b,start,len);
		}
		if(action.equals(AcceptInvite.MNEMONIC)) {
			return new AcceptInvite(b,start,len);
		}
		if(action.equals(DeclineInvite.MNEMONIC)) {
			return new DeclineInvite(b,start,len);
		}
		if(action.equals(ChatDialogAllocated.MNEMONIC)) {
			return new ChatDialogAllocated(b,start,len);
		}
		if(action.equals(ChatDialogYes.MNEMONIC)) {
			return new ChatDialogYes(b,start,len);
		}
		if(action.equals(InvalidGameID.MNEMONIC)) {
			return new InvalidGameID(b,start,len);
		}
		if(action.equals(RequestGameRestart.MNEMONIC)) {
			return new RequestGameRestart(b,start,len);
		}
		if(action.equals(GameMove.MNEMONIC)) {
			return new GameMove(b,start,len);
		}
		if(action.equals(AcceptRestart.MNEMONIC)) {
			return new AcceptRestart(b,start,len);
		}
		if(action.equals(ListGames.MNEMONIC)) {
			return new ListGames(b,start,len);
		}
		if(action.equals(RequestToObserve.MNEMONIC)) {
			return new RequestToObserve(b,start,len);
		}
		if(action.equals(RestartGameAck.MNEMONIC)) {
			return new RestartGameAck(b,start,len);
		}
		if(action.equals(LeaveGame.MNEMONIC)) {
			return new LeaveGame(b,start,len);
		}
		if(action.equals(DeclineRestart.MNEMONIC)) {
			return new DeclineRestart(b,start,len);
		}
		if(action.equals(FindPartners.MNEMONIC)) {
			return new FindPartners(b,start,len);
		}
		if(action.equals(IncludeMe.MNEMONIC)) {
			return new IncludeMe(b,start,len);
		}
		if(action.equals(ExcludeMe.MNEMONIC)) {
			return new ExcludeMe(b,start,len);
		}
		if(action.equals(CancelPartnerSearch.MNEMONIC)) {
			return new CancelPartnerSearch(b,start,len);
		}
		if(action.equals(PartnerSearchStatusRequest.MNEMONIC)) {
			return new PartnerSearchStatusRequest(b,start,len);
		}
		if(action.equals(SelectPartner.MNEMONIC)) {
			return new SelectPartner(b,start,len);
		}
		if(action.equals(FindMorePartners.MNEMONIC)) {
			return new FindMorePartners(b,start,len);
		}
		if(action.equals(PlayBackMovesAck.MNEMONIC)) {
			return new PlayBackMovesAck(b,start,len);
		}
		if(action.equals(MakeReservation.MNEMONIC)) {
			return new MakeReservation(b,start,len);
		}
		if(action.equals(CancelReservation.MNEMONIC)) {
			return new CancelReservation(b,start,len);
		}
		if(action.equals(DialogYes.MNEMONIC)) {
			return new DialogYes(b,start,len);
		}
		if(action.equals(DialogNo.MNEMONIC)) {
			return new DialogNo(b,start,len);
		}
		if(action.equals(DialogCancel.MNEMONIC)) {
			return new DialogCancel(b,start,len);
		}
		if(action.equals(DeleteAccountInSlotAck.MNEMONIC)) {
			return new DeleteAccountInSlotAck(b,start,len);
		}
		if(action.equals(EnterSuperChat.MNEMONIC)) {
			return new EnterSuperChat(b,start,len);
		}
		if(action.equals(ExtIdentifyUser.MNEMONIC)) {
			return new ExtIdentifyUser(b,start,len);
		}
		if(action.equals(SelectFileDocumentation.MNEMONIC)) {
			return new SelectFileDocumentation(b,start,len);
		}
		
		return new UnknownAction(b,start,len);
	}
}
