package com.ehtsoft.supervise.services;


import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.im.services.UserinfoService;

/**
 * 签到管理
 * @author sunhailong
 *
 */
@Service("SigninService")
public class SigninService extends AbstractService{

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private UserinfoService userinfoService;
	
	
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 查询签到情况
	 * @param qurrey
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String,Object>> findAll(BasicMap<String, Object> qurrey,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> result = new ResultList<>();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(qurrey);
			String sqlstr = "select q.aid,q.qdlx,q.qdwz,q.score,q.cts,j.xm,j.xb,j.sfzh from JZ_QDXXB q inner join JZ_JZRYJBXX j on q.aid=j.id ";	
			filter.in("j.orgid", user.getOrgidSet()).desc("q.cts");
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			result = dbClient.find(sql, paginate,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					if(NumberUtil.toInt(rowData.get("qdlx"))==1){
						rowData.put("qdlx", "指纹签到");
					}else if(NumberUtil.toInt(rowData.get("qdlx"))==2){
						rowData.put("qdlx", "声纹签到");
					}else if(NumberUtil.toInt(rowData.get("qdlx"))==3){
						rowData.put("qdlx", "人脸签到");
					}
				}
			});
		}
		return result;
	}
	/**
	 * 查询一个人的所有签到信息
	 * 
	 */
	public BasicMap<String,Object> findOne(String aid){
		String sql = "select qdlx,cts from rep_qdxxb where aid='"+aid+"'";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		final BasicMap<String, Object> rtn = new BasicMap<>();
		dbClient.find(sqlAdapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				
				if(NumberUtil.toInt(rowData.get("qdlx"))==1){
					rowData.put("qdlx", "指纹签到");
				}else if(NumberUtil.toInt(rowData.get("qdlx"))==2){
					rowData.put("qdlx", "声纹签到");
				}else if(NumberUtil.toInt(rowData.get("qdlx"))==3){
					rowData.put("qdlx", "人脸签到");
				}
				rtn.put(DateUtil.format(rowData.get("cts"),"yyyy-MM-dd"), rowData);
				rowData.put("cts",  DateUtil.format(rowData.get("cts"),"yyyy-MM-dd HH:mm:ss"));
			}
		});
		return rtn;
	}
}
