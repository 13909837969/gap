package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.bouncycastle.i18n.filter.SQLFilter;
import org.springframework.stereotype.Service;

import com.alibaba.druid.sql.dialect.oracle.ast.clause.ModelClause.ReturnRowsClause;
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
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

/**
 * @Description TODO(基层法律服务工作者)
 */
@Service("FlfwGzzService")
public class FlfwGzzService extends AbstractService {

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;

	@Resource(name = "SSOService")
	private SSOService ssoService;

	/**
	 * 根据行政区划的ID (旗县的 REGIONID) 获取该旗县下的法律服务所
	 * 
	 * @param regionid
	 * @return<br>
	 * 			返回值格式:<br>
	 * @author wangbao
	 * @date 2018年3月18日 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findFlfws(String regionid) {
		String sqlstr = "select id as orgid,JGMC as orgname from FLFW_JCFLFWS";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.getFilter().eq("REGIONID", regionid);
		return dbClient.find(sql);
	}

	/**
	 * @param data<br>
	 *            返回值格式: void 方法的作用：新增 -->FLFW_JCFLFWGZZ
	 */
	public  List<BasicMap<String, Object>> save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.FLFW_JCFLFWGZZ, data);
		List<BasicMap<String, Object>> list = new ArrayList<>();
		list.add(data);
		return list;
	}

	/**
	 * 方法的作用:刪除一條基层法律服务工作者信息
	 */
	public void deleteFocusService(String id) {
		dbClient.remove(SupConst.Collections.FLFW_JCFLFWGZZ, new SqlDbFilter().eq("id", id));
	}

	/**
	 * 方法的作用:更新一條基层法律服务工作者信息
	 * 
	 * @param data
	 */
	public void saveFocusService(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.FLFW_JCFLFWGZZ, data);
	}

	/**
	 * 
	 * TODO(返回右侧内容【基层法律服务工作者的全部列表】
	 * 
	 * @param query
	 * @param paginate
	 * @return<br>
	 * 			返回值格式: List<BasicMap<String,Object>> 【可更换
	 *             ResultList<BasicMap<String,Object>>】 方法的作用：返回全部记录 xm 姓名 xb 性别 xl
	 *             学历 mz 民族 zyzh 执业证号 zzmm 政治面貌 qsnd 起始年度 bzsj 颁证时间 zhnjsj 最后年检时间
	 *             grjj 个人简介
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate) {
		SqlDbFilter filter = toSqlFilter(query);
		String sqlstr = "select a.id,a.xm,a.zyzh,a.mz,a.xb,a.xl,a.bzsj,a.zhnjsj,a.orgid,a.grjj,a.zzmm,a.qsnd,a.ywzc,b.id,b.jgmc from FLFW_JCFLFWGZZ a join flfw_jcflfws b on a.orgid=b.id";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(filter);
		String orgidfield = "orgid";
		if (Util.isNotEmpty(query.get(orgidfield))) {
			if (query.get(orgidfield) instanceof String) {
				sql.getFilter().eq("orgid", query.get(orgidfield));
			}
			if (query.get(orgidfield) instanceof List) {
				sql.getFilter().in("orgid", (List) query.get(orgidfield));
			}
		}
		ResultList<BasicMap<String, Object>> list = dbClient.find(sql, paginate);
		return list;
	}

	/**
	 * 
	 * TODO(区域树，基层法律服务所管理)
	 * @return<br>
	 * 			返回值格式:List<BasicMap<String, Object>> 方法的作用：区域树 【数据来源 sys_region表】
	 */
	public List<BasicMap<String, Object>> findTree() {
		List<BasicMap<String, Object>> rtn = new ArrayList<>();
		User user = ssoService.getUser();
		String sql = "SELECT parentid,region_code,region_name,lvl,REGIONID from sys_region";
		SQLAdapter adapter = new SQLAdapter(sql);
		adapter.getFilter().eq("parentid", user.getRegioncode());
		final BasicMap<String, Object> p = dbClient.findOne(
				"SELECT parentid,region_code,region_name,lvl,REGIONID from sys_region where regionid = ?",
				user.getRegioncode());
		if (p != null) {
			// 检索市
			final List<BasicMap<String, Object>> list = new ArrayList<>();
			list.add(p);
			dbClient.find(adapter, new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					list.add(rowData);
					if (NumberUtil.toInt(rowData.get("lvl")) == 3) {// 3 旗县
						String sqljg = "SELECT JGMC as region_name,ID as orgid,REGIONID FROM FLFW_JCFLFWS WHERE REGIONID = '"
								+ StringUtil.toString(rowData.get("REGIONID")) + "'";
						rowData.put("nodes", dbClient.find(new SQLAdapter(sqljg), new RowDataListener() {
							public void processData(BasicMap<String, Object> rowData) {
							}
						}));
					}
				}
			});
			rtn = Util.list2Tree(list, "parentid", "regionid", "nodes", new Util.List2Tree() {
				@Override
				public boolean isFirstNode(BasicMap<String, Object> obj) {
					boolean r = false;
					if (NumberUtil.toInt(obj.get("lvl")) == NumberUtil.toInt(p.get("lvl"))) {
						r = true;
					}
					return r;
				}
			});
		}
		return rtn;
	}
}
