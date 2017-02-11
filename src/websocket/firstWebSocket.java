package websocket;

import java.io.IOException;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 * 開啟http://localhost:8080/coreyou.servletAndJSP/webSocket/firstWebSocket.html測試
 * 
 * @author coreyou
 *
 */
@ServerEndpoint("/websocket")
public class firstWebSocket {
	@OnMessage
	public void onMessage(String message, Session session) throws IOException, InterruptedException {

		System.out.println("User input: " + message);

		session.getBasicRemote().sendText("Hello world Mr. " + message);

		// Sending message to client each 1 second
		for (int i = 0; i <= 10; i++) {

			session.getBasicRemote().sendText(i + " Message from server");

			Thread.sleep(1000);

		}

	}

	@OnOpen
	public void onOpen() {

		System.out.println("Client connected");

	}

	@OnClose
	public void onClose() {

		System.out.println("Connection closed");

	}
}
