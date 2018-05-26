var option = {
    title: {
        text: '工作任务统计'
    },
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        data:['报警信息处理','教育培训','帮困扶贫']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    toolbox: {
        feature: {
            saveAsImage: {}
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: ['2017年12月10','2017年12月10','2017年12月10','2017年12月10','2017年12月10','2017年12月10','2017年12月10']
    },
    yAxis: {
        type: 'value'
    },
    series: [
        {
            name:'报警信息处理',
            type:'line',
            stack: '总量',
            data:[120, 132, 101,120, 132, 101,300]
        },
        {
            name:'教育培训',
            type:'line',
            stack: '总量',
            data:[220, 182, 191,220, 182, 191,200]
        },
        {
            name:'帮困扶贫',
            type:'line',
            stack: '总量',
            data:[150, 232, 201,210, 122, 191,111]
        }
    ]
};
$(function() {
	var workChar = echarts.init(document.getElementById('workId'));
	workChar.setOption(option);
});
