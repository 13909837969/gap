/**
 * 仪表盘
 * @param opt
 * @returns {Eht.Dashboard}
 * @author wangbao
 */
Eht.Dashboard=function(opt){
	var def = {
		selector:null,
		width:null,
		height:null,
		initAngle:-60,
		maxAngle:300,
		margin:40,
		maxValue:120,//最大值
		minValue:30,//最小值
		digits:0//小数点
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
	this.cx = this.width/2;
	this.cy = this.height/2;
	this.r = this.cx>this.cy?this.cy-this.opt.margin - 18:this.cx-this.opt.margin - 18;
	this.paper = Raphael(this.selector.get(0),this.width,this.height);
	
	this.draw();
};
Eht.Dashboard.prototype.draw=function(){
	this.paper.clear();
	//仪表盘边框样式
	this.paper.circle(this.cx,this.cy,this.r+18).attr({"stroke-width":1,"fill":"r#eee:90-#ccc-#aaa-#eee","stroke":"#aaa"});
	this.paper.circle(this.cx,this.cy,this.r+2).attr({"stroke-width":1,"stroke":"#aaa"});
	this.textRect = this.paper.rect();
	this.text = this.paper.text(this.cx,this.cy+this.r/2,"");
	this.pointer = new Eht.Pointer({paper:this.paper,x:this.cx,y:this.cy,length:this.r-30,initAngle:this.opt.initAngle});
	this.scale();
};
Eht.Dashboard.prototype.scale=function(){
	var dash = this;
	var cx = this.cx,
	cy=this.cy,
	r=this.r,
	initAngle=this.opt.initAngle,
	maxAngle=this.opt.maxAngle,
	maxV = this.opt.maxValue,
	minV = this.opt.minValue;
	
	warnColor();
	
	for(var i=0;i<=maxAngle;i+=4){
		//刻度
		var ex1 =  cx - r*Math.cos(Math.PI/180 * (initAngle+ i ));
		var ey1 =  cy - r*Math.sin(Math.PI/180 * (initAngle+ i));

		var ex2 =  cx - (r-7)*Math.cos(Math.PI/180 * (initAngle+ i));
		var ey2 =  cy - (r-7)*Math.sin(Math.PI/180 * (initAngle+ i));
		
		var tx =  cx - (r-20)*Math.cos(Math.PI/180 * (initAngle+ i));
		var ty =  cy - (r-22)*Math.sin(Math.PI/180 * (initAngle+ i));
		//生成刻度
		this.paper.path(["M",ex1,ey1,"L",ex2,ey2]);
		if(i%10==0){
			var ex3 =  cx - (r-10)*Math.cos(Math.PI/180 * (initAngle+ i));
			var ey3 =  cy - (r-10)*Math.sin(Math.PI/180 * (initAngle+ i));
			this.paper.path(["M",ex1,ey1,"L",ex3,ey3]).attr("stroke-width",2);
			
			var t = (maxV-minV)/maxAngle * i + minV;
			this.paper.text(tx,ty,t.toFixed(this.opt.digits));
		}
	}
	
	function warnColor(){
		var green = ["M"],gr=[];
		var yellow = ["M"],ye=[];
		var red = ["M"],re=[];
		for(var i=0;i<=maxAngle;i+=4){
			//刻度
			var x1 =  cx - (r+2)*Math.cos(Math.PI/180 * (initAngle+ i ));
			var y1 =  cy - (r+2)*Math.sin(Math.PI/180 * (initAngle+ i));
			
			var x2 =  cx - (r-12)*Math.cos(Math.PI/180 * (initAngle+ i));
			var y2 =  cy - (r-12)*Math.sin(Math.PI/180 * (initAngle+ i));
			
			if(i<=parseInt(maxAngle/3)){
				if(i==0){
					green.push(x1);
					green.push(y1);
				}else{
					green.push("L");
					green.push(x1);
					green.push(y1);
				}
				gr.unshift(y2);
				gr.unshift(x2);
				gr.unshift("L");
			}
			if(i>=parseInt(maxAngle/3) && i<=parseInt(maxAngle/3*2)){
				if(i==parseInt(maxAngle/3)){
					yellow.push(x1);
					yellow.push(y1);
				}else{
					yellow.push("L");
					yellow.push(x1);
					yellow.push(y1);
				}
				ye.unshift(y2);
				ye.unshift(x2);
				ye.unshift("L");
			}
			if(i>=parseInt(maxAngle/3*2) && i<=maxAngle){
				if(i==parseInt(maxAngle/3*2)){
					red.push(x1);
					red.push(y1);
				}else{
					red.push("L");
					red.push(x1);
					red.push(y1);
				}
				re.unshift(y2);
				re.unshift(x2);
				re.unshift("L");
			}
			
		}
		green.push(gr);
		green.push("Z");
		yellow.push(ye);
		yellow.push("Z");
		red.push(re);
		red.push("Z");
		dash.paper.path(green).attr({"stroke-width":0,fill:"90-#0f0-#ff0"});
		dash.paper.path(yellow).attr({"stroke-width":0,fill:"#ff0"});
		dash.paper.path(red).attr({"stroke-width":0,fill:"270-#ff0-#f00"});
	}
};
Eht.Dashboard.prototype.setValue=function(value){
	if(value==null || !Eht.Utils.isNumber(value)){
		return;
	}
	var dash = this;
	this.value = value;
	maxAngle=this.opt.maxAngle,
	maxV = this.opt.maxValue,
	minV = this.opt.minValue;
	//根据值计算角度
	var angle = (value - minV)/(maxV-minV)*maxAngle;
	this.pointer.setData(value);
	this.pointer.setRotate(angle + this.opt.initAngle,function(){
	});
	//值样式
	dash.text.attr({"text":value,"font-size":16,"text-anchor":"middle",
		"stroke":"#000",fill:"#fff","stroke-width":"0.5"});
	var box = dash.text.getBBox();
	//值边框样式
	dash.textRect.attr({x:box.x -10,y:box.y-2,
						width:box.width+20,
						height:box.height+4,r:3,
						"stroke":"#aaa"});//fill:"rgb(86,213,254)"
};
Eht.Dashboard.prototype.setMaxValue=function(value){
	this.opt.maxValue = value;
	this.draw();
	this.scale();
	if(this.value){
		this.setValue(this.value);
	}
};
Eht.Dashboard.prototype.setMinValue=function(value){
	this.opt.minValue = value;
	this.draw();
	this.scale();
	if(this.value){
		this.setValue(this.value);
	}
};
Eht.Dashboard.prototype.loadData=function(obj){
	
};