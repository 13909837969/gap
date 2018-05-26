/**
 * 饼图组件
 * @param opt
 * @returns {Eht.Pie}
 * @author wangbao
 */
Eht.Pie = function(opt){
	var def = {
		selector:null,
		width:null,
		height:null,
		cx:null, //圆心x坐标
		cy:null, //圆心y坐标
		r:null,   //半径
		valueField:"value", //字符串  
		valueFields:[],     //数组 ["v1","v2","v3"]
		labelField:"label", //字符串  
		labelFields:[],       // 数组 ["l1","l2","l3"]
		colors:["#f00","#0f0","#00f","#ff0","#0ff"],
		duration:400,
		labelWidth:80,
		margin:40,
		FontSize:12,
		nodatamassage:"当前没有统计数据"
	};
	this.opt = $.extend(def,opt);
	this.selector = $(this.opt.selector);
	this.width = this.opt.width;
	this.height = this.opt.height;
	if(this.width==null){
		this.width = this.selector.width();
	}
	if(this.height==null){
		this.height = this.selector.height();
	}
	this.paper =  Raphael(this.selector.get(0),
			this.width,
			this.height);
	this.cx = this.opt.cx;
	this.cy = this.opt.cy;
	this.r = this.opt.r;
    
	this.labelDes = this.paper.set();
};
/**
 * obj 为  array ,object ,function
 * 
 */
Eht.Pie.prototype.loadData=function(obj){
	this.paper.clear();
	if(this.loadParam==null){
		this.loadParam = obj;
	};
	var pie = this;
	if(this.cx==null){
		this.cx = (this.width - this.opt.labelWidth)/2;
	}
	if(this.cy == null){
		this.cy = this.height/2;
	}
	if(this.r == null){
		if(this.cx > this.cy){
			this.r = this.cy - this.opt.margin;
		}else{
			this.r = this.cx - this.opt.margin;
		}
	}
	var t = "t"+ (this.width-this.opt.labelWidth )+ " 20";
	var o2arr = [];
	if($.type(obj)=="object"){
		if($.isArray(this.opt.valueFields)){
			for(var i=0;i<this.opt.valueFields.length;i++){
				if(obj[this.opt.valueFields[i]]!=null && obj[this.opt.valueFields[i]]!=0){
					var o = {};
					o[this.opt.valueField]=obj[this.opt.valueFields[i]];
					o[this.opt.labelField]=this.opt.labelFields[i];
					o2arr.push(o);
				}
			}
			obj=o2arr;
		}else{
			return;
		}
	}
	if($.isArray(obj)){
		this.data = obj;
		var total = 0;
		var len = 0;
		for(var i=0;i<this.data.length;i++){
			if(Eht.Utils.isNumber(this.data[i][this.opt.valueField])){
				total += parseInt(this.data[i][this.opt.valueField]);
				len++;
			}
		}
		var a = 0,n=0;
		if(total!=0){
			for(var i=0;i<this.data.length;i++){
				if(Eht.Utils.isNumber(this.data[i][this.opt.valueField])){
					var color = this._fillColor?this._fillColor(i,this.data[i]):this.opt.colors[i];
					var sector = new Eht.Sector({paper:this.paper,
												color:color,
												width:this.width,
												height:this.height,
												cx:this.cx, //圆心x坐标
												cy:this.cy, //圆心y坐标
												r:this.r,   //半径
												duration:pie.opt.duration});
					if(i>0){
						 a += this.data[i-1][this.opt.valueField]/total * 360;
						sector.initAngle = a;
					}
					sector.setData(this.data[i]);
					sector.drawSector(this.data[i][this.opt.valueField]/total * 360);
					sector.click(function(data){
						if(pie._click){
							pie._click(data);
						}
					});
					var circle = this.paper.circle(10,17 * n + 10,5).attr("fill",sector.color);
					circle.data = this.data[i];
					var str = this.data[i][this.opt.labelField] + " " + this.data[i][this.opt.valueField] + " ("+(this.data[i][this.opt.valueField]/total * 100).toFixed(2)+"%)";
					if(this._labelTips){
						str = this.data[i][this.opt.labelField] + this._labelTips(this.data[i][this.opt.valueField],this.data[i][this.opt.valueField]/total);
					}
					var label = this.paper.text(25,17 * n + 10,str).attr({"font-size":this.opt.FontSize,"text-anchor":"start"});
					label.data = this.data[i];
					circle.sector = sector;
					circle.label = label;
					label.sector = sector;
					label.circle = circle;
					this.labelDes.push(circle,label);
					
					circle.click(function(){
						this.sector.hasClick =!this.sector.hasClick;
						if(pie._click){
							pie._click(this.data);
						}
					});
					label.click(function(){
						this.sector.hasClick =!this.sector.hasClick;
						if(pie._click){
							pie._click(this.data);
						}
					});
					circle.mouseover(function(){
						mover(this.sector,this,this.label);
					});
					circle.mouseout(function(){
						mout(this.sector,this,this.label);
					});
					label.mouseover(function(){
						mover(this.sector,this.circle,this);
					});
					label.mouseout(function(){
						mout(this.sector,this.circle,this);
					});
					sector.circle = circle;
					sector.label = label;
					sector.mouseover(function(){
						mover(this,this.circle,this.label);
					});
					sector.mouseout(function(){
						mout(this,this.circle,this.label);
					});
					n++;
				}
			}
			if(len==1){
				//this.paper.circle(this.cx,this.cy,this.r);
			}
			
			this.labelDes.animate({"transform":t},pie.opt.duration,"bounce");
		}else{
			this.paper.text(this.cx,this.cy,this.opt.nodatamassage);
		}
	}
	
	if($.isFunction(obj)){
		this._loadData = obj;
		this.loadResp = new Eht.Responder();
		this.loadResp.success=function(data){
			if(pie._loadCompleteBefore){
				pie._loadCompleteBefore(data);
			}
			pie.loadData(data);
			if(pie._loadComplete){
				pie._loadComplete(data);
			}
		};
		this._loadData(this.loadResp);
	}
	
	function mover(sector,circle,label){
		circle.animate({transform:t+"s1.7 1.7 "},pie.opt.duration,"bounce");
		label.attr("font-weight","bold");
		sector.detach(true);
	}
	function mout(sector,circle,label){
		circle.animate({transform:t+"s1 1 "},pie.opt.duration,"bounce");
		sector.detach(false);
		label.attr("font-weight","normal");
	}
};
Eht.Pie.prototype.fillColor=function(func){
	// return func(i,data);
	this._fillColor= func;
};
Eht.Pie.prototype.labelTips=function(func){
	//func(data,percent)
	this._labelTips = func;
};
Eht.Pie.prototype.click=function(func){
	//func(data)
	this._click = func;
};
Eht.Pie.prototype.loadCompleteBefore=function(func){
	//func(data)
	this._loadCompleteBefore = func;
};
Eht.Pie.prototype.loadComplete=function(func){
	//func(data)
	this._loadComplete = func;
};
Eht.CurveLine.prototype.refresh=function(){
	this.loadData(this.loadParam);
};