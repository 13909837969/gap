/**
 * 矩形格子对象
 * @param opt
 * @returns {Eht.RectGrid}
 * @author wangbao
 */
Eht.RectGrid=function(opt){
	var def = {
		selector:null,
		parentSize:false,//图像大小是否为上级容器的大小
		width:null,
		height:null,
		minXGap:10,//最小 x 轴方向网格线间隔
		minYGap:10, //最小 y 轴方向网格线间隔
		leftMargin:60,
		rightMargin:40,
		topMargin:40,
		bottomMargin:60,
		
		xAxisLine:64,//x轴最多竖线数
		yAxisLine:32,//y轴最多横线数
		
		maxXAxis:64,//x 轴最大值
		maxYAxis:32,//y 轴最大值
		yAxisLabel:"体重",
		xAxisLabel:"年龄（月）",
		axisLabelFontSize:12,//轴描述信息字体大小
		scaleFontSize:12 //刻度字体大小
	};
	this.opt = $.extend(def,opt);
	this.maxXAxis = this.opt.maxXAxis;
	this.maxYAxis = this.opt.maxYAxis;
	this.xAxisLine = this.opt.xAxisLine;
	this.yAxisLine = this.opt.yAxisLine;
	this.width = this.opt.width;
	this.height= this.opt.height;
	this.selector = $(this.opt.selector);
	if(this.width==null){
		this.width = this.selector.width();
	}
	if(this.height==null){
		this.height = this.selector.height();
	}
	this.paper = Raphael(this.selector.get(0),
			this.width,
			this.height);
	
	//x 周描述信息组件
	this.xAxisDes = this.paper.set();
	//y 中描述信息组件
	this.yAxisDes = this.paper.set();
	
	this.zero = {x : this.opt.leftMargin,y : this.height-this.opt.bottomMargin};
	
	this.minYGap = this.opt.minYGap;
	this.minXGap = this.opt.minXGap;
	
	this._width = this.width - this.opt.leftMargin - this.opt.rightMargin;
	this._height = this.height -  this.opt.topMargin - this.opt.bottomMargin;
	
	this.minYGap = this._height/this.yAxisLine;
	this.minXGap = this._width/this.xAxisLine;
	//一个最小格的值
	this.minYGapValue = this.maxYAxis/this.yAxisLine;
	this.minXGapValue = this.maxXAxis/this.xAxisLine;
};
Eht.RectGrid.prototype.drawGrid=function(){
	
	this.paper.rect(0,0,
			this.width,
			this.height).attr("stroke","#aaa");
	
	//纵坐标描述中的线
	var vl = this.paper.path(["M",(this.opt.leftMargin-26)/2,this._height/7+this.opt.topMargin,"v",this._height/7*5]);
	//纵坐标描述信息
	var vtxt = this.paper.rect();
	var txt1 = this.paper.text((this.opt.leftMargin-26)/2,
			this._height/2+this.opt.topMargin,this.opt.yAxisLabel).rotate(270)
			.attr({"fill-opacity":1,fill:"#3334af","font-size":this.opt.axisLabelFontSize});
	vtxt.attr({"width":txt1.getBBox().width+4,"height":txt1.getBBox().height+4,
				x:txt1.attr("x")-txt1.getBBox().width/2-2,
				y:txt1.attr("y")-txt1.getBBox().height/2-2,fill:"#fff",stroke:"#fff"});
	
	this.yAxisDes.push(vl,vtxt,txt1);
	//横坐标描述中的线
	var hl = this.paper.path(["M",this.zero.x + this._width/7,this.zero.y + 30,"h",this._width/7*5]);
	//横坐标描述信息
	var htxt = this.paper.rect();
	var txt2 = this.paper.text(this._width/2 + this.opt.leftMargin,
			this.zero.y + 30,this.opt.xAxisLabel)
			.attr({"fill-opacity":1,fill:"#3334af","font-size":this.opt.axisLabelFontSize});
	htxt.attr({"width":txt2.getBBox().width+4,"height":txt2.getBBox().height+4,
		x:txt2.attr("x")-txt2.getBBox().width/2-2,
		y:txt2.attr("y")-txt2.getBBox().height/2-2,fill:"#fff",stroke:"#fff"});
	
	this.xAxisDes.push(hl,htxt,txt2);
	
	//横格线
	for(var i=0;i<=this.yAxisLine;i++){
    	var path = ["M"];
    	var x = this.zero.x;
    	var y = this.zero.y - i*this.minYGap;
    	path.push(x);
    	path.push(y);
    	path.push("l");
    	path.push(this.width-this.opt.leftMargin-this.opt.rightMargin);
    	path.push(0);
    	var yline = this.paper.path(path);
    	if(i==0){
    		yline.attr({"stroke-width":1,"stroke-linecap": "round",stroke:"#444"});
    	}else{
    		yline.attr({"stroke-width":0.4,"stroke-linecap": "round",stroke:"#444"});
    	}
    	//添加标尺
		this.paper.path(["M",x,y,"h",-4]);
		var yText = this._yScaleLabel ? this._yScaleLabel(i,this.minYGapValue) : i * this.minYGapValue;
		if(this._yAxisMod){
			if(this._yAxisMod(i)){
				this.paper.path(["M",x,y,"h",-7]);
				this.paper.text(x - 9,y,yText).attr({"text-anchor":"end","font-size":this.opt.scaleFontSize});
			}
		}else{
    		if(this.minYGap<=16){
    			if(i%2==0){
    				this.paper.path(["M",x,y,"h",-7]);
    				this.paper.text(x - 9,y,yText).attr({"text-anchor":"end","font-size":this.opt.scaleFontSize});
    			}
    		}else{
    			this.paper.text(x - 9,y,yText).attr({"text-anchor":"end","font-size":this.opt.scaleFontSize});
    		}
		}
	}
	//纵格线
	for(var i=0;i<=this.xAxisLine;i++){
		var path = ["M"];
		var x = this.zero.x + this.minXGap*i;
		var y = this.zero.y;
    	path.push(x);
    	path.push(y);
    	path.push("L");
    	path.push(x);
    	path.push(this.opt.topMargin);
    	var xline = this.paper.path(path);
    	if(i==0){
    		xline.attr({"stroke-width":1,"stroke-linecap": "round",stroke:"#444"});
    	}else{
    		xline.attr({"stroke-width":0.4,"stroke-linecap": "round",stroke:"#444"});	
    	}
    	//添加标尺
		this.paper.path(["M",x,y,"v",4]);
		var xText = this._xScaleLabel ? this._xScaleLabel(i,this.minXGapValue) : i * this.minXGapValue;
		if(this._xAxisMod){
			if(this._xAxisMod(i)){
				this.paper.path(["M",x,y,"v",7]);
				this.paper.text(x,y+14,xText).attr({"font-size":this.opt.scaleFontSize});
			}
		}else{
    		if(this.minXGap<=16){
				if(i%2==0){
					this.paper.path(["M",x,y,"v",7]);
					this.paper.text(x,y+14,xText).attr({"font-size":this.opt.scaleFontSize});
				}
    		}else{
    			this.paper.text(x,y+14,xText).attr({"font-size":this.opt.scaleFontSize});
    		}
		}
	}
};

Eht.RectGrid.prototype.xAxisMod=function(func){
	//func(i)
	this._xAxisMod = func;
};
Eht.RectGrid.prototype.yAxisMod=function(func){
	//func(i)
	this._yAxisMod = func;
};
Eht.RectGrid.prototype.xScaleLabel=function(func){
	//func(i,minXGapValue) return ""
	this._xScaleLabel=func;
};
Eht.RectGrid.prototype.yScaleLabel=function(func){
	//func(i,minYGapValue) return ""
	this._yScaleLabel=func;
};
