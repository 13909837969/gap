(function($){
	var calContainer = $('<table class="ltrhao-calendar">'+
							'<caption>' +
								'<table style="width:100%"><tr>'+
								'<td align="left"><span id="ltrhao-calendar-prev" class="glyphicon glyphicon-menu-left"></span></td>'+
								'<td align="center"><span id="ltrhao-calendar-date">2014年5月</span></td>'+
								'<td align="right"><span id="ltrhao-calendar-next" class="glyphicon glyphicon-menu-right"></span></td></tr></table>'+
							'</caption>' +
							'<thead>'+
							'<tr>'+
							'	<td>星期日</td>'+
							'	<td>星期一</td>'+
							'	<td>星期二</td>'+
							'	<td>星期三</td>'+
							'	<td>星期四</td>'+
							'	<td>星期五</td>'+
							'	<td>星期六</td>'+
							'</tr>'+
							'</thead>'+
							'<tbody id="ltrhao-calendar-body">'+
							'</tbody>'+
						'</table>');
	$.fn.calendar=function(func){
		$(this).empty();
		$(this).append(calContainer);
		var currentDate = new Date();
		drawCalendar(currentDate,func);
		calContainer.find("#ltrhao-calendar-prev").unbind("click").bind("click",function(){
			currentDate = prevMonth(currentDate);
			drawCalendar(currentDate,func);
		});
		calContainer.find("#ltrhao-calendar-next").unbind("click").bind("click",function(){
			currentDate = nextMonth(currentDate);
			drawCalendar(currentDate,func);
		});
	};
	function nextMonth(date){
		return new Date(date.getFullYear(),date.getMonth()+1);
	}
	function prevMonth(date){
		return new Date(date.getFullYear(),date.getMonth()-1);
	}
	function drawCalendar(date,func){
		var cdate = new Date();
		var cm = (cdate.getMonth()+1);
		var cday = cdate.getDate();
		//当前日期
		var cdatestr = cdate.getFullYear() + "-" + (cm<10?"0"+cm:cm) + "-" + (cday<10?"0"+cday:cday);
		var prevDate =  new Date(date.getFullYear(),date.getMonth()-1,1);
		var firstDay = new Date(date.getFullYear(),date.getMonth(),1).getDay();
		var nextDate = new Date(date.getFullYear(),date.getMonth()+1,1);
	    var label = calContainer.find("#ltrhao-calendar-date");
	    label.html(date.getFullYear()+"年"+(date.getMonth()+1) + "月");
	    var cbody = calContainer.find("#ltrhao-calendar-body");
	    cbody.empty();
    	var tr = $("<tr></tr>");
    	var cMaxDate = getMaxDateByMonth(date.getFullYear(),date.getMonth());
    	var pMaxDate = getMaxDateByMonth(prevDate.getFullYear(),prevDate.getMonth());
    	var nMaxDate = getMaxDateByMonth(nextDate.getFullYear(),nextDate.getMonth());

		for(var c=0;c<42;c++){
    		if(c % 7 == 0){
    			tr = $("<tr></tr>");
    			cbody.append(tr);
    		}
    		var td = $("<td></td>");
    		var day = c - firstDay + 1;
    		if(day<=0){
    			td.addClass("not-current-month");
    			day = pMaxDate + day;
    			var m = (prevDate.getMonth()+1);
    			var ds = prevDate.getFullYear() + "-" + (m<10?"0"+m:m) + "-" + (day<10?"0"+day:day);
    			td.attr("date", ds);
    		}else if(day>nMaxDate){
    			day = day - nMaxDate;
    			td.addClass("not-current-month");
    			var m = (nextDate.getMonth()+1);
    			var ds = nextDate.getFullYear() + "-" + (m<10?"0"+m:m)  + "-" +  (day<10?"0"+day:day);
    			td.attr("date", ds);
    		}else{
    			var m = (date.getMonth()+1);
    			var ds = date.getFullYear() + "-" + (m<10?"0"+m:m)  + "-" +  (day<10?"0"+day:day);
    			td.attr("date", ds);
    		}
    		if(td.attr("date")==cdatestr){
    			td.addClass("current-date");
    		}
    		td.html(day);
    		tr.append(td);
    		td.unbind("click").bind("click",function(){
    			if(func!=null){
    				func.call(this,$(this).attr("date"));
    			}
    		});
		}
	}
	function getMaxDateByMonth(year,month){
		var rtn = 31;
		if(month==1){ // 2 月份
			if(isRunnan(year)){
				rtn = 29;
			}else{
				rtn = 28;
			}
		}else if(isMaxMonth(month)){
			rtn = 31;
		}else{
			rtn = 30;
		}
		return rtn;
	}
	function isRunnan(year){
		return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
	}
	function isMaxMonth(month){
		var rtn = false;
		var maxmonth=[1,3,5,7,8,10,12];
		for(var i=0;i<maxmonth.length;i++){
			if(maxmonth[i]==month){
				rtn = true;
				break;
			}
		}
		return rtn;
	}
}(jQuery));