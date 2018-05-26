/**
 * 扇形组件
 * @param opt
 * @returns {Eht.Sector}
 * @author wangbao
 */
Eht.Sector=function(opt){
	var def = {
			selector:null,
			width:null,
			height:null,
			cx:210, //圆心x坐标
			cy:210, //圆心y坐标
			r:100,   //半径
			initAngle:0,//初始启动角度
			mouseAnimate:true,
			paper:null,
			color:"#"+Math.floor(Math.random()*16777215).toString(16),
			duration:800
	};
	this.opt= $.extend(def,opt);
	this.selector = $(this.opt.selector);
	this.color = this.opt.color;
	this.r = this.opt.r;   //半径
	this.cx = this.opt.cx; //圆心坐标
	this.cy = this.opt.cy;
	
	this.width = this.opt.width;
	this.height = this.opt.height;
	if(this.width==null){
		this.width = this.selector.width();
	}
	if(this.height==null){
		this.height = this.selector.height();
	}
	if(this.opt.paper==null){
		this.paper = Raphael(this.selector.get(0),
			this.width,
			this.height);
	}else{
		this.paper = this.opt.paper;
	}
	this.initAngle = this.opt.initAngle;
	/*test
	this.paper.rect(0,0,this.width,this.height);
	this.paper.circle(this.cx,this.cy,this.r);
	this.paper.path(["M",this.cx,this.cy,"h100"]);
	this.paper.path(["M",this.cx,this.cy,"v-100"]);
	*/
	this.sector = this.paper.path(["M",this.cx,this.cy]);
	this.hasClick = false;
};
Eht.Sector.prototype.drawSector=function(angle){
	if(angle==360){
		angle=359.9999;
	}
	var sector = this;
		//angle 角度
		//var path = createPathArray(this.initAngle,angle);
		
		//动画移动位置
		this.dx = (this.cx + 20*Math.cos(Math.PI/180*(this.initAngle+angle/2)))-this.cx;
		this.dy = (this.cy - 20*Math.sin(Math.PI/180*(this.initAngle+angle/2)))-this.cy;
			
		this.paper.customAttributes.angle = function (n) {
            return {
                path: createPathArray(this.initAngle,n)
            };
    	};
    	this.sector.initAngle = this.initAngle;
		this.sector.attr({"fill":angle+"-"+this.opt.color+"-#fff",angle:2});
		this.sector.stop().stop().animate({"angle": angle}, this.opt.duration);
		this.sector.mouseover(function(){
			if(sector._mouseover){
				sector._mouseover(sector);
			}
			sector.detach(true);
		});
		this.sector.mouseout(function(){
			if(sector._mouseout){
				sector._mouseout(sector);
			}
			sector.detach(false);
		});
		this.sector.click(function(){
			sector.hasClick =!sector.hasClick;
			if(sector._click){
				sector._click(sector.data);
			}
		});
		
		function createPathArray(initAngle,angle){
			//圆弧的 x,y 坐标
			var ax = sector.cx+sector.r*Math.cos(Math.PI/180*(initAngle+angle));
			var ay = sector.cy-sector.r*Math.sin(Math.PI/180*(initAngle+angle));
			//扇形边框起始点
			var lx = sector.cx + sector.r*Math.cos(Math.PI/180*initAngle);
			var ly = sector.cy - sector.r*Math.sin(Math.PI/180*initAngle);
			//(rx ry x-axis-rotation large-arc-flag sweep-flag x y)
			var largeArc = 0;
			if(angle>180){
				largeArc = 1;
			}
			return ["M",sector.cx,sector.cy,"L",lx,ly,"A",sector.r,sector.r,0,largeArc,0,ax,ay,"z"];
		}
};
Eht.Sector.prototype.mouseover=function(func){
	this._mouseover = func;
};
Eht.Sector.prototype.mouseout=function(func){
	this._mouseout = func;
};
Eht.Sector.prototype.setData=function(data){
	this.data = data;
};
Eht.Sector.prototype.click=function(func){
	//func(data)
	this._click=func;
};
Eht.Sector.prototype.detach=function(detach){
	if(this.opt.mouseAnimate){
		var ms = this.opt.duration;
		if(this.hasClick==false){
			if(detach){
				/* linear (default), > , < ,<>,bounce,elastic,backIn,backOut */
			 	this.sector.animate({transform: "t"+this.dx+"," + this.dy}, ms, "bounce");//"elastic"
			 	this.sector.animate({opacity: 1}, ms, ">");//"elastic"
			}else{
			 	this.sector.stop().animate({transform: ""}, ms, "bounce");//"elastic"
			}
		}
	}
};
