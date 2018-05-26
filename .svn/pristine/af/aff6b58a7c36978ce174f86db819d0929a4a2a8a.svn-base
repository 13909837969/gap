package com.ehtsoft.supervise.utils;

import java.util.Date;
		import java.text.DateFormat;
		import java.text.ParseException;
		import java.text.SimpleDateFormat;
		import java.util.ArrayList;
		import java.util.Calendar;
		import java.util.HashMap;
		import java.util.Iterator;
		import java.util.List;
		import java.util.regex.Pattern;

	import org.apache.commons.lang.StringUtils;

import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.DateUtil;
	/**
	 * 
	 * @Description 时间工具类
	 * @author Administrator
	 * @date 2018年3月21日
	 *
	 */
	public class DateUtils {

		private final static SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
		private final static SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");
		private final static SimpleDateFormat sdfDays = new SimpleDateFormat("yyyyMMdd");
		private final static SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		private final static SimpleDateFormat sdfTimes = new SimpleDateFormat("yyyyMMddHHmmss");
		private final static SimpleDateFormat sdfMonth = new SimpleDateFormat("yyyy-MM");
		private final static SimpleDateFormat sdfMonths = new SimpleDateFormat("yyyyMM");
		
		private static final int FIRST_DAY = Calendar.MONDAY;

		
		/**
		 * 获得本周星期集合[指定日期格式 yyyy-MM-dd]
		 * 
		 * @Title : getWeekdays
		 * @功能描述 : TODO
		 * @设定文件 :
		 * @返回类型 : void
		 * @throws :
		 */
		public static ArrayList<String> getWeekdays(String day) {
			String sdfMonth = day.split("-")[1];
			String sdfYear = day.split("-")[0];
			int month = Integer.valueOf(sdfMonth);
			int year = Integer.valueOf(sdfYear);
			if (month == 1) {
				month = 12;
				year--;
			} else {
				month--;
			}
			String monthStr = month + "";
			if (month < 10) {
				monthStr = "0" + month;
			}
			String days = year + "-" + monthStr + "-" + day.split("-")[2];
			ArrayList<String> list = new ArrayList<String>();
			String[] arr = days.split("-");
			Calendar calendar = Calendar.getInstance();
			calendar.set(Integer.parseInt(arr[0]), Integer.parseInt(arr[1]), Integer.parseInt(arr[2]));
			setToFirstDay(calendar);
			for (int i = 0; i < 7; i++) {
				String formatDay = formatDay(calendar);
				list.add(formatDay);
				calendar.add(Calendar.DATE, 1);
			}
			return list;
		}

		/**
		 * 获得本周星期集合
		 * 
		 * @Title : getWeekdays
		 * @功能描述 : TODO
		 * @设定文件 :
		 * @返回类型 : void
		 * @throws :
		 */
		public static ArrayList<String> getWeekdays() {
			ArrayList<String> list = new ArrayList<String>();
			Calendar calendar = Calendar.getInstance();
			setToFirstDay(calendar);
			for (int i = 0; i < 7; i++) {
				String formatDay = formatDay(calendar);
				list.add(formatDay);
				calendar.add(Calendar.DATE, 1);
			}
			return list;
		}

		private static void setToFirstDay(Calendar calendar) {
			int dayOfWeek = Calendar.DAY_OF_WEEK;
			while (calendar.get(dayOfWeek) != FIRST_DAY) {
				calendar.add(Calendar.DATE, -1);
			}
		}

		private static String formatDay(Calendar calendar) {
			// SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd EE");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String string = dateFormat.format(calendar.getTime()).toString();
			return string;
		}

		/**
		 * 获取后一个月YYYY-MM格式
		 */
		public static String getFrontaftMonth() {
			String sdfMonth = getSdfMonth().split("-")[1];
			String sdfYear = getSdfMonth().split("-")[0];
			int month = Integer.valueOf(sdfMonth);
			int year = Integer.valueOf(sdfYear);
			if (month == 12) {
				month = 1;
				year++;
			} else {
				month++;
			}
			String monthStr = month + "";
			if (month < 10) {
				monthStr = "0" + month;
			}
			return year + "-" + monthStr;
		}

		/**
		 * 获取YYYY格式
		 * 
		 * @return
		 */
		public static String getSdfTimes() {
			return sdfTimes.format(new Date());
		}

		/**
		 * 获取当前月YYYY-MM格式
		 */
		public static String getSdfMonth() {
			return sdfMonth.format(new Date());
		}
		
		/**
		 * 获取当前月YYYYMM格式
		 */
		public static String getSdfMonths() {
			return sdfMonths.format(new Date());
		}

		/**
		 * 获取前一个月YYYY-MM格式
		 */
		public static String getFrontSdfMonth() {
			String sdfMonth = getSdfMonth().split("-")[1];
			String sdfYear = getSdfMonth().split("-")[0];
			int month = Integer.valueOf(sdfMonth);
			int year = Integer.valueOf(sdfYear);
			if (month == 1) {
				month = 12;
				year--;
			} else {
				month--;
			}
			String monthStr = month + "";
			if (month < 10) {
				monthStr = "0" + month;
			}
			return year + "-" + monthStr;
		}

		/**
		 * 获取前六个月YYYY-MM-DD格式
		 */
		public static String getFrontSdfMonthSev() {
			String day = getDay().split("-")[2];
			String sdfMonth = getSdfMonth().split("-")[1];
			String sdfYear = getSdfMonth().split("-")[0];
			int month = Integer.valueOf(sdfMonth);
			int year = Integer.valueOf(sdfYear);
			if (month == 6) {
				month = 12;
				year--;
			} else if (month < 6) {
				month = 12-( 6 - month);
				year--;
			}
			String monthStr = month + "";
			if (month < 10) {
				monthStr = "0" + month;
			}
			
			return year +monthStr+"";
		}

		

		/**
		 * 获取YYYY格式
		 * 
		 * @return
		 */
		public static String getYear() {
			return sdfYear.format(new Date());
		}

		/**
		 * 获取YYYY-MM-DD格式
		 * 
		 * @return
		 */
		public static String getDay() {
			return sdfDay.format(new Date());
		}

		/**
		 * 获取YYYYMMDD格式
		 * 
		 * @return
		 */
		public static String getDays() {
			return sdfDays.format(new Date());
		}

		/**
		 * 获取YYYY-MM-DD HH:mm:ss格式
		 * 
		 * @return
		 */
		public static String getTime() {
			return sdfTime.format(new Date());
		}

		/**
		 * @Title: compareDate
		 * @Description: TODO(日期比较，如果s>=e 返回true 否则返回false)
		 * @param s
		 * @param e
		 * @return boolean
		 * @throws @author
		 *             
		 */
		public static boolean compareDate(String s, String e) {
			if (fomatDate(s) == null || fomatDate(e) == null) {
				return false;
			}
			return fomatDate(s).getTime() >= fomatDate(e).getTime();
		}

		/**
		 * 格式化日期
		 * 
		 * @return
		 */
		public static Date fomatDate(String date) {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			try {
				return fmt.parse(date);
			} catch (ParseException e) {
				e.printStackTrace();
				return null;
			}
		}

		/**
		 * 校验日期是否合法
		 * 
		 * @return
		 */
		public static boolean isValidDate(String s) {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			try {
				fmt.parse(s);
				return true;
			} catch (Exception e) {
				// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
				return false;
			}
		}

		/**
		 * @param startTime
		 * @param endTime
		 * @return
		 */
		public static int getDiffYear(String startTime, String endTime) {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			try {
				// long aa=0;
				int years = (int) (((fmt.parse(endTime).getTime() - fmt.parse(startTime).getTime()) / (1000 * 60 * 60 * 24))
						/ 365);
				return years;
			} catch (Exception e) {
				// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
				return 0;
			}
		}

		/**
		 * <li>功能描述：时间相减得到天数
		 * 
		 * @param beginDateStr
		 * @param endDateStr
		 * @return long
		 * @author Administrator
		 */
		public static long getDaySub(String beginDateStr, String endDateStr) {
			long day = 0;
			java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.util.Date beginDate = null;
			java.util.Date endDate = null;

			try {
				beginDate = format.parse(beginDateStr);
				endDate = format.parse(endDateStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			day = (endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60 * 1000);
			// System.out.println("相隔的天数="+day);

			return day;
		}

		/**
		 * 得到n天之后的日期
		 * 
		 * @param days
		 * @return
		 */
		public static String getAfterDayDate(String days) {
			int daysInt = Integer.parseInt(days);

			Calendar canlendar = Calendar.getInstance(); // java.util包
			canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
			Date date = canlendar.getTime();

			SimpleDateFormat sdfd = new SimpleDateFormat("yyyyMMdd");
			String dateStr = sdfd.format(date);

			return dateStr;
		}


		/**
		 * 得到n天之后是周几
		 * 
		 * @param days
		 * @return
		 */
		public static String getAfterDayWeek(String days) {
			int daysInt = Integer.parseInt(days);
			Calendar canlendar = Calendar.getInstance(); // java.util包
			canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
			Date date = canlendar.getTime();
			SimpleDateFormat sdf = new SimpleDateFormat("E");
			String dateStr = sdf.format(date);
			return dateStr;
		}
		
		
		/**
		 * 
		 * 季度的换算
		 * @param SdfMonth
		 * @return<br>
		 * 返回值格式:BasicMap<String, Object>
		 *
		 * @author Administrator
		 * @date   2018年3月21日
		 *  第一季度：1月－3月
			第二季度：4月－6月
			第三季度：7月－9月
			第四季度：10月－12月
		 */
		public static BasicMap<String, Object> getQuarter(int month,int year) {
			BasicMap<String, Object> map = new BasicMap<>();
			if ( 1 <= month && month >=3) {
				map.put("title", "1");
				map.put("quarterstart",year+"01"+"01"); //季度开始
				map.put("quarterend",year+"03"+"31");//季度结束
			}
			if ( 4 <= month && month >=6) {
				map.put("title", "2");
				map.put("quarterstart",year+"04"+"01"); //季度开始
				map.put("quarterend",year+"06"+"30");//季度结束
			}
			if ( 7 <= month && month >=9) {
				map.put("title", "3");
				map.put("quarterstart",year+"07"+"01"); //季度开始
				map.put("quarterend",year+"09"+"30");//季度结束
			}
			if ( 10 <= month && month >=12) {
				map.put("title", "4");
				map.put("quarterstart",year+"10"+"01"); //季度开始
				map.put("quarterend",year+"12"+"31");//季度结束
			}
			return map;
		}

		/**
		 * 
		 * 获取前三个季度
		 * @param month
		 * @param year
		 * @return<br>
		 * 返回值格式:<br>
		 *
		 * @author Administrator
		 * @date   2018年3月21日
		 * 方法的作用：TODO
		 */
		public static List<BasicMap<String, Object>> getBeforQuarterThree(int month,int year) {
			List<BasicMap<String, Object>> list = new ArrayList<>();
			BasicMap<String, Object> mapBoferOne = new BasicMap<>();
			BasicMap<String, Object> mapBoferTwo = new BasicMap<>();
			BasicMap<String, Object> mapBoferThree = new BasicMap<>();
			BasicMap<String, Object> map = getQuarter(month,year);
			if ("1".equals(map.get("title"))) {
				year = year - 1;
				mapBoferOne.put("title", "2");
				mapBoferOne.put("quarterstart",year+"10"+"01"); //季度开始
				mapBoferOne.put("quarterend",year+"12"+"31");//季度结束
				
				mapBoferTwo.put("title", "3");
				mapBoferTwo.put("quarterstart",year+"07"+"01"); //季度开始
				mapBoferTwo.put("quarterend",year+"09"+"30");//季度结束
				
				mapBoferThree.put("title", "4");
				mapBoferThree.put("quarterstart",year+"04"+"01"); //季度开始
				mapBoferThree.put("quarterend",year+"06"+"30");//季度结束
				
			}if ("2".equals(map.get("title"))) {
				year = year - 1;
				mapBoferOne.put("title", "3");
				mapBoferOne.put("quarterstart",year+"10"+"01"); //季度开始
				mapBoferOne.put("quarterend",year+"12"+"31");//季度结束
				
				mapBoferTwo.put("title", "1");
				mapBoferTwo.put("quarterstart",year+"07"+"01"); //季度开始
				mapBoferTwo.put("quarterend",year+"09"+"30");//季度结束
				
				mapBoferThree.put("title", "4");
				mapBoferThree.put("quarterstart",(year+1)+"01"+"01"); //季度开始
				mapBoferThree.put("quarterend",(year+1)+"03"+"31");//季度结束
				
			}
			if ("3".equals(map.get("title"))) {
				year = year - 1;
				mapBoferOne.put("title", "1");
				mapBoferOne.put("quarterstart",year+"10"+"01"); //季度开始
				mapBoferOne.put("quarterend",year+"12"+"31");//季度结束
				
				mapBoferTwo.put("title", "4");
				mapBoferTwo.put("quarterstart",(year+1)+"04"+"01"); //季度开始
				mapBoferTwo.put("quarterend",(year+1)+"06"+"30");//季度结束
				
				mapBoferThree.put("title", "2");
				mapBoferThree.put("quarterstart",(year+1)+"01"+"01"); //季度开始
				mapBoferThree.put("quarterend",(year+1)+"03"+"31");//季度结束
				
				
			}
			if ("4".equals(map.get("title"))) {
				mapBoferOne.put("title", "3");
				mapBoferOne.put("quarterstart",year+"07"+"01"); //季度开始
				mapBoferOne.put("quarterend",year+"09"+"30");//季度结束
				
				mapBoferTwo.put("title", "2");
				mapBoferTwo.put("quarterstart",(year+1)+"04"+"01"); //季度开始
				mapBoferTwo.put("quarterend",(year+1)+"06"+"30");//季度结束
				
				mapBoferThree.put("title", "1");
				mapBoferThree.put("quarterstart",(year+1)+"01"+"01"); //季度开始
				mapBoferThree.put("quarterend",(year+1)+"03"+"31");//季度结束
				
			}
			list.add(map);
			list.add(mapBoferOne);
			list.add(mapBoferTwo);
			list.add(mapBoferThree);
			return list;
		}
		
		
		/**
		 * 
		 * 
		 * @param month
		 * @param year
		 * @return<br>
		 * 返回值格式: List<BasicMap<String, Object>> 根据 type值 获取相应的季度:    1 - 第一季度  ，2- 第二季度 ，3 -第三季度 ，4- 第四季度
		 *
		 * @author Administrator
		 * @date   2018年3月21日
		 * 方法的作用：根据 type值 获取相应的 季度    1  第一季度  ，2 第二季度 ，3 第三季度 ，4 第四季度
		 */
		public static List<BasicMap<String, Object>> getByType(String year,String type) {
			List<BasicMap<String, Object>> list = new ArrayList<>();
			BasicMap<String, Object> map = new BasicMap<>();
			if ("1".equals(type)) {
				map.put("quarterstart",year+"01"+"01"); //季度开始
				map.put("quarterend",year+"03"+"31");//季度结束
				
			}
			if ("2".equals(type)) {
				map.put("quarterstart",year+"04"+"01"); //季度开始
				map.put("quarterend",year+"06"+"30");//季度结束
				
			}
			if ("3".equals(type)) {
				map.put("quarterstart",year+"07"+"01"); //季度开始
				map.put("quarterend",year+"09"+"30");//季度结束
				
			}
			if ("4".equals(type)) {
				map.put("quarterstart",year+"10"+"01"); //季度开始
				map.put("quarterend",year+"12"+"31");//季度结束
				
			}
			list.add(map);
			return list;
		}
		
		
		
		
	}


