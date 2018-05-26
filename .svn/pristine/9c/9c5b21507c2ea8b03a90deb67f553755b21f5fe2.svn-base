/**
 * 日期选择器
 * @param opt
 * @returns {Eht.DatePicker}
 * @author wangbao
 */
Eht.DatePicker=function(opt){
	var dp = this;
	var def = {
		selector:null,
		yearprev:50,
		yearnext:30,
		width:180,
		format:"yyyy-MM-dd",
		show:true
	};
	this.opt = $.extend(def,opt);
	this.selector = $(this.opt.selector==null?"<div></div>":this.opt.selector);
	this.container = this.selector;
	this.header = $("<div class='eht-date-picker-head'><table align='center'><tr><td style='width:30px;text-align:left;'><span id='date-year-prev'></span></td><td id='date-year' style='cursor:pointer;'>year</td><td id='date-month'></td><td style='width:30px;text-align:right;'><span id='date-year-next'></span></td></tr></table></div>");
	this.yearpanel = $("<div class='eht-date-picker-year-panel'></div>");
	this.table=$("<table class='eht-date-picker-table'>");
	this.footer=$("<div style='text-align:right;'><span><a href='javascript:void(0);' id='date-current' style='color:#00f;font-size:11px;'>今天</a></span>&nbsp;&nbsp;<span><a href='javascript:void(0);' id='date-close' style='color:#00f;font-size:11px;'></a></span></div>");// date-close <a>关闭</a>

	
	this.selector.append(this.header);
	this.selector.append(this.table);
	this.selector.append(this.footer);
	this.selector.width(this.opt.width);
	this.date = new Date();
	this.date.setDate(1);
	
	this.value = new Date().format(this.opt.format);
	
	this.header.find("#date-year").text(Eht.Utils.toDate(this.value).getFullYear());
	
	this.month = $("<select></select>");
	for(var i=1;i<=12;i++){
		this.month.append("<option value='"+i+"'>"+i+"月</option>");
	}
	this.header.find("#date-month").append(this.month);
	this.month.val(this.date.getMonth()+1);
	if(this.opt.show==true){
		this.open();
	}else{
		this.close();
	}
	
	this.month.change(function(){
		var vd = Eht.Utils.toDate(dp.value);
		var str =  dp.header.find("#date-year").text()+"-" + $(this).val()+"-" + vd.getDate();
		dp.setValue(str);
	});
	this.header.find("#date-year-prev").click(function(){
		dp.setValue((dp.getYear()-1)+"-"+dp.getMonth()+"-" + dp.getDay());
	});
	this.header.find("#date-year-next").click(function(){
		dp.setValue((dp.getYear()+1)+"-"+dp.getMonth()+"-" + dp.getDay());
	});
	this.footer.find("#date-current").click(function(){
		var today = new Date();
		dp.setValue(today.getFullYear()+"-"+(today.getMonth()+1)+"-" + today.getDate());
		if(dp._click){
			dp._click(today.format(dp.opt.format));
		}
	});
	this.footer.find("#date-close").click(function(){
		dp.close();
	});
	this.header.find("#date-year").click(function(){
		dp.yearpanel.children().remove();
		dp.yearpanel.remove();
		var l = dp.header.position().left;
		var t = $(this).position().top+$(this).outerHeight();
		if(dp.header.offset().left + 375 > $(window).width()){
			l = $(window).width() - (dp.header.offset().left + 380);
		}
		dp.yearpanel.css({position:"absolute",left:l,top:t});
		var yearTable = $("<table>");
		for(var i=0;i<7;i++){
			yearTable.append("<tr></tr>");
		}
		var row = 0;
		for(var y=$(this).text()-dp.opt.yearprev;y<$(this).text()-0+dp.opt.yearnext;y++){
			var td = $("<td>"+y+"</td>");
			if(y==$(this).text()-0){
				td.addClass("eht-date-picker-selected");
			}
			if(row==7){
				row=0;
			}
			yearTable.find("tr").eq(row).append(td);
			row++;
			td.click(function(){
				var vd = Eht.Utils.toDate(dp.value);
				dp.setValue($(this).text()+"-"+dp.month.val()+"-" + vd.getDate());
				dp.yearpanel.hide(300);
			});
		}
		dp.yearpanel.append(yearTable);
		dp.selector.append(dp.yearpanel);
		dp.yearpanel.hide();
		dp.yearpanel.show("show");
	});
};
Eht.DatePicker.prototype.getYear=function(){
	var vd = Eht.Utils.toDate(this.value);
	return vd.getFullYear();
};
Eht.DatePicker.prototype.getMonth=function(){
	var vd = Eht.Utils.toDate(this.value);
	return vd.getMonth()+1;
};
Eht.DatePicker.prototype.getDay=function(){
	var vd = Eht.Utils.toDate(this.value);
	return vd.getDate();
};
Eht.DatePicker.prototype.setValue=function(datestr){
	datestr = datestr.replace(/\-|\.|\/|\\/g,"-");
	if(datestr.search(/\-|\.|\/|\\/)==-1){		
		if(datestr.length<8){
			return;
		}
		datestr = datestr.substring(0,4) + "-" + datestr.substring(5,6) + "-" + datestr.substring(6);
	}
	this.value = datestr;
	this.date = Eht.Utils.toDate(this.value);
	if(this.date==null){
		this.date = new Date();
	}
	this.month.val(this.date.getMonth()+1);
	this.header.find("#date-year").text(this.date.getFullYear());
	this.date.setDate(1);
	this.open();
};
Eht.DatePicker.prototype.close=function(){
	this.selector.hide();
};
Eht.DatePicker.prototype.open=function(){
	this.selector.show();
	this.table.children().remove();
	var dp = this;
	var vd = Eht.Utils.toDate(this.value);
	if(vd==null){
		vd = new Date();
	}
	var total = new Date();
	var y = total.getFullYear();// this.header.find("#date-year").text()-0;
	var m = total.getMonth()+1;//this.month.val()-0;
	var d = total.getDate();
	var maxdate=isMaxMonth(this.date.getMonth()+1)?31:30;
	if(this.date.getMonth()==1){
		if(isRunnan(this.date.getFullYear())){
			maxdate = 29;
		}else{
			maxdate = 28;
		}
	}
	var prevDate = new Date(this.date.getFullYear(),this.date.getMonth()-1);
	var prevmaxdate = isMaxMonth(prevDate.getMonth()+1)?31:30;
	if(prevDate.getMonth()==1){
		if(isRunnan(prevDate.getFullYear())){
			prevmaxdate = 29;
		}else{
			prevmaxdate = 28;
		}
	}
	var nextDate = new Date(this.date.getFullYear(),this.date.getMonth()+1);
	
	var tr = $("<tr class='eht-date-picker-title'>");
	tr.append("<td>日</td><td>一</td><td>二</td><td>三</td><td>四</td><td>五</td><td>六</td>");
	this.table.append(tr);
	var v = 0;
	var nextdate = 1;
	var prevday = prevmaxdate - this.date.getDay() + 1;
	if( this.date.getDay()==0){
		prevday = prevday - 7;
	}
	for(var i=0;i<42;i++){
		if(i%7==0){
			tr = $("<tr class='eht-date-picker-day'>");
			this.table.append(tr);
		}
		if(this.date.getDay()==i){
			v = 1;
		}
		var td = $("<td align='center'></td>");
		if(v==0 || (this.date.getDay()==0 && i<7)){
			td.html(prevday++);
			td.attr("year",prevDate.getFullYear());
			td.attr("month",prevDate.getMonth()+1);
			td.attr("day",td.text());
			td.css({"color":"#aaa"});
		}
		if(v > maxdate){
			td.html(nextdate++);
			td.attr("year",nextDate.getFullYear());
			td.attr("month",nextDate.getMonth()+1);
			td.attr("day",td.text());
			td.css({"color":"#aaa"});
		}
		if(this.date.getDay()!=0){
			if(v!=0 && v <= maxdate){
				if(d==v && vd.getFullYear()==y && vd.getMonth()+1==m){
					td.addClass("eht-date-picker-current");
				}
				td.html(v);
				td.attr("year",this.date.getFullYear());
				td.attr("month",this.date.getMonth()+1);
				td.attr("day",td.text());
				v++;
			}
		}else if(i>=7){
			if(v!=0 && v <= maxdate){
				td.attr("year",this.date.getFullYear());
				td.attr("month",this.date.getMonth()+1);
				td.attr("day",td.text());
				if(d==v && vd.getFullYear()==y && vd.getMonth()+1==m){
					td.addClass("eht-date-picker-current");
				}
				td.html(v);
				v++;
			}
		}
		tr.append(td);
		td.click(function(){
			$(this).parent().parent().find("td").removeClass("eht-date-picker-selected");
			$(this).addClass("eht-date-picker-selected");
			var vdate = new Date($(this).attr("year"),$(this).attr("month")-1,$(this).text());
			dp.value = vdate.format(dp.opt.format);
			if(dp._click){
				dp._click(vdate.format(dp.opt.format));
			}
		});
	}
	this.table.find("td").removeClass("eht-date-picker-selected");
	this.table.find("td[year='"+vd.getFullYear()+"'][month='"+(vd.getMonth()+1)+"'][day='"+vd.getDate()+"']").addClass("eht-date-picker-selected");
	
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
};
Eht.DatePicker.prototype.click=function(func){
	//func(value);
	this._click = func;
};
