package com.ehtsoft.supervise.services;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.DownloadInfo;
import com.ehtsoft.fw.core.services.api.IDownLoadService;
import com.ehtsoft.fw.utils.StringUtil;

@Service
public class DownLoadService implements IDownLoadService{

	public final static String DIR = "/Users/wangbao/Desktop";
	/**
	 * filename :
	 */
	@Override
	public DownloadInfo download(BasicMap<String, String> param) {
		DownloadInfo rtn = new DownloadInfo();
		String filename = StringUtil.toString(param.get("filename"));
		if(filename!=null){
			rtn.setFilename(filename);
			FileInputStream fis =  null;
			try {
				fis = new FileInputStream(DIR + File.separator +  filename);
				rtn.setInputStream(fis);
			} catch (FileNotFoundException e) {
				rtn.setError(filename + "不存在");
			}
		}
		return rtn;
	}

}
