/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年4月9日
 */
package com.ehtsoft.common.servlet;

/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年4月9日
 *
 */

import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.servlet.AbstractServlet;
import com.ehtsoft.common.api.IJasperService;
import com.ehtsoft.common.dto.JasperInfo;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.export.HtmlExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleHtmlExporterOutput;
import net.sf.jasperreports.export.SimpleHtmlReportConfiguration;
import net.sf.jasperreports.web.util.WebHtmlResourceHandler;

public class SimpleJRServlet
  extends AbstractServlet
{
  private static final long serialVersionUID = 7428504867932482858L;
  String PASER_REPORT_PATH = "META-INF/jasper/";
  String SUBREPORT_DIR = "SUBREPORT_DIR";
  
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    StringBuffer requri = new StringBuffer(request.getRequestURI());
    if (requri.charAt(requri.length() - 1) == '/') {
      requri.deleteCharAt(requri.length() - 1);
    }
    requri.replace(0, request.getContextPath().length(), "");
    
    String jasper = requri.substring(requri.lastIndexOf("/") + 1);
    
    Map<String, Object> param = new HashMap();
    Enumeration<String> em = request.getParameterNames();
    while (em.hasMoreElements())
    {
      String name = (String)em.nextElement();
      param.put(name, request.getParameter(name));
    }
    String jasperDir = request.getServletContext().getRealPath("WEB-INF/classes/" + this.PASER_REPORT_PATH);
    param.put(this.SUBREPORT_DIR, jasperDir);
    try
    {
      InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream(this.PASER_REPORT_PATH + jasper + ".jasper");
      String service = request.getParameter("service");
      String pdf = request.getParameter("pdf");
      DataSource dataSource = null;
      JasperInfo jasperInfo = new JasperInfo();
      if (service == null)
      {
        dataSource = (DataSource)AppContext.getSpringBean("DataSource");
        jasperInfo.setJasperPrint(JasperFillManager.fillReport(is, param, dataSource.getConnection()));
      }
      else
      {
        IJasperService jasperService = (IJasperService)AppContext.getSpringBean(service);
        jasperInfo = jasperService.getJasperInfo(is, param);
      }
      if (pdf == null)
      {
        HtmlExporter exporter = new HtmlExporter();
        request.getSession().setAttribute("net.sf.jasperreports.j2ee.jasper_print", jasperInfo.getJasperPrint());
        
        exporter.setImageHandler(new WebHtmlResourceHandler(request.getContextPath() + "/jrimage?image={0}"));
        exporter.setExporterInput(new SimpleExporterInput(jasperInfo.getJasperPrint()));
        exporter.setExporterOutput(new SimpleHtmlExporterOutput(response.getOutputStream()));
        
        SimpleHtmlReportConfiguration reportExportConfiguration = new SimpleHtmlReportConfiguration();
        reportExportConfiguration.setWhitePageBackground(Boolean.valueOf(false));
        reportExportConfiguration.setRemoveEmptySpaceBetweenRows(Boolean.valueOf(true));
        exporter.setConfiguration(reportExportConfiguration);
        exporter.exportReport();
      }
      if ("download".equals(pdf))
      {
        String filename = jasperInfo.getFilename() + ".pdf";
        
        response.addHeader("Content-Disposition", "attachment; filename=" + response.encodeURL(new String(filename.getBytes("utf-8"), "ISO-8859-1")));
        
        JasperExportManager.exportReportToPdfStream(jasperInfo.getJasperPrint(), response.getOutputStream());
      }
      if ("view".equals(pdf))
      {
        response.addHeader("content-type", "application/pdf");
        String filename = jasperInfo.getFilename();
        
        response.addHeader("Content-Disposition", "inline; filename=" + response.encodeURL(new String(filename.getBytes("utf-8"), "ISO-8859-1")));
        
        JasperExportManager.exportReportToPdfStream(jasperInfo.getJasperPrint(), response.getOutputStream());
      }
    }
    catch (JRException e)
    {
      this.logger.error(e.getMessage(), e);
    }
    catch (SQLException e)
    {
      this.logger.error(e.getMessage(), e);
    }
  }
  
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException
  {
    doGet(req, resp);
  }
}

