<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>鼠标拾取地图坐标</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <script type="text/javascript"
            src="http://webapi.amap.com/maps?v=1.3&key=2bd1a491810f4c0a9c6a7c0ec73ce9ee&plugin=AMap.Autocomplete"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>

	
		<!--Basic Scripts-->
	<script type="text/javascript" src="assets/js/jquery-2.0.3.min.js"></script>
	<script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
	<!--Beyond Scripts-->
	<script type="text/javascript" src="assets/js/beyond.js"></script>
	<script type="text/javascript" src="assets/js/toastr/toastr.js"></script>

	<script type="text/javascript"
		src="common/js/artDialog4.1.7/artDialog.js"></script>
	<script type="text/javascript"
		src="common/js/artDialog4.1.7/plugins/iframeTools.js"></script>

	<script type="text/javascript"
		src="assets/page/js/jquery.twbsPagination.js"></script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/assets/js/ztree/jquery.ztree.all-3.5.js"></script>

	<script type="text/javascript" src="assets/js/bootbox/bootbox.js"></script>

	<script type="text/javascript" src="common/js/common.js"></script> 

</head>
<body>
<div id="container"></div>
<div id="myPageTop">
    <table>
        <tr>
            <td>
                <label>按关键字搜索：</label>
            </td>
        </tr>
        <tr>
            <td>
                <input type="text" placeholder="请输入关键字进行搜索" id="tipinput">
                <input type="button" id="addRabbit" onclick="popupRabbit(<s:property value="dto.id"/>);" value="添加兔子" />
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript">
	function popupRabbit(id){
		popup('选择兔子', '${pageContext.request.contextPath}/activity_toAddRabbit.action?dto.id='+id, 700, 480, 'chooseAddRabbit',true);
	}
	
	function addRabbitHook(rabbit){
	    if(rabbit){
			alert(rabbit.x);
	    }
	}

    var map = new AMap.Map("container", {
        resizeEnable: true,
        zoom:15
    });
    
    
    // 设置点
    <s:iterator value="dataList" status="status">
    var marker<s:property value="#status.index"/> = new AMap.Marker({
        map: map,
        icon: "http://webapi.amap.com/theme/v1.3/markers/n/mark_r.png",
        position: [<s:property value="x"/>, <s:property value="y"/>]
    });
   	</s:iterator>
   	
   	<s:iterator value="dataList" status="status">
    marker<s:property value="#status.index"/>.on('click', function() {
	   if(window.confirm('确认删除这只兔子吗？')){
	       //alert('您点击了兔子 id:<s:property value="id"/>');
	       ajaxPostRequest('activity_delActivityRabbitRel.action?dto.id=<s:property value="dto.id"/>&rabbitDto.id='+<s:property value="id"/>, 'fo', function callback(result){
	    		 if (result && result.status == '1') {
					// alert('删除成功！');
		    		//top.refreshSetRabbit(<s:property value="dto.id"/>);
	    			 marker<s:property value="#status.index"/>.setMap(null);
	    	         marker<s:property value="#status.index"/> = null;
	         	}else{
					alert('删除失败！' + result.message);
	         	}
	       });
	   }
    });
   	</s:iterator>
</script>
</body>
</html>	