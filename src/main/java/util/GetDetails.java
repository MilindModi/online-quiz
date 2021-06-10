package util;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/GetDetails")
public class GetDetails {
	private static Set<Session> userSessions = Collections.newSetFromMap(new ConcurrentHashMap<Session, Boolean>());

	@OnOpen
	public void onOpen(Session curSession) {
		userSessions.add(curSession);
	}

	@OnClose
	public void onClose(Session curSession) {
		userSessions.remove(curSession);
	}

	@OnMessage
	public void onMessage(String message, Session userSession) {
		int[] result = db.Database.getPerQuestionResult(message);
		String ans = result[0] + "," + result [1] ;

		

		for (Session ses : userSessions) {
			ses.getAsyncRemote().sendText(ans);
		}
	}
}