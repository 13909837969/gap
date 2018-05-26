/**
 * 表盘指针
 * @author wangbao
 */
Eht.Pointer=function(opt){
	var pointer = this;
	var def={
		selector:null,
		paper:null,
		x:100,
		y:50,
		length:80,
		data:null,
		width:8,
		initAngle:0
	};

	this.opt=$.extend(def,opt);
	this.selector = $(this.opt.selector);
	this.data = this.opt.data;
	this.paper = this.opt.paper;
	
	this.opt.width=this.opt.length/10;
	var x = this.opt.x;
	var y = this.opt.y;
	
	var p=this.paper.path(["M",x,y,"l",0,this.opt.width/4,"l",-this.opt.length/8*5,this.opt.width/4,"l",-this.opt.length/8*3,-this.opt.width/2,"l",this.opt.length/8*3,-this.opt.width/2,"l",this.opt.length/8*5,2,"z"])
				.attr({"stroke-width":0.5,fill:"90-#fff-#555:50-#555:50-#fff"});
	var f = this.paper.circle(x,y,this.opt.width+1).attr({fill:"0-#555-#2f2-#555","stroke-width":0});
	this.pointer=this.paper.set([p,f]);
	
	this.pointer.transform("r"+this.opt.initAngle+" "+this.opt.x + " " + this.opt.y);
	
	this.pointer.click(function(e){
		if(pointer._click)
		pointer._click(e,pointer.data);
	});
	this.pointer.hover(function(e){
		if(pointer._mouseover)
		pointer._mouseover(pointer.data);
	},
	function(e){
		if(pointer._mouseout)
		pointer._mouseout(pointer.data);
	});
	this.pointer.mousemove(function(e){
		if(pointer._mousemove)
		pointer._mousemove(e,pointer.data);
	});
};
Eht.Pointer.prototype.mouseover=function(func){
	//func(data)
	this._mouseover = func;
};
Eht.Pointer.prototype.mouseout=function(func){
	//func(data)
	this._mouseout = func;
};
Eht.Pointer.prototype.mousemove=function(func){
	//func(data)
	this._mousemove = func;
};
Eht.Pointer.prototype.click=function(func){
	//func(data)
	this._click = func;
};
Eht.Pointer.prototype.setRotate=function(a,func){
	if(func){
		this.pointer.animate({transform:"r"+a+" "+this.opt.x + " " + this.opt.y},800,"<>",func);
	}else{
		this.pointer.animate({transform:"r"+a+" "+this.opt.x + " " + this.opt.y},800);
	}
};
Eht.Pointer.prototype.setData=function(data){
	this.data = data;
};