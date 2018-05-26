package com.ehtsoft.fw.plugin.views;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.jface.action.Action;
import org.eclipse.jface.action.IMenuListener;
import org.eclipse.jface.action.IMenuManager;
import org.eclipse.jface.action.IToolBarManager;
import org.eclipse.jface.action.MenuManager;
import org.eclipse.jface.action.Separator;
import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.jface.viewers.DoubleClickEvent;
import org.eclipse.jface.viewers.IDoubleClickListener;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.jface.viewers.TreeSelection;
import org.eclipse.jface.viewers.TreeViewer;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.MouseAdapter;
import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.MouseListener;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.ui.IActionBars;
import org.eclipse.ui.ISharedImages;
import org.eclipse.ui.IWorkbenchActionConstants;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.part.DrillDownAdapter;
import org.eclipse.ui.part.ViewPart;

import com.ehtsoft.fw.plugin.model.ColumnConfig;
import com.ehtsoft.fw.plugin.model.DBSettingData;
import com.ehtsoft.fw.plugin.utils.SqlDBMetaDataFactory;
import com.ehtsoft.fw.plugin.views.tree.NameSorter;
import com.ehtsoft.fw.plugin.views.tree.TreeObject;
import com.ehtsoft.fw.plugin.views.tree.DatabaseViewContentProvider;
import com.ehtsoft.fw.plugin.views.tree.ViewLabelProvider;
import com.ehtsoft.fw.plugin.window.CreateXmlWindow;
import com.ehtsoft.fw.plugin.window.DBSettingWindow;

/**
 * 数据库视图
 * 通过相应的配置后，将数据库中所有的表都现实出来
 * @author 王宝
 */
public class DatabaseView extends ViewPart {
	
	public static final String DBSETTING_FILE = "dbsetting.setting"; 

	/**
	 * extension 扩展点中的 view 的 id 值。
	 * 如:
	 *    &lt;extension</br>
	 *        point="org.eclipse.ui.views"&gt;</br>
	 *     &lt;category</br>
	 *           name="Eht Framework"</br>
	 *           id="<b>com.ehtsoft.fw.plugin</b>"&gt;</br>
	 *     &lt;/category&gt;</br>
	 *     &lt;view</br>
	 *           name="Database Mode View"</br>
	 *           icon="icons/sample.gif"</br>
	 *           category="com.ehtsoft.fw.plugin"</br>
	 *           class="com.ehtsoft.fw.plugin.views.DatabaseView"</br>
	 *           id="com.ehtsoft.fw.plugin.views.DatabaseView"&gt;</br>
	 *     &lt;/view&gt;</br>
	 *  &lt;/extension&gt;</br>
	 */
	public static final String ID = "com.ehtsoft.fw.plugin.views.DatabaseView";

	//Tree View 视图中要现实的tree
	private TreeViewer viewer;
	private DrillDownAdapter drillDownAdapter;
	
	//连接打开数据库配置连接相应事件方法
	private Action action1;
	private Action action2;
	private Action doubleClickAction;

	/**
	 * The constructor.
	 */
	public DatabaseView() {
	}

	/**
	 * ViewPart 视图方法调用（视图回调方法）
	 * 在该方法中创建相关的视图组件信息（包括 tree 等）
	 */
	@Override
	public void createPartControl(Composite parent) {
		viewer = new TreeViewer(parent, SWT.MULTI | SWT.H_SCROLL | SWT.V_SCROLL);
		//视图右键菜单或视图中的ActionBar 中的 返回（Go Back）,前进 （Go inter），主页 （Go home） 菜单项目
		drillDownAdapter = new DrillDownAdapter(viewer);
		//tree 节点内容
		viewer.setContentProvider(new DatabaseViewContentProvider(viewer));
		//tree节点 现实 label 渲染 （ 图标信息）
		viewer.setLabelProvider(new ViewLabelProvider());
		//tree 排序方式
		viewer.setSorter(new NameSorter());
		viewer.setInput(getViewSite());

		// 创建 帮助 信息（ help 信息，按下 F1 所提示的信息）  the help context id for the viewer's control
		PlatformUI.getWorkbench().getHelpSystem().setHelp(viewer.getControl(), "com.ehtsoft.fw.plugin.viewer");
		//右键菜单点击事件
		makeActions();
		//右键菜单
		hookContextMenu();
		//双击事件
		hookDoubleClickAction();
		//添加视图工具bar按钮
		contributeToActionBars();
	}

	private void hookContextMenu() {
		MenuManager menuMgr = new MenuManager("#PopupMenu");
		menuMgr.setRemoveAllWhenShown(true);
		menuMgr.addMenuListener(new IMenuListener() {
			public void menuAboutToShow(IMenuManager manager) {
				//填充右键菜单项目
				DatabaseView.this.fillContextMenu(manager);
			}
		});
		Menu menu = menuMgr.createContextMenu(viewer.getControl());
		viewer.getControl().setMenu(menu);
//		//Resource Configurations 菜单
//		getSite().registerContextMenu(menuMgr, viewer);
	}

	private void contributeToActionBars() {
		IActionBars bars = getViewSite().getActionBars();
		//添加视图bar下拉选
		fillLocalPullDown(bars.getMenuManager());
		//添加视图 bar 按钮
		fillLocalToolBar(bars.getToolBarManager());
	}

	private void fillLocalPullDown(IMenuManager manager) {
		manager.add(action1);
		manager.add(new Separator());
		manager.add(action2);
	}
	//填充右键菜单项目
	private void fillContextMenu(IMenuManager manager) {
		TreeSelection ts = (TreeSelection)viewer.getSelection();
		action1.setEnabled(false);
		action2.setEnabled(false);
		if(ts.size()>0){
			TreeObject to = (TreeObject)ts.getFirstElement();
			if("root".equals(to.getKey()) && !to.hasChildren()){
				action1.setEnabled(true);
			}else if("table".equals(to.getKey()) || "root".equals(to.getKey())){
				action2.setEnabled(true);
			}
		}
		manager.add(action1);
		manager.add(action2);
		manager.add(new Separator());
		
		//视图右键菜单或视图中的ActionBar 中的 返回（Go Back）,前进 （Go inter），主页 （Go home） 菜单项目
//		drillDownAdapter.addNavigationActions(manager);
//		manager.add(new Separator(IWorkbenchActionConstants.MB_ADDITIONS));
	}
	//添加视图 bar 按钮
	private void fillLocalToolBar(IToolBarManager manager) {
		manager.add(action1);
		manager.add(action2);
		manager.add(new Separator());
		drillDownAdapter.addNavigationActions(manager);
	}
	//右键菜单点击事件
	private void makeActions() {
		//打开数据库配置
		action1 = new Action() {
			public void run() {
				openDBSettingWindow();
			}
		};
		action1.setText("打开数据库配置");
		action1.setToolTipText("打开数据库配置");
		action1.setImageDescriptor(PlatformUI.getWorkbench().getSharedImages().
			getImageDescriptor(ISharedImages.IMG_TOOL_NEW_WIZARD));
		//创建模型文件（-model.xml）
		action2 = new Action() {
			public void run() {
				CreateXmlWindow xmlwin = new CreateXmlWindow(getSite().getShell());
				TreeSelection treeSelection = (TreeSelection) viewer.getSelection();
				Object[] objs = treeSelection.toArray();
				List<String> tables = new ArrayList<String>() ;
				if(objs.length==1){
					TreeObject to = (TreeObject) objs[0];
					if("root".equals(to.getKey())){
						for(int i=0;i<to.getChildren().length;i++){
							tables.add(to.getChildren()[i].getName());
						}
					}else if("table".equals(to.getKey())){
						tables.add(to.getName());
					}
				}else{
					for(int i=0;i<objs.length;i++){
						TreeObject o=(TreeObject)objs[i];
						if("table".equalsIgnoreCase(o.getKey())){
							tables.add(o.getName());
						}
					}
				}
				xmlwin.setTables(tables);
				xmlwin.open();
			}
		};
		action2.setText("创建模型文件（-model.xml）");
		action2.setToolTipText("创建模型文件（-model.xml）");
		action2.setImageDescriptor(PlatformUI.getWorkbench().getSharedImages().
				getImageDescriptor(ISharedImages.IMG_OBJ_ADD));
		
		// tree 双击时候调用
		doubleClickAction = new Action() {
			public void run() {
				openDBSettingWindow();
			}
		};
	}
	
	/**
	 * 打开数据库配置界面
	 */
	private void openDBSettingWindow(){
			
		ISelection selection = viewer.getSelection();
		Object obj = ((IStructuredSelection)selection).getFirstElement();
		TreeObject to = (TreeObject)obj;
		if("root".equals(to.getKey())){
			
			final TreeObject root = to;
			final DBSettingWindow dbSettingWin = new DBSettingWindow(getSite().getShell());
			dbSettingWin.addMouseListener(new MouseAdapter() {
				@Override
				public void mouseUp(MouseEvent arg0) {
					root.removeAllChild();
					DBSettingData d = dbSettingWin.getDBSettingData();
					ObjectOutputStream oos = null;
					try {
						//数据库配置序列号到本地，下次打开时，直接读取
						String workspacePath = ResourcesPlugin.getWorkspace().getRoot().getLocation().toOSString();
						File file = new File(workspacePath + File.separator + DBSETTING_FILE);
						if(!file.exists()){
							file.createNewFile();
						}
						oos = new ObjectOutputStream(new FileOutputStream(file));
						oos.writeObject(d);
						oos.flush();
					} catch (Exception e) {
					} finally{
						if(oos!=null){
							try {
								oos.close();
							} catch (IOException e) {
							}
						}
					}
					dbSettingWin.initMetaSchemaInfo();
					//获取库中所有的表
					List<String> tables = SqlDBMetaDataFactory.getSqlDBMetaData().getTables("%");
					root.setLabel(d.toString() + "(" + tables.size() + ")");
					for(String t:tables){
						root.addChild(new TreeObject(t,"table"));
					}
					viewer.refresh();
					viewer.expandToLevel(2);
					dbSettingWin.close();
				}
			});
			dbSettingWin.setBlockOnOpen(true);
			dbSettingWin.open();
		} else{
			if("column".equals(((TreeObject)obj).getKey())){
				return;
			}
			String table = obj.toString();
			//获取表中的字段
			List<ColumnConfig> ccs = SqlDBMetaDataFactory.getSqlDBMetaData().getColumns(table);
			to.removeAllChild();
			for(ColumnConfig cc:ccs){
				TreeObject node = new TreeObject(cc.getField(),"column");
				node.setLabel(cc.getField());
				to.addChild(node);
			}
			to.setLabel(to.getName()+ " ("+ccs.size()+")");
			viewer.refresh();
		}
	}
	
	//双击事件
	private void hookDoubleClickAction() {
		viewer.addDoubleClickListener(new IDoubleClickListener() {
			public void doubleClick(DoubleClickEvent event) {
				System.out.println(event);
				doubleClickAction.run();
			}
		});
	}

	/**
	 * Passing the focus request to the viewer's control.
	 */
	public void setFocus() {
		viewer.getControl().setFocus();
	}
}