package com.ehtsoft.supervise.services;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 社区矫正-人员矫正
 * @author huazhuo
 *
 */
@Service("SqjzRyjzService")
public class SqjzRyjzService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	
	/**
	 * 查询所有矫正人员信息
	 * @param query
	 * @param paginate
	 * @return{
	 *  [
	 *		主键	id
	 *		社区矫正人员编号	sqjzrybh
	 *		姓名	xm
	 *		曾用名	cym
	 *		性别	xb
	 *		民族	mz
	 *		身份证号	sfzh
	 *		出生日期	csrq
	 *		是否成年	sfcn
	 *		未成年	wcn
	 *		矫管类型	jglx
	 *		文化程度	whcd
	 *		婚姻状况	hyzk
	 *		个人联系电话(手机号)	grlxdh
	 *		是否三无人员	sfswry
	 * 		捕前职业	pqzy
	 *		就业就学情况	jyjxqk
	 *		现政治面貌	xzzmm
	 *		原政治面貌	yzzmm
	 *		是否被宣告禁止令	sfbxgjzl
	 *		未按时报到情况说明	wasbdqksm
	 *		原工作单位	ygzdw
	 * 		现工作单位	xgzdw
	 *		单位联系电话	dwlxdh
	 * 		其他联系方式	qtlxfs
	 *		矫正机构编码	jzjgbm
	 *		矫正机构	jzjg
	 *		是否采集完成	sfcj
	 *		是否在线	online
	 *		是否脱管	sftk
	 *		是否建立矫正小组	sfjljzxz
	 *		报到情况	bdqk	
	 * 	]
	 * }
	 */
	@Transactional
	public ResultList<BasicMap<String, Object>> findAllRy(BasicMap<String,Object> data,Paginate paginate){
		SqlDbFilter filter = toSqlFilter(data);
		String sql = "SELECT id,sqjzrybh,xm,cym,xb,mz,sfzh,csrq,grlxdh,wasbdqksm,ygzdw,xgzdw,dwlxdh,qtlxfs,jzjgbm,jzjg,sfcj,online,sftk,sfjljzxz,bdqk FROM JZ_JZRYJBXX";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		sqlAdapter.setFilter(filter);
		ResultList<BasicMap<String, Object>> list = dbClient.find(sqlAdapter, paginate);
		return list;
	}
	
	/**
	 * 根据身份证查询矫正人员信息
	 * 
	 */
	@Transactional
	public BasicMap<String, Object> findPeById(String sfzh){
		String sql = "SELECT id,sqjzrybh,xm,cym,xb,mz,sfzh,csrq,wasbdqksm,ygzdw,xgzdw,dwlxdh,qtlxfs,jzjgbm,jzjg,sfcj,online,sftk,sfjljzxz,bdqk FROM JZ_JZRYJBXX WHERE sfzh=?";
		BasicMap<String,Object> person = dbClient.findOne(sql, sfzh);
		return person;
	}
	
	/**
	 * 根据姓名查询矫正人员信息
	 * @param sfzh
	 * @return
	 */
	@Transactional
	public BasicMap<String, Object> findPeByName(String name){
		String sql = "SELECT id,sqjzrybh,xm,cym,xb,mz,sfzh,csrq,wasbdqksm,ygzdw,xgzdw,dwlxdh,qtlxfs,jzjgbm,jzjg,sfcj,online,sftk,sfjljzxz,bdqk FROM JZ_JZRYJBXX WHERE xm LIKE ?";
		BasicMap<String,Object> person = dbClient.findOne(sql, name);
		return person;
	}
	
	/**
	 * 新增矫正人员信息
	 * @param data 新增矫正人员信息
	 */
	@Transactional
	public void saveJzry(BasicMap<String,Object> data) {
		System.out.println("data:"+data);
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, data);
	}
	
	
}
