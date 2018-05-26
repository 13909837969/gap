/**
 * 预警图形
 * @param options type=banner,sector
 * @returns {Eht.Warning}
 */
Eht.Warning=function(options){
	var defaults = {
			selector:null,
			width:400,
			height:200,
			wh:25,//warning height
			cx:20,
			cy:80,
			r:100,
			fixed:0,
			value:70,
			maxValue:100,
			maxNormal:33,
			maxWarn:66,
			normalLabel:"正常",
			warnLabel:"警告",
			seriousLabel:"严重",
			title:"Warning Chart Demo",
			showLabel:true,
			labelAlign:"right",//right,bottom
			delay:800,
			percent:false,
			colors:["#0f0","#ff0","#f00"],
			type:"banner",//banner,sector
			click:function(e,d){},
			mouseover:function(e,d){},
			mouseout:function(e,d){},
			mousemove:function(e,d){}
	};
	this.options = $.extend(defaults,options);
	this.selector = $(this.options.selector);
	this.paper = Raphael(this.selector.get(0),this.options.width,this.options.height);
	this.selector.width(this.options.width);
	this.selector.height(this.options.height);
	this.value=this.options.value;
	this.maxValue=this.options.maxValue;
	this.maxNormal=this.options.maxNormal;
	this.maxWarn=this.options.maxWarn;
	this.refresh();
};
Eht.Warning.prototype.refresh=function(){
	this.paper.clear();
	if(this.options.type=="banner"){
		this.drawBannerWaring();
	}
	if(this.options.type=="sector"){
		this.drawSectorWaring();
	}
};
Eht.Warning.prototype.drawBannerWaring=function(){
	var warning = this;
	var cx = this.options.cx;
	var cy = this.options.cy;
	var w = this.options.width - cx*4;
	var h = this.options.wh;
	if(this.options.title){
		this.paper.text(w/2 + cx,cy - 60,this.options.title).attr({"font-size":20});
	}
	this.paper.rect(cx,cy,w,h).attr("stroke-width",0);
	var maxv = this.maxValue;
	var mnv=this.maxNormal;
	var mwv=this.maxWarn;
	var colors = this.options.colors;
	var normal=this.paper.rect(cx,      cy,mnv/maxv*w,h).attr({"fill":colors[0],"stroke-width":0});
	var warn=this.paper.rect(cx+normal.getBBox().width,  cy,(mwv-mnv)/maxv*w,h).attr({"fill":colors[1],"stroke-width":0});
	var servious=this.paper.rect(cx+normal.getBBox().width+warn.getBBox().width,cy,
			w-normal.getBBox().width-warn.getBBox().width,h).attr({"fill":colors[2],"stroke-width":0});
	
	//线
	this.paper.path(["M",cx+0.5,cy + h+12,"h",w,"v",2,"h",-w,"z"]).attr({"fill":"0-"+colors.join("-"),"stroke-width":0});//"fill":"0-#0f0-#ff0-#f00"
	
	var c = w/10;
	for(var i=0;i<=10;i++){
		this.paper.path(["M",cx + c*i,cy + h+7,"v",5]);
		this.paper.text(cx + c*i,cy + h+20,maxv/10 * i);
	}
	//指针
	var parr0=["M",cx,cy+h+7,"l",-3,-7,"v",-(h+4),"h",6,"v",h+4,"Z"];
	
	var pointer=this.paper.path(parr0).attr({"fill":"0-#fff-#555:50-#555:50-#fff","stroke-width":0.8,"opacity":0.7});
	var parr1=["M",cx+this.value/this.maxValue*w,cy+h+7,"l",-3,-7,"v",-(h+4),"h",6,"v",h+4,"Z"];
	pointer.animate({path:parr1},this.options.delay);//elastic,backIn,backOut
	
	var txt=this.paper.text(cx,pointer.getBBox().y-10,this.value).attr("font-size","14");
	txt.animate({x:cx+this.value/this.maxValue*w},this.options.delay);
	
	//label	
	if(this.options.showLabel){
		var markx = w;
		var marky = cy - 60;
		mark(markx,marky,this.options.normalLabel,"#0f0");
		mark(markx,marky + 15,this.options.warnLabel,"#ff0");
		mark(markx,marky + 30,this.options.seriousLabel,"#f00");
	};
	function mark(markx,marky,label,color){
		var mrect=warning.paper.rect(markx,marky-5,18,10).attr({"fill":color,"scroke":color});
		var mtext=warning.paper.text(markx + mrect.getBBox().width + 5,marky,label).attr("text-anchor","start");
		var w= mrect.getBBox().width + mtext.getBBox().width;
		return w;
	}
};
Eht.Warning.prototype.drawSectorWaring=function(){
	var warning = this;
	var r = this.options.r;
	var cx = this.options.width/2;
	var cy = this.options.height/4 + r;
	if(this.options.labelAlign!="bottom"){
		cx = this.options.width/2 - 20;
	}
	if(this.options.title){
		this.paper.text(cx,15,this.options.title).attr({"font-size":20});
	}
	var maxv = this.maxValue;
	var mnv=this.maxNormal;
	var mwv=this.maxWarn;
	var colors=this.options.colors;
	
	var bs=new Eht.Sector({paper:this.paper,cx:cx,cy:cy,animate:false});
	bs.initAngle=180;
	bs.setAngle(180);
	bs.setRadius(r+5);
	bs.sector.attr("border-width",0);
	bs.setFillColor("#999");
	bs.drawSector();
	
	var ia=180;
	for(var i=0;i<3;i++){
		var s=new Eht.Sector({paper:this.paper,cx:cx,cy:cy,animate:false});
		s.initAngle=ia;
		var a=0;
		switch(i){
		case 0:
			a=mnv/maxv*180;
			ia = ia+a;
			break;
		case 1:
			a=(mwv-mnv)/maxv*180;
			ia = ia + a;
			break;
		case 2:
			a=180 - mwv/maxv*180;
		};
		s.setAngle(a);
		s.setRadius(r);
		s.setFillColor(colors[i]);
		s.sector.attr("stroke-width",0);
		s.drawSector();
	}
	//指针
	var v = this.value;
	var p=new Eht.Pointer({paper:this.paper,x:cx,y:cy,length:r-20,data:v,
		mouseover:function(e,d){
			warning.options.mouseover(e,d);
		},
		mouseout:function(e,d){
			warning.options.mouseout(e,d);
		},
		mousemove:function(e,d){
			warning.options.mousemove(e,d);
		},
		click:function(e,d){
			warning.options.click(e,d);
		}
	});
	p.setRotate(v/maxv * 180,function(){
		//warning.paper.text(cx,cy+30,v);
	});
	//value
	var set = this.paper.set();
	if(this.options.showLabel){
		if(this.options.labelAlign=="bottom"){
			var markx = cx;
			var marky = cy + 30;
			var w1=mark(markx,marky,this.options.normalLabel,colors[0]);
			var w2=mark(markx+w1+10,marky,this.options.warnLabel,colors[1]);
			var w3=mark(markx+w1+w2+10+10,marky,this.options.seriousLabel,colors[2]);
			var ww = w1 + w2 + w3 + 30;
			set.transform("t-"+ww/2+",0");
		}else{
			var markx = this.options.width - 120;
			var marky = 15;
			mark(markx,marky,this.options.normalLabel,colors[0]);
			mark(markx,marky + 15,this.options.warnLabel,colors[1]);
			mark(markx,marky + 30,this.options.seriousLabel,colors[2]);
		}
	};
	
	for(var i=0;i<=10;i++){
		rule(i*18,r-3,maxv/10*i);
	}
	function rule(angle,r,v){
		v = v.toFixed(warning.options.fixed);
		var arc = Math.PI/180;
		var r0=r;
		var x0 = -r0*Math.cos(arc*angle) + cx;
		var y0 = -r0*Math.sin(arc*angle) + cy;
		
		var r1=r0-5;
		var x1 = -r1*Math.cos(arc*angle) + cx;
		var y1 = -r1*Math.sin(arc*angle) + cy;
		
		var r2 = r1 -8;
		
		var x2 = -r2*Math.cos(arc*angle) + cx;
		var y2 = -r2*Math.sin(arc*angle) + cy;
		
		var path=["M",x0,y0,"L",x1,y1];

		warning.paper.path(path);
		if(warning.options.percent==true){
			warning.paper.text(x2,y2,v*100+"%");
		}else{
			warning.paper.text(x2,y2,v);
		}
	}
	function mark(markx,marky,label,color){
			var mrect=warning.paper.rect(markx,marky-5,18,10).attr({"fill":color,"scroke":color});
			var mtext=warning.paper.text(markx + mrect.getBBox().width + 5,marky,label).attr("text-anchor","start");
			set.push(mrect,mtext);
			var w = mrect.getBBox().width + mtext.getBBox().width;
		return w;
	}
};