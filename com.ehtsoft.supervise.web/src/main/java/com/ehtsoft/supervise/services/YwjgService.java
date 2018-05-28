package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ctc.wstx.util.DataUtil;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.utils.DateUtils;

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
		String sql1="select count(a.f_aid) as gbjys from (select distinct f_aid from JZ_GBJYQK) a ";
		map1.put("value", dbClient.findOne(sql1).get("gbjys"));
		map1.put("name","个别教育" );
		list.add(map1);
		
		BasicMap<String,Object> map2=new BasicMap<>();
		String sql2="select count(1) as jzjys from JZ_PXQKDJB";
		map2.put("value", dbClient.findOne(sql2).get("jzjys"));
		map2.put("name","集中教育" );
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
		String sql5="select count(a.f_aid) as dqbg from (select distinct f_aid from JZ_SXHB where f_aid<>'') a";
		map5.put("value", dbClient.findOne(sql5).get("dqbg"));
		map5.put("name","定期报告人数" );
		list.add(map5);
		
		BasicMap<String,Object> map6=new BasicMap<>();
		String sql6="select count(1) as wcwg from JZ_SQJZRYWGXXCJB where wglx='05'";
		map6.put("value", dbClient.findOne(sql6).get("wcwg"));
		map6.put("name","外出违规" );
		list.add(map6);
		
		BasicMap<String,Object> map7=new BasicMap<>();
		String sql7="select count(1) as yjwg from JZ_SQJZRYWGXXCJB where wglx='08'";
		map7.put("value", dbClient.findOne(sql7).get("yjwg"));
		map7.put("name","越界违规" );
		list.add(map7);
		
		BasicMap<String,Object> map8=new BasicMap<>();
		String sql8="select count(1) as jzdwg from JZ_SQJZRYWGXXCJB where wglx='07'";
		map8.put("value", dbClient.findOne(sql8).get("jzdwg"));
		map8.put("name","居住地变更违规" );
		list.add(map8);
		return list;
		
	}
	
	/**
	 * 人员监管
	 * @return
	 */
	public List<BasicMap<String,Object>> findRyjgList(){
		
		List<BasicMap<String,Object>> list=new ArrayList<>();
		
		BasicMap<String,Object> map1=new BasicMap<>();
		String sql1="select count(1) as qmjc from JZ_JZJCXXCJB where JJLX='01'";
		map1.put("name", dbClient.findOne(sql1).get("qmjc"));
		map1.put("value", "期满解除");
		list.add(map1);
		
		BasicMap<String,Object> map2=new BasicMap<>();
		String sql2="select count(1) as sjzx from JZ_JZJCXXCJB where JJLX='02'";
		map2.put("name", dbClient.findOne(sql2).get("sjzx"));
		map2.put("value", "收监执行");
		list.add(map2);
		
		BasicMap<String,Object> map3=new BasicMap<>();
		String sql3="select count(1) as sw from JZ_JZJCXXCJB where JJLX='03'";
		map3.put("name", dbClient.findOne(sql3).get("sw"));
		map3.put("value", "死亡");
		list.add(map3);
		
		BasicMap<String,Object> map4=new BasicMap<>();
		//String sql4="select count(1) as gyshz from JZ_JZRYJBXX_JZ where FZLX=''";
		//map4.put("name", dbClient.findOne(sql4).get("gyshz"));
		map4.put("name", "0");
		map4.put("value", "故意伤害罪");
		list.add(map4);
		
		BasicMap<String,Object> map5=new BasicMap<>();
		//String sql5="select count(1) as qjz from JZ_JZRYJBXX_JZ where FZLX=''";
		//map5.put("name", dbClient.findOne(sql5).get("qjz"));
		map5.put("name", "0");
		map5.put("value", "抢劫罪");
		list.add(map5);
		
		BasicMap<String,Object> map6=new BasicMap<>();
		//String sql6="select count(1) as qjzm from JZ_JZRYJBXX_JZ where FZLX=''";
		//map6.put("name", dbClient.findOne(sql6).get("qjzm"));
		map6.put("name", "0");
		map6.put("value", "强奸罪");
		list.add(map6);
		
		BasicMap<String,Object> map7=new BasicMap<>();
		//String sql7="select count(1) as zqz from JZ_JZRYJBXX_JZ where FZLX=''";
		//map7.put("name", dbClient.findOne(sql7).get("zqz"));
		map7.put("name", "0");
		map7.put("value", "诈骗罪");
		list.add(map7);
		
		BasicMap<String,Object> map8=new BasicMap<>();
		//String sql8="select count(1) as xxzs from JZ_JZRYJBXX_JZ where FZLX=''";
		//map8.put("name", dbClient.findOne(sql8).get("xxzs"));
		map8.put("name", "0");
		map8.put("value", "寻衅滋事罪");
		list.add(map8);
		
		BasicMap<String,Object> map9=new BasicMap<>();
		//String sql9="select count(1) as jzdo from JZ_JZRYJBXX_JZ where FZLX=''";
		//map9.put("name", dbClient.findOne(sql9).get("jzdo"));
		map9.put("name", "0");
		map9.put("value", "聚众斗殴罪");
		list.add(map9);
		
		BasicMap<String,Object> map10=new BasicMap<>();
		//String sql10="select count(1) as jtzs from JZ_JZRYJBXX_JZ where FZLX=''";
		//map10.put("name", dbClient.findOne(sql10).get("jtzs"));
		map10.put("name", "0");
		map10.put("value", "交通肇事罪");
		list.add(map10);
		
		BasicMap<String,Object> map11=new BasicMap<>();
		//String sql11="select count(1) as ffjj from JZ_JZRYJBXX_JZ where FZLX=''";
		//map11.put("name", dbClient.findOne(sql11).get("ffjj"));
		map11.put("name", "0");
		map11.put("value", "非法拘禁罪");
		list.add(map11);
		
		BasicMap<String,Object> map12=new BasicMap<>();
		//String sql12="select count(1) as dqz from JZ_JZRYJBXX_JZ where FZLX=''";
		//map12.put("name", dbClient.findOne(sql12).get("dqz"));
		map12.put("name", "0");
		map12.put("value", "盗窃罪");
		list.add(map12);
		
		return list;
	}
	
	/**
	 * 系统应用监管
	 * @return
	 */
	public List<BasicMap<String,Object>> findYyjgList(){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		
		BasicMap<String,Object> map1=new BasicMap<>();
		List<BasicMap<String,Object>> list1=findYqwjj();
		List<BasicMap<String,Object>> list2=new ArrayList<>();
		for (int i = 0; i < list1.size(); i++) {
			if(NumberUtil.toInt(list1.get(i).get("day"))>0) {
				list2.add(list1.get(i));
			}
		}
		map1.put("value",NumberUtil.toInt(list2.size()));
		map1.put("name", "逾期未解矫");
		list.add(map1);
		
//		BasicMap<String,Object> map2=new BasicMap<>();
//		String sql="select count(a.id) from JZ_XLJZB a right join JZ_JZRYJBXX b on a.aid=b.id";
		
		
		return list;

	}
	
	/**
	 * 
	 * @return
	 */
	public List<BasicMap<String,Object>> findYqwjj(){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="select b.id,b.xm,SQJZJSRQ from JZ_JZRYJBXX_JZ a join JZ_JZRYJBXX b on a.id=b.id where b.sfjs='1' and b.jcjz='0'";
		SQLAdapter adapter=new SQLAdapter(sql);
		list=dbClient.find(adapter, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				 	if(rowData.get("SQJZJSRQ")!=null) {
				 		long days=DateUtils.getDaySub(
				 				StringUtil.toString(DateUtil.format(new Date(),"yyyy-MM-dd")),
				 				StringUtil.toString(rowData.get("SQJZJSRQ")));	
				 		rowData.put("day", Math.abs(NumberUtil.toInt(days)));
				 	};     
			}
		});
		return list;
	}


	
	
	
	
	
	
}
