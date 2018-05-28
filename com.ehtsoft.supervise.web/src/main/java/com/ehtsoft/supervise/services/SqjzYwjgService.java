package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ibm.icu.text.SimpleDateFormat;

/**
 * 社区矫正--业务监管--Service
 * @author zhuzj
 *
 */
@Service("SqjzYwjgService")
public class SqjzYwjgService extends AbstractService{
	

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService service;
	
	@Resource(name = "SqjzYwjgSjbbService")
	private SqjzYwjgSjbbService sqjzSjbbService;
	
	
	private Date date = new Date();
	
	private SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	
	
	/**
	 * 业务监管
	 * @param parentid
	 * @return
	 */
	public List<BasicMap<String, Object>> findAllData(String parentid){
		String str = "select jgmc, " + 
				"sum(cast(zcsqjzrs as int)) as zcsqjzrs,sum(cast(jzxz as int)) as jzxz,sum(cast(bkfz as int)) as bkfz, " + 
				"sum(cast(ksgl as int)) as ksgl,sum(cast(ptgl as int)) as ptgl,sum(cast(yggl as int)) as yggl, " + 
				"sum(cast(bdwg as int)) as bdwg,sum(cast(tggl as int)) as tggl,sum(cast(zzjzjy as int)) as zzjzjy, " + 
				"sum(cast(gbthjy as int)) as gbthjy,sum(cast(jxxlfd as int)) as jxxlfd,sum(cast(zzsqfw as int)) as zzsqfw, " + 
				"sum(cast(jx as int)) as jx,sum(cast(jg as int)) as jg,sum(cast(zacf as int)) as zacf, " + 
				"sum(cast(sjzz as int)) as sjzz,sum(cast(zfz as int)) as zfz,sum(cast(jswt as int)) as jswt, " + 
				"sum(cast(wcpg as int)) as wcpg,sum(cast(cx as int)) as cx,sum(cast(zzgzry as int)) as zzgzry, " + 
				"sum(cast(zzshgzz as int)) as zzshgzz,sum(cast(shzyz as int)) as shzyz,sum(cast(yjljyjd as int)) as yjljyjd, " + 
				"sum(cast(jyjdyjl as int)) as jyjdyjl,sum(cast(yjlsqfwjd as int)) as yjlsqfwjd,sum(cast(yjlsqjzzx as int)) as yjlsqjzzx  " + 
				"from rep_gzjgxxcjb where parentid = '"+parentid+"' " + 
				"group by jgmc " + 
				"order by jgmc desc ";
		SQLAdapter sql = new SQLAdapter(str);
		List<BasicMap<String, Object>> list = dbClient.find(sql);
		return list;
		
	}
	//查询时间
	public List<BasicMap<String, Object>> findQueryData(BasicMap<String, Object> basicMap){
		String dataTime ="";
		
		if(!"".equals(basicMap.get("qssj")) && basicMap.get("qssj") != null) {
			if(!"".equals(basicMap.get("jssj")) && basicMap.get("jssj") != null) {
				//处理字符串
				String  strTime1 =  StringUtil.toEmptyString(basicMap.get("qssj")).replace("-","");
				String  strTime2 =  StringUtil.toEmptyString(basicMap.get("jssj")).replace("-","");
				//拼接时间
				dataTime = " and cdate between "+strTime1+" and "+strTime2+" ";
			}
		}
		String str = "select jgmc, " + 
				"sum(cast(zcsqjzrs as int)) as zcsqjzrs,sum(cast(jzxz as int)) as jzxz,sum(cast(bkfz as int)) as bkfz, " + 
				"sum(cast(ksgl as int)) as ksgl,sum(cast(ptgl as int)) as ptgl,sum(cast(yggl as int)) as yggl, " + 
				"sum(cast(bdwg as int)) as bdwg,sum(cast(tggl as int)) as tggl,sum(cast(zzjzjy as int)) as zzjzjy, " + 
				"sum(cast(gbthjy as int)) as gbthjy,sum(cast(jxxlfd as int)) as jxxlfd,sum(cast(zzsqfw as int)) as zzsqfw, " + 
				"sum(cast(jx as int)) as jx,sum(cast(jg as int)) as jg,sum(cast(zacf as int)) as zacf, " + 
				"sum(cast(sjzz as int)) as sjzz,sum(cast(zfz as int)) as zfz,sum(cast(jswt as int)) as jswt, " + 
				"sum(cast(wcpg as int)) as wcpg,sum(cast(cx as int)) as cx,sum(cast(zzgzry as int)) as zzgzry, " + 
				"sum(cast(zzshgzz as int)) as zzshgzz,sum(cast(shzyz as int)) as shzyz,sum(cast(yjljyjd as int)) as yjljyjd, " + 
				"sum(cast(jyjdyjl as int)) as jyjdyjl,sum(cast(yjlsqfwjd as int)) as yjlsqfwjd,sum(cast(yjlsqjzzx as int)) as yjlsqjzzx  " + 
				"from rep_gzjgxxcjb where parentid = '"+basicMap.get("orgid")+"' " + dataTime+
				"group by jgmc " + 
				"order by jgmc desc ";
		SQLAdapter sql = new SQLAdapter(str);
		List<BasicMap<String, Object>> list = dbClient.find(sql);
		//如果为空则数据全部至0
		if (list.size()<1) {
			String Str1 = "select distinct jgmc from rep_gzjgxxcjb where parentid = '"+basicMap.get("orgid")+"'";
			
			SQLAdapter sql2 = new SQLAdapter(Str1);
			List<BasicMap<String, Object>> list2 = dbClient.find(sql2);
			for (BasicMap<String, Object> basicMap2 : list2) {
				basicMap2.put("zcsqjzrs", "0");
				basicMap2.put("jzxz", "0");
				basicMap2.put("bkfz", "0");
				basicMap2.put("ksgl", "0");
				basicMap2.put("ptgl", "0");
				basicMap2.put("yggl", "0");
				basicMap2.put("bdwg", "0");
				basicMap2.put("tggl", "0");
				basicMap2.put("zzjzjy", "0");
				basicMap2.put("gbthjy", "0");
				basicMap2.put("jxxlfd", "0");
				basicMap2.put("zzsqfw", "0");
				basicMap2.put("jx", "0");
				basicMap2.put("jg", "0");
				basicMap2.put("zacf", "0");
				basicMap2.put("sjzz", "0");
				basicMap2.put("zfz", "0");
				basicMap2.put("jswt", "0");
				basicMap2.put("wcpg", "0");
				basicMap2.put("cx", "0");
				basicMap2.put("zzgzry", "0");
				basicMap2.put("zzshgzz", "0");
				basicMap2.put("shzyz", "0");
				basicMap2.put("yjljyjd", "0");
				basicMap2.put("jyjdyjl", "0");
				basicMap2.put("yjlsqfwjd", "0");
				basicMap2.put("yjlsqjzzx", "0");
			}
			return list2;
		}
		return list;
	}
	/**
	 * 人员监管
	 * @param parentid
	 * @return
	 */
	public List<BasicMap<String, Object>> findAllRyData(String parentid){
		String str = "select jgmc, " + 
				"sum(cast(zcsqjzrs as int)) as zcsqjzrs,sum(cast(byzj as int)) as byzj,sum(cast(qmjc as int)) as qmjc, " + 
				"sum(cast(cxhc as int)) as cxhc,sum(cast(cxjs as int)) as cxjs,sum(cast(jdsj as int)) as jdsj, " + 
				"sum(cast(sjzxqt as int)) as sjzxqt,sum(cast(zcsw as int)) as zcsw,sum(cast(fzcsw as int)) as fzcsw, " + 
				"sum(cast(swqt as int)) as swqt,sum(cast(nan as int)) as nan,sum(cast(nv as int)) as nv, " + 
				"sum(cast(wcn as int)) as wcn,sum(cast(cntwo as int)) as cntwo,sum(cast(cnthree as int)) as cnthree, " + 
				"sum(cast(cnold as int)) as cnold,sum(cast(bshj as int)) as bshj,sum(cast(wshj as int)) as wshj, " + 
				"sum(cast(gatj as int)) as gatj,sum(cast(wgj as int)) as wgj,sum(cast(xxjyx as int)) as xxjyx, " + 
				"sum(cast(czxl as int)) as czxl,sum(cast(gzxl as int)) as gzxl,sum(cast(dzjys as int)) as dzjys, " + 
				"sum(cast(wh as int)) as wh,sum(cast(yh as int)) as yh,sum(cast(so as int)) as so , " + 
				"sum(cast(ly as int)) as ly,sum(cast(zh as int)) as zh,sum(cast(hz as int)) as hz, " + 	
				"sum(cast(shmz as int)) as shmz,sum(cast(jx as int)) as jx,sum(cast(jy as int)) as jy, " + 
				"sum(cast(wy as int)) as wy,sum(cast(xiaoqx as int)) as xiaoqx,sum(cast(zhongqx as int)) as zhongqx, " + 
				"sum(cast(xzqx as int)) as xzqx,sum(cast(daqx as int)) as daqx,sum(cast(gz as int)) as gz, " + 
				"sum(cast(hx as int)) as hx,sum(cast(js as int)) as js,sum(cast(zyjwzx as int)) as zyjwzx, " + 
				"sum(cast(bdzzql as int)) as bdzzql,sum(cast(whgjaq as int)) as whgjaq,sum(cast(whggaq as int)) as whggaq, " + 
				"sum(cast(phjjzx as int)) as phjjzx,sum(cast(qfgmrsql as int)) as qfgmrsql,sum(cast(qfcc as int)) as qfcc, " + 
				"sum(cast(fhshglzx as int)) as fhshglzx,sum(cast(twsh as int)) as twsh,sum(cast(dz as int)) as dz, " + 
				"sum(cast(qt as int)) as qt "+
				"from rep_ryjgxxcjb where parentid = '"+parentid+"' " + 
				"group by jgmc " + 
				"order by jgmc desc ";
		SQLAdapter sql = new SQLAdapter(str);
		List<BasicMap<String, Object>> list = dbClient.find(sql);
		return list;
		
	}
	
		/**
		 * 人员监管
		 * 查询时间
		 */
		public List<BasicMap<String, Object>> findQueryRyData(BasicMap<String, Object> basicMap){
			String dataTime ="";
			
			if(!"".equals(basicMap.get("qssj")) && basicMap.get("qssj") != null) {
				if(!"".equals(basicMap.get("jssj")) && basicMap.get("jssj") != null) {
					//处理字符串
					String  strTime1 =  StringUtil.toEmptyString(basicMap.get("qssj")).replace("-","");
					String  strTime2 =  StringUtil.toEmptyString(basicMap.get("jssj")).replace("-","");
					//拼接时间
					dataTime = " and cdate between "+strTime1+" and "+strTime2+" ";
				}
			}
			String str = "select jgmc, " + 
					"sum(cast(zcsqjzrs as int)) as zcsqjzrs,sum(cast(byzj as int)) as byzj,sum(cast(qmjc as int)) as qmjc, " + 
					"sum(cast(cxhc as int)) as cxhc,sum(cast(cxjs as int)) as cxjs,sum(cast(jdsj as int)) as jdsj, " + 
					"sum(cast(sjzxqt as int)) as sjzxqt,sum(cast(zcsw as int)) as zcsw,sum(cast(fzcsw as int)) as fzcsw, " + 
					"sum(cast(swqt as int)) as swqt,sum(cast(nan as int)) as nan,sum(cast(nv as int)) as nv, " + 
					"sum(cast(wcn as int)) as wcn,sum(cast(cntwo as int)) as cntwo,sum(cast(cnthree as int)) as cnthree, " + 
					"sum(cast(cnold as int)) as cnold,sum(cast(bshj as int)) as bshj,sum(cast(wshj as int)) as wshj, " + 
					"sum(cast(gatj as int)) as gatj,sum(cast(wgj as int)) as wgj,sum(cast(xxjyx as int)) as xxjyx, " + 
					"sum(cast(czxl as int)) as czxl,sum(cast(gzxl as int)) as gzxl,sum(cast(dzjys as int)) as dzjys, " + 
					"sum(cast(wh as int)) as wh,sum(cast(yh as int)) as yh,sum(cast(so as int)) as so , " + 
					"sum(cast(ly as int)) as ly,sum(cast(zh as int)) as zh,sum(cast(hz as int)) as hz, " + 	
					"sum(cast(shmz as int)) as shmz,sum(cast(jx as int)) as jx,sum(cast(jy as int)) as jy, " + 
					"sum(cast(wy as int)) as wy,sum(cast(xiaoqx as int)) as xiaoqx,sum(cast(zhongqx as int)) as zhongqx, " + 
					"sum(cast(xzqx as int)) as xzqx,sum(cast(daqx as int)) as daqx,sum(cast(gz as int)) as gz, " + 
					"sum(cast(hx as int)) as hx,sum(cast(js as int)) as js,sum(cast(zyjwzx as int)) as zyjwzx, " + 
					"sum(cast(bdzzql as int)) as bdzzql,sum(cast(whgjaq as int)) as whgjaq,sum(cast(whggaq as int)) as whggaq, " + 
					"sum(cast(phjjzx as int)) as phjjzx,sum(cast(qfgmrsql as int)) as qfgmrsql,sum(cast(qfcc as int)) as qfcc, " + 
					"sum(cast(fhshglzx as int)) as fhshglzx,sum(cast(twsh as int)) as twsh,sum(cast(dz as int)) as dz, " + 
					"sum(cast(qt as int)) as qt "+
					"from rep_ryjgxxcjb where parentid = '"+basicMap.get("orgid")+"' " + dataTime+
					"group by jgmc " + 
					"order by jgmc desc ";
			SQLAdapter sql = new SQLAdapter(str);
			List<BasicMap<String, Object>> list = dbClient.find(sql);
			//如果为空则数据全部至0
			if (list.size()<1) {
				String Str1 = "select distinct jgmc from rep_ryjgxxcjb where parentid = '"+basicMap.get("orgid")+"'";
				
				SQLAdapter sql2 = new SQLAdapter(Str1);
				List<BasicMap<String, Object>> list2 = dbClient.find(sql2);
				for (BasicMap<String, Object> basicMap2 : list2) {
					basicMap2.put("zcsqjzrs", "0");
					basicMap2.put("jzxz", "0");
					basicMap2.put("byzj", "0");
					basicMap2.put("qmjc", "0");
					basicMap2.put("cxhc", "0");
					basicMap2.put("cxjs", "0");
					basicMap2.put("jdsj", "0");
					basicMap2.put("tggl", "0");
					basicMap2.put("sjzxqt", "0");
					basicMap2.put("zcsw", "0");
					basicMap2.put("fzcsw", "0");
					basicMap2.put("swqt", "0");
					basicMap2.put("nan", "0");
					basicMap2.put("nv", "0");
					basicMap2.put("wcn", "0");
					basicMap2.put("cntwo", "0");
					basicMap2.put("cnthree", "0");
					basicMap2.put("cnold", "0");
					basicMap2.put("bshj", "0");
					basicMap2.put("wshj", "0");
					basicMap2.put("gatj", "0");
					basicMap2.put("wgj", "0");
					basicMap2.put("xxjyx", "0");
					basicMap2.put("czxl", "0");
					basicMap2.put("gzxl", "0");
					basicMap2.put("dzjys", "0");
					basicMap2.put("wh", "0");
					
					basicMap2.put("yh", "0");
					basicMap2.put("so", "0");
					basicMap2.put("ly", "0");
					basicMap2.put("zh", "0");
					basicMap2.put("hz", "0");
					basicMap2.put("shmz", "0");
					basicMap2.put("jx", "0");
					basicMap2.put("jy", "0");
					basicMap2.put("wy", "0");
					basicMap2.put("xiaoqx", "0");
					basicMap2.put("zhongqx", "0");
					basicMap2.put("xzqx", "0");
					basicMap2.put("daqx", "0");
					basicMap2.put("gz", "0");
					basicMap2.put("hx", "0");
					basicMap2.put("js", "0");
					basicMap2.put("zyjwzx", "0");
					basicMap2.put("bdzzql", "0");
					basicMap2.put("whgjaq", "0");
					basicMap2.put("whggaq", "0");
					basicMap2.put("phjjzx", "0");
					basicMap2.put("qfgmrsql", "0");
					basicMap2.put("qfcc", "0");
					basicMap2.put("fhshglzx", "0");
					basicMap2.put("twsh", "0");
					basicMap2.put("dz", "0");
					basicMap2.put("qt", "0");
				}
				return list2;
			}
			return list;
		}
		/*************************系统应用监管**************************************/
		
		public List<BasicMap<String,Object>> findAllyyData(String orgid,String type){
			List<BasicMap<String,Object>> list = new ArrayList<BasicMap<String,Object>>();
			String sfsIndex = " and a.jgmc like '%司法所' GROUP BY a.jgmc ORDER BY a.jgmc desc";
			String sfjIndex = " and a.jgmc like '%司法局' GROUP BY a.jgmc ORDER BY a.jgmc desc";
			if(type.equals("4")){
				list = findAllYy(orgid,sfsIndex);
			}else{
				list = findAllYy(orgid,sfjIndex);
			}
			return list;
			
		}
		/**
		 * 
		 * @param orgid
		 * @param liketype
		 * @return
		 */
		public List<BasicMap<String,Object>> findAllYy(String orgid,String likeType){
			
			String[] nowDate = df.format(date).split("-");
			//本月开始日
			String starDate = nowDate[0] + nowDate[1] +"01";
			//本月结束日
			String endDate = nowDate[0] + nowDate[1] +"31";
			//本季度 
			if(NumberUtil.toInt(nowDate[1])>= 10) {
				//本季度开始时间
				String jdStart =nowDate[0] + "1001" ;
				String jdEnd =nowDate[0] + "1231" ;
			}else if(NumberUtil.toInt(nowDate[1])>= 7 && NumberUtil.toInt(nowDate[1]) <10) {
				//本季度开始时间
				String jdStart =nowDate[0] + "0701" ;
				String jdEnd =nowDate[0] + "0930" ;
			}else if(NumberUtil.toInt(nowDate[1])>= 4 && NumberUtil.toInt(nowDate[1]) <7) {
				//本季度开始时间
				String jdStart =nowDate[0] + "0401" ;
				String jdEnd =nowDate[0] + "0630" ;
			}else {
				//本季度开始时间
				String jdStart =nowDate[0] + "0101" ;
				String jdEnd =nowDate[0] + "0331" ;
			}
			
			List<BasicMap<String,Object>> list = new ArrayList<BasicMap<String,Object>>();
			
			//在矫社区人数
			String str1 = "SELECT A .jgmc,COUNT (*)  FROM jc_sfxzjgjbxx a LEFT JOIN jz_jzryjbxx b ON b.orgid = a.ID"+
				"WHERE a.parentid = '"+orgid+"' AND b.jcjz = '0' " + likeType;
			SQLAdapter sqlStr1 = new SQLAdapter(str1);
			list = dbClient.find(sqlStr1);
			//逾期未解矫人数
			String str2 = "SELECT a.jgmc,sum(case when c.sqjzjsrq<'20170101' then 1 else 0 end) as yqwjjs FROM jc_sfxzjgjbxx A " + 
					"LEFT JOIN jz_jzryjbxx b ON b.orgid = A.ID " + 
					"LEFT JOIN JZ_JZRYJBXX_JZ c on b.orgid = c.orgid " + 
					"WHERE a.parentid = '"+orgid+"' AND b.jcjz = '0' " +  likeType;
			list =  findDataUtil(list,str2);
			//无照片数
			String str3 = "SELECT a.jgmc,sum(case when b.id in(select imgid as id from  JZ_JZRYJBXX_IMG) then 1 else 0 end) as wzps FROM jc_sfxzjgjbxx a " + 
					"LEFT JOIN jz_jzryjbxx b ON b.orgid = a.ID " + 
					"WHERE a.parentid = '"+orgid +"'  AND b.jcjz = '0' "  +  likeType;
			list =  findDataUtil(list,str3);
			//本季度未进行风险评估数---查的是调查委托书记录表
			
			//未登记小组数
			String str5 = "SELECT a.jgmc,sum(case when b.id NOT in(select f_aid as id from  JZ_JZXZCY) then 0 else 1 end) as yqwjjs FROM jc_sfxzjgjbxx A " + 
					"LEFT JOIN jz_jzryjbxx b ON b.orgid = A.ID " + 
					"WHERE a.parentid = '"+orgid+"' AND b.jcjz = '0' " + likeType;
			list =  findDataUtil(list,str5);
			//本月教育学习数--集中教育JZ_PXQKDJB
			String str6 = "select a.jgmc, " + 
					"sum(case when b.cdate BETWEEN '"+starDate+"' and '"+endDate+"'  then CAST (b.sjcjrs  as INT) else 0 end) " + 
					" FROM jc_sfxzjgjbxx a  " + 
					"left join  JZ_PXQKDJB b on b.orgid = a.ID where a. parentid = '"+orgid+"' " + likeType;
			//本月社区服务人数
			String str7 ="select a.jgmc, " + 
					"sum(case when b.cdate BETWEEN '"+starDate+"' and '"+endDate+"'  then CAST (b.sdrs  as INT) else 0 end) " + 
					" FROM jc_sfxzjgjbxx a  " + 
					"left join  jz_sqfwxx b on b.orgid = a.ID where a. parentid = '"+orgid+"' " + likeType;
			list =  findDataUtil(list,str7);
			//本月报到人数
			String str8 = "SELECT a.jgmc,sum(case when b.cdate between '"+starDate+"' and '"+endDate+"' then 1 else 0 end) " + 
					"from jc_sfxzjgjbxx a LEFT JOIN jz_jzryjbxx b ON a.id = b.orgid where a.parentid = '"+orgid+"' " + likeType;
			list =  findDataUtil(list,str8);
			//上季度未考核数
			String  str9 = "select  a.jgmc,count(c.aid) from jc_sfxzjgjbxx a LEFT JOIN jz_jzryjbxx b on a.id = b.orgid  " + 
					"left JOIN JZ_KHXX  c on b.id = c.aid  where a.parentid = '"+orgid+"' and b.jcjz = '0' " + likeType;
			return null;
			
			
		}
		
		/**
		 * 拼接查询数据
		 * @param list
		 * @param sql
		 * @return
		 */
		public List<BasicMap<String, Object>> findDataUtil(List<BasicMap<String, Object>> list,String sql){
			List<BasicMap<String, Object>> list1 = new ArrayList<BasicMap<String,Object>>();
			//sql
			SQLAdapter sqlData = new SQLAdapter(sql);
			list1 = dbClient.find(sqlData);
			//总list
			for (BasicMap<String, Object> basicMap : list) {
				for (BasicMap<String, Object> basicMap1 : list1) {
					if (basicMap.get("jgmc").equals(basicMap1.get("jgmc"))) {
						//名字一样则放入
						basicMap.putAll(basicMap1);
					}
				}
			}
			return list;
		}
		
}
