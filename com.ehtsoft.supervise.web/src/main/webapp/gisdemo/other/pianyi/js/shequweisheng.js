

//初始化坐标
function InitPoint()
{
	$.ajax({
		type: "get", 
	   	url: "read/ReadFuWuZhongXin_FuWuZhang.ashx", 
	   	data:{areaid:'0'},
	   	dataType:"text",
	   	error:function(XMLHttpRequest, textStatus, errorThrown){alert(errorThrown);},  
	   	success: function(data){addMarker( eval(data),false,true,"全部" );} 
	});
}



//点击地区，加各区单位
function AreaClick( points,size,AreaID,AreaName )
{
	var arr = points.split('|');
	var point = new BMap.Point(arr[0],arr[1]);
	map.setCenter( point );
	map.zoomTo(size);
	map.clearOverlays();
	
	//JQuery Ajax
    $.get("read/ReadFuWuZhongXin_FuWuZhang.ashx",{Action:"get",areaid:AreaID},function(data){addMarker( eval(data),false,true,AreaName );});
}


//点击服务站名称，生成详细窗口　－－Ajax
function DeptClickByID( DeptID )
{
	$.get("get/GetFuWuZhanByID.ashx",{ deptid: DeptID },function(data){createInfoWindow(data);});
}


//点击服务中心名称，生成详细窗口　－－Ajax
function CenterClickByID( DeptID )
{
	$.get("get/GetFuWuZhongXinByID.ashx",{ deptid: DeptID },function(data){createInfoWindow(data);});
}


//在服务中心或服务站，点击“查看片医”，显示片医详细窗口　－－Ajax
function viewdoctor( iCenterID,iSiteID,points )
{
	$.get("read/ReadPianYiByCenterIDOrSiteID.ashx", { centerid: iCenterID,siteid:iSiteID },
		  function(data)
		  {
			var json = data;
			var arr = points.split('|');
			var point = new BMap.Point(arr[0],arr[1]);
		
			var win = new BMap.InfoWindow(json,{offset:new BMap.Size(10,-20),width:520});
		
			map.openInfoWindow( win, point );
		}
	); 	
}

