package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.NumberUtil;

@Service("YwjgService")
public class YwjgService {

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 工作监管
	 * @return
	 */
	public List<BasicMap<String,Object>> findGzjgList(){
		List<BasicMap<String,Object>> list=new ArrayList<BasicMap<String,Object>>();
		
		BasicMap<String,Object> map1=new BasicMap<>();
		String sql1="select count(1) as zcrys from Jz_JZRYJBXX where sfjs='1' and jcjz='0'";
		map1.put("value", dbClient.findOne(sql1).get("zcrys"));
		map1.put("name","在册社区矫正人数" );
		list.add(map1);
		
		BasicMap<String,Object> map2=new BasicMap<>();
		String sql2="select count(a.xm) as jzxzrs from (select distinct xm from JZ_JZXZCY) a";
		map2.put("value", dbClient.findOne(sql2).get("jzxzrs"));
		map2.put("name","矫正小组" );
		list.add(map2);
		
		BasicMap<String,Object> map3=new BasicMap<>();
		String sql3="select count(1) as gldjs from jz_jzryjbxx  where sfjs='1' and jcjz='0' and (JGLX='1' or JGLX='2' or JGLX='3')";
		map3.put("value", dbClient.findOne(sql3).get("gldjs"));
		map3.put("name","管理等级" );
		list.add(map3);
		
		BasicMap<String,Object> map4=new BasicMap<>();
		String sql4="select count(a.f_aid) as bfs from (select distinct f_aid from JZ_BFXXCJB where f_aid<>'') a";
		map4.put("value", dbClient.findOne(sql4).get("bfs"));
		map4.put("name","帮困扶助" );
		list.add(map4);
		
		BasicMap<String,Object> map5=new BasicMap<>();
		String sql5="select count(a.f_aid) as jcs from (select distinct f_aid from JZ_SQJZRYJCXXCJB where f_aid<>'') a";
		map5.put("value", dbClient.findOne(sql5).get("jcs"));
		map5.put("name","奖惩情况" );
		list.add(map5);
		
		BasicMap<String,Object> map6=new BasicMap<>();
		map6.put("value", "0");
		map6.put("name","适用社区影响评估" );
		list.add(map6);
		
		BasicMap<String,Object> map7=new BasicMap<>();
		map7.put("value", "0");
		map7.put("name","基础工作建设" );
		list.add(map7);
		
		BasicMap<String,Object> map8=new BasicMap<>();
		String sql6="select count(1) as jzjys from JZ_PXQKDJB";//集中教育次数
		int jzjys=NumberUtil.toInt(dbClient.findOne(sql6).get("jzjys"));
		String sql7="select count(a.f_aid) as gbjys from (select distinct f_aid from JZ_GBJYQK) a";//个别教育人数
		int gbjys=NumberUtil.toInt(dbClient.findOne(sql7).get("gbjys"));
		int zs=0;
		zs=jzjys+gbjys;
        map8.put("value", zs);
		map8.put("name","教育矫正" );
		list.add(map8);
		
		BasicMap<String,Object> map9=new BasicMap<>();
		String sql8="select count(a.f_aid) as dqbg from (select distinct f_aid from JZ_SXHB where f_aid<>'') a";//定期报告人数
		int dqbg=NumberUtil.toInt(dbClient.findOne(sql8).get("dqbg"));
		String sql9="select count(a.f_aid) as zfjc from (select distinct f_aid from jz_zfjcqk where f_aid<>'') a";//走访检查人数
		int zfjc=NumberUtil.toInt(dbClient.findOne(sql9).get("zfjc"));
		int dqzf=0;
		dqzf=dqbg+zfjc;
        map9.put("value", dqzf);
		map9.put("name","监督管理" );
		list.add(map9);
		
		
		
		
		
		return list;
		
	}
	
	/**
	 * 人员监管
	 * @return
	 */
//	public List<BasicMap<String,Object>> findRyjgList(){
//		
//        List<BasicMap<String,Object>> list=new ArrayList<BasicMap<String,Object>>();
//		
//		BasicMap<String,Object> map1=new BasicMap<>();
//		String sql1="select count(1) as nls from JZ_JZryjbxx where csrq is not null and sfjs='1' and jcjz='0'";
//		map1.put("value", dbClient.findOne(sql1).get("nls"));
//		map1.put("name","年龄" );
//		list.add(map1);
//		
//		BasicMap<String,Object> map2=new BasicMap<>();
//		String sql2="";
//		map2.put("value", dbClient.findOne(sql1).get("nls"));
//		map2.put("name","" );
//		list.add(map2);
//		
		
		
		
//		return list;
		
//	}
	
	
	
	
	
	
}
