package com.ehtsoft.user.utils;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ehtsoft.fw.utils.NumberUtil;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

public class OrganizationExcelUtil {

	private static List<Org> parseExcel(){
		List<Org> data = new ArrayList<Org>();
		
		Map<String,String> map = new HashMap<String,String>();
		File file = new File("E:/doc/04.项目产品管理/全国区县以上区域编码.xls");
		Workbook book = null;
		try {
			book = Workbook.getWorkbook(file);
			
			Sheet[] sheets = book.getSheets();
			System.out.println("一共 "+sheets.length + " 省");
			int sysid = 1;
			for(int i=0;i<sheets.length;i++){
				int rows = sheets[i].getRows();
				int cols = sheets[i].getColumns();
				for(int row=1;row<rows;row++){
					Org org = new Org();
					org.setSysid(sysid + "");
					sysid ++;
					for(int col=0;col<cols;col++){
						String content = sheets[i].getCell(col,row).getContents().trim();
						switch(col){
						case 0:
							org.setOrgcode(content);
							break;
						case 1:
							org.setOrgname(content);
							break;
						case 2:
							org.setLvl(content);
							break;
						}
					}
					if(org.getOrgcode().length()==2 || org.getOrgcode().length()==4){
						map.put(org.getOrgcode(), org.getSysid());
					}
					org.setParentid(map.get(org.getSubstr()));
					if(org.validate()==false){
						System.out.println(sheets[i].getName() + " " + org.getOrgcode() + " " + org.getOrgname() + "有错误");
					}
					data.add(org);
				}
			}
		} catch (BiffException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			if(book!=null)
			book.close();
		}
		return data;
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Connection conn = null;
		PreparedStatement psmt = null;
		List<Org> data = parseExcel();
		
		String tablename = "CORE_ORGANIZATION"; 
		
    	try {
			Class.forName("org.postgresql.Driver");
			Long ts = new java.util.Date().getTime();
			conn = DriverManager.getConnection("jdbc:postgresql://172.16.30.58:5432/fw_core","postgres","root");
			conn.setAutoCommit(false);
			ResultSet rs = conn.createStatement().executeQuery("select count(1) as cnt from " + tablename);
			if(rs.next()){
				if(rs.getInt(1)>0){
					System.out.println("数据已经存在，不需要导入数据");
					return;
				}
			}
			psmt = conn.prepareStatement("INSERT INTO "+tablename+"(sysid,parentid,orgcode,orgname,lvl,cts,uts) VALUES (?,?,?,?,?,?,?)");
			for(Org org : data){
				psmt.setLong(1, NumberUtil.toLong(org.getSysid()));
				if(org.getParentid()!=null){
					psmt.setLong(2, NumberUtil.toLong(org.getParentid()));
				}else{
					psmt.setNull(2, Types.BIGINT);
				}
				psmt.setString(3, org.getOrgcode());
				psmt.setString(4, org.getOrgname());
				psmt.setInt(5, NumberUtil.toInt(org.getLvl()));
				psmt.setDate(6, new Date(ts));
				psmt.setDate(7, new Date(ts));
				psmt.addBatch();
			}
			psmt.executeBatch();
			conn.commit();
			System.out.println("行政机构数据导入完成！");
    	} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
			if(conn!=null){
				try {
					conn.rollback();
				} catch (SQLException e1) {
				}
			}
		} finally{
			if(psmt!=null){
				try {
					psmt.close();
				} catch (SQLException e1) {
				}
			}
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e1) {
				}
			}
		}
		
	}

}
class Org{
	private String orgcode;
	private String orgname;
	private String lvl;
	private String parentid;
	private String sysid;
	public String getOrgcode() {
		return orgcode;
	}
	public void setOrgcode(String orgcode) {
		this.orgcode = orgcode;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getLvl() {
		return lvl;
	}
	public void setLvl(String lvl) {
		this.lvl = lvl;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getSysid() {
		return sysid;
	}
	public void setSysid(String sysid) {
		this.sysid = sysid;
	}
	
	public String getSubstr(){
		String rtn = null;
		if(orgcode!=null){
			if(orgcode.length()>2){
				rtn = orgcode.substring(0, orgcode.length()-2);
			}
		}
		return rtn;
	}
	
	public boolean validate(){
		boolean rtn = false;
		if(lvl==null){
			return rtn;
		}
		if(orgcode==null){
			return rtn;
		}
		if("1".equals(lvl) && orgcode.trim().length()==2){
			rtn = true;
		}
		if("2".equals(lvl) && orgcode.trim().length()==4){
			rtn = true;
		}
		if("3".equals(lvl) && orgcode.trim().length()==6){
			rtn = true;
		}
		return rtn;
	}
	
	public String toString(){
		return sysid + "|" + parentid + ":" + orgcode + "  " + orgname + "    "  + lvl;
	}
	
}