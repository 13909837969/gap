package com.ehtsoft.supervise.services;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 社区矫正-人员解除信息
 * @author huazhuo
 *
 */
@Service("SqjzRyjcxxService")
public class SqjzRyjcxxService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="UserinfoService")
	private UserinfoService uService;
	
	@Resource(name="SSOService")
	private SSOService service;
	/**
	 * 查询所有解除矫正人员信息
	 * @param query
	 * @param paginate
	 * @return{
	 *  [
	 *		主键					ID
	 *		社区矫正人员编号			SQJZRYBH
	 *		矫正解除（终止）类型                    JJLX
	 *		矫正解除（终止）日期		SJZXRQ
	 *		收监执行原因			SJZXYY
	 * 		收监执行类型			SJZXLX
	 *		收监执行日期			SJZXRQ
	 * 		死亡日期				SWSJ
	 *		死亡原因				SWYY
	 *		具体死因				JTSY
	 *		居住地变更日期			JZDBGRQ
	 *		新居住地地址			XJZDDZ
	 *		矫正期间表现			JZQJBX
	 *		认罪态度				RZTD
	 *		矫正期间是否参加职业技能培训	SFCJZYJNPX
	 *		矫正期间是否获得职业技能证书	SFHDZYJNZS
	 *		技术特长及等级			JSTCJDJ
	 *		危险性评估				WXXPG
	 *		家庭联系情况			JTLXQK
	 *		矫正期间特殊情况备注及帮教建议TSQKBZJBJJY
	 *		备注					BZ
	 *		司法所解除人			SFSJCR
	 *		司法所解除时间			SFSJCSJ
	 * 	]
	 * }
	 */
	public BasicMap<String, Object> findRyJzXX(BasicMap<String,Object> data,Paginate paginate){
		String sql = "SELECT id,sqjzrybh,jjlx,jjrq,sjzxyy,sjzxlx,sjzxrq,swsj,swyy,jtsy,jzdbgrq,xjzddz,jzqjbx,rztd,sfcjzyjnpx,sfhdzyjnzs,jstcjdj,wxxpg,jtlxqk,tsqkbzjbjjy,bz,sfsjcr,sfsjcsj FROM JZ_JZJCXXCJB WHERE id=?";
		BasicMap<String, Object> jcXx = dbClient.findOne(sql, data);
		return jcXx;
	}
	
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
	
	public ResultList<BasicMap<String, Object>> findAllRyJb(BasicMap<String,Object> data,Paginate paginate){
		SqlDbFilter filter = toSqlFilter(data);
		String sql = "SELECT id,sqjzrybh,xm,cym,xb,mz,sfzh,csrq,grlxdh,wasbdqksm,ygzdw,xgzdw,dwlxdh,qtlxfs,jzjgbm,jzjg,sfcj,online,sftk,sfjljzxz,bdqk FROM JZ_JZRYJBXX";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		sqlAdapter.setFilter(filter);
		filter.asc("XM");
		ResultList<BasicMap<String, Object>> list = dbClient.find(sqlAdapter, paginate);
		return list;
	}
	
	/**
	 * 查询矫正人员基本信息和矫正解除信息
	 * @param data
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAllRy(BasicMap<String,Object> data,Paginate paginate){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SqlDbFilter filter = toSqlFilter(data);
		String sql = "SELECT a.id,a.sqjzrybh,a.xm,a.cym,a.xb,a.mz,a.sfzh,a.csrq,a.grlxdh,a.wasbdqksm,a.ygzdw,a.xgzdw,a.dwlxdh,a.qtlxfs,a.jzjgbm,a.jzjg,a.sfcj,a.online,a.sftk,a.sfjljzxz,a.bdqk,a.jcjz,a.jglx,"
				+ "j.id,j.sqjzrybh,j.jjlx,j.jjrq,j.sjzxyy,j.sjzxlx,j.sjzxrq,j.swsj,j.swyy,j.jtsy,j.jzdbgrq,j.xjzddz,j.jzqjbx,j.rztd,j.sfcjzyjnpx,j.sfhdzyjnzs,j.jstcjdj,j.wxxpg,j.jtlxqk,j.tsqkbzjbjjy,j.bz,j.sfsjcr,j.sfsjcsj,"
				+ "jz.sqjzjsrq"
				+ " FROM JZ_JZRYJBXX AS a LEFT JOIN JZ_JZJCXXCJB AS j ON a.id=j.id"
				+ " LEFT JOIN JZ_JZRYJBXX_JZ AS jz ON jz.id=a.id";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		sqlAdapter.setFilter(filter);
		filter.asc("sqjzjsrq");
		ResultList<BasicMap<String, Object>> list = dbClient.find(sqlAdapter, paginate);
		return list;
	}
	
	/**
	 * 新增解除矫正人员信息
	 * @param data 新增解除矫正人员信息
	 */
	public void saveJzry(BasicMap<String,Object> data) {
		dbClient.save(SupConst.Collections.JZ_JZJCXXCJB, data);
		BasicMap<String,Object> map = new BasicMap<>();
		map.put("jcjz", "1");
		map.put("id", data.get("id"));
		dbClient.update(SupConst.Collections.JZ_JZRYJBXX, map);
		System.out.println(data.get("id")+"更新成功");
	}
	
	
	/**
	 * 根据Id查询解除矫正人员手机号
	 * @param id
	 * @return
	 * {
	 * 	grlxdh 解除矫正人员手机号
	 * }
	 */
	public String findRyTelById(String id) {
		String sql = "SELECT grlxdh FROM JZ_JZJCXXCJB WHERE id=?";
		BasicMap<String, Object> tel = dbClient.findOne(sql, id);
		System.out.println("tel:"+tel);
		return (String)tel.get("grlxdh");
	}
	
}
