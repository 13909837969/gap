package com.ehtsoft.im.services;

import java.util.Date;

import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.im.dto.Group;

public class AudioService {
	
	public static void main(String[] args){
		Group g = new Group();
		
		g.setAid("aid0001");
		g.setAudit(1);
		g.setCaid("caid00001");
		g.setCdate(20170909);
		g.setCts(new Date());
		g.setCuid("cuid0002");
		g.setGid("gid000001");
		g.setName("groupname00002");
		g.setType(2);
		g.setOrgid("orgid");
	
		BasicMap<String,Object> bm = ReflectUtil.bean2Map(g, "F_");
		
		System.out.println(bm);
		
		Group gg = ReflectUtil.map2Bean(bm, Group.class, "F_");
		System.out.println(gg);
	}

}
