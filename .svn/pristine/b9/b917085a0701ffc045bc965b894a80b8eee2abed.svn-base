package com.ehtsoft.supervise.services;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;

import oracle.sql.DATE;
/**
 * 律师信息获取
 * @author 李恒
 *
 */
@Service("lszhglLsxxhqService")
public class lszhglLsxxhqService extends AbstractService {
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	/**
	 * 区域名称:		QYMC
	 * 执业机构:		ZYJG
	 * 发证日期		FZRQ
	 * 年龄段:		NLD//数据库没有
	 * 姓名:			XM
	 * 民族:			MZ
	 * 性别:			XB
	 * 业务专长:		YWZC
	 * 最高学历:		ZGXL
	 * 政治面貌:		ZZMM
	 * 资格证类别:		ZGZLB
	 * 手机号码:		SJHM
	 * 业务专长:		YWZC
	 */
	//设置权限查询数据库需要的字段
	public ResultList<BasicMap<String,Object>> findAllRy(BasicMap<String,Object> data,Paginate paginte){
		User user = ssoService.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		SqlDbFilter filter = new SqlDbFilter();
		filter.eq("orgid",user.getOrgid());//按照权限获取数据
		if(user!=null) {
			StringBuffer sqlstr = new StringBuffer("SELECT * FROM LSZHGL_LSXXHQ ");
			if(Util.isNotEmpty(data.get("zyjg"))) {
				filter.like("zyjg", data.get("zyjg").toString());
			}
			//发证开始日期
			if(Util.isNotEmpty(data.get("fzrq_ks"))) {
				filter.gtEq("fzrq",data.get("fzrq_ks") );
			}
			if(Util.isNotEmpty(data.get("fzrq_js"))) {//发证结束日期
				filter.ltEq("fzrq", data.get("fzrq_js"));
			}
			
			if(Util.isNotEmpty(data.get("nl_ks"))) {//出生日期开始
				//获取出生年
			int year =	DateUtil.getYear() - Integer.parseInt(data.get("nl_ks").toString());
			   //获取出生月
			String Month = Integer.toString( DateUtil.getMonth());
			if(Month.length()<=1) Month = "0"+ Month;
			//获取出生日
			String Day = Integer.toString(DateUtil.getDayOfMonth());
			if(Day.length()<=1) Month = "0"+ Day;
			String csrq_ks = year + "-" +Month +"-"+ Day;//把所有的时间相加
			filter.gtEq("csrq",csrq_ks);
			}
			
			//出生日期结束
			if(Util.isNotEmpty(data.get("nl'_js"))) {
				//结束出生年
				int year = DateUtil.getYear() - Integer.parseInt(data.get("nl_ks").toString());
				//获取出生日
				String Month = Integer.toString(DateUtil.getMonth());
				if(Month.length()<=1) Month ="0"+Month;
				//获取出生日
				String  Day = Integer.toString(DateUtil.getDayOfMonth());
				if(Day.length()<=1) Month = "0" + Day;
				String csrq_js = year+"-"+Month +"-"+ Day;//把所有时间相加
				filter.ltEq("csrq",csrq_js);
			}
			if(Util.isNotEmpty(data.get("mz"))) {
				filter.like("mz", data.get("mz").toString());
			}
			if(Util.isNotEmpty(data.get("xb"))) {
				filter.like("xb", data.get("xb").toString());
			}
			if(Util.isNotEmpty(data.get("zgxl"))) {
				filter.like("zgxl", data.get("zgxl").toString());
			}
			if(Util.isNotEmpty(data.get("zzmm"))) {
				filter.like("zzmm", data.get("zzmm").toString());
			}
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr.toString());
			sqlAdapter.setFilter(filter);
			list = dbClient.find(sqlAdapter, paginte);
		}
		return list;
	}
	
	
}
