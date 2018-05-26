package com.ehtsoft.fw.plugin.model;

import java.util.List;

public class TableConfig {
	private String name;
	private String label;
	private String type;//默认为 basicMap
	private String remark;
	/**
	 * 是否基础表(不经常变化的数据表)
	 */
	private boolean base;
	private PrimaryConfig primary;
	
	private List<ColumnConfig> columns;
	private List<UniqueConfig> uniques;
	private List<ForeignConfig> foreigns;

	public TableConfig(){}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public PrimaryConfig getPrimary() {
		return primary;
	}

	public void setPrimary(PrimaryConfig primary) {
		this.primary = primary;
	}

	public List<ColumnConfig> getColumns() {
		return columns;
	}

	public void setColumns(List<ColumnConfig> columns) {
		this.columns = columns;
	}

	public List<UniqueConfig> getUniques() {
		return uniques;
	}

	public void setUniques(List<UniqueConfig> uniques) {
		this.uniques = uniques;
	}

	public List<ForeignConfig> getForeigns() {
		return foreigns;
	}

	public void setForeigns(List<ForeignConfig> foreigns) {
		this.foreigns = foreigns;
	}
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String toString(){
		return "tablename:"+name;
	}

	public boolean isBase() {
		return base;
	}

	public void setBase(boolean base) {
		this.base = base;
	}
	
}
