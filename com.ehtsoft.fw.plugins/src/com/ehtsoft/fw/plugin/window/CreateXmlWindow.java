package com.ehtsoft.fw.plugin.window;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import org.eclipse.core.resources.IContainer;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.resources.IWorkspaceRoot;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.Path;
import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.jface.window.ApplicationWindow;
import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.StyleRange;
import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.layout.FormAttachment;
import org.eclipse.swt.layout.FormData;
import org.eclipse.swt.layout.FormLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.dialogs.ContainerSelectionDialog;

import com.ehtsoft.fw.plugin.utils.ModelConfigHelper;
import com.ehtsoft.fw.plugin.utils.SqlDBMetaDataFactory;

public class CreateXmlWindow extends ApplicationWindow{

	private Text txtContainer;

	private Label lblStatus;

	private List<String> tables;
	/**
	 * 处理日志
	 */
	private StyledText txtProgessLog;
	
	private Button btnCancel;

	public CreateXmlWindow(Shell parentShell) {
		super(parentShell);
	}

	@Override
	protected Control createContents(Composite parent) {
		if(parent.getChildren().length>0){
			parent.getChildren()[0].dispose();
		}
		Rectangle rect = parent.getDisplay().getPrimaryMonitor().getBounds();
		Shell shell = getShell();
		shell.setText("配置数据库");
		shell.setBounds((rect.width-500)/2, 200, 500, 320);
	    FormLayout form = new FormLayout();
	    form.marginTop = 10;
	    form.marginLeft = 5;
	    form.marginRight = 5;
	    shell.setLayout(form);

	    FormData fd = new FormData();
	    fd.top = new FormAttachment(0,0);
	    fd.left = new FormAttachment(0,5);
	    fd.right = new FormAttachment(100,-5);
		lblStatus = new Label(shell, SWT.BORDER);
		lblStatus.setLayoutData(fd);
		
		Label label = new Label(shell, SWT.NULL);
		label.setText("&Container:");
		FormData fd0 = new FormData();
	    fd0.top = new FormAttachment(lblStatus,10);
	    fd0.left =  new FormAttachment(0,5);
	    label.setLayoutData(fd0);
	    
		txtContainer = new Text(shell, SWT.BORDER);
		FormData fd1 = new FormData();
		fd1.top = new FormAttachment(lblStatus,10); 
		fd1.left = new FormAttachment(label,10);
		fd1.right = new FormAttachment(100,-80);
		txtContainer.setLayoutData(fd1);
		
		Button btnContainer = new Button(shell,SWT.PUSH);
		FormData fd2 = new FormData();
		fd2.left = new FormAttachment(txtContainer,10);
		fd2.right = new FormAttachment(100,-2);
		fd2.top = new FormAttachment(lblStatus,8);
		btnContainer.setLayoutData(fd2);
		btnContainer.setText("选择位置");
		
		Text txtLog = new Text(shell,SWT.BORDER|SWT.MULTI|SWT.V_SCROLL|SWT.READ_ONLY);
		
		FormData fd3 = new FormData();
		fd3.top = new FormAttachment(txtContainer, 10);
		fd3.left = new FormAttachment(0,2);
		fd3.right = new FormAttachment(50,-2);
		fd3.bottom = new FormAttachment(100,-60);
		txtLog.setLayoutData(fd3);
		
		txtProgessLog = new StyledText(shell,SWT.BORDER|SWT.MULTI|SWT.V_SCROLL|SWT.H_SCROLL|SWT.READ_ONLY);
		
		FormData fd4 = new FormData();
		fd4.top = new FormAttachment(txtContainer, 10);
		fd4.left = new FormAttachment(txtLog,2);
		fd4.right = new FormAttachment(100,-2);
		fd4.bottom = new FormAttachment(100,-60);
		txtProgessLog.setLayoutData(fd4);
		
		Button btnEnter = new Button(shell,SWT.NONE);
		FormData fd5 = new FormData();
		fd5.width = 80;
		fd5.right = new FormAttachment(100,-86);
		fd5.bottom = new FormAttachment(100,-5);
		btnEnter.setLayoutData(fd5);
		btnEnter.setText("确认");
		
		btnCancel = new Button(shell,SWT.NONE);
		FormData fd6 = new FormData();
		fd6.width = 80;
		fd6.right = new FormAttachment(100,-2);
		fd6.bottom = new FormAttachment(100,-5);
		btnCancel.setLayoutData(fd6);
		btnCancel.setText("取消");
		
		txtContainer.addModifyListener(new ModifyListener() {
			public void modifyText(ModifyEvent e) {
				dialogChanged();
			}
		});
		
		btnContainer.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				handleBrowse();
			}
			
		});
		btnEnter.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				createNewFile();
			}
		});
		btnCancel.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				CreateXmlWindow.this.close();
			}
			
		});
		
		if(this.tables!=null){
			txtLog.append("选择的表如下:\n");
			for(String table : tables){
				txtLog.append(table+ "\n");
			}
		}
		
		return shell;
	}
	
	private void handleBrowse() {
		//打开项目选择窗口
		ContainerSelectionDialog dialog = new ContainerSelectionDialog(
				getShell(), ResourcesPlugin.getWorkspace().getRoot(), false,
				"选择模型存储的位置");
		if (dialog.open() == ContainerSelectionDialog.OK) {
			Object[] result = dialog.getResult();
			if (result.length == 1) {
				txtContainer.setText(((Path) result[0]).toString());
			}
		}
	}
	
	private void dialogChanged() {
		String path = txtContainer.getText();
		IResource container = ResourcesPlugin.getWorkspace().getRoot()
				.findMember(new Path(path));
		//String fileName = getFileName();

		if (path.length() == 0) {
			updateStatus("File container must be specified");
			return;
		}
		if (container == null
				|| (container.getType() & (IResource.PROJECT | IResource.FOLDER)) == 0) {
			updateStatus("File container must exist");
			return;
		}
		if (!container.isAccessible()) {
			updateStatus("Project must be writable");
			return;
		}

		updateStatus(null);
	}
	
	private void updateStatus(String msg){
		if(msg!=null){
			lblStatus.setText(msg);
			lblStatus.setForeground(this.getShell().getDisplay().getSystemColor(SWT.COLOR_RED));
		}else{
			lblStatus.setText("success");
			lblStatus.setForeground(this.getShell().getDisplay().getSystemColor(SWT.COLOR_GREEN));
		}
	}
	
	public void setTables(List<String> tables) {
		this.tables = tables;
	}

	/**
	 * 根据数据模型创建 xml 文件
	 */
	public void createNewFile(){
		String suffix = "-model.xml";
		if(this.tables==null){
			MessageDialog.openError(getShell(), "Error", "没有选择需要创建的表");
			return;
		}
		String containerName = txtContainer.getText();
		IWorkspaceRoot root = ResourcesPlugin.getWorkspace().getRoot();
		IResource resource = root.findMember(new Path(containerName));
		if (resource == null || !resource.exists() || !(resource instanceof IContainer)) {
			MessageDialog.openError(getShell(), "Error", "不存在" + containerName + "文件夹");
			return;
		}
		IContainer container = (IContainer) resource;
		IContainer p = container.getParent();
		if(p!=null){
			IFile schema = p.getFile(new Path("schema.xsd"));
			if(!schema.exists()){
				try {
					InputStream  is = this.getClass().getClassLoader().getResourceAsStream("META-INF/schema.xsd");
					schema.create(is, true, null);
				} catch (CoreException e) {
					e.printStackTrace();
				}
			}
		}
		if(txtProgessLog!=null){
			txtProgessLog.setText("正在创建模型文件(-model.xml)...\n");
		}
		try {
			for(String table : tables){
				String fileName = table + suffix;
				IFile file = container.getFile(new Path(fileName));
					if(!file.exists()){
						byte[] bs = ModelConfigHelper.createModelXml(table, SqlDBMetaDataFactory.getSqlDBMetaData());
							file.create(new ByteArrayInputStream(bs), true, null);
							if(txtProgessLog!=null){
								txtProgessLog.append("文件 " + fileName + " 创建成功.\n");
							}
					}else{
						//setContents(InputStream source, boolean force, boolean keepHistory, IProgressMonitor monitor) 
						//file.setContents(new ByteArrayInputStream("我爱你老婆!".getBytes()),true,true,null);
						if(txtProgessLog!=null){
							int s = txtProgessLog.getText().length();
							String log = "文件 " + fileName + " 已经存在，不能创建.\n";
							txtProgessLog.append(log);
							//不能创建的时候，日志显示红色
							StyleRange r = new StyleRange(s,log.length(),getShell().getDisplay().getSystemColor(SWT.COLOR_RED),getShell().getDisplay().getSystemColor(SWT.COLOR_WHITE));
							txtProgessLog.setStyleRange(r);
							//日志始终向下滚动
							//txtProgessLog.setTopIndex(Integer.MAX_VALUE); // or 
							txtProgessLog.setSelection(txtProgessLog.getCharCount());
						}
					}
			}
		} catch (CoreException e) {
			e.printStackTrace();
		} catch (Throwable e) {
			MessageDialog.openError(getShell(), "Error", e.getMessage());
			e.printStackTrace();
		}
		if(txtProgessLog!=null){
			txtProgessLog.append("数据模型已经创建完成.\n位置： " + container.getLocation().toOSString());
			txtProgessLog.setSelection(txtProgessLog.getCharCount());
		}
		//文件创建完成
		btnCancel.setText("完成");
	}
	public static void main(String[] args){
		CreateXmlWindow helloWorldApp = new CreateXmlWindow(null);
		helloWorldApp.setBlockOnOpen(true);
		helloWorldApp.open();
		Display.getCurrent().dispose();
	}
}
