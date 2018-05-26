<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EHT Column Chart Demo</title>
<meta name="description" content="EHT 柱状图 demo;演示地址：http://demo.ehtsoft.com/" />
<meta name="description" content="copyright:大连易恒通软件有限公司，http://www.ehtsoft.com"/>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript">

/**
 * 
 * @param options
 * @returns {Eht.Column}
 */
Eht.Column=function(options){
	var defaults = {
		selector:null,
		title:"Column Chart Demo",
		valueField:"value",//v1,v2  逗号分隔，一组多列
		labelField:"label",
		labelDesc:{value:'红色',v1:"绿色",v2:"蓝色",v3:"黄色"},
		width:600,
		height:380,
		rotate:0,
		delay:800,
		color:"#2ad4ff",
		gColor:["#ff0000","#00ff00","#0000ff","#ffff00","#00ffff","#ff00ff","#ffa800","#00a2ff","#8e20cf","#ff008a","#a26dc3","#f986ae","#d8ff00","#abaa36","#0b2a3f","#fff996","#93bcbe","#efefef"],//groupcolor
		//data:[200,100,150,100,230.5,120],
		data:[{label:"label1",value:100},{label:"label2",value:200},{label:"label3",value:"300"},{label:"label4",value:100},{label:"label5",value:200},{label:"label5",value:250}],
		/*
		data:[{label:"label1",value:130,v1:100,v2:300,v3:500},
		      {label:"label2",value:120,v1:100,v2:350,v3:400},
		      {label:"label2",value:120,v1:100,v2:350,v3:400},
		      {label:"label2",value:120,v1:100,v2:350,v3:400},
		      {label:"label2",value:120,v1:100,v2:350,v3:400},
		      {label:"label2",value:120,v1:100,v2:350,v3:400}
		      ],
		 */
		clickItem:function(e,data){
		},
		mouseover:function(e,data){},
		mouseout:function(e,data){},
		mousemove:function(e,data){}
	};
	this.options = $.extend(defaults,options);
	this.selector = $(this.options.selector);
	this.data = this.options.data;
	this.paper = Raphael(this.selector.get(0),this.options.width,this.options.height);
	
	this.cw = 20;//columnWidth 列宽度
	this.cg = 0;//columnGap 列与列的间隔
	this.cgg = 20;//columnGroupGap 列组之间的间隔
	this.rtx = 40;  //ruleTopX  标尺顶端  x 位置
	this.rty = 50;  //ruleTopY  标尺 顶端 y 位置
	this.title = null;
	if(this.options.title==null){
		this.rtx = 40;  //ruleTopX  标尺顶端  x 位置
		this.rty = 10;  //ruleTopY  标尺 顶端 y 位置
	}
	var vfs = this.options.valueField.split(",");
	if(vfs.length>1){
		this.lbh = 60; //labelHeight  label 标签位置高度
	}else{
		this.lbh = 30;
	}
	this.cb = {x:this.rtx + 20,y:this.options.height - this.lbh};//columnBottom 列低初始位置
	
	this.refresh();
};
Eht.Column.prototype.getMaxValue=function(){
	var rtn = 0;
	for(var i=0;i<this.data.length;i++){
		if($.type(this.data[i])=="object"){
			var vfs =  this.options.valueField.split(",");
			for(var j=0;j<vfs.length;j++){
				if(rtn < parseFloat(this.data[i][vfs[j]])){
					rtn = parseFloat(this.data[i][vfs[j]]);
				}
			}
		}else{
			if(rtn<parseFloat(this.data[i])){
				rtn = parseFloat(this.data[i]);
			}
		}
	}
	return Math.ceil(rtn) + 20;
};
Eht.Column.prototype.refresh=function(){
	this.paper.clear();
	if(this.options.title){
		this.title = this.paper.text(this.options.width/2,15,this.options.title).attr("text-anchor","middle").attr("font-size",20);
	}
	this.drawRule();
	this.drawColumn();
};
Eht.Column.prototype.setTitle=function(title){
	if(this.title!=null)
	this.title.attr("text",title);
};
Eht.Column.prototype.drawRule=function(){
	var column = this;
	this.paper.rect(this.rtx,this.rty,this.options.width-this.rtx-1,this.options.height-this.rty-this.lbh).attr("stroke-width",1);
	
	var ruleH = this.cb.y - this.rty,
	maxv = this.getMaxValue();
	var n = Math.floor(ruleH/32);
	var ruleGap = ruleH/n;
	var vgap = maxv/n;
	for(var i=0;i<=n;i++){
		var y = this.cb.y - ruleGap * i;
		var arr = ["M",this.rtx - 8,y,"H",this.options.width];
		this.paper.path(arr).attr("stroke-width",1).attr("stroke","#c0c0c0");
		this.paper.text(this.rtx-9,y,(vgap * i).toFixed(0)).attr("text-anchor","end");
	}
	//颜色 标示
	var vfs = this.options.valueField.split(",");
	if(vfs.length>1){
		var ms = new Array();
		for(var i=0;i<vfs.length;i++){
			ms.push(new mark(0,this.options.height - 15,vfs[i]));
		}
		var w = 0;
		for(var i=0;i<ms.length;i++){
			w+=ms[i].width + 15;
		}
		var x0=(this.options.width-w)/2;
		for(var i=0;i<ms.length;i++){
			ms[i].setX(x0 + i*(ms[i].width + 15));
		}
	}
	function mark(x,y,vf){
		this.rect = column.paper.rect(x,y-5,18,10).attr("fill",column.options.gColor[i]).attr("scroke",column.options.gColor[i]);
		this.text = column.paper.text(x + this.rect.getBBox().width + 5,y,column.options.labelDesc[vf]).attr("text-anchor","start");
		this.width = this.rect.getBBox().width + this.text.getBBox().width;
		
		this.setX=function(x){
			this.rect.attr("x",x);
			this.text.attr("x",x + this.rect.getBBox().width + 5);
		};
	}
};
Eht.Column.prototype.drawColumn=function(){
	var vfs = this.options.valueField.split(",");
	
	var n = this.data.length;
	this.cw = ((this.options.width - this.cb.x)/n - this.cgg)/vfs.length;
	if(this.cw>110){
		this.cw = 110;
	}
	if(this.cw<10){
		this.cw=10;
	}
	
	this.cgg = (this.options.width - this.cb.x)/n - this.cw*vfs.length;//20;
	if(this.cgg<8){
		this.cgg = 8;
	}
	if(this.cgg>35){
		this.cgg=35;
	}
	
	var maxv = this.getMaxValue();
	var ruleH = this.cb.y - this.rty;
	for(var i=0;i<this.data.length;i++){
		this.addItem(i,this.data[i],maxv,ruleH);
	}
	
};
Eht.Column.prototype.addItem=function(index,data,maxvalue,ruleH){
	var height=0;
	var opt = this.options;
	var vfs = this.options.valueField.split(",");
	var paper = this.paper;
	for(var i=0;i<vfs.length;i++){
		if($.type(data)=="object"){
			height=data[vfs[i]]/maxvalue * ruleH
		}else{
			height = data;
		}
		var column = this;
		var x = this.cb.x + (this.cw + this.cg) * i + (this.cw * vfs.length + this.cgg) * index;
		var y = this.cb.y;
		
		var arr0=["M",x,y,"h",this.cw,"v",0,"h",-this.cw,"Z"];
		var arr1=["M",x,y,"h",this.cw,"v",-height,"h",-this.cw,"Z"];

		var color = this.options.color;
		if(vfs.length>1){
			color = this.options.gColor[i];
		}
		//column
		var c = this.paper.path(arr0).attr("fill",color).attr("stroke",color).attr("opacity",1);
		c.data=data;
		c.valueField=vfs[i];
		c.animate({path:arr1},opt.delay,"<>",function(){
			paper.text(this.getBBox().x+this.getBBox().width/2,this.getBBox().y - 5,this.data[this.valueField]);
		});
		c.click(function(e){
			column.clickItem(e,data);
		});
		c.mousemove(function(e){
			opt.mousemove(e,data);
		});
		c.hover(function(e){
			this.attr("stroke","#444");
			opt.mouseover(e,data);
		},
		function(e){
			this.attr("stroke",this.attr("fill"));
			opt.mouseout(e,data);
		});
	}
	// column label
	if($.type(data)=="object"){
		var lx = this.cb.x + (this.cgg + this.cw*vfs.length) * index;
		var lbl = this.paper.text(lx+this.cw*vfs.length/2,y+15,data[this.options.labelField]);
		if(this.options.rotate!=0){
			lbl.attr("text-anchor","end").rotate(this.options.rotate).translate(0,lbl.getBBox().width*Math.cos(this.options.rotate));
		}
	}
};
Eht.Column.prototype.setDelay=function(delay){
	this.options.delay = delay;
};
Eht.Column.prototype.clickItem=function(e,data){
	if(this.options.clickItem){
		this.options.clickItem(data,key);
	}
};


</script>
<script>
$(function(){
	var c1 = new Eht.Column({selector:"#column1",valueField:"value",height:300,
				    data:[{label:"label1",value:100},
			      		  {label:"label2",value:200},
			      		  {label:"label3",value:300},
			      		  {label:"label4",value:100},
			      		  {label:"label5",value:200},
			      		  {label:"label6",value:250},
			      		  {label:"label7",value:200}
		      		  ],
					clickItem:function(data,key){
						$("#text").html(JSON.stringify(data) + "<- " + key);
					}
				 });
	
	var c2 = new Eht.Column({selector:"#column2",valueField:"v1,v2,v3",
				labelDesc:{v1:"xx数据1",v2:"xx数据2",v3:"xx数据3"},
	    	data:[{label:"label1",v1:100,v2:50,v3:150},
	      		  {label:"label2",v1:200,v2:50,v3:110},
	      		  {label:"label3",v1:300,v2:40,v3:100},
	      		  {label:"label4",v1:100,v2:30,v3:120},
	      		  {label:"label5",v1:200,v2:60,v3:110},
	      		  {label:"label6",v1:250,v2:50,v3:100},
	      		  {label:"label7",v1:80,v2:50,v3:100}
  		  ],
		clickItem:function(data,key){
			$("#text").html(JSON.stringify(data) + "<- " + key);
		}
	 });
	
	$("#btn").click(function(){
		c1.refresh();
		c2.refresh();
	});
});
</script>
</head>
<body style="overflow:auto;">
<input type="button" id="btn" value="draw column"/>
<div id="text"></div>
<DIV id="column1"></DIV>
<DIV id="column2"></DIV>
</body>
</html>