/**
 * Eht Line 线性图
 * @param options
 * @returns {Eht.Line}
 */
Eht.Line=function(options){
	var defaults={
		selector:null,
		paper:null,
		title:"EHT Line Chart Demo",
		width:600,
		height:360,
		valueField:"v1,v2,v3",
		labelDesc:{v1:"xx数据1",v2:"xx数据2",v3:"xx数据3"},
		axisField:"axis",
		ruleAxisLabel:function(data){
			return data[this.axisField];
		},
		data:[{axis:0,v1:15,v2:40,v3:80},
		      {axis:1,v1:15,v2:40,v3:80},
		      {axis:2,v1:25,v2:60,v3:85},
		      {axis:3,v1:30,v2:50,v3:72},
		      {axis:4,v1:35,v2:60,v3:105},
		      {axis:5,v1:20,v2:80,v3:120},
		      {axis:6,v1:15,v2:45,v3:89},
		      {axis:7,v1:30,v2:65,v3:85},
		      {axis:8,v1:25,v2:60,v3:80}],
		colors:["#2ad4ff","#ff0000","#00ff00","#0000ff","#ffff00","#00ffff","#ff00ff","#ffa800","#00a2ff","#8e20cf",
            "#ff008a","#a26dc3","#f986ae","#d8ff00","#abaa36","#0b2a3f","#fff996","#93bcbe","#efefef"],
        yn:10, //y轴刻度个数
        strokeWidth:3,
        xfull:true,
        xgap:25
	};
	this.options=$.extend(defaults,options);
	this.selector=$(this.options.selector);
	this.data = this.options.data;
	this.paper=Raphael(this.selector.get(0),this.options.width,this.options.height);
	this.title;
	this.rules = new Object();//new Array();
	var h=this.options.height;
	var w=this.options.width;

	this.x = 40;
	this.y = h-50;
	
	this.rw = w-this.x*2;
	this.rh = this.y-50;
	
	this.showVal=false;
	
	this.ascSort();
	
	this.refresh();
};
Eht.Line.prototype.refresh=function(){
	this.rules = new Object();
	this.paper.clear();
	this.drawFrame();
	this.drawRule();
	this.drawLine();
	this.showValue();
};
Eht.Line.prototype.drawFrame=function(){
	//title
	if(this.options.title){
		this.title = this.paper.text(this.x+this.rw/2,15,this.options.title).attr("font-size",20);
	}
	
	var arrh=["M",this.x,this.y,"h",this.rw];
	this.paper.path(arrh);
	
	var arrv=["M",this.x,this.y,"v",-this.rh];
	this.paper.path(arrv);
	
	var rects=["M",this.x,this.y,"h",this.rw,"v",-this.rh,"h",-this.rw,"Z"];
	this.paper.path(rects);
};
Eht.Line.prototype.setTitle=function(title){
	this.title.attr("text",title);
};
Eht.Line.prototype.getMaxRule=function(){
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
Eht.Line.prototype.ascSort=function(){
	var axis=this.options.axisField;
	this.data.sort(function(a,b){
		return a[axis]>b[axis]?1:a[axis]==b[axis]?0:-1;
	});
};
Eht.Line.prototype.showValue=function(show){
	if(show!=undefined){
		this.showVal=show;
	}
	if(this.showVal){
		this.values=new Array();
		var vs=this.options.valueField.split(",");
		var maxr = Math.ceil(this.getMaxRule()/this.options.yn)*this.options.yn;
		var index=0;
		for(var v=0;v<vs.length;v++){
			for(var i=0;i<this.rules.length;i++){
				if(this.data[i]){
					var x=this.rules[this.data[i][this.options.axisField]]+3;
					var y=this.y-this.data[i][vs[v]]/maxr*this.rh-10;
					var txt=this.paper.text(x,y,this.data[i][vs[v]]);
					txt.attr({"text-anchor":"start","font-size":12});
					this.values[index]=txt;
					index++;
				}
			}
		}
	}else{
		if(this.values){
			for(var i=0;i<this.values.length;i++){
				this.values[i].remove();
			}
		}
	}
};
Eht.Line.prototype.drawLine=function(){
	var vs=this.options.valueField.split(",");
	var maxr = Math.ceil(this.getMaxRule()/this.options.yn)*this.options.yn;
	for(var v=0;v<vs.length;v++){
		var ds=new Array();
		var d0=new Array();
		var d1=new Array();
		var line = null;
		for(var i=0;i<this.data.length;i++){
			if(this.data[i]){
				var x=this.rules[this.data[i][this.options.axisField]];
				var y=this.y-this.data[i][vs[v]]/maxr*this.rh;
				if(i==0){
					d0.push("M");
					d0.push(x);
					d0.push(y);
					
					d1.push("M");
					d1.push(x);
					d1.push(y);
					
					ds.push("M");
					ds.push(x);
					ds.push(y);
					line=this.paper.path(d0).attr({"stroke":this.options.colors[v],"stroke-width":this.options.strokeWidth});
					this.paper.circle(x,y,3).attr("z-index","100").attr("fill","#aaeeff");
				}else{
					d1.push("L");
					d1.push(x);
					d1.push(d0[2]);
					
					ds.push("L");
					ds.push(x);
					ds.push(y);
					this.paper.circle(x,y,3).attr("z-index","100").attr("fill","#aaeeff");
				}
			}
		}
		line.data = ds;
		line.animate({path:d1},1000,"linear",function(){
			this.animate({path:this.data},1000);
		});
	}
};
Eht.Line.prototype.drawRule=function(){
	var ngap=12;
	var sh=this.rw/ngap;
	
	if(this.data){
		for(var i=0;i<this.data.length;i++){
			this.rules[this.data[i][this.options.axisField]]=this.x+i*sh;
			var rs=["M",this.x+i*sh,this.y,"v",6];
			this.paper.path(rs);
			if(this.options.ruleAxisLabel){
				this.paper.text(this.x+i*sh,this.y+15,this.options.ruleAxisLabel(this.data[i]));
			}
		}
	}
	
	//x轴坐标刻度
	/*
	for(var i=0;i<=ngap;i++){
		this.rules.push(this.x+i*sh);
		var rs=["M",this.x+i*sh,this.y,"v",6];
		this.paper.path(rs);
		this.paper.text(this.x+i*sh,this.y+15,i);
	}
	*/
	//y轴坐标刻度
	var sv=this.rh/this.options.yn;
	var mr = this.getMaxRule();
	var pmr=Math.ceil(mr/this.options.yn);
	for(var i=0;i<=this.options.yn;i++){
		var rs=["M",this.x,this.y-i*sv,"h",-6];
		var rsh=["M",this.x,this.y-i*sv,"h",this.rw];
		this.paper.path(rs).attr({"stroke-width":0.5});
		this.paper.path(rsh).attr({"stroke-width":0.2});
		this.paper.text(this.x-10,this.y-i*sv,i*pmr).attr("text-anchor","end");
	}
	//颜色标记
	var vs=this.options.valueField.split(",");
	var p=this.paper;
	var x=0;
	var mw=0;
	var arr=new Array();
	for(var i=0;i<vs.length;i++){
		var m=new mark(x,this.options.height-10,this.options.labelDesc[vs[i]],this.options.colors[i]);
		mw+=m.width+10;
		arr.push(m);
	}
	x=(this.options.width - mw)/2;
	for(var i=0;i<arr.length;i++){
		if(i>0){
			x=x+arr[i-1].width + 10;
		}
		arr[i].setX(x);
	}
	function mark(x,y,label,color){
		var m=this;
		this.lp=["M",x,y,"v",5,"h",20,"v",-10,"h",-20,"z"];
		this.l = p.path(this.lp).attr("fill",color);
		this.t = p.text(x+this.l.getBBox().width + 5,y,label).attr("text-anchor","start");
		this.width = this.l.getBBox().width+this.t.getBBox().width+5;
		this.setX=function(x){
			m.lp.splice(1,1,x);
			this.l.attr("path",m.lp);
			this.t.attr("x",x+this.l.getBBox().width+5);
		};
	}
};