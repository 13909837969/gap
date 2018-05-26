
//---------------------------创建和初始化地图函数---------------------------------------
var _size;

function initMap( iSize )
{
    _size = iSize;      //地图放大级别
    
	checkSize( 283 );
	
	createMap( _size ); //创建地图（默认放大级别）
	setMapEvent();      //设置地图事件
	addMapControl();    //向地图添加控件
	
	
	InitPoint();        //初始化坐标
}

//创建地图函数，设置默认放大级别为12
function createMap()
{
    if( _size == undefined || _size == 0 )
        _size = 12;
        
	var map = new BMap.Map("dituContent");              //在百度地图容器中创建一个地图
	var point = new BMap.Point(113.671695,34.75979);    //定义一个中心点坐标
	map.centerAndZoom(point,_size);                    //设定地图的中心点和坐标并将地图显示在地图容器中
	window.map = map;                                   //将map变量存储在全局
}

//地图事件设置函数：
function setMapEvent()
{
	map.enableDragging();       //启用地图拖拽事件，默认启用(可不写)
	map.enableScrollWheelZoom();//启用地图滚轮放大缩小
	map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
	map.enableKeyboard();       //启用键盘上下左右键移动地图
}

//地图控件添加函数：
function addMapControl()
{
	//向地图中添加缩放控件
	var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_RIGHT,type:BMAP_NAVIGATION_CONTROL_LARGE});
	map.addControl(ctrl_nav);
	//向地图中添加缩略图控件
	var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:0});
	map.addControl(ctrl_ove);
	//向地图中添加比例尺控件
	var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
	map.addControl(ctrl_sca);
	
}

//自定义标注
function ComplexCustomOverlay(point, text, mouseoverText,id)
{
      this._point = point;
      this._text = text;
      this._overText = mouseoverText;
      this._id = id;
}

//创建marker
function addMarker( markerArr,showflag,isAppend,AreaName )
{
    //根据JSON数据生成单位列表
    if( isAppend )  //是否显示在下面列表里
        CreateDeptList( markerArr,AreaName );

    if( markerArr == undefined || markerArr == "" )
    {
        return;
    }

	for(var i=0;i<markerArr.length;i++)
	{
		var json = markerArr[i];

		var p0 = json.point.split("|")[0];
		var p1 = json.point.split("|")[1];
		var point = new BMap.Point(p0,p1);
		
		var iconImg = createIcon( json.type );
		
		var marker = new BMap.Marker(point,{icon:iconImg});
		var label = new BMap.Label(json.title,{"offset":new BMap.Size(10,-20)});
		marker.setLabel(label);		    //设置标注文本
		
		if( !showflag )
		{
			marker.getLabel().hide();	//隐藏标注文本
	    }
		marker.setTitle(json.title)	    //设置标注点title

		map.addOverlay(marker);
		label.setStyle({borderColor:"#808080",color:"#333",cursor:"pointer"});
		
		(function()
		{
			var index = i;
			var _marker = marker;

			label.addEventListener("click",function(){NodeClick(markerArr[index]);})	//显示窗口
			_marker.addEventListener("click",function(){NodeClick(markerArr[index]);});

			if(!!json.isOpen)
			{
				label.hide();
				NodeClick(markerArr[index]);
			}
		})()
	}
}


//把生成的数据转换成自定义的标注（蓝色背景，含单位名称）
function CustomOverlay( resultArr,AreaName )
{
    //根据JSON数据生成单位列表
    CreateDeptList( resultArr,AreaName );
    
    if( resultArr == undefined || resultArr == "" )
        return;
        
    for( var i=0;i<resultArr.length;i++)
    {
        var arr = resultArr[i].point.split('|');
        var point = new BMap.Point(arr[0],arr[1]);
        
        var text = resultArr[i].title;

        var myCompOverlay = new ComplexCustomOverlay(point, text,text,resultArr[i].ids);
        map.addOverlay(myCompOverlay);
    } 
}


//自定义标注点击事件
function InitOverlayClick( data )
{
	if( data == "" || data == undefined )
    {
        alert( "数据加载失败，请联系管理员！" );
        return;
    }
    
	var json = eval(data);
	var cjson = json[0];
	
	AreaClick(cjson.point,cjson.size,cjson.areaid,cjson.areaname);
}

//创建并显示InfoWindow
function createInfoWindow(data,iWidth)
{
	if( data == "" || data == undefined )
    {
        alert( "数据加载失败，请联系管理员！" );
        return;
    }
    
    if( iWidth == "" || iWidth == undefined )
        iWidth = 0;
    
	var json = eval(data);
	var cjson = json[0];
	var arr = cjson.point.split('|');
	var point = new BMap.Point(arr[0],arr[1]);

	var win = new BMap.InfoWindow(cjson.content,{offset:new BMap.Size(0,-10),width:iWidth});
	win.setTitle( "<b class='iw_poi_title' title='" + cjson.title + "'>" + cjson.title + "</b>" );

	map.openInfoWindow( win, point );
}


//判断Json
function isJson(obj)
{
	var isjson = typeof(obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]" && !obj.length;    
	return isjson;
}

//为节点点击增加事件
function NodeClick( obj )
{
	if( obj.type == 0 )
	    DeptClickByID(obj.ids);
    else
	//if( obj.type == 1 )
		CenterClickByID( obj.ids );
}


//创建一个Icon
function createIcon(flag)
{
    var icon;

    switch (flag) {
        case 0:
            icon = new BMap.Icon("/images/iocn_green.png", new BMap.Size(28, 37));
            break;
        case 1:
            icon = new BMap.Icon("/images/iocn_red.png", new BMap.Size(28, 37));
            break;
        case 2:
            icon = new BMap.Icon("/images/iocn_blue.png", new BMap.Size(28, 37));
            break;
        case 3:
            icon = new BMap.Icon("/images/iocn_yellow.png", new BMap.Size(28, 37));
            break;
        default:
            icon = new BMap.Icon("/images/iocn_green.png", new BMap.Size(28, 37));
            break;
    }
    
    /*
    if( flag == 0 )
	    icon = new BMap.Icon("/images/iocn_green.png",new BMap.Size(28, 37));
	else
	    icon = new BMap.Icon("/images/iocn_red.png",new BMap.Size(28, 37));
    */

	return icon;
}



//---------------------------其它操作---------------------------------------



//隐藏左侧列
function hidleft()
{
    var text = document.getElementById('btnHidden').innerText;
    
    if( text == "<<<" )
    {
        document.getElementById('menuLeft').style.display = "none";
        document.getElementById('boxLeft').style.display = "none";     
        document.getElementById('menuRight').style.left = 0;
        document.getElementById('main').style.left = 0;
        document.getElementById('btnHidden').innerText = ">>>";
        checkSize(0);
    }
    else
    {
        document.getElementById('menuLeft').style.display = "block";
        document.getElementById('boxLeft').style.display = "block";
        document.getElementById('menuRight').style.left = "283px";
        document.getElementById('main').style.left = "283px";
        document.getElementById('btnHidden').innerText = "<<<";
        checkSize(283);
    }

}

//采用Jquery框架显示隐藏左侧列
function SlidLeft()
{
    var flag = $("#IsHidden").val();

    if( flag == "0" )
    {
        $("#menuLeft").toggle(500);
        $("#boxLeft").toggle(500);
        
        $("#menuRight").animate({left:'0px'});
        $("#main").animate({left:'0px'});
        
        $("#IsHidden").val("1");
        
        checkSize(0);
        $("#slidbtn").toggleClass( "slidRightBtn");
    }
    if( flag == "1" )
    {
        $("#menuLeft").toggle(500);
        $("#boxLeft").toggle(500);
        $("#menuRight").animate({left:'283px'});
        $("#main").animate({left:'283px'});
        
        $("#IsHidden").val("0");
        
        checkSize(283);
        
        $("#slidbtn").toggleClass( "slidRightBtn");
    }
}

//设置地图容器全屏
function checkSize( iWidth ) 
{
    var w = $(window).width();
    var h = $(window).height();
    
    $("#dituContent").css({"height":h-145,"width":w-iWidth});
    
    SetDeptListHeight();
    
}

//浏览器尺寸变化时更新
$(window).resize(function(){checkSize( 283);});

//打开评价对话框
function OpenGuest()
{
    var dlg = art.dialog.open('/PingJia/guest.aspx',{title: '卫生医疗服务评价', width: 400, height: 280,lock:true,background:'#000',opacity: 0.6});
}


//设置列表高度
function SetDeptListHeight()
{
    var iHeight,iTop;
    
    iHeight = $(window).height();
    
    //判断是否存在
    if( $("#ulDeptList").offset() != null )
    {
        iTop = $("#ulDeptList").offset().top;
        $("#ulDeptList").css("height",iHeight-iTop-5);
    }
}


//根据异步传输结果生成列表
function CreateDeptList( arrDeptList,AreaName )
{
    //先清除子元素
    $('#ulDeptList').empty();
    
    if( arrDeptList == undefined || arrDeptList == "" )
    {
        $('#spanArea').text(AreaName + "(0)");
        return;
    }
    
    $('#spanArea').html(AreaName + "(<font color=\"red\">" + arrDeptList.length + "</font>)");
    
    //生成列表
    for(var i=0;i<arrDeptList.length;i++)
	{
		var json = arrDeptList[i];
		var value = "";
		
		if( json.type == 0 )
		    value = "<li><a href=\"javascript:DeptClickByID(" + json.ids + ");\">" + json.title + "</a></li>"; 
        else
	    //if( json.type == 1 )
		    value = "<li><a href=\"javascript:CenterClickByID("+ json.ids +");\">" + json.title + "</a></li>"; 
		
        $('#ulDeptList').append(value);
    }
}

//根据单位名称查询
function btnSearchClick( url )
{
    var strDeptName = $("#txtDeptName").val();

    if( strDeptName == "" )
    {
        art.dialog({lock:true,background:'#000',opacity:0.5,content:'请输入要查询的单位名称！',icon:'error',ok:true});
        return;
    }
    
    $.get(url,{Action:"get",deptname:strDeptName},function(data){InitSearch(data,strDeptName);});
}

//查询
function InitSearch( data,Keyword )
{
    var point = new BMap.Point(113.671695,34.75979);
	map.centerAndZoom(point,_size);
	map.clearOverlays();

	addMarker( eval(data),false,true,Keyword );
}



//左侧滑动收缩
$(document).ready(function ()
{
    $(".message_head").click(function () {
        $(this).next(".message_body").slideToggle(500);             
        $(this).children('div').toggleClass('adtit2 adtit');
    });
    
    
    $(".leftbox .message_body1:eq(0)").hide();   //隐藏搜索
    $(".message_head1").click(function () {
        //显示搜索时自动关闭分区浏览
        $(".leftbox .message_head0:eq(0)").next(".message_body0").slideToggle(500); 
        
        $(this).next(".message_body1").slideToggle(500);             
        $(this).children('div').toggleClass('adtit2 adtit');
    });

        
});