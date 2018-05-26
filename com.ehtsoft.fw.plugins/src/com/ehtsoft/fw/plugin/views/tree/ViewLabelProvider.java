package com.ehtsoft.fw.plugin.views.tree;

import org.eclipse.jface.viewers.LabelProvider;
import org.eclipse.swt.graphics.Image;
import org.eclipse.ui.ISharedImages;
import org.eclipse.ui.PlatformUI;


/**
 * 每个Tree节点的显示标签
 * @author 王宝
 */
public class ViewLabelProvider extends LabelProvider {

	@Override
	public String getText(Object obj) {
		return obj.toString();
	}
	@Override
	public Image getImage(Object obj) {
		String imageKey = ISharedImages.IMG_OBJ_ELEMENT;
		if (obj instanceof TreeObject){
			TreeObject to = (TreeObject)obj;
			if(to.hasChildren()){
				imageKey = ISharedImages.IMG_OBJ_FOLDER;
			}
		}
		return PlatformUI.getWorkbench().getSharedImages().getImage(imageKey);
	}
}