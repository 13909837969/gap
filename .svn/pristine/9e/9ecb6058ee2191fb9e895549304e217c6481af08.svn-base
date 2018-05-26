package com.ehtsoft.supervise.services;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.dto.AuditApply;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;
@Service("JzryHsqzxxService")
public class JzryHsqzxxService extends AbstractService{     
	@Resource(name="SSOService")
	private SSOService ssoService;
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
/**
 * 查询所有信息
 * xm 人员姓名,xb 性别,sfzh 身份证号,grlxdh 个人联系电话,JGLX 矫管类型,bhsqzr 
 * 被核实取证人,hsqzsy 核实取证事由,hsqzr 核实取证人,hsqzsj 核实取证时间,hsqzdd 
 * 核实取证地点,hsqkjl 核实情况记录,clyj处理意见
 * @param data
 * @param paginate
 * @return
 */
   public ResultList<BasicMap<String,Object>> find(BasicMap<String,Object> query,Paginate paginate){	  
	   SqlDbFilter filter = toSqlFilter(query);
	   String sql = "select a.id,a.xm,a.xb,a.sfzh,a.audit,a.grlxdh,a.JGLX,b.id,b.aid,b.bhsqzr,b.hsqzsy,b.hsqzr,b.hsqzsj,b.hsqzdd,b.HSQKJL,b.clyj,c.id,c.GDJZDMX FROM JZ_JZRYJBXX A LEFT JOIN JZ_JZRYJBXX_DZ C ON A.ID = C.ID LEFT JOIN JZ_HSQZXXCJB B ON B.AID=a.ID";
	   SQLAdapter sqlAdapter = new SQLAdapter(sql);	   
       filter.eq("a.AUDIT",NumberUtil.toInt(query.get("audit")));
		sqlAdapter.setFilter(filter);
		ResultList<BasicMap<String, Object>> list = dbClient.find(sqlAdapter, paginate);	   
	   return list;
   }
   /**
    * 保存核实取证信息采集表 
    *  核实取证信息采集数据 数据格式：见 JZ_HSQZXXCJB 表
    */
   public void save(BasicMap<String, Object> data) {
		User user = ssoService.getUser();
		dbClient.save(SupConst.Collections.JZ_HSQZXXCJB, data);		  
		String aid = StringUtil.toString(data.get("aid"));
		if(aid==null){
			throw new AppException("上报核实取证信息的服刑人员不能为空");
		}
		BasicMap<String, Object> one = dbClient.findOne("select xm from jz_jzryjbxx where id = ?",aid);
		String fxryxm = StringUtil.toString(one.get("xm"));
		AuditApply auditApply = new AuditApply();
		auditApply.setBillid(SupConst.Collections.JZ_HSQZXXCJB);
		auditApply.setBsid(StringUtil.toString(data.get("ID")));
		auditApply.setTitle(fxryxm + "的核实取证信息");
	    auditApply.setName(user.getName());
	}
   /**
    * 根据矫正人员获取所有核实信息
    * @return
    */
   public List<BasicMap<String,Object>> findxx(BasicMap<String,Object> query,Paginate paginate){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="SELECT a.aid,a.bhsqzr,a.hsqzr,a.hsqzsj,a.hsqzdd,a.hsqkjl,a.clyj,b.id FROM jz_hsqzxxcjb a inner JOIN jz_jzryjbxx b on a.aid=b.id;";
		SqlDbFilter sqlDbFilter=new SqlDbFilter();		
		SQLAdapter sqlAdapter=new SQLAdapter(sql);
		sqlAdapter.setFilter(sqlDbFilter);
		list=dbClient.find(sqlAdapter);
		return list;
	} 
   
   /**
    * 根据服刑人员id查询该人员的核实信息
    * @param id
    * @return
    */
   public List<BasicMap<String,Object>> findO(String id){
	   List<BasicMap<String,Object>> list = new ArrayList<BasicMap<String,Object>>();
		list = dbClient.find(SupConst.Collections.JZ_HSQZXXCJB, new SqlDbFilter().eq("aid", id));
		return list;
	}
}
