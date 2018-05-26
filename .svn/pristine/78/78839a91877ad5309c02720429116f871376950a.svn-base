package com.ehtsoft.fw.plugin.window;



import java.sql.SQLException;
import java.util.List;

import org.eclipse.jface.dialogs.Dialog;
import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.jface.window.ApplicationWindow;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.MouseListener;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Combo;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;

import com.ehtsoft.fw.plugin.model.DBSettingData;
import com.ehtsoft.fw.plugin.utils.ConsoleFactory;
import com.ehtsoft.fw.plugin.utils.SqlDBMetaData;
import com.ehtsoft.fw.plugin.utils.SqlDBMetaDataFactory;

public class DBSettingWindow extends Dialog{//ApplicationWindow{  

	public DBSettingWindow(Shell parentShell) {
		super(parentShell);
	}
	String[] items = {
			"Oracle",
			"SQLServer2008",
			"PostgreSql",
			"MySql"};
	String[] drivers = {
			"oracle.jdbc.OracleDriver",
			"net.sourceforge.jtds.jdbc.Driver",
			"org.postgresql.Driver",
			"com.mysql.jdbc.Driver"};
	String[] urls = {
			"jdbc:oracle:thin:@localhost:1521:orcl",
			"jdbc:jtds:sqlserver://172.16.20.188:1433;DatabaseName=[database]",
			"jdbc:postgresql://localhost:5432/[database]",
			"jdbc:mysql://localhost:3306/[database]"
	};
	
	private SqlDBMetaData sqlDBMetaData;
	
	private Combo cboDbType;
	private Text txtDriver ;
	private Text txtUrl;
	private Text txtUser;
	private Text txtPsw;
	private Combo cboDb;
	private Combo cboSchema;
	
	@Override
	protected Control createContents(Composite parent) {
		Rectangle rect = parent.getDisplay().getPrimaryMonitor().getBounds();
		
		Control[] cs = parent.getChildren();  
		if(cs.length>0){
			Control c = cs[0];  
			if(c instanceof org.eclipse.swt.widgets.Label){
				c.dispose();  
			}
		}
		Shell shell = getShell();
		
		shell.setText("配置数据库");
		shell.setBounds((rect.width-500)/2, 200, 500, 320);
		shell.setMaximized(false);
		//Layout
		GridLayout  grid = new GridLayout(2,false);
		grid.marginLeft = 10;
		grid.marginRight = 10;
		grid.marginTop = 10;
		grid.marginBottom = 10;
		grid.verticalSpacing = 10;
		shell.setLayout(grid);
		
		//数据库类型
		Label lblDbtype = new Label(shell,SWT.NONE);
		lblDbtype.setText("数据库类型");
		lblDbtype.setLayoutData( new GridData(SWT.RIGHT,SWT.CENTER,false,false,1,1));
		cboDbType = new Combo(shell,SWT.BORDER|SWT.READ_ONLY);
		cboDbType.setItems(items);
		cboDbType.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,false,1,1));
		Label lblDriver = new Label(shell,SWT.NONE);
		lblDriver.setText("驱动");
		lblDriver.setLayoutData( new GridData(SWT.RIGHT,SWT.CENTER,false,false,1,1));
		
		txtDriver = new Text(shell,SWT.BORDER);
		txtDriver.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,false,1,1));
		
		
		Label lblUrl = new Label(shell,SWT.NONE);
		lblUrl.setText("URL");
		lblUrl.setLayoutData( new GridData(SWT.RIGHT,SWT.CENTER,false,false,1,1));
		
		txtUrl = new Text(shell,SWT.BORDER);
		txtUrl.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,false,1,1));
		
		Label lblUser = new Label(shell,SWT.NONE);
		lblUser.setText("用户名");
		lblUser.setLayoutData( new GridData(SWT.RIGHT,SWT.CENTER,false,false,1,1));
		
		txtUser = new Text(shell,SWT.BORDER);
		txtUser.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,false,1,1));
		
		Label lblPsw = new Label(shell,SWT.NONE);
		lblPsw.setText("密码");
		lblPsw.setLayoutData( new GridData(SWT.RIGHT,SWT.CENTER,false,false,1,1));
		
		txtPsw = new Text(shell,SWT.BORDER|SWT.PASSWORD);
		txtPsw.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,false,1,1));
		
		
		Label lbldb = new Label(shell,SWT.NONE|SWT.Dispose);
		lbldb.setText("数据库");
		lbldb.setLayoutData( new GridData(SWT.RIGHT,SWT.CENTER,false,false,1,1));
		cboDb = new Combo(shell,SWT.BORDER);
		cboDb.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,false,1,1));
		
		Label lblSchema = new Label(shell,SWT.NONE);
		lblSchema.setText("Schema");
		lblSchema.setLayoutData( new GridData(SWT.RIGHT,SWT.CENTER,false,false,1,1));
		cboSchema = new Combo(shell,SWT.BORDER);
		cboSchema.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,false,1,1));
		
		Button btn = new Button(shell,SWT.NONE);
		btn.setText("确认");
		GridData gd = new GridData(SWT.RIGHT,SWT.FILL,true,false,2,1);
		gd.widthHint = 100;
		btn.setLayoutData(gd);
		
		/**
		 * 选中数据库种类
		 */
		cboDbType.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent arg0) {
				Combo cbo = (Combo)arg0.getSource();
				int index = cbo.getSelectionIndex();
				txtDriver.setText(drivers[index]);
				txtUrl.setText(urls[index]);
				txtPsw.setText("");
				txtUser.setText("");
			}
			@Override
			public void widgetDefaultSelected(SelectionEvent arg0) {
			}
		});
		/**
		 * 密码焦点失去时触发，更加driver url username password 连接到数据库，获取 catalog 及 schema 信息
		 */
		txtPsw.addListener(SWT.FocusOut, new Listener() {
			public void handleEvent(Event arg0) {
				try {
					if("".equals(txtPsw.getText())){
						return;
					}
					
					sqlDBMetaData = SqlDBMetaDataFactory.createSqlDBMetaData(txtDriver.getText(), txtUrl.getText(), txtUser.getText(), txtPsw.getText());
					List<String> catalogs = sqlDBMetaData.getCatalogs();
					cboDb.removeAll();
					if(catalogs.isEmpty()){
						cboDb.add("NULL",0);
						cboDb.setText("NULL");
					}else{
						for(int i=0;i< catalogs.size();i++){
							cboDb.add(catalogs.get(i), i);
							if("SQLServer2008".equalsIgnoreCase(cboDbType.getText())){
								System.out.println(txtDriver.getText().toLowerCase() + ":" + catalogs.get(i).toLowerCase());
								if(txtUrl.getText().toLowerCase().contains(catalogs.get(i).toLowerCase())){
									cboDb.setText(catalogs.get(i));
								}
							}
						}
						if(catalogs.size()==1){
							cboDb.setText(catalogs.get(0));
						}
					}
					List<String> schemas = sqlDBMetaData.getSchemas();
					cboSchema.removeAll();
					for(int i=0;i< schemas.size();i++){
						cboSchema.add(schemas.get(i), i);
						if("PostgreSql".equalsIgnoreCase(cboDbType.getText())){
							if("public".equalsIgnoreCase(schemas.get(i))){
								cboSchema.setText(schemas.get(i));
							}
						}
						if("Oracle".equalsIgnoreCase(cboDbType.getText())){
							if(txtUser.getText().equalsIgnoreCase(schemas.get(i))){
								cboSchema.setText(schemas.get(i));
							}
						}
						if("SQLServer2008".equalsIgnoreCase(cboDbType.getText())){
							if("dbo".equalsIgnoreCase(schemas.get(i))){
								cboSchema.setText(schemas.get(i));
							}
						}
					}
					
				} catch (SQLException e) {
					ConsoleFactory.printToConsole(e.getMessage(),true);
					MessageDialog.openInformation(
							getShell(),
							"错误信息",
							e.getMessage());
					
				} catch (ClassNotFoundException e) {
					ConsoleFactory.printToConsole(e.getMessage(),true);
					MessageDialog.openInformation(
							getShell(),
							"错误信息",
							e.getMessage());
				}
			}
		});
		if(mouseListener!=null)
			btn.addMouseListener(mouseListener);
		return shell;
	}
	private MouseListener mouseListener;
	
	public void addMouseListener(MouseListener mouseListener){
		this.mouseListener = mouseListener;
	}
	
//	public DBSettingWindow() {
//		super(null);
//	}
	
	public void initMetaSchemaInfo() {
		DBSettingData dbsd = getDBSettingData();
		if(sqlDBMetaData!=null){
			sqlDBMetaData.setCatalog(dbsd.getCatalog());
			sqlDBMetaData.setSchema(dbsd.getSchema());
		}
	}
	private DBSettingData dbsd;
	public DBSettingData getDBSettingData(){
		if(dbsd==null){
			dbsd = new DBSettingData();
		}
		if(cboDbType!=null){
			dbsd.setDbType(cboDbType.getText());
			dbsd.setDriver(txtDriver.getText());
			dbsd.setUrl(txtUrl.getText());
			dbsd.setUsername(txtUser.getText());
			dbsd.setPassword(txtPsw.getText());
			dbsd.setCatalog(cboDb.getText());
			dbsd.setSchema(cboSchema.getText());
		}
		return dbsd;
	}
//	public static void main(String[] args){
//		DBSettingWindow helloWorldApp = new DBSettingWindow();
//		helloWorldApp.setBlockOnOpen(true);
//		helloWorldApp.open();
//		Display.getCurrent().dispose();
//	}
}
