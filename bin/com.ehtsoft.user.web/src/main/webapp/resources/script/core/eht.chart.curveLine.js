/**
 * 曲线/折线图/区域图 继承Eht.RectGrid 类
 * 具体方法调用见  Eht.RectGrid 方法
 * @author wangbao
 */
Eht.CurveLine = function(opt){
	var def = {
			//其他参数参照  Eht.RectGrid
			xAxisField:"x",//字符串
			yAxisField:["y","y1","y2"],//字符串或数组
			colors:["#f00","#0f0","#00f"],
			labels:["描述1","描述2","描述3"],
			sortField:null,
			duration:1000,
			type:"curve",  //curve 曲线图, line 折线图
			isArea:false
		};
	this.opt = $.extend(def,opt);
	this.rectGrid = new Eht.RectGrid(this.opt);
	this.colors = $.isArray(this.opt.colors)?this.opt.colors:[this.opt.colors];
	//将 RectGrid 中属性及方法放入当前类中（模拟继承）
	for(p in this.rectGrid){
		this[p]=this.rectGrid[p];
	}
	
	var yAxisFields = $.isArray(this.opt.yAxisField)?this.opt.yAxisField:[this.opt.yAxisField];
	var labels = $.isArray(this.opt.labels)?this.opt.labels:[this.opt.labels];
	//父类中的属性
	/** 曲线/折线/区域图中的 标签 及 红 表示什么 录表示什么等 **/
	var st = this.paper.set();
	var x = 5;
	for(var i=0;i<yAxisFields.length;i++){
		var label = labels[i]?labels[i]:"null";
		var color = this.colors[i]?this.colors[i]:"red";
		var line = this.paper.path(["M",x,10,"h",10]).attr({"stroke":color,"stroke-width":3});
		var txt = this.paper.text(x+=12,10,label).attr("text-anchor","start");
		x+=txt.getBBox().width+15;
		st.push(line,txt);
	}
	var box = st.getBBox();
	st.push(this.paper.rect(0,0,box.width+10,box.height+10,5).attr("stroke","#aaa"));
	//st.transform("t100,0");
	/**clear 用**/
	this.elements = new Array();
};
/**
 * 数据 x 轴转换回调
 */
Eht.CurveLine.prototype.xAxisConvert=function(func){
	//func(this.data[i][xAxisField]) //x 轴数据值
	this._xAxisConvert = func;
};
/**
 * 数据 y 周转换回调
 */
Eht.CurveLine.prototype.yAxisConvert=function(func){
	//func(this.data[i][yAxisField]) //y 轴数据值
	this._yAxisConvert = func;
};
Eht.CurveLine.prototype.data2path=function(){
	if(this.data==null){
		return;
	}
	var yAxisFields = $.isArray(this.opt.yAxisField)?this.opt.yAxisField:[this.opt.yAxisField];
	for(var m=0;m<yAxisFields.length;m++){
		var curvePath=["M"];
		if(this.opt.isArea){
	    	curvePath.push(this.zero.x);
	    	curvePath.push(this.zero.y);
	    	curvePath.push("L");
		}
		var xAxisField = this.opt.xAxisField;
		var yAxisField = yAxisFields[m];
		var index = 0;
    	for(var i=0;i<this.data.length;i++){
    		if(this.data[i][xAxisField]!=null && this.data[i][yAxisField]!=null){
    			var dx = this._xAxisConvert?this._xAxisConvert(this.data[i][xAxisField]):this.data[i][xAxisField];
    			var dy = this._yAxisConvert?this._yAxisConvert(this.data[i][yAxisField]):this.data[i][yAxisField];
	    		var x = this.zero.x + dx/this.minXGapValue * this.minXGap;
	    		var y = this.zero.y - dy/this.minYGapValue * this.minYGap;
	    		if(index==0){
	    			curvePath.push(x);
	    			curvePath.push(y);
	    		}
	    		if(this.opt.type=="line"){
	    			curvePath.push("L");
	    			curvePath.push(x);
	    			curvePath.push(y);
	    		}else{
		    		if(index==1){
		    			curvePath.push("R");
		    			curvePath.push(x);
		    			curvePath.push(y);
		    		}else{
		    			curvePath.push(x);
		    			curvePath.push(y);
		    		}
	    		}
	    		index++;
    		}
    	}
    	
    	if(this.opt.isArea){
	    	var h = this.zero.y - curvePath[curvePath.length-1];
	    	curvePath.push("v");
	    	curvePath.push(h);
	    	curvePath.push("z");
    	}
    	this.curvePaths[m]=curvePath;
	}
};
Eht.CurveLine.prototype.clear=function(){
	for(var i=0;i<this.elements.length;i++){
		this.elements[i].remove();
	}
};
/**
 * 设置图形类型  curve 曲线  line 折线
 * @param type
 */
Eht.CurveLine.prototype.setType = function(type){
	this.opt.type=type;
	this.data2path();
	if(this.curves){
		for(var i=0;i<this.curves.length;i++){
			this.curves[i].stop().animate({path: this.curvePaths[i]}, this.opt.duration);
		}
	}
};
Eht.CurveLine.prototype.loadData=function(object){
	// [] or func(resp)
	var curveLine = this;
	this.clear();
	if(this.loadParam==null){
		this.loadParam = object;
	}
	// data  [{x:1,y:1},{x:2,y:2}]
	if($.type(object)=="object"){
		this.data = object.rows;
	}
	if($.isArray(object)){
		this.data = object;
	}
	if(this.data !=null && $.isArray(this.data)){
		
		this.curvePaths = new Array();
		
		this.data2path();
		//父类中的属性
		var paper = this.paper;
		this.curves = new Array();
		
		for(var i=0;i<this.curvePaths.length;i++){
	    	var hideCurve = paper.path(this.curvePaths[i]);
	    	this.elements.push(hideCurve);
	    	paper.customAttributes.bb=i;
	    	paper.customAttributes.followPath = function (n) {
	    		var l = this.curve.getTotalLength() - 10;
	    		var len = n * l + 11;
	    		var p = this.curve.getSubpath(0, len);
	    		if(curveLine.opt.isArea){
	    			var a = this.curve.getPointAtLength(len);
	    			p+="v"+(curveLine.zero.y - a.y) + "z";
	    		}
	            return {
	                path: p
	            };
	    	};
	        var curve = this.paper.path();
	        this.curves[i] = curve;
	        this.elements.push(curve);
	        curve.curve = hideCurve;
	        var color = this.colors[i]?this.colors[i]:"red";
	        curve.attr({
	        	followPath: 0,
	            stroke: color,
	            "stroke-width": 2
	        });
	        if(this.opt.isArea){
	        	curve.attr({fill:color,"fill-opacity":0.4});
	        }
	        hideCurve.hide();
	        curve.stop().animate({followPath: 1}, this.opt.duration);
	        curve.mouseover(function(e){
	        	this.attr("stroke-width",4);
	        });
	        curve.mouseout(function(e){
	        	this.attr("stroke-width",2);
	        });
	    }
	}
	if($.isFunction(object)){
		this._loadData = object;
		this.loadResp = new Eht.Responder();
		this.loadResp.success=function(data){
			if(curveLine._loadCompleteBefore){
				curveLine._loadCompleteBefore(data);
			}
			curveLine.loadData(data);
			if(curveLine._loadComplete){
				curveLine._loadComplete(data);
			}
		};
		this._loadData(this.loadResp);
	}
};
Eht.CurveLine.prototype.loadCompleteBefore=function(func){
	//func(data)
	this._loadCompleteBefore = func;
};
Eht.CurveLine.prototype.loadComplete=function(func){
	//func(data)
	this._loadComplete = func;
};
Eht.CurveLine.prototype.refresh=function(){
	this.loadData(this.loadParam);
};