Eht.Sector=function(options){
	var sector = this;
	var defaults = {
		paper:null,
		cx:300,
		cy:250,
		r:120,
		data:null,
		dataPercent:null,
		animate:true,
		delay:600
	};
	this.options = $.extend(defaults,options);
	this.radius = this.options.r;
	this.initAngle = 0;
	this.paper = this.options.paper;
	this.sector=this.paper.path();
	
	this.fillColor = "#"+("000000" + Math.ceil(Math.random() * 0x1000000).toString(16)).slice(-6);
	this.strokeColor="#999";
	this.sector.attr("fill", this.fillColor);
	this.sector.attr("stroke",this.strokeColor);
	this.hasClick = false;
	if(this.options.animate==true){
		this.sector.mouseover(function(){
			sector.animateOver();
		});
		this.sector.mouseout(function(){
			sector.animateOut();
		});
		this.sector.click(function(e){
			sector.detach(!sector.hasClick);
			sector.click(sector);
		});
	}
};
Eht.Sector.prototype.animateOver=function(){
	var cx = this.options.cx;
	var cy = this.options.cy;
	var delay = this.options.delay;
	if(this.hasClick==false){
		this.sector.animate({transform: "s1.1 1.1 " + cx + " " + cy}, delay, "elastic");//"elastic"
	}
	if(this.circle && this.label){
		this.circle.animate({transform:"s1.7 1.7 "},delay,"bounce");
		this.label.attr("font-weight","bold");
	}
};
Eht.Sector.prototype.animateOut=function(){
	var delay = this.options.delay;
	if(this.hasClick==false){
		this.sector.animate({transform: ""}, delay, "elastic");//"elastic"
	}
	if(this.circle && this.label){
		this.circle.animate({transform:""},delay,"bounce");
		this.label.attr("font-weight","normal");
	}
};
Eht.Sector.prototype.setData = function(data){
	this.data = data;
};
Eht.Sector.prototype.setLabel=function(label,x,y){
	var delay = this.options.delay;
	var sector = this;
	this.circle = this.paper.circle(x,0,5).attr("fill",this.fillColor).attr("stroke",this.fillColor);
	this.label = this.paper.text(x+20,0,label);
	this.label.attr("font-size",12);
	this.label.attr("text-anchor","start");
	
	this.circle.animate({"cx":x,"cy":y},delay,"bounce");
	this.label.animate({"x":x+20,"y":y},delay,"bounce");
	
	this.label.mouseover(function(){
		sector.animateOver();
	});
	this.label.mouseout(function(){
		sector.animateOut();
	});
	
	this.label.click(function(e){
		sector.detach(!sector.hasClick);
		sector.click(sector);
	});
	this.circle.mouseover(function(){
		sector.animateOver();
	});
	this.circle.mouseout(function(){
		sector.animateOut();
	});
	
	this.circle.click(function(e){
		sector.detach(!sector.hasClick);
		sector.click(sector);
	});
	
};
Eht.Sector.prototype.setRadius=function(r){
	this.radius = r;
	
};
Eht.Sector.prototype.setAngle=function(a){
	this.angle = a;
	var ia = this.initAngle,arc = 2*Math.PI/360;
	this.dx = 25*Math.cos(arc*(this.angle/2+ia));
	this.dy = 25*Math.sin(arc*(this.angle/2+ia));
};
Eht.Sector.prototype.drawSector=function(){
	var delay = this.options.delay;
	var pl = Math.floor(delay/40);
	if(this.options.animate==false){
		pl=1;
	}
	var sector = this,
	r = this.radius,
	a0 = this.angle / pl,
	a = a0,
	ia = this.initAngle,
	arc = 2*Math.PI/360;
	var cx = this.options.cx;
	var cy = this.options.cy;
	var lx = r * Math.cos(arc*ia) + cx;
	var ly = r * Math.sin(arc*ia) + cy;

	var cnt = 1;
	function animate(){
		a = a0 * cnt;
		var largeArc = 0;
		a=a+ia;
		if(a==360+ia){
			a= 360+ia-0.01;
		}
		if(a==ia){
			a=ia+0.01;
		}
		if(a>360 + ia){
			a = a%360;
		}
		if(a - ia>180){
		  largeArc = 1;
		}
		var x = r*Math.cos(arc*a) + cx;
		var y = r*Math.sin(arc*a) + cy;
		var arrPath=["M",cx,cy,"L",lx,ly,"A",r,r,"0",largeArc,"1",x,y,"Z"];
		sector.sector.attr("path",arrPath);
		setTimeout(function(){
			cnt ++;
			if(cnt<=pl){
				animate();
			}
		},35);
	};
	animate();
};
Eht.Sector.prototype.click=function(self){
};
Eht.Sector.prototype.detach=function(detach){
	var ms = this.options.delay;
	this.hasClick = detach;
	if(detach){
		/* linear (default), > , < ,<>,bounce,elastic,backIn,backOut */
	 	this.sector.animate({transform: "t"+this.dx+"," + this.dy}, ms, "bounce");//"elastic"
	 	this.sector.animate({opacity: 1}, ms, ">");//"elastic"
	}else{
	 	this.sector.stop().animate({transform: ""}, ms, "bounce");//"elastic"
	}
};
Eht.Sector.prototype.setFillColor=function(color){
	this.fillColor = color;
	this.sector.attr("fill", color);
};
Eht.Sector.prototype.setStrokeColor=function(color){
	this.strokeColor = color;
	this.sector.attr("stroke",color);
};
Eht.Sector.prototype.setTranslate=function(){
	this.sector.translate(this.dx,this.dy);
};