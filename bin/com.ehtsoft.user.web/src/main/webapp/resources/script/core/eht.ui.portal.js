Eht.Portal = function(opt){
	var portal = this;
	var def={
		hgap:5,
		minWidth : 400,
		colCount:4,
		rowCount:2
	}
	this.opt = $.extend(def,opt);
	var hgap = this.opt.hgap;
	var minWidth = this.opt.minWidth;
	function init(){
		
		var scrWidth = $(".eht-portal").parent().width();
		var itemWidth = 400;

		var colCount = portal.opt.colCount;
		for(var i=colCount;i>0;i--){
			if(i==colCount){
				if(minWidth * i + hgap*(i-1) < scrWidth){
					itemWidth = scrWidth/i - hgap;
				}
			}
			if(minWidth * i + hgap*(i-1) < scrWidth && minWidth * (i+1) + hgap*i > scrWidth){
				itemWidth = scrWidth/i - hgap;
			}
		}
		$(".eht-portal").each(function(){
			var h = $(this).find(".eht-portal-title").outerHeight();
			$(this).width(itemWidth);
			$(this).find(".eht-portal-body").height($(this).height()-h-1);
		});
	}
	init();
	$(window).resize(function(){
		init();
	});
}