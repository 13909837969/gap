function logout(){
		var ls = new LoginService();
		ls.logout(new Eht.Responder({success:function(data){
			//removeChatListen();
			window.top.location.href = data.value;
		}}));
	}
	var convertData = function (data) {
	    var res = [];
	    for (var i = 0; i < data.length; i++) {
	        var geoCoord = geoCoordMap[data[i].name];
	        if (geoCoord) {
	            res.push({
	                name: data[i].name,
	                value: geoCoord.concat(data[i].value)
	            });
	        }
	    }
	    return res;
};
 	var option = { 
		   baseOption: {
	    		 timeline: {
	                   axisType: 'category',
	                   orient: 'vertical',
	                   autoPlay: true,
	                   inverse: true,
	                   playInterval: 1000,
	                   left: null,
	                   right:30,
	                   top: 20,
	                   bottom: 20,
	                   width:115,
	                   height: null,
	                   label: {
	                       normal: {
	                           textStyle: {
	                               color: '#ddd',
	                               fontSize:20
	                           }
	                       },
	                       emphasis: {
	                           textStyle: {
	                               color: '#fff'
	                           }
	                       }
	                   },
	                   symbol: 'none',
	                   lineStyle: {
	                       color: '#f4e001'
	                   },
	                   checkpointStyle: {
	                       color: '#bbb',
	                       borderColor: '#777',
	                       borderWidth: 3
	                   },
	                   controlStyle: {
	                       showNextBtn: false,
	                       showPrevBtn: false,
	                       normal: {
	                           color: '#666',
	                           borderColor: '#666'
	                       },
	                       emphasis: {
	                           color: '#aaa',
	                           borderColor: '#aaa'
	                       }
	                   },
	                   data: []
	               },
         backgroundColor: '#404a59',
         title: {
             text: '全区矫正人员分布情况',
             left: 'center',
             textStyle: {
                 color: '#fff',
                 fontSize:16
             }
         },
         tooltip : {
             trigger: 'item'
         },
         bmap: {
             center: [108.27712,44.40898],
             zoom: 6,
             roam: true,
             mapStyle: {
                 styleJson: [
                         {
                             "featureType": "water",
                             "elementType": "all",
                             "stylers": {
                                 "color": "#044161"
                             }
                         },
                         {
                             "featureType": "land",
                             "elementType": "all",
                             "stylers": {
                                 "color": "#004981"
                             }
                         },
                         {
                             "featureType": "boundary",
                             "elementType": "geometry",
                             "stylers": {
                                 "color": "#064f85"
                             }
                         },
                         {
                             "featureType": "railway",
                             "elementType": "all",
                             "stylers": {
                                 "visibility": "off"
                             }
                         },
                         {
                             "featureType": "highway",
                             "elementType": "geometry",
                             "stylers": {
                                 "color": "#004981"
                             }
                         },
                         {
                             "featureType": "highway",
                             "elementType": "geometry.fill",
                             "stylers": {
                                 "color": "#005b96",
                                 "lightness": 1
                             }
                         },
                         {
                             "featureType": "highway",
                             "elementType": "labels",
                             "stylers": {
                                 "visibility": "off"
                             }
                         },
                         {
                             "featureType": "arterial",
                             "elementType": "geometry",
                             "stylers": {
                                 "color": "#004981"
                             }
                         },
                         {
                             "featureType": "arterial",
                             "elementType": "geometry.fill",
                             "stylers": {
                                 "color": "#00508b"
                             }
                         },
                         {
                             "featureType": "poi",
                             "elementType": "all",
                             "stylers": {
                                 "visibility": "off"
                             }
                         },
                         {
                             "featureType": "green",
                             "elementType": "all",
                             "stylers": {
                                 "color": "#056197",
                                 "visibility": "off"
                             }
                         },
                         {
                             "featureType": "subway",
                             "elementType": "all",
                             "stylers": {
                                 "visibility": "off"
                             }
                         },
                         {
                             "featureType": "manmade",
                             "elementType": "all",
                             "stylers": {
                                 "visibility": "off"
                             }
                         },
                         {
                             "featureType": "local",
                             "elementType": "all",
                             "stylers": {
                                 "visibility": "off"
                             }
                         },
                         {
                             "featureType": "arterial",
                             "elementType": "labels",
                             "stylers": {
                                 "visibility": "off"
                             }
                         },
                         {
                             "featureType": "boundary",
                             "elementType": "geometry.fill",
                             "stylers": {
                                 "color": "#029fd4"
                             }
                         },
                         {
                             "featureType": "building",
                             "elementType": "all",
                             "stylers": {
                                 "color": "#1a5787"
                             }
                         },
                         {
                             "featureType": "label",
                             "elementType": "all",
                             "stylers": {
                                 "visibility": "off"
                             }
                         }
                 ]
             }
         },
         legend: {
             orient: 'vertical',
             y: 'bottom',
             x:'right',
             data:['全区矫正人员分布情况'],
             textStyle: {
                 color: '#fff',
                 fontSize:16
             }
         },
         series : [
	               {
	                   name: '矫正人员数量',
	                   type: 'scatter',
	                   coordinateSystem: 'bmap',
	                   data: convertData(data[0]),
	                   symbolSize: function (val) {
	                       return val[2] / 10;
	                   },
	                   label: {
	                       normal: {
	                           formatter: '{b}',
	                           position: 'right',
	                           show: false
	                       },
	                       emphasis: {
	                           show: true
	                       }
	                   },
	                   itemStyle: {
	                       normal: {
	                           color: '#ddb926'
	                       }
	                   }
	               },
	               {
	                   name: '矫正人员数量',
	                   type: 'effectScatter',
	                   coordinateSystem: 'bmap', 
	                   data: convertData(data[0].sort(function (a, b) {
	                       return b.value - a.value;
	                   }).slice(0, 6)),
	                   symbolSize: function (val) {
	                       return val[2] / 10;
	                   },
	                   showEffectOn: 'render',
	                   rippleEffect: {
	                       brushType: 'stroke'
	                   },
	                   hoverAnimation: true,
	                   label: {
	                       normal: {
	                           formatter: '{b}',
	                           position: 'right',
	                           show: true
	                       }
	                   },
	                   itemStyle: {
	                       normal: {
	                           color: '#f4e925',
	                           shadowBlur: 10,
	                           shadowColor: '#333'
	                       }
	                   },
	                   zlevel: 1
	               }
	           ]
     },
     options:[]
     };
 $(function(){
   		var a= new JzJzryjbxxService();
   		a.findCount({},new Eht.Responder({
   			success : function(data) {
   				//从后台返回的数据 data
   			   if (data!= null&&data.length>0) {
   					for (var i = 0; i < data.length; i++) {
   						$("#bdrs").html(data[i].bdrs);
   					}
   				} 
   			}
		}));   
      	 var  syrChart = echarts.init(document.getElementById('syrChart'));
      	  for (var n = 0; n < data1.timeline.length; n++) {
	           option.baseOption.timeline.data.push(data1.timeline[n]);
	           option.options.push({
	               title: {
	                   show: true,
	                    y:8,
	                   'text': data1.timeline[n] + '全区矫正人员分布情况统计',
	                   textStyle: {
	                       color: '#fff',
	                       fontSize:26
	                   }
	               },
	               series: [
	  	               {
		                   name: '矫正人员数量',
		                   type: 'scatter',
		                   coordinateSystem: 'bmap',
		                   data: convertData(data[n]),
		                   symbolSize: function (val) {
		                       return val[2] / 10;
		                   },
		                   label: {
		                       normal: {
		                           formatter: '{b}',
		                           position: 'right',
		                           show: false
		                       },
		                       emphasis: {
		                           show: true
		                       }
		                   },
		                   itemStyle: {
		                       normal: {
		                           color: '#ddb926'
		                       }
		                   }
		               },
		               {
		                   name: '矫正人员数量',
		                   type: 'effectScatter',
		                   coordinateSystem: 'bmap',
		                   data: convertData(data[n].sort(function (a, b) {
		                       return b.value - a.value;
		                   }).slice(0, 6)),
		                   symbolSize: function (val) {
		                       return val[2] / 10;
		                   },
		                   showEffectOn: 'render',
		                   rippleEffect: {
		                       brushType: 'stroke'
		                   },
		                   hoverAnimation: true,
		                   label: {
		                       normal: {
		                           formatter: '{b}',
		                           position: 'right',
		                           show: true
		                       }
		                   },
		                   itemStyle: {
		                       normal: {
		                           color: '#f4e925',
		                           shadowBlur: 10,
		                           shadowColor: '#333'
		                       }
		                   },
		                   zlevel: 0
		               }
		           ]
	           });
	       } 
       	 syrChart.setOption(option);
       	optionzt =  {
       			color: ['#f4e001'],
       		    title: {
       		        //text: '2017年各盟市矫正人员分布情况',
	       		     textStyle: {
	                     color: '#ffffff'
	                 }
       		    },
       		    tooltip: {
       		        trigger: 'axis',
       		        axisPointer: {
       		            type: 'shadow'
       		        }
       		    },
       		
       		    grid: {
       		        left: '3%',
       		        right: '4%',
       		        bottom: '3%',
       		        containLabel: true
       		    },
       		    xAxis: {
       		        type: 'value',
       		        boundaryGap: [0, 0.01],
	       		     axisLabel: {
	                     show: true,
	                     textStyle: {
	                         color: '#fff'
	                     }
	       		     },
       		     	splitLine:{ 
                     show:false
    				}
       		    },
       		    yAxis: {
       		        type: 'category',
       		        //data: ['呼和浩特','包头','乌海','赤峰','通辽','鄂尔多斯','呼伦贝尔','乌兰察布','巴彦淖尔','兴安盟','阿拉善盟','锡林郭勒盟'],
	       		    data:getCityName(), 
       		        axisLabel: {
	                     show: true,
	                     textStyle: {
	                         color: '#fff',
	                         fontSize:16
	                     }
	       		     }
       		    },
       		    series: [
       		        {
       		            name: '矫正人员数量',
       		            type: 'bar',

       		            labelLine: {
	       		    	normal: {
	       		    	show: false
	       		    	}
	       		        }
       		        }
       		    ]
       		};
       	
       	function getCityName(){
       		var r = [];
       		for(var i =0 ; i< data[0].length; i++){
       			r[i] = data[0][i].name;
       		}
       		return r;
       	}
    	function getCityValue(index){
       		var r = [];
       		for(var i =0 ; i< data[index].length; i++){
       			r[i] = data[index][i].value;
       		}
       		return r;
       	}
       	var  ztChart = echarts.init(document.getElementById('ztChart'));
       	ztChart.setOption(optionzt);
       	syrChart.on('timelinechanged', function (obj) {  
       		optionzt.series[0].data = getCityValue(obj.currentIndex);
       		ztChart.setOption(optionzt);
       	}); 
 });