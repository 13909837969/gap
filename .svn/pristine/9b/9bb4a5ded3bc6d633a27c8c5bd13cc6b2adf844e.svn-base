/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年5月8日
 */
package com.ehtsoft.supervise.utils;

import java.io.FileOutputStream;
import java.math.BigInteger;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.xml.bind.annotation.adapters.HexBinaryAdapter;

import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.TextAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFStyle;
import org.apache.poi.xwpf.usermodel.XWPFStyles;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableCell.XWPFVertAlign;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTColor;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTDecimalNumber;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTFonts;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTHpsMeasure;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTOnOff;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTPPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTRPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTString;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTStyle;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTbl;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblWidth;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTcPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STStyleType;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTblWidth;

import com.ehtsoft.fw.core.config.Deploy;
import com.ehtsoft.fw.core.config.helper.ModelConfigHelper;
import com.ehtsoft.fw.core.config.model.ColumnConfig;
import com.ehtsoft.fw.core.config.model.TableConfig;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.StringUtil;

/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年5月8日
 *
 */
public class Model2Word {
	public static void main(String[] args) throws Exception {

		Deploy.setProperty("database.type", "postgres");
		String modelPath = "META-INF/model/*/*-model.xml";
		// ModelConfigHelper.DIR="d:/";
		ModelConfigHelper.init(modelPath);
		getWord();
	}

	public static void getWord() throws Exception {

		String[] deleteStr = null;
		XWPFDocument xdoc = new XWPFDocument();
		List<TableConfig> list = ModelConfigHelper.getAllTableConfig();
		Collections.sort(list, new Comparator<TableConfig>() {
			@Override
			public int compare(TableConfig o1, TableConfig o2) {
				return o1.getName().compareTo(o2.getName());
			}
		});
		BasicMap<String, String> map = new BasicMap<>("ANZBJ", "安置帮教数据模型", "JZ", "社区矫正数据模型", "FLFW", "法律服务数据模型",
				"FLYZ", "法律援助数据模型", "FZXC", "法制宣传数据模型", "GZZHGL", "公证证号管理数据模型", "IM", "消息推送数据模型", "JC", "业务基础数据模型",
				"LSZHGL", "律师综合数据模型", "REP", "大数据及综合报表数据模型", "RMTJ", "人民调解数据模型", "SFS", "司法所数据模型", "SYS", "系统基层数据模型");
		BasicMap<String, String> bMap = new BasicMap<>();
		int idx = 0;
		int subIdx = 0;
		for (TableConfig tc : list) {
			String pre = tc.getName().substring(0, tc.getName().indexOf("_"));
			if ("BIZ".equals(pre) || "CORE".equals(pre)) {
				continue;
			}
			if(bMap.get(pre)==null){
				idx++;
				subIdx = 0;
				XWPFParagraph titleMes1 = xdoc.createParagraph();
				titleMes1.setAlignment(ParagraphAlignment.LEFT);
				XWPFStyles styles1 = xdoc.createStyles();
				String heading1 = "标题1";
				addCustomHeadingStyle(xdoc, styles1, heading1, 1, 36, "4288BC");
				titleMes1.setStyle(heading1);
	
				XWPFRun r = titleMes1.createRun();
				r.setBold(true);
				r.setText(idx+"."+StringUtil.toEmptyString(map.get(pre)));// 活动名称
				r.setColor("333333");
				bMap.put(pre, pre);
			}
			subIdx ++;
			////////// --------

			XWPFParagraph titleMes = xdoc.createParagraph();
			titleMes.setAlignment(ParagraphAlignment.LEFT);
			XWPFStyles styles = xdoc.createStyles();
			String heading2 = "标题2";
			addCustomHeadingStyle(xdoc, styles, heading2, 2, 28, "4288BC");
			titleMes.setStyle(heading2);

			XWPFRun r1 = titleMes.createRun();
			r1.setBold(true);
			// r1.setFontFamily("微软雅黑");
			r1.setText(idx+"." + subIdx+" "+tc.getLabel() + "(" + tc.getName() + ")");// 活动名称
			// r1.setFontSize(20);
			r1.setColor("333333");
			// r1.setBold(true);
			// 序号 名称 字段 类型 约束 必填 备注
			XWPFTable dTable = xdoc.createTable(tc.getColumns().size(), 6);

			createTable(dTable, xdoc, tc);
		}

		// 在服务器端生成
		FileOutputStream fos = new FileOutputStream("/workspace/数据库设计.docx");
		xdoc.write(fos);
		fos.close();
	}

	public static void createTable(XWPFTable xTable, XWPFDocument xdoc, TableConfig tc) {
		String bgColor = "111111";

		CTTbl ttbl = xTable.getCTTbl();
		CTTblPr tblPr = ttbl.getTblPr() == null ? ttbl.addNewTblPr() : ttbl.getTblPr();

		CTTblWidth tblWidth = tblPr.isSetTblW() ? tblPr.getTblW() : tblPr.addNewTblW();

		tblWidth.setW(new BigInteger("8600"));
		tblWidth.setType(STTblWidth.DXA);
		// 序号 名称 字段 类型 约束 必填 备注
		XWPFTableCell xh = getCellHight(xTable, 0, 0);
		setCellText(0,xdoc, xh, "序号", bgColor, 600);
		setCellText(1,xdoc, getCellHight(xTable, 0, 1), "名称", bgColor, 1800);
		setCellText(2,xdoc, getCellHight(xTable, 0, 2), "字段", bgColor, 1500);
		setCellText(3,xdoc, getCellHight(xTable, 0, 3), "类型", bgColor, 1800);
		setCellText(4,xdoc, getCellHight(xTable, 0, 4), "必填", bgColor, 1200);
		setCellText(5,xdoc, getCellHight(xTable, 0, 5), "备注", bgColor, 1800);
		int number = 0;
		for (int i = 1; i < tc.getColumns().size(); i++) {
			ColumnConfig cc = tc.getColumns().get(i);
			number++;
			setCellText(0,xdoc, getCellHight(xTable, number, 0), number + "", bgColor, 600);
			setCellText(1,xdoc, getCellHight(xTable, number, 1), cc.getLabel(), bgColor, 1800);
			setCellText(2,xdoc, getCellHight(xTable, number, 2), cc.getField(), bgColor, 1500);
			setCellText(3,xdoc, getCellHight(xTable, number, 3), cc.getTypeOfSql(), bgColor, 1800);
			setCellText(4,xdoc, getCellHight(xTable, number, 4), cc.getRequired() + "", bgColor, 1200);
			setCellText(5,xdoc, getCellHight(xTable, number, 5), cc.getRemark() + "", bgColor, 1800);
		}
	}

	// 设置表格高度
	private static XWPFTableCell getCellHight(XWPFTable xTable, int rowNomber, int cellNumber) {
		XWPFTableRow row = null;
		row = xTable.getRow(rowNomber);
		row.setHeight(100);
		XWPFTableCell cell = null;
		cell = row.getCell(cellNumber);
		if(cellNumber==0){
			cell.setVerticalAlignment(XWPFVertAlign.CENTER);
		}
		return cell;
	}

	/**
	 * 
	 * @param xDocument
	 * @param cell
	 * @param text
	 * @param bgcolor
	 * @param width
	 */
	private static void setCellText(int col,XWPFDocument xDocument, XWPFTableCell cell, String text, String bgcolor,
			int width) {
		CTTc cttc = cell.getCTTc();
		CTTcPr cellPr = cttc.addNewTcPr();
		cellPr.addNewTcW().setW(BigInteger.valueOf(width));
		XWPFParagraph pIO = cell.addParagraph();
		cell.removeParagraph(0);
		if(col==0){
			pIO.setAlignment(ParagraphAlignment.CENTER);
		}
		XWPFRun rIO = pIO.createRun();
		rIO.setFontFamily("微软雅黑");
		rIO.setColor("000000");
		rIO.setFontSize(10);
		rIO.setText(text);
	}

	// 设置表格间的空行
	public static void setEmptyRow(XWPFDocument xdoc, XWPFRun r1) {
		XWPFParagraph p1 = xdoc.createParagraph();
		p1.setAlignment(ParagraphAlignment.CENTER);
		p1.setVerticalAlignment(TextAlignment.CENTER);
		r1 = p1.createRun();
	}

	private static void addCustomHeadingStyle(XWPFDocument docxDocument, XWPFStyles styles, String strStyleId,
			int headingLevel, int pointSize, String hexColor) {

		CTStyle ctStyle = CTStyle.Factory.newInstance();
		ctStyle.setStyleId(strStyleId);

		CTString styleName = CTString.Factory.newInstance();
		styleName.setVal(strStyleId);
		ctStyle.setName(styleName);

		CTDecimalNumber indentNumber = CTDecimalNumber.Factory.newInstance();
		indentNumber.setVal(BigInteger.valueOf(headingLevel));

		// lower number > style is more prominent in the formats bar
		ctStyle.setUiPriority(indentNumber);

		CTOnOff onoffnull = CTOnOff.Factory.newInstance();
		ctStyle.setUnhideWhenUsed(onoffnull);

		// style shows up in the formats bar
		ctStyle.setQFormat(onoffnull);

		// style defines a heading of the given level
		CTPPr ppr = CTPPr.Factory.newInstance();
		ppr.setOutlineLvl(indentNumber);
		ctStyle.setPPr(ppr);

		XWPFStyle style = new XWPFStyle(ctStyle);

		CTHpsMeasure size = CTHpsMeasure.Factory.newInstance();
		size.setVal(new BigInteger(String.valueOf(pointSize)));
		CTHpsMeasure size2 = CTHpsMeasure.Factory.newInstance();
		size2.setVal(new BigInteger("24"));

		CTFonts fonts = CTFonts.Factory.newInstance();
		fonts.setAscii("Loma");

		CTRPr rpr = CTRPr.Factory.newInstance();
		rpr.setRFonts(fonts);
		rpr.setSz(size);
		rpr.setSzCs(size2);

		CTColor color = CTColor.Factory.newInstance();
		color.setVal(hexToBytes(hexColor));
		rpr.setColor(color);
		style.getCTStyle().setRPr(rpr);
		// is a null op if already defined

		style.setType(STStyleType.PARAGRAPH);
		styles.addStyle(style);

	}

	public static byte[] hexToBytes(String hexString) {
		HexBinaryAdapter adapter = new HexBinaryAdapter();
		byte[] bytes = adapter.unmarshal(hexString);
		return bytes;
	}
}
