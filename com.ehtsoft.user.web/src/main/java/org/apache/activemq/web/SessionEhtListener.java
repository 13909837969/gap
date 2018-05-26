package org.apache.activemq.web;

import java.util.Map;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;


public class SessionEhtListener implements HttpSessionListener {

    public void sessionCreated(HttpSessionEvent se) {
    }

    public void sessionDestroyed(HttpSessionEvent se) {
        WebClient client = WebClient.getWebClient(se.getSession());
        if (client != null) {
            client.close();
        }
        Object obj = se.getSession().getAttribute("hap.ajax.webclients");
        if(obj!=null){
        	@SuppressWarnings("unchecked")
        	Map<String,AjaxWebClient> hm = (Map<String,AjaxWebClient>)obj;
        	for(String key : hm.keySet()){
        		AjaxWebClient ac = hm.get(key);
        		if(ac!=null && !ac.isClosed()){
        			ac.close();
        		}
        	}
        }
    }
}
