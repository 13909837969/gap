package com.ehtsoft.fw.plugin.views.tree;

import java.util.ArrayList;

import org.eclipse.core.runtime.IAdaptable;


/**
 * Tree 视图中的 节点数据
 * @author 王宝
 */
public class TreeObject implements IAdaptable {
	private String name;
	private String key;
	private TreeObject parent;
	
	private String label;
	private ArrayList<TreeObject> children;
	
	public TreeObject(String name) {
		this(name,null);
	}
	public TreeObject(String name,String key) {
		this.name = name;
		this.key = key;
		children = new ArrayList<TreeObject>();
	}
	public String getName() {
		return name;
	}
	public String setName(String name) {
		return this.name = name;
	}
	public void setParent(TreeObject parent) {
		this.parent = parent;
	}
	public TreeObject getParent() {
		return parent;
	}

	public String getKey(){
		return key;
	}

	
	public void addChild(TreeObject child) {
		children.add(child);
		child.setParent(this);
	}
	public void removeChild(TreeObject child) {
		children.remove(child);
		child.setParent(null);
	}
	public void removeAllChild(){
		for(int i=children.size()-1;i>=0;i--){
			children.remove(i);
		}
	}
	public TreeObject [] getChildren() {
		return (TreeObject [])children.toArray(new TreeObject[children.size()]);
	}
	public boolean hasChildren() {
		return children.size()>0;
	}
	
	public String toString() {
		return getLabel();
	}
	
	public String getLabel() {
		if(label==null){
			label = name;
		}
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	@Override
	public Object getAdapter(Class key) {
		return null;
	}
}
