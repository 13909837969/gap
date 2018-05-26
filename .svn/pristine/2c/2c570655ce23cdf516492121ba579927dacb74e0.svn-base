package com.ehtsoft.fw.plugin.action;

import org.eclipse.jface.action.IAction;
import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.ui.IObjectActionDelegate;
import org.eclipse.ui.IWorkbenchPart;

public class CreateSqlAction implements IObjectActionDelegate {

	private Shell shell;
	
	public CreateSqlAction() {
		super();
	}

	@Override
	public void setActivePart(IAction action, IWorkbenchPart targetPart) {
		shell = targetPart.getSite().getShell();
	}

	@Override
	public void run(IAction action) {
		MessageDialog.openInformation(
			shell,
			"Popmenu",
			"New Action was executed.");
	}

	@Override
	public void selectionChanged(IAction action, ISelection selection) {
		
	}

}
