/**
 * @Description jasperreport 对象工具
 * @author wangbao
 * @date 2018年4月9日
 */
package com.ehtsoft.common.dto;

import net.sf.jasperreports.engine.JasperPrint;

/**
 * @Description 
 * @author wangbao
 * @date 2018年4月9日
 *
 */
public class JasperInfo {
	  private JasperPrint jasperPrint;
	  private String filename;
	  
	  public JasperPrint getJasperPrint()
	  {
	    return this.jasperPrint;
	  }
	  
	  public void setJasperPrint(JasperPrint jasperPrint)
	  {
	    this.jasperPrint = jasperPrint;
	  }
	  
	  public String getFilename()
	  {
	    return this.filename;
	  }
	  
	  public void setFilename(String filename)
	  {
	    this.filename = filename;
	  }
}
