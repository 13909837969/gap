/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年5月11日
 */
package com.ehtsoft.common.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.supervise.utils.DeployContext;

/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年5月11日
 *
 */
public class ScheduleService {
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	/**
	 * 清理无效数据
	 * 返回值格式:<br>
	 *
	 * @author wangbao
	 * @date   2018年5月11日
	 * 方法的作用：TODO
	 */
	public void removeInvalidData(){
		//调度开关
		if(DeployContext.isEnableScheduled(DeployContext.DEPLOY_SCHEDULED_REMOVE_ENABLE)){
			//已经采集的在矫人员数据  a.jcjz = '0' AND a.SFCJ = 1 AND a.SFJS = '1'
			String sqlstr = "select a.id,a.orgid"
							+" from  jz_jzryjbxx a left join jz_jzryjbxx_jz jz on jz.id = a.id "
							+" left join jz_collect_user b on a.id = b.f_id  "
							+" WHERE a.jcjz = '0' AND a.SFCJ = 1 AND a.SFJS = '1'";
			//已经采集的在矫正人员
			final Map<String, List<String>> map1 = new HashMap<>(); 
			dbClient.find(new SQLAdapter(sqlstr), new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					String orgid = StringUtil.toEmptyString(rowData.get("orgid"));
					if(map1.get(orgid)==null){
						List<String> list = new ArrayList<>();
						map1.put(orgid, list);
						list.add(StringUtil.toEmptyString(rowData.get("id")));
					}else{
						map1.get(orgid).add(StringUtil.toEmptyString(rowData.get("id")));
					}
				}
			});
			//清理不在矫人员的定位数据
			for(String orgid : map1.keySet()){
				Query query = Query.query(Criteria.where("orgid").is(orgid).and("_id").nin(map1.get(orgid)));
				mongoClient.remove(ImConst.Collections.IM_CURRENT_LOCATION, query);
			}
			System.out.println("========= 删除无效的当前定位信息 =========");
		}
	}

}
