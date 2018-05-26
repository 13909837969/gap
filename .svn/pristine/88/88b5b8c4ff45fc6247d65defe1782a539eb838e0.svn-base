/**
 * 饼图
 * @param options
 * @returns {Eht.Pie}
 */
Eht.Pie=function(options){
	var defaults={
		selector:null,
		title:"Pie Chart Demo",
		width:530,
		height:420,
		cx:null,
		cy:null,
		r:120,
		valueField:"value",
		labelField:"label",
		//data:[100,200,300,240,100,50,25.55,100,200,300,240,100],
		data:[{label:"label1",value:200},
		      {label:"label2",value:300},
		      {label:"label3",value:100},
		      {label:"label4",value:220},
		      {label:"label5",value:120},
		      {label:"label6",value:210},
		      {label:"label7",value:80},
		      {label:"label8",value:"100"},
		      {label:"label9",value:"20"},
		      {label:"label10",value:"70.08"},
		      {label:"label11",value:"134.5"},
		      {label:"label12",value:"90"},
		      {label:"label13",value:"100"},
		      {label:"label14",value:"130"}
		      ],
		labels:[],
		colors:["#ff0000","#00ff00","#0000ff","#ffff00","#00ffff","#ff00ff","#ffa800","#00a2ff","#8e20cf",
	            "#ff008a","#a26dc3","#f986ae","#d8ff00","#abaa36","#0b2a3f","#fff996","#93bcbe","#efefef"],
	    clickItem:function(sector){
	    },
	    nodatamessage:"没有数据",
	    delay:600
	};
	
	this.options = $.extend(defaults,options);
	if(this.options.cx==null){
		this.options.cx = this.options.width/2 - this.options.r;
	}
	if(this.options.cy==null){
		this.options.cy = this.options.height/2;
	}
	
	this.initLableX = this.options.cx + 1.5 * this.options.r;
	this.initLableY = this.options.cy - this.options.r;
	
	this.selector = $(this.options.selector);
	this.selector.addClass("eht-chart-background");
	this.paper = Raphael(this.selector.get(0),this.options.width,this.options.height);
	this.data = this.options.data;
	this.labels = this.options.labels;
	this.colors = this.options.colors;
	this.refresh();
};
Eht.Pie.prototype.setDelay=function(delay){
	this.options.delay = delay;
};
Eht.Pie.prototype.refresh=function(){
	this.paper.clear();
	if(this.options.title){
		this.paper.text(this.options.width/2,20,this.options.title).attr("text-anchor","middle").attr("font-size",20);
	}
	this.drawPie();
};
Eht.Pie.prototype.drawPie=function(){
	this.totalValue = 0;
	if(this.data==null || this.data.length==0){
		this.paper.circle(this.options.cx,this.options.cy,this.options.r).attr("fill","#efefef");
		this.paper.text(this.options.cx,this.options.cy,this.options.nodatamessage).attr("font-size",16).attr("fill","#aaa");
		return;
	}
	this.dataPercent = new Array();
	this.items = new Array();
	
	var pie = this;
	this.processData();
	this.options.paper = this.paper;
	var ia = 0;
	for(var i=0;i<this.dataPercent.length;i++){
		if(i>0){
			ia+=this.dataPercent[i-1] * 360;
		}
		var sector = new Eht.Sector(this.options);
		sector.initAngle = ia;
		sector.setData(this.data[i]);
		sector.setAngle(this.dataPercent[i] * 360);
		sector.drawSector();
		sector.setFillColor(this.colors[i]);
		var tmp = "";
		if(this.labels[i]){
			tmp = this.labels[i];
		}
		var lbl = tmp +"  " + ($.type(this.data[i])=="object"?this.data[i][this.options.valueField]:this.data[i])+"("+(this.dataPercent[i]*100).toFixed(2) + "%)";
		sector.setLabel(lbl,this.initLableX,this.initLableY + i*22);
		$(sector.sector).css("cursor","pointer");
		sector.click=function(self){
			for(var j=0;j<pie.items.length;j++){
				if(self!=pie.items[j]){
					pie.items[j].detach(false);
				}
			}
			pie.clickItem(self);
		};
		this.items.push(sector);
	}
};
Eht.Pie.prototype.processData=function(){
	if(this.data && $.type(this.data)=="array"){
		for(var i=0;i<this.data.length;i++){
			if(this.data[i]){
				if($.type(this.data[i])=="object"){
					this.totalValue += parseFloat(this.data[i][this.options.valueField]);
					this.labels[i]=this.data[i][this.options.labelField];
				}else{
					this.totalValue += parseFloat(this.data[i]);
				}
			}
		}
		if(this.totalValue>0){
			for(var i=0;i<this.data.length;i++){
				if(this.data[i]){
					if($.type(this.data[i])=="object"){
						this.dataPercent[i] = parseFloat(this.data[i][this.options.valueField])/this.totalValue;
					}else{
						this.dataPercent[i] = parseFloat(this.data[i])/this.totalValue;
					}
				}else{
					this.dataPercent[i] = 0;
				}
			}
		}
	}
};
Eht.Pie.prototype.detach=function(index){
	if(index != undefined && index >=this.items.length){
		index = this.items.length - 1;
	}
	this.items[index].detach(true);
};
Eht.Pie.prototype.clickItem=function(item){
	if(this.options.clickItem){
		this.options.clickItem(item);
	}
};