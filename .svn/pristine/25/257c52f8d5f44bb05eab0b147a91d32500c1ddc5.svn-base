package com.ehtsoft.user.services;

import java.util.List;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.user.api.UserConst;

/**
 * 组织机构数据获取接口服务<br>
 * 新增接口服务，单独用在整个框架范围内系统（如 CSM 系统的数据获取接口）<br>
 * 日期：2017年3月3日<br>
 * <br>
 * 注：该服务在本项目中没有任何的UI操作，只用于接口服务<br>
 * （OsaOrganizationService，PsaOrganizationService 为本 user 项目前后台交互服务
 * 这两个服务类有点乱，只是针对本项目 user 页面建后台交互使用）<br>
 * @author wangbao
 */
public class OrganizationService {

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	/**
	 * 根据 组织机构ID 获取组织机构的编码及机构名称信息
	 * @param sysid 组织机构ID
	 * @return 返回组织机构对象信息
	 * {
	 * 	orgcode:"组织机构的编码",
	 *  orgname:"组织机构的名称",
	 *  LVL:机构类型
	 * }
	 * @throws AppException
	 */
	public BasicMap<String,Object> findOrg(String sysid) throws AppException{
		String sqlstr = "SELECT ORGCODE,ORGNAME,LVL FROM CORE_ORGANIZATION WHERE SYSID = '"+sysid+"'";
		return dbClient.findOne(new SQLAdapter(sqlstr));
	}
	/**
	 * 获取机构信息列表数据
	 * @return
	 * @throws AppException
	 */
	public List<BasicMap<String,Object>> findOrg() throws AppException{
		String sqlstr = "SELECT SYSID,ORGCODE,ORGNAME,LVL FROM CORE_ORGANIZATION WHERE LVL >= 4";
		return dbClient.find(new SQLAdapter(sqlstr));
	}
	/**
	 * 根据orgid获取机构所在的辖区信息
	 * @param sysid
	 * @return 机构所在的辖区信息
	 * {
	 *   province:"省",
	 *   city:"市",
	 *   district:"区",
	 *   orgname:"机构"
	 *   orgcode:"机构代码"
	 *   orgtype:机构类型
	 * }
	 * @throws AppException
	 */
	public BasicMap<String,Object> findOrgCity(String sysid) throws AppException{
		final BasicMap<String,Object> rtn = new BasicMap<>();
		BasicMap<String,Object> one = dbClient.findOne(new SQLAdapter("SELECT LFT,RGT FROM CORE_ORGANIZATION WHERE SYSID = '"+sysid+"'"));
		if(one!=null){
			String sqlstr = "SELECT ORGCODE,ORGNAME,LVL FROM CORE_ORGANIZATION WHERE LFT <= " + NumberUtil.toInt(one.get("LFT")) + " AND RGT >= " + NumberUtil.toInt(one.get("RGT"));
			dbClient.find(new SQLAdapter(sqlstr),new RowDataListener() {
				public void processData(BasicMap<String, Object> rowData) {
					int type = NumberUtil.toInt(rowData.get("LVL"));
					switch(type){
						case 1://省
							rtn.put("province", StringUtil.toEmptyString(rowData.get("ORGNAME")));
							break;
						case 2://市
							rtn.put("city", StringUtil.toEmptyString(rowData.get("ORGNAME")));
							break;
						case 3://区县
							rtn.put("district", StringUtil.toEmptyString(rowData.get("ORGNAME")));
							break;
						default://住址机构
							rtn.put("orgname", StringUtil.toEmptyString(rowData.get("ORGNAME")));
							rtn.put("orgcode", StringUtil.toEmptyString(rowData.get("ORGCODE")));
							rtn.put("orgtype", type);
					}
				}
			});
		}
		return rtn;
	}
	/**
	 * 更新机构名称<br>
	 * 通过框架内第三方项目系统如 csm 调用修改机构的名称
	 * @param sysid
	 * @param orgname
	 * @throws AppException 
	 */
	public void updateOrgname(String sysid,String orgname) throws AppException{
		dbClient.getInterceptor().setSkipSso(true);
		dbClient.update(UserConst.Collections.CORE_ORGANIZATION, new BasicMap<String,Object>("SYSID",sysid,"ORGNAME",orgname));
		dbClient.getInterceptor().setSkipSso(false);
	}
	
	/**
	 * 更新机构名称<br>
	 * 通过框架内第三方项目系统如 csm 调用修改机构的名称
	 * @param sysid
	 * @param orgname
	 * @throws AppException 
	 */
	public void updateRegionCode(String sysid,String regioncode) throws AppException{
		dbClient.getInterceptor().setSkipSso(true);
		dbClient.update(UserConst.Collections.CORE_ORGANIZATION, new BasicMap<String,Object>("SYSID",sysid,"REGIONCODE",regioncode));
		dbClient.getInterceptor().setSkipSso(false);
	}
}
