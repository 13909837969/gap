package com.ehtsoft.fw.plugin.views.tree;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.List;

import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.jface.viewers.IStructuredContentProvider;
import org.eclipse.jface.viewers.ITreeContentProvider;
import org.eclipse.jface.viewers.TreeViewer;
import org.eclipse.jface.viewers.Viewer;

import com.ehtsoft.fw.plugin.model.DBSettingData;
import com.ehtsoft.fw.plugin.utils.SqlDBMetaData;
import com.ehtsoft.fw.plugin.utils.SqlDBMetaDataFactory;
import com.ehtsoft.fw.plugin.views.DatabaseView;


/**
 * Tree 节点内容
 * @author 王宝
 */
public class ViewContentProvider  implements IStructuredContentProvider, ITreeContentProvider {

	
	private TreeObject invisibleRoot;

	private TreeViewer treeViewer;
	
	public ViewContentProvider(TreeViewer viewer){
		this.treeViewer = viewer;
	}


	/*
	 * 在tree 显示数据库的表信息
	 */
	private void initialize() {
		/*
		TreeObject to1 = new TreeObject("Leaf 1");
		TreeObject to2 = new TreeObject("Leaf 2");
		TreeObject to3 = new TreeObject("Leaf 3");
		TreeParent p1 = new TreeParent("Parent 1");
		p1.addChild(to1);
		p1.addChild(to2);
		p1.addChild(to3);
		
		TreeObject to4 = new TreeObject("Leaf 4");
		TreeParent p2 = new TreeParent("Parent 2");
//		p2.addChild(to4);
		
		TreeParent root = new TreeParent("Root");
		
		root.addChild(p1);
		root.addChild(p2);
		
		invisibleRoot = new TreeParent("");
		invisibleRoot.addChild(root);
*/
		
		ObjectOutputStream oos = null;
		String workspacePath = ResourcesPlugin.getWorkspace().getRoot().getLocation().toOSString();
		File file = new File(workspacePath + File.separator + DatabaseView.DBSETTING_FILE);
		if(!file.exists()){
			invisibleRoot = new TreeObject("");
			TreeObject root = new TreeObject("Database Model","root");
			invisibleRoot.addChild(root);
			return;
		}
		ObjectInputStream ois = null;
		try {
			ois = new ObjectInputStream(new FileInputStream(file));
			DBSettingData dbsetting = (DBSettingData)ois.readObject();
			SqlDBMetaData sqlDB = SqlDBMetaDataFactory.createSqlDBMetaData(dbsetting.getDriver(), dbsetting.getUrl(), dbsetting.getUsername(), dbsetting.getPassword());
			sqlDB.setCatalog(dbsetting.getCatalog());
			sqlDB.setSchema(dbsetting.getSchema());
			
			invisibleRoot = new TreeObject("");
			TreeObject root = new TreeObject(dbsetting.toString(),"root");
			invisibleRoot.addChild(root);
			List<String> tables = sqlDB.getTables("%");
			root.setLabel(dbsetting.toString()+"("+tables.size()+")");
			for(String t:tables){
				root.addChild(new TreeObject(t,"table"));
			}
		} catch (Exception e) {
		} finally{
			if(oos!=null){
				try {
					oos.close();
				} catch (IOException e) {
				}
			}
		}
	}
	
	
	@Override
	public void dispose() {
		
	}

	@Override
	public void inputChanged(Viewer arg0, Object arg1, Object arg2) {
	}

	@Override
	public Object [] getChildren(Object parent) {
		if (parent instanceof TreeObject) {
			return ((TreeObject)parent).getChildren();
		}
		return new Object[0];
	}
	@Override
	public Object getParent(Object child) {
		if (child instanceof TreeObject) {
			return ((TreeObject)child).getParent();
		}
		return null;
	}

	@Override
	public boolean hasChildren(Object parent) {
		if (parent instanceof TreeObject)
			return ((TreeObject)parent).hasChildren();
		return false;
	}

	@Override
	public Object[] getElements(Object parent) {
//		if (parent.equals(getViewSite())) {
			if (invisibleRoot==null) initialize();
			return getChildren(invisibleRoot);
//		}
//		return getChildren(parent);
	}

}
