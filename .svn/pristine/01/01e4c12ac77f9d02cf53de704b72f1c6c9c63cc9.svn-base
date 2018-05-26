package com.ehtsoft.supervise.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 问卷 题库 服务类
 * <br>
 * 对应的 数据表为： JZ_WJTKXXB
 * @author wangbao
 */
@Service("QuestionService")
public class QuestionService extends AbstractService{

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	public ResultList<BasicMap<String,Object>> find(BasicMap<String,Object> query,Paginate paginate){
		
		ResultList<BasicMap<String, Object>> rtn = dbClient.find(SupConst.Collections.JZ_WJTKXXB,toSqlFilter(query),paginate);
		return rtn;
	}
	/**
	 * 保存题库数据
	 * @param data
	 * {
	 *  F_WTMS:问题描述
	 *  F_WJLX:问卷类型 1 法律问卷  2 心理评测
	 *  F_XTLX:选题类型 1 单选  2 多选  3 判断  4 填空题  5 简答题
	 *  F_WTDA:问题答案
	 *  F_DAJX:答案解释
	 *  daxxs:[{f_daxx：答案选项,f_daxxms:"答案选项描述"}] 答案选项数据
	 * }
	 */
	public void save(BasicMap<String,Object> data){
		dbClient.save(SupConst.Collections.JZ_WJTKXXB, data);
		List<BasicMap<String,Object>> daxxs = (List<BasicMap<String, Object>>) data.get("daxxs");
		final String tkid = StringUtil.toString(data.get("F_TKID"));
		dbClient.remove(SupConst.Collections.JZ_WJTKXX_DAXX, new SqlDbFilter().eq("F_TKID",tkid));
		dbClient.insert(SupConst.Collections.JZ_WJTKXX_DAXX, daxxs,new InsertOperation() {
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				data.put("F_TKID", tkid);
			}
			public void insertAfter(BasicMap<String, Object> data) {
			}
		});
	}
	/**
	 * 根据题库ID 获取题库信息
	 * @param f_tkid
	 * {
	 *  F_WTMS:问题描述
	 *  F_WJLX:问卷类型 1 法律问卷  2 心理评测
	 *  F_XTLX:选题类型 1 单选  2 多选  3 判断  4 填空题  5 简答题
	 *  F_WTDA:问题答案
	 *  F_DAJX:答案解释
	 *  daxxs:[{f_daxx：答案选项,f_daxxms:"答案选项描述"}] 答案选项数据
	 * @return
	 */
	public BasicMap<String,Object> findOne(String f_tkid){
		BasicMap<String,Object> rtn = dbClient.findOne("SELECT * FROM JZ_WJTKXXB WHERE F_TKID = ?", f_tkid);
		List<BasicMap<String,Object>> daxxs = dbClient.find(SupConst.Collections.JZ_WJTKXX_DAXX, new SqlDbFilter().eq("F_TKID", f_tkid));
		rtn.put("daxxs", daxxs);
		return rtn;
	}
}
