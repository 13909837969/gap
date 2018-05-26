package com.ehtsoft.fw.plugin.utils;

import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * eht 工具类
 * @author wangbao
 */
public class AppUtil {
	public static String DATE_FORMAT="yyyy-MM-dd";
	

	/**
	 * 将字符传第一个字符转换成大写
	 * @param value
	 * @return
	 */
	public static String toFirstUpperCase(String value){
		if(value!=null&&value.length()>0){
			value=value.substring(0,1).toUpperCase() + value.substring(1);
		}
		return value;
	}
	/**
	 * 将字符传第一个字符转换成小写
	 * @param value
	 * @return
	 */
	public static String toFirstLowerCase(String value){
		if(value!=null&&value.length()>0){
			value=value.substring(0,1).toLowerCase() + value.substring(1);
		}
		return value;
	}
	
	/**
	 * 将字符串转化为大写
	 * @param value
	 * @return
	 */
	public static String toUpperCase(String value){
		if(value==null){
			return null;
		}
		return value.toUpperCase();
	}
	
	/**
	 * 将字符串转化为小写
	 * @param value
	 * @return
	 */
	public static String toLowerCase(String value){
		if(value==null){
			return null;
		}
		return value.toLowerCase();
	}
	
	/**
	 * 判断对象为空
	 */
	public static boolean isEmpty(Object value){
		return value==null || "".equals(value.toString());
	}
	/**
	 * 判断对象不为空
	 */
	public static boolean isNotEmpty(Object value){
		return !isEmpty(value);
	}
	
	/**
	 * 判断字符串是否json格式的数据
	 * @param str
	 * @return
	 */
	public static boolean isJsonFormat(String str){
		return isJsonArray(str) || isJsonObject(str);
	}
	/**
	 * 判断字符串是否是 json 数组格式 
	 * @param str
	 * @return
	 */
	public static boolean isJsonArray(String str){
		boolean rtn = false;
		if(str!=null){
			if(str.trim().startsWith("[") && str.trim().endsWith("]")){
				rtn = true;
			}
		}
		return rtn;
	}
	/**
	 * 判断字符串是否为 json 对象格式
	 * @param str
	 * @return
	 */
	public static boolean isJsonObject(String str){
		boolean rtn = false;
		if(str!=null){
			if(str.trim().startsWith("{") && str.trim().endsWith("}")){
				rtn = true;
			}
		}
		return rtn;
	}
	/**
	 * 去掉两边的空格
	 * @param value
	 * @return
	 */
	public static String trim(String value){
		if(value==null){
			return null;
		}
		return value.trim();
	}
	
	public static String toString(Object value){
		if(isEmpty(value)){
			return null;
		}
		if("null".equals(value.toString())){
			return null;
		}
		return value.toString();
	}
	
	/**
	 * 去掉字符串数组中的null元素
	 * @param arrays
	 * @return 没有null元素的字符数组
	 */
	public static String[] getNotNullArray(String[] arrays){
		List<String> l=new ArrayList<String>();
		for(String str:arrays){
			if(str != null){
				l.add(str);
			}
		}
		String[] rtn=new String[l.size()];
		l.toArray(rtn);
		return rtn;
	}
	
	public static boolean isInteger(String arg){
		boolean rtn = false;
		if(isNotEmpty(arg)){
			Pattern p = Pattern.compile("-{0,1}\\d*");
			rtn = p.matcher(arg).matches();
		}
		return rtn;
	}
	public static boolean isNumber(String arg){
		Pattern p = Pattern.compile("-{0,1}\\d+\\.{0,1}\\d+");
		return  p.matcher(arg).matches();
	}
	
	public static double toDigits(double dvalue,int digits){
		NumberFormat nf = NumberFormat.getNumberInstance();
		nf.setMaximumFractionDigits(digits);
		return new Double(nf.format(dvalue));
	}
	/**
	 * 将 对象 转化成 Integer 非数字对象返回为 null
	 * @param obj
	 * @return
	 */
	public static Integer toInteger(Object obj){
		Integer rtn = null;
		if(obj!=null){
			try{
			rtn = Double.valueOf(obj.toString()).intValue();
			}catch(Exception e){}
		}
		return rtn;
	}
	/**
	 *  将 对象 转化成 int 非数字对象返回为  0 
	 * @param obj
	 * @return
	 */
	public static int toInt(Object obj){
		int rtn = 0;
		if(obj!=null){
			try{
				rtn =  Double.valueOf(obj.toString()).intValue();
			}catch(Exception e){}
		}
		return rtn;
	}
	/**
	 *  将 对象 转化成 double 非数字对象返回为  0 
	 * @param obj
	 * @return
	 */
	public static double toDouble(Object obj){
		double rtn = 0;
		if(obj!=null){
			try{
				rtn =  Double.valueOf(obj.toString()).doubleValue();
			}catch(Exception e){}
		}
		return rtn;
	}
	
	
	public static Long toLong(Object obj){
		Long rtn = null;
		if(obj!=null){
			try{
			rtn = Long.valueOf(obj.toString());
			}catch(Exception e){}
		}
		return rtn;
	}
	public static String format(Date date,String format){
		String rtn = null;
		if(format==null){
			format = DATE_FORMAT;
		}
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		rtn = sdf.format(date);
		return rtn;
	}
	public static boolean isDateFormat(String arg){
		String format = DATE_FORMAT;
	 	String hms = "(\\W\\d{1,2}(:\\d{1,2}(:\\d{1,2}){0,1}){0,1}){0,1}";
	 	String tmp = format.toLowerCase().replace("hh:mm:ss", "").trim();
	 	
	 	Pattern p = Pattern.compile("\\W");
	 	Matcher m = p.matcher(tmp);
	 	String[] f = tmp.split("\\W");
	    StringBuffer sb = new StringBuffer("(");
	 	for(String s:f){
	 		if(s.length()==4){
	 			sb.append("\\d{4}");
	 		}else{
	 			sb.append("\\d{1,2}");
	 		}
	 		if(m.find()){
	 			sb.append("\\"+m.group());
	 		}
	 	}
	 	sb.append(")");
	 	sb.append(hms);
	 	
	 	Pattern p1 = Pattern.compile(sb.toString());
		
	    return p1.matcher(arg).matches();
	}
	

	public static Date toDate(String value,String format){
		
		Date rtn = null;
		if(isNotEmpty(value)){
			value = trim(value);
			if(format!=null){
				SimpleDateFormat sdf = new SimpleDateFormat(format);
				try {
					rtn = sdf.parse(value);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}else{
				String s = value.replaceAll("\\-|\\/|\\\\|\\.", "");//"\\.|\\|\\-|\\/"
				if(s.length()>=8){
					value = s.substring(0,4)+"-"+s.substring(4,6)+"-"+s.substring(6);
				}
				String[] vs = value.split(" "); 
				StringBuffer f=new StringBuffer(DATE_FORMAT);
				if(vs.length>1){
					String hms = vs[vs.length-1];
					f.append(" ");
					String[] tmp = hms.split("\\W");
					Pattern p = Pattern.compile("\\W");
					Matcher m = p.matcher(hms);
					for(int i=0;i<tmp.length;i++){
						if(i==0){
							f.append("HH");
							if(m.find()){
								f.append(m.group());
							}
						}
						if(i==1){
							f.append("mm");
							if(m.find()){
								f.append(m.group());
							}
						}
						if(i==2){
							f.append("ss");
						}
					}
				}
				SimpleDateFormat sdf = new SimpleDateFormat(f.toString());
				try {
					rtn = sdf.parse(value);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
		return rtn;
	}
	/**
	 * 根据省份证号获取出生日期
	 * @param cardid
	 * @return
	 */
	public static String getBirthdate(String cardid){
		String rtn = "";
		if(cardid==null){
			return "";
		}
		if(cardid.trim().length()==18){
			rtn = cardid.trim().substring(6,10) + "-" + cardid.trim().substring(10,12) + "-" + cardid.trim().substring(12,14);
		}
		if(cardid.trim().length()==15){
			rtn = "19"+cardid.trim().substring(6,8) + "-" + cardid.trim().substring(8,10) + "-" + cardid.trim().substring(10,12);
		}
		return rtn;
	}
	/**
	 * 根据出生日期得到年龄（周岁）
	 * @param birthdate
	 * @return
	 */
	public static int getAge(Date birthdate){
		int rtn = 0;
		if(birthdate!=null){
			GregorianCalendar btdate = new GregorianCalendar();
			btdate.setTime(birthdate);
			
			GregorianCalendar current = new GregorianCalendar();
			rtn = current.get(Calendar.YEAR) - btdate.get(Calendar.YEAR);
			
			if(btdate.get(Calendar.MONTH)>current.get(Calendar.MONTH)){
				rtn = rtn -1;
			}else if(btdate.get(Calendar.MONTH)==current.get(Calendar.MONTH) && 
					btdate.get(Calendar.DAY_OF_MONTH)>current.get(Calendar.DAY_OF_MONTH) ){
				rtn = rtn -1;
			}
			if(rtn<0){
				rtn = 0;
			}
		}
		return rtn;
	}
	
	/**
	 * 根据出生日期得到 月龄（月龄）
	 * @param birthdate
	 * @return
	 */
	public static int getMonthOfAge(Date birthdate){
		int rtn = 0;
		if(birthdate!=null){
			GregorianCalendar btdate = new GregorianCalendar();
			btdate.setTime(birthdate);
			
			GregorianCalendar current = new GregorianCalendar();
			rtn = (current.get(Calendar.YEAR) - btdate.get(Calendar.YEAR)) * 12 + (current.get(Calendar.MONTH) - btdate.get(Calendar.MONTH));
			if(btdate.get(Calendar.DAY_OF_MONTH)>current.get(Calendar.DAY_OF_MONTH)){
				rtn = rtn -1;
			}
		}
		return rtn;
	}
	

	
	public static byte[] toByteArray(List<Integer> list){
		if(list!=null){
			int size = list.size();
			byte[] rtn = new byte[size];
			Integer[] l =list.toArray(new Integer[size]);
			for(int i=0;i<size;i++){
				rtn[i] = l[i].byteValue();
			}
			return rtn;
		}
		return null;
	}
	
	
	/**
	 * 校验的计算方式：
	 * 1. 对前17位数字本体码加权求和
	 * 公式为：S = Sum(Ai * Wi), i = 0, ... , 16
	 * 其中Ai表示第i位置上的身份证号码数字值，Wi表示第i位置上的加权因子，其各位对应的值依次为： 7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
	 * 2. 以11对计算结果取模
	 * Y = mod(S, 11)
	 * 3. 根据模的值得到对应的校验码
	 * 对应关系为：
	 * Y值： 0 1 2 3 4 5 6 7 8 9 10
	 * 校验码： 1 0 X 9 8 7 6 5 4 3 2
	 **/
	//身份证验证
	public static boolean  isPersonCard(String cardno){
		if(cardno==null){
			return false;
		}
		//创建日期
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		//要求严格检查日期格式
		sdf.setLenient(false);
		
		if(cardno.trim().length() != 15 && cardno.trim().length() != 18){
			return false;
		}
		if(cardno.trim().length() == 18){
			
			//当截取的字符串不符合yyyyMMdd格式时，返回false
			try {
			    sdf.parse(cardno.trim().substring(6, 14));
			} catch (Exception e) {
				return false;
			}
			
			String validatechar = cardno.substring(17,18);
			//加权因子
			int[] weighting = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
			//校验码
			String[]  validate = {"1","0","X","9","8","7","6","5","4","3","2"};
			int s = 0;
			for(int i = 0;i < weighting.length;i++){
				s = s + (Integer.parseInt(String.valueOf(cardno.split("")[i + 1]).trim())) * weighting[i];
			}
			if(!validatechar.equals(validate[s%11])){
				return false;
			}
		}else{
			//当截取的字符串不符合yyyyMMdd格式时，返回false
			try {
			    sdf.parse("19" + cardno.trim().substring(6,12));
			} catch (Exception e) {
				return false;
			}
		}
		return true;
	}
}
