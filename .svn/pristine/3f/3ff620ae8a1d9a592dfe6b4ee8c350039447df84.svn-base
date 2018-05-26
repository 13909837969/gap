package com.ehtsoft.supervise.services;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SFCodeService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SaveOperation;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.fw.utils.api.IDictionary;
import com.ehtsoft.supervise.api.SupConst;
import com.ibm.icu.text.SimpleDateFormat;



@Service("RmtjYwszService")
public class RmtjYwszService extends AbstractService{
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	@Resource(name="SFCodeService")
	private SFCodeService sfCodeService;
	
	@Resource(name="DictionaryService")
	private IDictionary dictionaryService;
	
	
		
	/**
	 * 
	 * 人民调解调查记录-添加功能
	 * @param dcjl
	 * @param bdcrs
	 * @param cjrs<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月1日
	 * 
	 * 调查记录保存：
		1.基本信息、调查记录、案件调解级别、案件预测 保存到  RMTJ_DCJL (人民调解调查记录) 具体见数据模型
		
		2.被调查人保存到 RMTJ_TJAJSQR 表中  调查记录ID (RMTJ_DCJL.ID)  保存到  RMTJ_TJAJSQR.TJAJXXID ，类型（LX） 为 3  ，具体见数据模型文档
		
		3.参加人保存到 RMTJ_TJAJSQR 表中  调查记录ID (RMTJ_DCJL.ID)  保存到  RMTJ_TJAJSQR.TJAJXXID ，类型（LX） 为 4  ，具体见数据模型文档
	 * 
	 */
//	TODO 未对接
	public void saveDcjl(BasicMap<String,Object> dcjl,List<BasicMap<String,Object>> bdcrs,List<BasicMap<String,Object>> cjrs){
		//保存 基本信息
		
		dbClient.save(SupConst.Collections.RMTJ_DCJL, dcjl,new InsertOperation() {
			
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				
			}
			
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
				//保存签字图片
				
				/**
				 *  1 调查人签字 
				 */
				if (Util.isNotEmpty(StringUtil.toString(dcjl.get("type1")))) {
					//处理type1 的value 值
						BasicMap<String, Object> img1 = new BasicMap<>();
						img1.put("DCJLID", StringUtil.toString(dcjl.get("dcjzid")));
						img1.put("LISTID", StringUtil.toString(dcjl.get("listid")));
						img1.put("QZLX", "1");
						img1.put("data",dcjl.get("type1"));
						dbClient.save(SupConst.Collections.RMTJ_DCJL_IMG, img1);
					
					
				}
				/**
				 *    2 被调查人签字  
				 */
				if (Util.isNotEmpty(StringUtil.toString(dcjl.get("type2")))) {
						if (!"".equals(StringUtil.toEmptyString(dcjl.get("type2")))) {
							List<BasicMap<String, Object>> list =  (List<BasicMap<String, Object>>) dcjl.get("type2");
							System.out.println(list.size());
							for (int i = 0; i < list.size(); i++) {
								BasicMap<String, Object> img2 = new BasicMap<>();
								img2.put("DCJLID", StringUtil.toString(dcjl.get("dcjzid")));
								img2.put("LISTID", StringUtil.toString(dcjl.get("listid")));
								img2.put("QZLX", "2");
		                        img2.put("data",list.get(i).get(i));
								dbClient.save(SupConst.Collections.RMTJ_DCJL_IMG, img2);
							}
						}
					
						
						
					
				}
			/**
				 *   3 记录人签字   
				 */
				if (Util.isNotEmpty(StringUtil.toString(dcjl.get("type3")))) {
					BasicMap<String, Object> img3 = new BasicMap<>();
					img3.put("DCJLID", StringUtil.toString(dcjl.get("dcjzid")));
					img3.put("LISTID", StringUtil.toString(dcjl.get("listid")));
					img3.put("QZLX", "3");
					img3.put("data", dcjl.get("type3"));
					dbClient.save(SupConst.Collections.RMTJ_DCJL_IMG, img3);
					
				}
				
				
			}
		});
		
		//保存被调查人【关联调节记录 】
		dbClient.save(SupConst.Collections.RMTJ_TJAJSQR, bdcrs, new InsertOperation() {
			
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				data.put("lx", 3);
				data.put("tjajxxid", StringUtil.toString(dcjl.get("id")));
				
			}
			
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
				
			}
		});
		
		
		//保存参加人【关联调节记录 】
		dbClient.save(SupConst.Collections.RMTJ_TJAJSQR, cjrs, new InsertOperation() {
			
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				data.put("lx", 4);
				data.put("tjajxxid", StringUtil.toString(dcjl.get("id")));
				
				
			}
			
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
				
			}
		});
		
		
		//保存RMTJ_DCJZ_YWSZ
		BasicMap<String, Object> ywsz = new BasicMap<>();
		ywsz.put("DCJZID",StringUtil.toEmptyString(dcjl.get("dcjzid")));
		ywsz.put("YWSZID", StringUtil.toEmptyString(dcjl.get("ywid")));
		dbClient.save(SupConst.Collections.RMTJ_DCJZ_YWSZ, ywsz);
		

		
		
		
		
	 }
	
	/**
	 * 根据 id 返回 人民调解调查卷宗（书面调解）详情
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findDcjzmx(BasicMap<String, Object> query) {
		String sql = "SELECT id,jm,jh,tjrq,ljr,ajly,orgid,TJY FROM RMTJ_DCJZ where id = '"+ query.get("id") +"'";
		SQLAdapter adapter = new  SQLAdapter(sql);
		return dbClient.findOne(adapter);
	}
	
	
	/**
	 * 查询卷内目录表
	 */
	public List<BasicMap<String,Object>> findAllRows(String dcjzid){
		SQLAdapter sql = new SQLAdapter("select A.id,a.lx,a.mc,a.url,a.vurl,a.remark,B.YWSZID from SYS_RMTJ_YWSZ a "
				+ " left join rmtj_dcjz_ywsz b on a.id = b.YWSZID and b.dcjzid = '"+dcjzid+"' WHERE a.SFJY = '0' "
				+ "GROUP BY  A.id,a.lx,a.mc,a.url,a.remark,B.YWSZID ORDER BY a.ID ASC");
		
		return dbClient.find(sql,new RowDataListener() {
			boolean flag = true;
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				if(Util.isEmpty(rowData.get("YWSZID")) && flag) {
					rowData.put("enable", true);
					flag = false;
				}else {
					rowData.put("enable", false);
				}
				if(Util.isNotEmpty(rowData.get("YWSZID"))) {
					if("2".equals(rowData.get("YWSZID"))) {
						rowData.put("enable", true);
					}
					if("6".equals(rowData.get("YWSZID"))) {
						rowData.put("enable", true);
					}
				}
			}
		});
	}
	
	
	/**
	 * 书面调解完成目录查询列表
	 */
	public List<BasicMap<String,Object>> findQueary(BasicMap<String, Object> query){
		String sql = "SELECT dcjz.*,tj.total,tj.complete FROM RMTJ_DCJZ dcjz inner join (select b.dcjzid,count(a.id) as total,count(b.ywszid) as complete from sys_rmtj_ywsz a  " + 
				"left join  rmtj_dcjz_ywsz b on b.ywszid = a.id group by b.dcjzid ) tj on dcjz.id = tj.dcjzid";
		SQLAdapter adapter = new SQLAdapter(sql);
		SqlDbFilter filter = new SqlDbFilter();
		filter.like("dcjz.jm",StringUtil.toString(query.get("jm"))).eq("dcjz.orgid", ssoService.getUser().getOrgid());
		adapter.setFilter(filter);
		return dbClient.find(adapter);
	}
	
	
	/***
	 * 受理等级添加
	 * @param dataXX 申请人的详细信息{"":"","":"",}
	 * @param bsqrxxs 被申请人信息列表
	 * @param sqsxs 当事人申请事项列表
	 */
	public void saveTjsq(BasicMap<String,Object> dataXX,
			List<BasicMap<String,Object>> bsqrxxs,List<BasicMap<String,Object>> sqsxs){
		
		
		
		//保存人民调解调查卷宗（书面调解）
		//调查卷宗ID
		final String jzId = (String)dataXX.get("jzId");
		dataXX.put("dcjzid", jzId);
		//人民调解业务设置ID
		final String ywId = (String)dataXX.get("ywId");
		dataXX.put("ywszid", ywId);
		dataXX.put("ID", jzId);
		
		
		//先删除在插入
		dbClient.remove(SupConst.Collections.RMTJ_TJAJSQR, new SqlDbFilter()
				.eq("LX","1").eq("TJAJXXID", jzId));
		dbClient.remove(SupConst.Collections.RMTJ_TJAJSQR, new SqlDbFilter()
				.eq("LX","2").eq("TJAJXXID", jzId));
		
		//保存人民调解申请书
		dbClient.save(SupConst.Collections.RMTJ_TJSQS, dataXX);
			
		String tjsqsID = (String)dataXX.get("jzId");
		
		
		//保存被申请人信息
		dbClient.insert(SupConst.Collections.RMTJ_TJAJSQR,bsqrxxs,new InsertOperation() {
			
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				data.put("LX", 2);
				data.put("TJAJXXID", tjsqsID);
			}
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
			
			}
		});
		//保存申请人信息
			dbClient.insert(SupConst.Collections.RMTJ_TJAJSQR,dataXX,new InsertOperation() {
				
				@Override
				public void insertBefore(BasicMap<String, Object> data) {
					data.put("LX", 1);
					data.put("TJAJXXID", tjsqsID);
					data.put("ID", dataXX.get("SQRID"));
				}
				
				@Override
				public void insertAfter(BasicMap<String, Object> data) {
				
				}
			});
			//保存申请事项信息
			dbClient.save(SupConst.Collections.RMTJ_SQSXJL, sqsxs,new InsertOperation() {
				
				@Override
				public void insertBefore(BasicMap<String, Object> data) {
					data.put("TJSQSID", tjsqsID);
				}
				
				@Override
				public void insertAfter(BasicMap<String, Object> data) {
					
				}
			});
			//保存人民调解调查卷宗（书面调解）
			final String jflx = dictionaryService.getDictionaryName("SYS104", StringUtil.toEmptyString(dataXX.get("JFLB")));
			dbClient.save(SupConst.Collections.RMTJ_DCJZ, dataXX,new SaveOperation() {
				@Override
				public void saveBefore(BasicMap<String, Object> data) {
					data.put("id", tjsqsID);
					//生成卷号
					String code = sfCodeService.getRmtjJzbmCode();
					data.put("jh", code);
					String jm = StringUtil.toEmptyString(data.get("JM"));
					data.put("JM", jm + jflx);
					data.put("tjrq", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
				}
				
				@Override
				public void saveAfter(BasicMap<String, Object> data) {
					
				}
			});				
			dbClient.save(SupConst.Collections.RMTJ_DCJZ_YWSZ, dataXX,new InsertOperation() {
				
				@Override
				public void insertBefore(BasicMap<String, Object> data) {
					data.put("dcjzid", tjsqsID);
					data.put("ywszid", ywId);
				}
				
				@Override
				public void insertAfter(BasicMap<String, Object> data) {
					
				}
			});
			
	 }
	
	public void delete(String jzid) {
		dbClient.remove(SupConst.Collections.RMTJ_DCJZ_YWSZ, new SqlDbFilter().eq("DCJZID", jzid));
	}
	
	/**
	 * 
	 * 书面调解-人民调解申请书 
	 * @param id  卷宗ID
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月9日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findAddApply(String dcjzid) {
		String sql = "select b.xm,b.lx,b.jtzz,b.dhhm from RMTJ_TJSQS a LEFT JOIN RMTJ_TJAJSQR b ON a.id = b.TJAJXXID where a.ID ='"+ dcjzid +"'";
		SQLAdapter adapter = new  SQLAdapter(sql);
		return dbClient.find(adapter);
	}
	
	public BasicMap<String, Object> findSQR(String dcjzid) {
		String sql = "select a.*,b.id as sqr_id,b.xm,b.xb,b.nl,b.sfzh,b.dhhm,b.jtzz,b.lx "
				+ " from RMTJ_TJSQS a LEFT JOIN RMTJ_TJAJSQR b ON a.id = b.TJAJXXID where a.ID ='"+ dcjzid +"' and b.lx='1'";
		SQLAdapter adapter = new  SQLAdapter(sql);
		BasicMap<String, Object> rowData = dbClient.findOne(adapter);
		return rowData;
		
	}
	
	
	
	public List<BasicMap<String, Object>> findSQSX(String dcjzid) {
		String sql = "select * from RMTJ_SQSXJL where TJSQSID ='"+ dcjzid +"'";
		SQLAdapter adapter = new  SQLAdapter(sql);
		return dbClient.find(adapter);
	}


	
}
