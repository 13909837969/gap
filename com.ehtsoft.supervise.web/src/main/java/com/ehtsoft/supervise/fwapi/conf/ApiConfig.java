package com.ehtsoft.supervise.fwapi.conf;

import java.util.List;

public class ApiConfig {
	
	private List<RespBodyConfig> respBodyConfigs;
	private String ApiUrl;
	private String method;
	private String admOrgCode;

	public String getAdmOrgCode() {
		return admOrgCode;
	}

	public void setAdmOrgCode(String admOrgCode) {
		this.admOrgCode = admOrgCode;
	}

	public String getApiUrl() {
		return ApiUrl;
	}

	public void setApiUrl(String ApiUrl) {
		this.ApiUrl = ApiUrl;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public List<RespBodyConfig> getRespBodyConfigs() {
		return respBodyConfigs;
	}

	public void setRespBodyConfigs(List<RespBodyConfig> respBodyConfigs) {
		this.respBodyConfigs = respBodyConfigs;
	}
	
}
