package controllers;


import java.util.ArrayList;
import java.util.List;

import play.libs.F.EventStream;
import play.libs.F.Matcher;
import play.mvc.Http.WebSocketEvent;
import play.mvc.Http.WebSocketFrame;
import play.mvc.Http;
import play.mvc.WebSocketController;

public class WebSocket extends WebSocketController {
	
	private static List<Http.Outbound> outboundConns = new ArrayList<Http.Outbound>();
	
	public static void listen() {
		System.out.println("Got connection");
		outboundConns.add(outbound);
		while (inbound.isOpen()) {
			try {
				WebSocketEvent event = await(inbound.nextEvent());
				if(event instanceof WebSocketFrame){
					WebSocketFrame frame = (WebSocketFrame) event;
					if(!frame.isBinary){
						publish(frame.textData);
					}
				}
			} catch (Exception e) {
			}
		}
		outboundConns.remove(outbound);
		System.out.println("Lost connection");
	}

	private static void publish(String textData) {
		System.out.println("Message: "+textData);
		for(Http.Outbound o : outboundConns){
			if(!o.equals(outbound))
				o.send(textData);
		}
	}
}
