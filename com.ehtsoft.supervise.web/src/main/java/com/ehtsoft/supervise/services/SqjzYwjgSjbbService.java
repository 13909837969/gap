package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.Basic;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;
import com.ibm.icu.text.SimpleDateFormat;

/**
 * 社区矫正-业务监管-数据报表用
 * @author Lenovo
 *
 */
@Service("SqjzYwjgSjbbService")
public class SqjzYwjgSjbbService extends AbstractService{

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService service;
	
	private Date date = new Date();
	
	private SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * 查找工作监管数据
	 * @param orgid
	 * @return
	 */
	public List<BasicMap<String, Object>> findAllData(String orgid,String likeGroupBy){
		List<BasicMap<String, Object>> list = new ArrayList<BasicMap<String,Object>>();
		
		String likeSfjGroupBy = " and a.jgmc like '%司法局' GROUP BY a.jgmc ORDER BY a.jgmc DESC ";
		String likeSfsGroupBy = "and a.jgmc like '%司法所' GROUP BY a.jgmc ORDER BY a.jgmc DESC ";
		//判断当前登录人是否为旗县司法局
		if (NumberUtil.toInt(likeGroupBy)<4) {
			list = findDatasfsOrsfj(orgid,likeSfjGroupBy);
		}else {
			list = findDatasfsOrsfj(orgid,likeSfsGroupBy);
		}
			
		
		return list;
		
	}
	
	/**
	 * 根据sql查询数据库中司法局或者司法所的所有报表字段数据
	 * @param orgid
	 * @param likeSfsGroupBy
	 * @return
	 */
	public List<BasicMap<String, Object>> findDatasfsOrsfj(String orgid,String likeSfsGroupBy){
		
		List<BasicMap<String, Object>> list1 = new ArrayList<BasicMap<String,Object>>();
		
		//------1----在册社区矫正人数  zcjzrs  宽松管理   kg 普通管理  pg 严格管理  yg
		String str1 = "select a.jgmc,count(b.id) as zcsqjzrs, " + 
				"sum(case when b.jglx='1' then 1 else 0 end) as ksgl, " + 
				"sum(case when b.jglx='2' then 1 else 0 end) as ptgl, " + 
				"sum(case when b.jglx='3' then 1 else 0 end) as yggl, " + 
				"sum(case when b.bdqk>'01' then 1 else 0 end) as bdwg  " + 
				"from jc_sfxzjgjbxx a " + 
				"left JOIN JZ_JZRYJBXX b ON a.id = b.orgid " + 
				"where a.parentid =  '"+orgid+"'" +likeSfsGroupBy;
		SQLAdapter sql = new SQLAdapter(str1);
		list1 = dbClient.find(sql);
	
		/*//-----2----矫正小组--jzxzrs 
		 * select a.jgmc, COALESCE(count(c.xzid),0) as jzxzrs from jc_sfxzjgjbxx a 
		left JOIN JZ_JZXZCY c  on c.orgid = a.id where a.parentid = 'NM0000000000-0000-0000-0000000-01422' and a.jgmc like '%司法所%'
				group BY a.jgmc
				ORDER BY a.jgmc DESC*/
		String str2 = "select a.jgmc, COALESCE(count(c.xzid),0) as jzxz from jc_sfxzjgjbxx a " + 
				"left JOIN JZ_JZXZCY c on c.orgid = a.ID and a.parentid = '"+orgid+"' "+likeSfsGroupBy;		
		list1 = findDataUtil(list1, str2);
		
		//----3------帮困扶助--bkfzrs
		String str3 = "select  a.jgmc, count(e.id) as bkfz from jc_sfxzjgjbxx a  left JOIN  JZ_BFXXCJB e on a.id = e.orgid " + 
				"where a.parentid ='"+orgid+"' " +likeSfsGroupBy;
		list1 = findDataUtil(list1, str3);
		
		//----4--------托管情况--tgqkrs
		String str4 = "select a.jgmc, count(d.tgxxid) as  tggl from jc_sfxzjgjbxx a LEFT JOIN " + 
				"JZ_TGXXCJB	d on a.id = d.orgid where a.parentid ='"+orgid+"'"+likeSfsGroupBy;
		list1 = findDataUtil(list1, str4);
		
		//-----5-----集中教育--jzjyrs
		String str5 = "select  a.jgmc, count(e.pxqkid) as zzjzjy from jc_sfxzjgjbxx a  left JOIN  JZ_PXQKDJB e on a.id = e.orgid " + 
				"where a.parentid ='"+orgid+"' "+likeSfsGroupBy;
		list1 = findDataUtil(list1, str5);
		
		//-----6-----个别教育--gbjyrs
		String str6 = "select a.jgmc,count(f.pxqkid) as gbthjy from jc_sfxzjgjbxx a  LEFT JOIN  JZ_GBJYQK	f on a.id = f.orgid " + 
				"where a.parentid ='"+orgid+"' "+likeSfsGroupBy;
		list1 = findDataUtil(list1, str6);
		
		//-----7---------心里辅导
		String str7 = "select  a.jgmc, count(e.id) as jxxlfd from jc_sfxzjgjbxx a  left JOIN  JZ_XLJZB e on a.id = e.orgid " + 
				"where a.parentid ='"+orgid+"' "+likeSfsGroupBy;
		list1 = findDataUtil(list1, str7);
		
		//-----8---------组织社区服务
		String str8 = "select a.jgmc, COALESCE(sum(cast(g.sdrs as int)),0) as zzsqfw " + 
				"from jc_sfxzjgjbxx a   LEFT JOIN  JZ_SQFWXX	g on a.id = g.orgid " + 
				"where a.parentid ='"+orgid+"' "+likeSfsGroupBy;
		list1 = findDataUtil(list1, str8);
		//----9---------减刑  警告  治安处罚
		String str9 = "select a.jgmc, " + 
				"sum(case when h.jclb='01' then 1 else 0 end) as jg, " + 
				"sum(case when h.jclb='02' then 1 else 0 end) as zacf, " + 
				"sum(case when h.jclb='03' then 1 else 0 end) as jx  from jc_sfxzjgjbxx a " + 
				"left JOIN JZ_SQJZRYJCXXCJB h on a.id = h.orgid  " + 
				"where a.parentid = '"+orgid+"' "+likeSfsGroupBy;
		list1 = findDataUtil(list1, str9);
		
		//----10---------收监执行
		String str10 = "select a.jgmc,count(i.id) as sjzz from jc_sfxzjgjbxx a  LEFT JOIN  JZ_TQSJZXXXCJB	i on a.id = i.orgid " + 
				"where a.parentid ='"+orgid+"' "+likeSfsGroupBy;
		list1 = findDataUtil(list1, str10);
				
		//----11---------在犯罪信息
		String str11 = "select a.jgmc,count(j.id) as zfz  from jc_sfxzjgjbxx a " + 
				"LEFT JOIN  JZ_SQJZRYZJZQJZFZXXCJB	j on a.id = j.orgid " + 
				"where a.parentid ='"+orgid+"' "+likeSfsGroupBy;
		list1 = findDataUtil(list1, str11);
		
		//----12--------接受委托---完成评估--采信--
		String str12 = "select a.jgmc, " + 
				"sum(case when k.sfdcpg='1' then 1 else 0 end) as jswt, " + 
				"sum(case when k.DCYJCXQK='01' then 1 else 0 end) as cx, " + 
				"sum(case when k.DCPGYJ='01' then 1 else 0 end) as wcpg " + 
				"from jc_sfxzjgjbxx a  " + 
				"LEFT JOIN JZ_JZRYJBXX_JZ k on a.id = k.orgid  where a.parentid = '"+orgid+"' "+likeSfsGroupBy;
		list1 = findDataUtil(list1, str12);
		
		//----13------队伍建设-----志愿者03---专职工作者01--社会工作者02---
		String str13 = "select a.jgmc, " + 
				"sum(case when k.XZCYLX='01' then 1 else 0 end) as zzgzz, " + 
				"sum(case when k.XZCYLX='02' then 1 else 0 end) as zzshgzz, " + 
				"sum(case when k.XZCYLX='03' then 1 else 0 end) as shzyz " + 
				"from jc_sfxzjgjbxx a " + 
				"LEFT JOIN JZ_JZXZCY k on a.id = k.orgid  where a.parentid = '"+orgid+"' "+likeSfsGroupBy;
		list1 = findDataUtil(list1, str13);
		
		//----14---就业基地02--社区服务基地01-教育基地03----社区矫正中心99----
				String str14 = "select a.jgmc, " + 
						"sum(case when k.JDLX='01' then 1 else 0 end) as yjlsqfwjd, " + 
						"sum(case when k.JDLX='02' then 1 else 0 end) as yjljyjd, " + 
						"sum(case when k.JDLX='03' then 1 else 0 end) as jyjdyjl, " + 
						"sum(case when k.JDLX='99' then 1 else 0 end) as yjlsqjzzx " + 
						"from jc_sfxzjgjbxx a  " + 
						"LEFT JOIN ANZBJ_AZBJJDJSXXCJB k on a.id = k.orgid  where a.parentid = '"+orgid+"' "+likeSfsGroupBy;
				list1 = findDataUtil(list1, str14);
				
		return list1;
		
		
	}
	
	
	/**
	 * 每天晚上12点执行一次入库操作
	 * 计算增量在入库
	 */
	public void saveIncrement(){
		//入库司法所
		//查询rep_gzjgxxcjb表中所有数据
		String str = "select distinct orgid,jgmc,parentid from  rep_gzjgxxcjb where jgmc like '%司法局' ";
		SQLAdapter sql = new SQLAdapter(str);
		//根据id一条一条查
		List<BasicMap<String,Object>> list = dbClient.find(sql);
		//循环查询下级司法所的所有工作报表字段
		for (BasicMap<String, Object> basicMap : list) {
			String strBiao = "select jgmc, " + 
					"sum(cast(zcsqjzrs as int)) as zcsqjzrs,sum(cast(jzxz as int)) as jzxz,sum(cast(bkfz as int)) as bkfz, " + 
					"sum(cast(ksgl as int)) as ksgl,sum(cast(ptgl as int)) as ptgl,sum(cast(yggl as int)) as yggl, " + 
					"sum(cast(bdwg as int)) as bdwg,sum(cast(tggl as int)) as tggl,sum(cast(zzjzjy as int)) as zzjzjy, " + 
					"sum(cast(gbthjy as int)) as gbthjy,sum(cast(jxxlfd as int)) as jxxlfd,sum(cast(zzsqfw as int)) as zzsqfw, " + 
					"sum(cast(jx as int)) as jx,sum(cast(jg as int)) as jg,sum(cast(zacf as int)) as zacf, " + 
					"sum(cast(sjzz as int)) as sjzz,sum(cast(zfz as int)) as zfz,sum(cast(jswt as int)) as jswt, " + 
					"sum(cast(wcpg as int)) as wcpg,sum(cast(cx as int)) as cx,sum(cast(zzgzry as int)) as zzgzry, " + 
					"sum(cast(zzshgzz as int)) as zzshgzz,sum(cast(shzyz as int)) as shzyz,sum(cast(yjljyjd as int)) as yjljyjd, " + 
					"sum(cast(jyjdyjl as int)) as jyjdyjl,sum(cast(yjlsqfwjd as int)) as yjlsqfwjd,sum(cast(yjlsqjzzx as int)) as yjlsqjzzx  " + 
					"from rep_gzjgxxcjb where parentid = '"+basicMap.get("orgid")+"' " + 
					"group by jgmc " + 
					"order by jgmc desc ";
			SQLAdapter sqlBiao = new SQLAdapter(strBiao);
			//查找表rep_gzjgxxcjb中的数据
			List<BasicMap<String, Object>> listBiaoData = dbClient.find(sqlBiao);
			//判断名字
			if(StringUtil.toEmptyString(basicMap.get("jgmc")).endsWith("司法局")){
			//查找所有表中数据
				List<BasicMap<String, Object>> listAllData = findAllData(StringUtil.toEmptyString(basicMap.get("orgid")),"4");
				for (BasicMap<String, Object> mapBiaoData : listBiaoData) {
					for (BasicMap<String, Object> mapAllData : listAllData) {
						String str11 = "select id,parentid from jc_sfxzjgjbxx where jgmc ='"+mapBiaoData.get("jgmc")+"'";
						List<BasicMap<String, Object>> listCm = dbClient.find(new SQLAdapter(str11));
						for (BasicMap<String, Object> mapCm : listCm) {
							
							if (mapBiaoData.get("jgmc").equals(mapAllData.get("jgmc")) && basicMap.get("orgid").equals(mapCm.get("parentid"))) {
								//存放司法所增量数据
								BasicMap<String, Object> resultMap = new BasicMap<String, Object>();
								resultMap.put("jgmc", mapBiaoData.get("jgmc"));
								resultMap.put("parentid",mapCm.get("parentid"));
								resultMap.put("orgid", mapCm.get("id"));
								
								//计算增量
								resultMap = fzShuJuGzMap(resultMap, mapAllData, mapBiaoData);
								dbClient.insert(SupConst.Collections.REP_GZJGXXCJB, resultMap);
								System.out.println("初始化"+mapBiaoData.get("jgmc")+"-------ok");
							}
						}
					}
				}
			}
		}
			//入库盟市司法局
			List<BasicMap<String, Object>> listMssfjAllData = findAllData("NM0000000000-0000-0000-0000000-00001", "1");
			for (BasicMap<String, Object> mapMssfjAllData : listMssfjAllData) {
				//根据厅级orgidRep_gzjgxxcib中对应机构的sum集合
				String strMsBiao = "select jgmc, " + 
						"sum(cast(zcsqjzrs as int)) as zcsqjzrs,sum(cast(jzxz as int)) as jzxz,sum(cast(bkfz as int)) as bkfz, " + 
						"sum(cast(ksgl as int)) as ksgl,sum(cast(ptgl as int)) as ptgl,sum(cast(yggl as int)) as yggl, " + 
						"sum(cast(bdwg as int)) as bdwg,sum(cast(tggl as int)) as tggl,sum(cast(zzjzjy as int)) as zzjzjy, " + 
						"sum(cast(gbthjy as int)) as gbthjy,sum(cast(jxxlfd as int)) as jxxlfd,sum(cast(zzsqfw as int)) as zzsqfw, " + 
						"sum(cast(jx as int)) as jx,sum(cast(jg as int)) as jg,sum(cast(zacf as int)) as zacf, " + 
						"sum(cast(sjzz as int)) as sjzz,sum(cast(zfz as int)) as zfz,sum(cast(jswt as int)) as jswt, " + 
						"sum(cast(wcpg as int)) as wcpg,sum(cast(cx as int)) as cx,sum(cast(zzgzry as int)) as zzgzry, " + 
						"sum(cast(zzshgzz as int)) as zzshgzz,sum(cast(shzyz as int)) as shzyz,sum(cast(yjljyjd as int)) as yjljyjd, " + 
						"sum(cast(jyjdyjl as int)) as jyjdyjl,sum(cast(yjlsqfwjd as int)) as yjlsqfwjd,sum(cast(yjlsqjzzx as int)) as yjlsqjzzx  " + 
						"from rep_gzjgxxcjb where parentid = 'NM0000000000-0000-0000-0000000-00001' " + 
						"group by jgmc " + 
						"order by jgmc desc ";
				SQLAdapter sqlMsBiao = new SQLAdapter(strMsBiao);
				//查找表rep_gzjgxxcjb中的数据
				List<BasicMap<String, Object>> listMsBiaoData = dbClient.find(sqlMsBiao);
				//循环计算增量
				for (BasicMap<String, Object> mapMsBiaoData : listMsBiaoData) {
					//查找当前数据
					BasicMap<String, Object> bm = dbClient.findOne("select distinct orgid,parentid,jgmc from rep_gzjgxxcjb where jgmc = ?",mapMsBiaoData.get("jgmc"));
					if (mapMsBiaoData.get("jgmc").equals(mapMssfjAllData.get("jgmc"))) {
						//存放盟市司法局增量数据
						BasicMap<String, Object> resultMap = new BasicMap<String, Object>();
						//safadsfaf
						resultMap.put("jgmc", mapMsBiaoData.get("jgmc"));
						resultMap.put("parentid",bm.get("parentid"));
						resultMap.put("orgid", bm.get("orgid"));
						//计算增量
						resultMap = fzShuJuGzMap(resultMap, mapMssfjAllData, mapMsBiaoData);

						dbClient.insert(SupConst.Collections.REP_GZJGXXCJB, resultMap);
						System.out.println("初始化"+mapMsBiaoData.get("jgmc")+"-------ok");
						//入库旗县司法局
						String strQx = "select * from Rep_gzjgxxcjb where parentid = "+resultMap.get("orgid");
						List<BasicMap<String, Object>>  listQxAllData = findAllData(StringUtil.toEmptyString(resultMap.get("orgid")), "3");
						for (BasicMap<String, Object> mapQxAllData : listQxAllData) {
							String strQxBiao = "select jgmc, " + 
									"sum(cast(zcsqjzrs as int)) as zcsqjzrs,sum(cast(jzxz as int)) as jzxz,sum(cast(bkfz as int)) as bkfz, " + 
									"sum(cast(ksgl as int)) as ksgl,sum(cast(ptgl as int)) as ptgl,sum(cast(yggl as int)) as yggl, " + 
									"sum(cast(bdwg as int)) as bdwg,sum(cast(tggl as int)) as tggl,sum(cast(zzjzjy as int)) as zzjzjy, " + 
									"sum(cast(gbthjy as int)) as gbthjy,sum(cast(jxxlfd as int)) as jxxlfd,sum(cast(zzsqfw as int)) as zzsqfw, " + 
									"sum(cast(jx as int)) as jx,sum(cast(jg as int)) as jg,sum(cast(zacf as int)) as zacf, " + 
									"sum(cast(sjzz as int)) as sjzz,sum(cast(zfz as int)) as zfz,sum(cast(jswt as int)) as jswt, " + 
									"sum(cast(wcpg as int)) as wcpg,sum(cast(cx as int)) as cx,sum(cast(zzgzry as int)) as zzgzry, " + 
									"sum(cast(zzshgzz as int)) as zzshgzz,sum(cast(shzyz as int)) as shzyz,sum(cast(yjljyjd as int)) as yjljyjd, " + 
									"sum(cast(jyjdyjl as int)) as jyjdyjl,sum(cast(yjlsqfwjd as int)) as yjlsqfwjd,sum(cast(yjlsqjzzx as int)) as yjlsqjzzx  " + 
									"from rep_gzjgxxcjb where parentid = '"+resultMap.get("orgid")+"' " + 
									"group by jgmc " + 
									"order by jgmc desc ";
							SQLAdapter sqlQxBiao = new SQLAdapter(strQxBiao);
							//查找表rep_gzjgxxcjb中的数据
							List<BasicMap<String, Object>> listQxBiaoData = dbClient.find(sqlQxBiao);
							for (BasicMap<String, Object> mapQxBiaoData : listQxBiaoData) {
								//查找当前数据
								BasicMap<String, Object> bmQx = dbClient.findOne("select distinct orgid,parentid,jgmc from rep_gzjgxxcjb where jgmc = ?",mapQxBiaoData.get("jgmc"));
								if (mapQxBiaoData.get("jgmc").equals(mapQxAllData.get("jgmc"))) {
									//存放盟市司法局增量数据
									BasicMap<String, Object> resultQxMap = new BasicMap<String, Object>();
									//safadsfaf
									resultQxMap.put("jgmc", mapQxBiaoData.get("jgmc"));
									resultQxMap.put("parentid",bmQx.get("parentid"));
									resultQxMap.put("orgid", bmQx.get("orgid"));
									//计算增量
									resultQxMap = fzShuJuGzMap(resultQxMap, mapQxAllData, mapQxBiaoData);

									dbClient.insert(SupConst.Collections.REP_GZJGXXCJB, resultQxMap);
									System.out.println("初始化"+mapQxBiaoData.get("jgmc")+"-------ok");
							}
							
						}
					}
				}
			}
		}	
	}
	public 	BasicMap<String, Object>  fzShuJuGzMap(BasicMap<String, Object> resultMap,BasicMap<String, Object> mapAllData,BasicMap<String, Object> mapBiaoData){
		resultMap.put("zcsqjzrs",NumberUtil.toInt(mapAllData.get("zcsqjzrs"))-NumberUtil.toInt(mapBiaoData.get("zcsqjzrs")));
		resultMap.put("ksgl",NumberUtil.toInt(mapAllData.get("ksgl"))-NumberUtil.toInt(mapBiaoData.get("ksgl")));
		resultMap.put("ptgl",NumberUtil.toInt(mapAllData.get("ptgl"))-NumberUtil.toInt(mapBiaoData.get("ptgl")));
		resultMap.put("yggl",NumberUtil.toInt(mapAllData.get("yggl"))-NumberUtil.toInt(mapBiaoData.get("yggl")));
		
		resultMap.put("jzxz",NumberUtil.toInt(mapAllData.get("jzxz"))-NumberUtil.toInt(mapBiaoData.get("jzxz")));
		resultMap.put("bkfz",NumberUtil.toInt(mapAllData.get("bkfz"))-NumberUtil.toInt(mapBiaoData.get("bkfz")));
		resultMap.put("bdwg",NumberUtil.toInt(mapAllData.get("bdwg"))-NumberUtil.toInt(mapBiaoData.get("bdwg")));
		resultMap.put("tggl",NumberUtil.toInt(mapAllData.get("tggl"))-NumberUtil.toInt(mapBiaoData.get("tggl")));
		resultMap.put("zzjzjy",NumberUtil.toInt(mapAllData.get("zzjzjy"))-NumberUtil.toInt(mapBiaoData.get("zzjzjy")));
		resultMap.put("gbthjy",NumberUtil.toInt(mapAllData.get("gbthjy"))-NumberUtil.toInt(mapBiaoData.get("gbthjy")));
		resultMap.put("jxxlfd",NumberUtil.toInt(mapAllData.get("jxxlfd"))-NumberUtil.toInt(mapBiaoData.get("jxxlfd")));
		resultMap.put("zzsqfw",NumberUtil.toInt(mapAllData.get("zzsqfw"))-NumberUtil.toInt(mapBiaoData.get("zzsqfw")));
		resultMap.put("jx",NumberUtil.toInt(mapAllData.get("jx"))-NumberUtil.toInt(mapBiaoData.get("jx")));
		resultMap.put("jg",NumberUtil.toInt(mapAllData.get("jg"))-NumberUtil.toInt(mapBiaoData.get("jg")));
		resultMap.put("zacf",NumberUtil.toInt(mapAllData.get("zacf"))-NumberUtil.toInt(mapBiaoData.get("zacf")));
		resultMap.put("sjzz",NumberUtil.toInt(mapAllData.get("sjzz"))-NumberUtil.toInt(mapBiaoData.get("sjzz")));
		resultMap.put("zfz",NumberUtil.toInt(mapAllData.get("zfz"))-NumberUtil.toInt(mapBiaoData.get("zfz")));
		resultMap.put("jswt",NumberUtil.toInt(mapAllData.get("jswt"))-NumberUtil.toInt(mapBiaoData.get("jswt")));
		resultMap.put("wcpg",NumberUtil.toInt(mapAllData.get("wcpg"))-NumberUtil.toInt(mapBiaoData.get("wcpg")));
		resultMap.put("cx",NumberUtil.toInt(mapAllData.get("cx"))-NumberUtil.toInt(mapBiaoData.get("cx")));
		resultMap.put("zzgzry",NumberUtil.toInt(mapAllData.get("zzgzry"))-NumberUtil.toInt(mapBiaoData.get("zzgzry")));
		resultMap.put("zzshgzz",NumberUtil.toInt(mapAllData.get("zzshgzz"))-NumberUtil.toInt(mapBiaoData.get("zzshgzz")));
		resultMap.put("shzyz",NumberUtil.toInt(mapAllData.get("shzyz"))-NumberUtil.toInt(mapBiaoData.get("shzyz")));
		resultMap.put("yjljyjd",NumberUtil.toInt(mapAllData.get("yjljyjd"))-NumberUtil.toInt(mapBiaoData.get("yjljyjd")));
		resultMap.put("jyjdyjl",NumberUtil.toInt(mapAllData.get("jyjdyjl"))-NumberUtil.toInt(mapBiaoData.get("jyjdyjl")));
		resultMap.put("yjlsqfwjd",NumberUtil.toInt(mapAllData.get("yjlsqfwjd"))-NumberUtil.toInt(mapBiaoData.get("yjlsqfwjd")));
		resultMap.put("yjlsqjzzx",NumberUtil.toInt(mapAllData.get("yjlsqjzzx"))-NumberUtil.toInt(mapBiaoData.get("yjlsqjzzx")));

		
		return resultMap;
	}
	
	/**
	 * 初始化工作监管增量表(REP_GZJGXXCJB)
	 */
		public void saveInit() {
			List<BasicMap<String, Object>> listAll = findAllData(StringUtil.toEmptyString("NM0000000000-0000-0000-0000000-00001"),"2");
				for (BasicMap<String, Object> basicMap : listAll) {
					//盟市循环入库
					basicMap.put("parentid", "NM0000000000-0000-0000-0000000-00001");
					BasicMap<String, Object> basicMap2 = dbClient.findOne("select id from jc_sfxzjgjbxx where jgmc = ?",basicMap.get("jgmc"));
					basicMap.put("orgid",basicMap2.get("id"));
					//basicMap.put("id",basicMap2.get("id"));
					dbClient.insert(SupConst.Collections.REP_GZJGXXCJB, basicMap);
					
					//保存旗县司法局
					saveQxsfj(StringUtil.toEmptyString(basicMap2.get("id")));
				}
		}
		//旗县司法局参数为盟市id
		public void saveQxsfj(String orgid) {
				//查询当前旗县局下所有司法所
				List<BasicMap<String, Object>> list = findAllData(orgid,"3");
				for (BasicMap<String, Object> basicMap : list) {
					//司法所入库
					BasicMap<String, Object> basicMap2 = dbClient.findOne("select id,parentid from jc_sfxzjgjbxx where jgmc = ?",basicMap.get("jgmc"));
					basicMap.put("parentid",basicMap2.get("parentid"));
					basicMap.put("orgid",basicMap2.get("id"));
					//basicMap.put("id",basicMap2.get("id"));
					dbClient.insert(SupConst.Collections.REP_GZJGXXCJB, basicMap);
					
					//保存司法所
					saveSfs(StringUtil.toEmptyString(basicMap2.get("id")));
				}
		}
		//司法所参数为旗县司法局的id
		public void saveSfs(String orgid) {
			
				//查询当前旗县局下所有司法所
				List<BasicMap<String, Object>> listAll = findAllData(orgid,"4");
				for (BasicMap<String, Object> basicMap : listAll) {
					//司法所入库(mmp有重名的)
					String str = "select id,parentid from jc_sfxzjgjbxx where jgmc ='"+basicMap.get("jgmc")+"'";
					List<BasicMap<String, Object>> list = dbClient.find(new SQLAdapter(str));
					for (BasicMap<String, Object> basicMap2 : list) {
						
						if (orgid.equals(basicMap2.get("parentid"))) {
							
							basicMap.put("parentid",basicMap2.get("parentid"));
							basicMap.put("orgid",basicMap2.get("id"));
							//basicMap.put("id",basicMap1.get("id"));
							dbClient.insert(SupConst.Collections.REP_GZJGXXCJB, basicMap);
						}
					}
				}

		
		}
		

		/**
		 * 查找人员监管数据
		 * @param orgid
		 * @param likeGroupBy
		 * @return
		 */
		public List<BasicMap<String, Object>> findAllRyData(String orgid,String likeGroupBy){
			List<BasicMap<String, Object>> list = new ArrayList<BasicMap<String,Object>>();
			
			
			String likeSfjGroupBy = " and a.jgmc like '%司法局' GROUP BY a.jgmc ORDER BY a.jgmc DESC ";
			String likeSfsGroupBy = " and b.jcjz = '0'  and a.jgmc like '%司法所' GROUP BY a.jgmc ORDER BY a.jgmc DESC ";
			//判断当前登录人是否为旗县司法局
			if (NumberUtil.toInt(likeGroupBy)<4) {
				list = findDataRysfsOrsfj(orgid,likeSfjGroupBy);
			}else {
				list = findDataRysfsOrsfj(orgid,likeSfsGroupBy);
			}
			return list;
			
		}
		
		
		/**
		 * 人员监管
		 * 根据orgid 和机构类型(司法局或者司法所)查找所有报表字段数据 
		 * @param orgid
		 * @param likeSfsGroupBy
		 * @return
		 */
		public List<BasicMap<String, Object>> findDataRysfsOrsfj(String orgid,String likeGroupBy){
			//存放结果
			List<BasicMap<String, Object>> list = new ArrayList<BasicMap<String,Object>>();
			//本月增加人数
			String[] nowDate = df.format(date).split("-");
			//本月开始日
			String starDate = nowDate[0] + nowDate[1] +"01";
			//本月结束日
			String endDate = nowDate[0] + nowDate[1] +"31";
			//未满18周岁时间
			String wcnDate = (NumberUtil.toInt(nowDate[0])-18)+ "0101";
			//18周岁到45周岁
			String fourDate = (NumberUtil.toInt(nowDate[0])-45)+ "0101";
			//45到60周岁
			String sixDate = (NumberUtil.toInt(nowDate[0])-60)+ "0101";
			
			
			//------1在册社区矫正人数 
			String str1 = "select a.jgmc,count(b.id) as zcsqjzrs from jc_sfxzjgjbxx a " + 
					"left JOIN JZ_JZRYJBXX b ON a.id = b.orgid " + 
					"where a.parentid =  '"+orgid+"'"+likeGroupBy;
			SQLAdapter sql = new SQLAdapter(str1);
			list = dbClient.find(sql);
			//--2本月增加
			String str2 = "select a.jgmc,sum(case when b.cdate BETWEEN '"+starDate+"' and '"+endDate+"' then 1 else 0 end) as byzj from jc_sfxzjgjbxx a left OUTER JOIN jz_jzryjbxx b  " + 
					"on b.orgid = a.id where a.parentid = '"+orgid+"'"  + likeGroupBy;
			list = findDataUtil(list, str2);
			//--3期满解除--收监执行---死亡
			String str3 = "select a.jgmc," + 
					"sum(case when c.jjlx='01' then 1 else 0 end) as jjlx, " + 
					"sum(case when c.jjlx='99' then 1 else 0 end) as swqt, " + 
					"sum(case when c.sjzxlx='01' then 1 else 0 end) as cxhx, " + 
					"sum(case when c.sjzxlx='02' then 1 else 0 end) as cxjs, " + 
					"sum(case when c.sjzxlx='03' then 1 else 0 end) as jdsj, " + 
					"sum(case when c.sjzxlx='99' then 1 else 0 end) as sjzxqt, " + 
					"sum(case when c.swyy='01' then 1 else 0 end) as zcsw, " + 
					"sum(case when c.swyy='02' then 1 else 0 end) as fzcsw " + 
					"from jc_sfxzjgjbxx a LEFT JOIN jz_jzryjbxx b on b.orgid = a.id  " + 
					"LEFT JOIN JZ_JZJCXXCJB c on  c.id = b.id where a.parentid =  '"+orgid+"'" +likeGroupBy;
			list = findDataUtil(list, str3);
			//--4性别-未成年----十八到四十五周岁--46到60
			String str4 = "select a.jgmc,sum(case when b.xb='1' then 1 else 0 end) as nan, " + 
					"sum(case when b.xb='2' then 1 else 0 end) as nv , " + 
					"sum(case when b.csrq > TIMESTAMP '"+wcnDate+"' then 1 else 0 end) as wcn, " + 
					"sum(case when b.csrq BETWEEN '"+wcnDate+"' and '"+fourDate+"' then 1 else 0 end) as cntwo, " + 
					"sum(case when b.csrq BETWEEN '"+fourDate+"' and '"+sixDate+"' then 1 else 0 end) as cnthree, " + 
					"sum(case when b.csrq <TIMESTAMP '"+sixDate+"' then 1 else 0 end) as cnold " + 
					"from jc_sfxzjgjbxx a left JOIN jz_jzryjbxx b  " + 
					"on b.orgid = a.id where a.parentid ='"+orgid+"'"+likeGroupBy;
			list = findDataUtil(list, str4);
			//-5本省户籍--外省户籍---港澳台--无国籍
			String str5 = "select a.jgmc,sum(case when c.hjszs='15' then 1 else 0 end) as bshj, " + 
					"sum(case when c.hjszs<>'15' then 1 else 0 end) as wshj, " + 
					"sum(case  " + 
					"when c.gj='13' then 1  " + 
					"when c.gj='14' then 1 " + 
					"when c.gj='15' then 1 " + 
					"else 0 end) as gatj, " + 
					"sum(case  " + 
					"when c.gj='02' then 1  " + 
					"when c.gj='03' then 1  " + 
					"else 0 end) as wgj " + 
					" from jc_sfxzjgjbxx a  " + 
					"left JOIN jz_jzryjbxx b on b.orgid = a.id " + 
					"LEFT JOIN JZ_JZRYJBXX_DZ c on c.id = b.id where a.parentid = '"+orgid+"'"+likeGroupBy;
			list = findDataUtil(list, str5);
			//-6文化程度--小学--初中--高中--大专及以上---婚姻状况--名族--就学
			String str6 = "select a.jgmc,sum(case when b.whcd='01' then 1  " + 
					"when b.whcd='02' then 1 " + 
					"else 0 end) as xxjyx," + 
					"sum(case when b.whcd='03' then 1 else 0 end) as czxl," + 
					"sum(case when b.whcd='04' then 1 else 0 end) as gzxl," + 
					"sum(case when b.whcd='05' then 1 " + 
					"when b.whcd ='06' then 1 " + 
					"when b.whcd ='07' then 1  " + 
					"when b.whcd ='08' then 1 else 0 end) as dzjys, " + 
					"sum(case when b.hyzk='01' then 1 else 0 end) as wh, " + 
					"sum(case when b.hyzk='02' then 1 else 0 end) as yh, " + 
					"sum(case when b.hyzk='03' then 1 else 0 end) as ly, " + 
					"sum(case when b.hyzk='04' then 1 else 0 end) as so, " + 
					"sum(case when b.hyzk='05' then 1 else 0 end) as zh, " + 
					"sum(case when b.mz = '01' then 1 else 0 end) as hz, " + 
					"sum(case when b.mz <> '01' then 1 else 0 end) as ssmz, " + 
					"sum(case when b.jyjxqk = '01' then 1 else 0 end) as jx, " + 
					"sum(case when b.jyjxqk = '02' then 1 else 0 end) as jy, " + 
					"sum(case when b.jyjxqk = '04' then 1 else 0 end) as wy " + 
					" from jc_sfxzjgjbxx a  " + 
					"left JOIN jz_jzryjbxx b on b.orgid = a.id " + 
					"where a.parentid ='"+orgid+"'"+likeGroupBy;
			list = findDataUtil(list, str6);
			//-7矫正期限---矫正类别---犯罪类型--JZ_JZRYJBXX_JZ-------------
			String str7 = "select a.jgmc, " + 
					"sum(case when c.gzqx='01' then 1 else 0 end) as xiaoqx,  " + 
					"sum(case when c.gzqx='02' then 1 else 0 end) as zhongqx, " + 
					"sum(case when c.gzqx='03' then 1 else 0 end) as xzqx, " + 
					"sum(case when c.gzqx='04' then 1 else 0 end) as daqx, " + 
					"sum(case when c.jzlb='01' then 1 else 0 end) as gz, " + 
					"sum(case when c.jzlb='02' then 1 else 0 end) as hx, " + 
					"sum(case when c.jzlb='03' then 1 else 0 end) as js, " + 
					"sum(case when c.jzlb='04' then 1 else 0 end) as zyjwzx, " + 
					"sum(case when c.jzlb='99' then 1 else 0 end) as bdzzql, " + 
					"sum(case when c.fzlx='01' then 1 else 0 end) as whgjaq, " + 
					"sum(case when c.fzlx='02' then 1 else 0 end) as whggaq, " + 
					"sum(case when c.fzlx='03' then 1 else 0 end) as phshzy, " + 
					"sum(case when c.fzlx='04' then 1 else 0 end) as qfgmrsql, " + 
					"sum(case when c.fzlx='05' then 1 else 0 end) as qfcc, " + 
					"sum(case when c.fzlx='06' then 1 else 0 end) as fashglzx, " + 
					"sum(case when c.fzlx='08' then 1 else 0 end) as twsh, " + 
					"sum(case when c.fzlx='09' then 1 else 0 end) as dz, " + 
					"sum(case when c.fzlx='99' then 1 else 0 end) as qt " + 
					"from jc_sfxzjgjbxx a LEFT JOIN jz_jzryjbxx b on b.orgid = a.id " + 
					"LEFT JOIN JZ_JZRYJBXX_JZ c on  c.id = b.id where a.parentid = '"+orgid+"'"+likeGroupBy;
			list = findDataUtil(list, str7);
			return list;
		}
		/**
		 * 初始化人员监管增量表(REP_RYJGXXCJB)
		 */
		public void saveIninRy() {
			List<BasicMap<String, Object>> listAll = findAllRyData(StringUtil.toEmptyString("NM0000000000-0000-0000-0000000-00001"),"2");
			for (BasicMap<String, Object> basicMap : listAll) {
				//盟市循环入库
				basicMap.put("parentid", "NM0000000000-0000-0000-0000000-00001");
				BasicMap<String, Object> basicMap2 = dbClient.findOne("select id from jc_sfxzjgjbxx where jgmc = ?",basicMap.get("jgmc"));
				basicMap.put("orgid",basicMap2.get("id"));
				//basicMap.put("id",basicMap2.get("id"));
				dbClient.insert(SupConst.Collections.REP_RYJGXXCJB, basicMap);
				
				//保存旗县司法局
				saveRyQxsfj(StringUtil.toEmptyString(basicMap2.get("id")));
			}
		}
		//旗县司法局参数为盟市id
		public void saveRyQxsfj(String orgid) {
				//查询当前旗县局下所有司法所
				List<BasicMap<String, Object>> list = findAllRyData(orgid,"3");
				for (BasicMap<String, Object> basicMap : list) {
					//司法所入库
					BasicMap<String, Object> basicMap2 = dbClient.findOne("select id,parentid from jc_sfxzjgjbxx where jgmc = ?",basicMap.get("jgmc"));
					basicMap.put("parentid",basicMap2.get("parentid"));
					basicMap.put("orgid",basicMap2.get("id"));
					//basicMap.put("id",basicMap2.get("id"));
					dbClient.insert(SupConst.Collections.REP_RYJGXXCJB, basicMap);
					
					//保存司法所
					saveRySfs(StringUtil.toEmptyString(basicMap2.get("id")));
				}
		}
		//司法所参数为旗县司法局的id
		public void saveRySfs(String orgid) {
			
				//查询当前旗县局下所有司法所
				List<BasicMap<String, Object>> listAll = findAllRyData(orgid,"4");
				for (BasicMap<String, Object> basicMap : listAll) {
					//司法所入库(mmp有重名的)
					String str = "select id,parentid from jc_sfxzjgjbxx where jgmc ='"+basicMap.get("jgmc")+"'";
					List<BasicMap<String, Object>> list = dbClient.find(new SQLAdapter(str));
					for (BasicMap<String, Object> basicMap2 : list) {
						
						if (orgid.equals(basicMap2.get("parentid"))) {
							
							basicMap.put("parentid",basicMap2.get("parentid"));
							basicMap.put("orgid",basicMap2.get("id"));
							//basicMap.put("id",basicMap1.get("id"));
							dbClient.insert(SupConst.Collections.REP_RYJGXXCJB, basicMap);
						}
					}
				}
	
				
		}
		/**
		 * 计算增量保存
		 */
		public void saveRyIncrement() {
			//入库盟市司法局
			List<BasicMap<String, Object>> listMssfjAllData = findAllRyData("NM0000000000-0000-0000-0000000-00001", "1");
			for (BasicMap<String, Object> mapMssfjAllData : listMssfjAllData) {
				//根据厅级orgid Rep_ryjgxxcib中对应机构的sum集合
				String strMsBiao = "select jgmc, " + 
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
						"from rep_ryjgxxcjb where parentid = 'NM0000000000-0000-0000-0000000-00001' " + 
						"group by jgmc " + 
						"order by jgmc desc ";
				SQLAdapter sqlMsBiao = new SQLAdapter(strMsBiao);
				//查找表rep_gzjgxxcjb中的数据
				List<BasicMap<String, Object>> listMsBiaoData = dbClient.find(sqlMsBiao);
				//循环计算增量
				for (BasicMap<String, Object> mapMsBiaoData : listMsBiaoData) {
					//查找当前数据
					BasicMap<String, Object> bm = dbClient.findOne("select distinct orgid,parentid,jgmc from rep_ryjgxxcjb where jgmc = ?",mapMsBiaoData.get("jgmc"));
					if (mapMsBiaoData.get("jgmc").equals(mapMssfjAllData.get("jgmc"))) {
						//存放盟市司法局增量数据
						BasicMap<String, Object> resultMap = new BasicMap<String, Object>();
						//safadsfaf
						resultMap.put("jgmc", mapMsBiaoData.get("jgmc"));
						resultMap.put("parentid",bm.get("parentid"));
						resultMap.put("orgid", bm.get("orgid"));
						//封装数据
						BasicMap<String, Object> result= fzShuJuMap(resultMap,mapMssfjAllData,mapMsBiaoData);
						dbClient.insert(SupConst.Collections.REP_RYJGXXCJB, result);
						System.out.println("初始化"+mapMsBiaoData.get("jgmc")+"-------ok");
						
						//入库旗县司法局
						List<BasicMap<String, Object>>  listQxAllData = findAllRyData(StringUtil.toEmptyString(resultMap.get("orgid")), "3");
						for (BasicMap<String, Object> mapQxAllData : listQxAllData) {
							String strQxBiao = "select jgmc, " + 
									"sum(cast(zcsqjzrs as int)) as zcsqjzrs,sum(cast(byzj as int)) as byzj,sum(cast(qmjc as int)) as qmjc, " + 
									"sum(cast(cxhc as int)) as cxhc,sum(cast(cxjs as int)) as cxjs,sum(cast(jdsj as int)) as jdsj, " + 
									"sum(cast(sjzxqt as int)) as sjzxqt,sum(cast(zcsw as int)) as zcsw,sum(cast(fzcsw as int)) as fzcsw, " + 
									"sum(cast(swqt as int)) as swqt,sum(cast(nan as int)) as nan,sum(cast(nv as int)) as nv, " + 
									"sum(cast(wcn as int)) as wcn,sum(cast(cntwo as int)) as cntwo,sum(cast(cnthree as int)) as cnthree, " + 
									"sum(cast(cnold as int)) as cnold,sum(cast(bshj as int)) as bshj,sum(cast(wshj as int)) as wshj, " + 
									"sum(cast(gatj as int)) as gatj,sum(cast(wgj as int)) as wgj,sum(cast(xxjyx as int)) as xxjyx, " + 
									"sum(cast(czxl as int)) as czxl,sum(cast(gzxl as int)) as gzxl,sum(cast(dzjys as int)) as dzjys, " + 
									"sum(cast(wh as int)) as wh,sum(cast(yh as int)) as yh,sum(cast(so as int)) as so,  " + 
									"sum(cast(ly as int)) as ly,sum(cast(zh as int)) as zh,sum(cast(hz as int)) as hz, " + 	
									"sum(cast(shmz as int)) as shmz,sum(cast(jx as int)) as jx,sum(cast(jy as int)) as jy, " + 
									"sum(cast(wy as int)) as wy,sum(cast(xiaoqx as int)) as xiaoqx,sum(cast(zhongqx as int)) as zhongqx, " + 
									"sum(cast(xzqx as int)) as xzqx,sum(cast(daqx as int)) as daqx,sum(cast(gz as int)) as gz, " + 
									"sum(cast(hx as int)) as hx,sum(cast(js as int)) as js,sum(cast(zyjwzx as int)) as zyjwzx, " + 
									"sum(cast(bdzzql as int)) as bdzzql,sum(cast(whgjaq as int)) as whgjaq,sum(cast(whggaq as int)) as whggaq, " + 
									"sum(cast(phjjzx as int)) as phjjzx,sum(cast(qfgmrsql as int)) as qfgmrsql,sum(cast(qfcc as int)) as qfcc, " + 
									"sum(cast(fhshglzx as int)) as fhshglzx,sum(cast(twsh as int)) as twsh,sum(cast(dz as int)) as dz, " + 
									"sum(cast(qt as int)) as qt "+
									"from rep_ryjgxxcjb where parentid = '"+resultMap.get("orgid")+"' " + 
									"group by jgmc " + 
									"order by jgmc desc ";
							SQLAdapter sqlQxBiao = new SQLAdapter(strQxBiao);
							//查找表rep_ryjgxxcjb中的数据
							List<BasicMap<String, Object>> listQxBiaoData = dbClient.find(sqlQxBiao);
							for (BasicMap<String, Object> mapQxBiaoData : listQxBiaoData) {
								//查找当前数据
								BasicMap<String, Object> bmQx = dbClient.findOne("select distinct orgid,parentid,jgmc from rep_ryjgxxcjb where jgmc = ?",mapQxBiaoData.get("jgmc"));
								if (mapQxBiaoData.get("jgmc").equals(mapQxAllData.get("jgmc"))) {
									//存放旗县司法局增量数据
									BasicMap<String, Object> resultQxMap = new BasicMap<String, Object>();
									//计算增量
									resultQxMap.put("jgmc", mapQxBiaoData.get("jgmc"));
									resultQxMap.put("parentid",bmQx.get("parentid"));
									resultQxMap.put("orgid", bmQx.get("orgid"));
									BasicMap<String, Object> resultQx =	fzShuJuMap(resultQxMap, mapQxAllData, mapQxBiaoData);
									dbClient.insert(SupConst.Collections.REP_RYJGXXCJB, resultQx);
									
									
									//入库司法所
									List<BasicMap<String, Object>>  listSfsAllData = findAllRyData(StringUtil.toEmptyString(resultQxMap.get("orgid")), "4");
									for (BasicMap<String, Object> mapSfsAllData : listSfsAllData) {
										String strSfsBiao = "select jgmc, " + 
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
												"from rep_ryjgxxcjb where parentid = '"+resultQxMap.get("orgid")+"' " + 
												"group by jgmc " + 
												"order by jgmc desc ";
										SQLAdapter sqlSfsBiao = new SQLAdapter(strSfsBiao);
										//查找表rep_ryjgxxcjb中的数据
										List<BasicMap<String, Object>> listSfsBiaoData = dbClient.find(sqlSfsBiao);
										for (BasicMap<String, Object> mapSfsBiaoData : listSfsBiaoData) {
											//查找当前数据
											BasicMap<String, Object> bmSfs = dbClient.findOne("select distinct orgid,parentid,jgmc from rep_ryjgxxcjb where jgmc = ?",mapSfsBiaoData.get("jgmc"));
											if (mapSfsBiaoData.get("jgmc").equals(mapSfsAllData.get("jgmc"))) {
												//存放司法所增量数据
												BasicMap<String, Object> resultSfsMap = new BasicMap<String, Object>();
												//计算增量
												resultSfsMap.put("jgmc", mapSfsBiaoData.get("jgmc"));
												resultSfsMap.put("parentid",bmSfs.get("parentid"));
												resultSfsMap.put("orgid", bmSfs.get("orgid"));
												BasicMap<String, Object> resultSfMap =	fzShuJuMap(resultSfsMap, mapSfsAllData, mapSfsBiaoData);
												dbClient.insert(SupConst.Collections.REP_RYJGXXCJB, resultSfMap);
												
												
												
												
											}}}	
									
								}}}		
						
					}
				}
			}
		}
		
		
		/**
		 * 封装计算人员增量
		 * @param resultMap
		 * @param mapAllData
		 * @param mapBiaoData
		 * @return
		 */
		public 	BasicMap<String, Object>  fzShuJuMap(BasicMap<String, Object> resultMap,BasicMap<String, Object> mapAllData,BasicMap<String, Object> mapBiaoData){
			
			//计算增量
			resultMap.put("zcsqjzrs",NumberUtil.toInt(mapAllData.get("zcsqjzrs"))-NumberUtil.toInt(mapBiaoData.get("zcsqjzrs")));
			resultMap.put("byzj",NumberUtil.toInt(mapAllData.get("byzj"))-NumberUtil.toInt(mapBiaoData.get("byzj")));
			resultMap.put("qmjc",NumberUtil.toInt(mapAllData.get("qmjc"))-NumberUtil.toInt(mapBiaoData.get("qmjc")));
			resultMap.put("cxhc",NumberUtil.toInt(mapAllData.get("cxhc"))-NumberUtil.toInt(mapBiaoData.get("cxhc")));
			resultMap.put("cxjs",NumberUtil.toInt(mapAllData.get("cxjs"))-NumberUtil.toInt(mapBiaoData.get("cxjs")));
			resultMap.put("jdsj",NumberUtil.toInt(mapAllData.get("jdsj"))-NumberUtil.toInt(mapBiaoData.get("jdsj")));
			resultMap.put("sjzxqt",NumberUtil.toInt(mapAllData.get("sjzxqt"))-NumberUtil.toInt(mapBiaoData.get("sjzxqt")));
			resultMap.put("zcsw",NumberUtil.toInt(mapAllData.get("zcsw"))-NumberUtil.toInt(mapBiaoData.get("zcsw")));
			resultMap.put("fzcsw",NumberUtil.toInt(mapAllData.get("fzcsw"))-NumberUtil.toInt(mapBiaoData.get("fzcsw")));
			resultMap.put("swqt",NumberUtil.toInt(mapAllData.get("swqt"))-NumberUtil.toInt(mapBiaoData.get("swqt")));
			resultMap.put("nan",NumberUtil.toInt(mapAllData.get("nan"))-NumberUtil.toInt(mapBiaoData.get("nan")));
			resultMap.put("nv",NumberUtil.toInt(mapAllData.get("nv"))-NumberUtil.toInt(mapBiaoData.get("nv")));
			resultMap.put("wcn",NumberUtil.toInt(mapAllData.get("wcn"))-NumberUtil.toInt(mapBiaoData.get("wcn")));
			resultMap.put("cntwo",NumberUtil.toInt(mapAllData.get("cntwo"))-NumberUtil.toInt(mapBiaoData.get("cntwo")));
			resultMap.put("cnthree",NumberUtil.toInt(mapAllData.get("cnthree"))-NumberUtil.toInt(mapBiaoData.get("cnthree")));
			resultMap.put("cnold",NumberUtil.toInt(mapAllData.get("cnold"))-NumberUtil.toInt(mapBiaoData.get("cnold")));
			resultMap.put("bshj",NumberUtil.toInt(mapAllData.get("bshj"))-NumberUtil.toInt(mapBiaoData.get("bshj")));
			resultMap.put("wshj",NumberUtil.toInt(mapAllData.get("wshj"))-NumberUtil.toInt(mapBiaoData.get("wshj")));
			resultMap.put("gatj",NumberUtil.toInt(mapAllData.get("gatj"))-NumberUtil.toInt(mapBiaoData.get("gatj")));
			resultMap.put("wgj",NumberUtil.toInt(mapAllData.get("wgj"))-NumberUtil.toInt(mapBiaoData.get("wgj")));
			resultMap.put("xxjyx",NumberUtil.toInt(mapAllData.get("xxjyx"))-NumberUtil.toInt(mapBiaoData.get("xxjyx")));
			resultMap.put("czxl",NumberUtil.toInt(mapAllData.get("czxl"))-NumberUtil.toInt(mapBiaoData.get("czxl")));
			resultMap.put("gzxl",NumberUtil.toInt(mapAllData.get("gzxl"))-NumberUtil.toInt(mapBiaoData.get("gzxl")));
			resultMap.put("dzjys",NumberUtil.toInt(mapAllData.get("dzjys"))-NumberUtil.toInt(mapBiaoData.get("dzjys")));
			resultMap.put("wh",NumberUtil.toInt(mapAllData.get("wh"))-NumberUtil.toInt(mapBiaoData.get("wh")));
			resultMap.put("yh",NumberUtil.toInt(mapAllData.get("yh"))-NumberUtil.toInt(mapBiaoData.get("yh")));
			resultMap.put("so",NumberUtil.toInt(mapAllData.get("so"))-NumberUtil.toInt(mapBiaoData.get("so")));
			resultMap.put("ly",NumberUtil.toInt(mapAllData.get("ly"))-NumberUtil.toInt(mapBiaoData.get("ly")));
			resultMap.put("zh",NumberUtil.toInt(mapAllData.get("zh"))-NumberUtil.toInt(mapBiaoData.get("zh")));
			resultMap.put("hz",NumberUtil.toInt(mapAllData.get("hz"))-NumberUtil.toInt(mapBiaoData.get("hz")));

			resultMap.put("shmz",NumberUtil.toInt(mapAllData.get("shmz"))-NumberUtil.toInt(mapBiaoData.get("shmz")));
			resultMap.put("jx",NumberUtil.toInt(mapAllData.get("jx"))-NumberUtil.toInt(mapBiaoData.get("jx")));
			resultMap.put("jy",NumberUtil.toInt(mapAllData.get("jy"))-NumberUtil.toInt(mapBiaoData.get("jy")));
			resultMap.put("wy",NumberUtil.toInt(mapAllData.get("wy"))-NumberUtil.toInt(mapBiaoData.get("wy")));
			resultMap.put("xiaoqx",NumberUtil.toInt(mapAllData.get("xiaoqx"))-NumberUtil.toInt(mapBiaoData.get("xiaoqx")));
			resultMap.put("zhongqx",NumberUtil.toInt(mapAllData.get("zhongqx"))-NumberUtil.toInt(mapBiaoData.get("zhongqx")));
			resultMap.put("xzqx",NumberUtil.toInt(mapAllData.get("xzqx"))-NumberUtil.toInt(mapBiaoData.get("xzqx")));
			resultMap.put("daqx",NumberUtil.toInt(mapAllData.get("daqx"))-NumberUtil.toInt(mapBiaoData.get("daqx")));
			resultMap.put("gz",NumberUtil.toInt(mapAllData.get("gz"))-NumberUtil.toInt(mapBiaoData.get("gz")));
			resultMap.put("hx",NumberUtil.toInt(mapAllData.get("hx"))-NumberUtil.toInt(mapBiaoData.get("hx")));
			resultMap.put("js",NumberUtil.toInt(mapAllData.get("js"))-NumberUtil.toInt(mapBiaoData.get("js")));
			resultMap.put("zyjwzx",NumberUtil.toInt(mapAllData.get("zyjwzx"))-NumberUtil.toInt(mapBiaoData.get("zyjwzx")));
			resultMap.put("bdzzql",NumberUtil.toInt(mapAllData.get("bdzzql"))-NumberUtil.toInt(mapBiaoData.get("bdzzql")));
			resultMap.put("whgjaq",NumberUtil.toInt(mapAllData.get("whgjaq"))-NumberUtil.toInt(mapBiaoData.get("whgjaq")));
			resultMap.put("whggaq",NumberUtil.toInt(mapAllData.get("whggaq"))-NumberUtil.toInt(mapBiaoData.get("whggaq")));
			resultMap.put("phjjzx",NumberUtil.toInt(mapAllData.get("phjjzx"))-NumberUtil.toInt(mapBiaoData.get("phjjzx")));
			resultMap.put("qfgmrsql",NumberUtil.toInt(mapAllData.get("qfgmrsql"))-NumberUtil.toInt(mapBiaoData.get("qfgmrsql")));
			resultMap.put("qfcc",NumberUtil.toInt(mapAllData.get("qfcc"))-NumberUtil.toInt(mapBiaoData.get("qfcc")));
			resultMap.put("fhshglzx",NumberUtil.toInt(mapAllData.get("fhshglzx"))-NumberUtil.toInt(mapBiaoData.get("fhshglzx")));
			resultMap.put("twsh",NumberUtil.toInt(mapAllData.get("twsh"))-NumberUtil.toInt(mapBiaoData.get("twsh")));
			
			resultMap.put("dz",NumberUtil.toInt(mapAllData.get("dz"))-NumberUtil.toInt(mapBiaoData.get("dz")));
			resultMap.put("qt",NumberUtil.toInt(mapAllData.get("qt"))-NumberUtil.toInt(mapBiaoData.get("qt")));

			
			return resultMap;
			
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
