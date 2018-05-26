package com.ehtsoft.sqjz.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;

@Service("SqjzOverviewService")
public class SqjzOverviewService extends AbstractService {

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	//在册人员总数;减刑情况总数;变更居住地总数;外出申请总数;警告总数;撤销缓刑总数;治安处罚总数
	public List<BasicMap<String,Object>> find_zs(BasicMap<String,Object> query){
		String sqlstr = "SELECT SUM(ry) ry,SUM(jzd) jzd,SUM(wcsq) wcsq,SUM(zacf) zacf,SUM(jg) jg,SUM(cxhx) cxhx,sum(jx) jxrn" + 
				"FROM " + 
				" (SELECT count(id)as ry,count(jzdid)as jzd,count(wcsqid) as wcsq,rn " + 
				" count(zacfid) as zacf,count(jgid) as jg,count(cxhxid) as cxhx,count(jxid) as jx from view_sqjz_zl) a";  
				
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
	//解除矫正人数
	public List<BasicMap<String,Object>> findJcjz(BasicMap<String,Object> query){
		String sqlstr = "SELECT count(ID) FROM jz_jzryjbxx where jcjz <> '0' AND jcjz is not NULL ";
				
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
	
	//人员类别
	public List<BasicMap<String,Object>> findRylb(){
		String sqlstr = "SELECT a.jglx,b.f_name lbname,count(a.jzrys)  FROM view_rep_jzrys_lx a left join sys_dictionary b on a.jglx = b.f_code where b.f_typecode = 'SYS114' group by a.jglx,lbname ";
		List<BasicMap<String,Object>> list=new ArrayList();
		SQLAdapter sql = new SQLAdapter(sqlstr);
		list=dbClient.find(sql);
		return list;
	}
	
	//个别教育
	public List<BasicMap<String,Object>> findGbjy(){
		String sqlstr = "SELECT count(pxqkid),substring(pxsj,1,7) mon from jz_gbjyqk GROUP BY mon";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		List<BasicMap<String,Object>> list=new ArrayList();
		
		list=dbClient.find(sql);
		
		return list;
	}
	
	//集中教育
		public List<BasicMap<String,Object>> findJzjy(){
			String sqlstr = "SELECT count(pxqkid),substring(pxksj,1,7) mon from JZ_PXQKDJB GROUP BY mon";
			SQLAdapter sql = new SQLAdapter(sqlstr);
			List<BasicMap<String,Object>> list=new ArrayList();
			
			list=dbClient.find(sql);
			
			return list;
		}
	
		
	//奖惩情况:警告（cnt）治安处罚（cnt2）减刑（cnt3）监外执行人员（cnt4）撤销缓刑（假释）（cnt5）
	public List<BasicMap<String,Object>> findJcqk(){
		String sqlstr = "select cnt,cnt2,cnt3,cnt4,cnt5 from view_zl_sqjz_jcqk";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		List<BasicMap<String,Object>> list=new ArrayList();
		
		list=dbClient.find(sql);
		
		return list;
	}
	//罪名情况
	public List<BasicMap<String,Object>> findZmqk(){
		String sqlstr = "SELECT a.jtzm,b.f_name lbname,count(a.ID) FROM jz_jzryjbxx_jz a left join sys_dictionary b on a.jtzm = b.f_code where b.f_typecode = 'SYS096'  group by a.jtzm,lbname";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		List<BasicMap<String,Object>> list=new ArrayList();
		
		list=dbClient.find(sql);
		
		return list;
	}
	
	//三天内未登录人员
	public List<BasicMap<String,Object>> findWdlry(){
		String sqlstr = "SELECT  mon,count(a.aid) FROM" + 
				"	(SELECT a.aid, substring(to_char(a.udate,'99999999'),1,7) mon,count(a.aid) cnt FROM jz_qdxxb a LEFT JOIN jz_jzryjbxx b on b.id=a.aid where ((now()::timestamp)::date-a.uts::date)>3 GROUP BY a.aid,mon) a "+ 
				" GROUP BY mon";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		List<BasicMap<String,Object>> list=new ArrayList();
		
		list=dbClient.find(sql);
		
		return list;
	}
	
	//报警人数
	public List<BasicMap<String,Object>> findBjrs(){
		String sqlstr = "SELECT substring(to_char(cdate,'99999999'),1,7) mon,count(f_id) from JZ_ALARM GROUP BY mon";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		List<BasicMap<String,Object>> list=new ArrayList();
		
		list=dbClient.find(sql);
		
		return list;
	}
	
	//矫正人员使用app情况
	public List<BasicMap<String,Object>> findApps(){
		String sqlstr = "SELECT substring(to_char(cdate,'99999999'),1,7) mon,count(jzrys) FROM view_rep_jzry_zcrs";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		List<BasicMap<String,Object>> list=new ArrayList();
		
		list=dbClient.find(sql);
		
		return list;
	}
}
