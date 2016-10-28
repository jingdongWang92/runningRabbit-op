<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ism" uri="http://www.baseproj.org/rd/html"%>
<!DOCTYPE html>
<html>
<head>
<title>TWOTWO GO</title>
<meta name="renderer" content="webkit">
<meta name="description" content="Dashboard" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />

<link rel="shortcut icon" href="assets/img/favicon.png"
	type="image/x-icon">

<!--Basic Styles-->
<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="assets/css/font-awesome.min.css" rel="stylesheet" />
<link href="assets/css/weather-icons.min.css" rel="stylesheet" />

<!--Page Related styles-->
<link href="assets/css/dataTables.bootstrap.css" rel="stylesheet" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ztree/zTreeStyle/zTreeStyle.css"
	type="text/css" />

<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/common/js/artDialog4.1.7/skins/default.css" />

<!--Beyond styles-->
<link id="beyond-link" href="assets/css/beyond.min.css" rel="stylesheet"
	type="text/css" />
<link href="assets/css/typicons.min.css" rel="stylesheet" />
<link href="assets/css/animate.min.css" rel="stylesheet" />

<link href="assets/css/clockpicker/bootstrap-clockpicker.min.css"
	rel="stylesheet" />
<link href="assets/css/datetimepicker/bootstrap-datetimepicker.min.css"
	rel="stylesheet" />

<!--上传文件-->
<link href="assets/upload/css/fileinput.css" media="all"
	rel="stylesheet" type="text/css" />

<!--Skin Script: Place this script in head to load scripts for skins and rtl support-->
<script src="assets/js/skins.min.js"></script>
</head>
<body>
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

	<script type="text/javascript"
		src="assets/js/datetime/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript"
		src="assets/js/datetime/locales/bootstrap-datetimepicker.zh-CN.js"
		charset="UTF-8"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/datetime/moment.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/datetime/daterangepicker.js"></script>
	<!--上传文件-->
	<script src="assets/upload/js/fileinput.min.js" type="text/javascript"></script>
	<script src="assets/upload/js/fileinput_locale_zh.js"
		type="text/javascript"></script>

	<script type="text/javascript"
		src="assets/js/validation/bootstrapValidator.js"></script>

	<script type="text/javascript" src="common/js/common.js"></script>
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget">
                <div class="widget-header bordered-bottom bordered-yellow">
                    <span class="widget-caption">兔子列表</span>
                    <div class="widget-buttons">
                        <a href="#" data-toggle="maximize">
                            <i class="fa fa-expand"></i>
                        </a>
                        <a href="#" data-toggle="collapse">
                            <i class="fa fa-minus"></i>
                        </a>
                    </div>
                </div>
                <div class="widget-body no-padding">
                    <div id="searchable_wrapper" class="dataTables_wrapper form-inline no-footer">
                        <div id="searchable_filter" class="dataTables_filter">
                            <form id="fo" method="post" action="rabbit_toAddRabbit.action">
                                <label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user darkorange"></i></span>
                                        <input type="text" name="dto.uuid" value="<s:property value="dto.uuid"/>" class="form-control input-sm" placeholder="uuid">
                                    </div>
                                </label> 
                                <label><a class="btn btn-blue input-sm" href="javascript:void(0);" onclick="queryAsyncByPage(1);" id="submitBtn">查询</a></label>
                            </form>
                        </div>
                        <table class="table table-bordered table-hover table-striped dataTable no-footer" id="searchable">
                            <thead class="bordered-darkorange">
                            <tr>
                                <th style="width: 100px;">坐标(X轴,Y轴)</th>
                                <th style="width: 100px;">uuid</th>
                                <th style="width: 100px;">major</th>
                                <th style="width: 100px;">minor</th>
                                <th style="width: 150px;"><s:text name="common.button.operate" /></th>
                            </tr>
                            </thead>
                            <tbody id="tbody">
                            <s:iterator value="dataList" status="status">
                                <tr class="<s:if test="status.odd">odd</s:if><s:else>even</s:else>">
                                    <td><s:property value="x"/>,<s:property value="y"/></td>
                                    <td><s:property value="uuid"/></td>
                                    <td><s:property value="major"/></td>
                                    <td><s:property value="minor"/></td>
                                    <td>
                                        <a href="javascript:void(0);" 
                                        	id="<s:property value="id"/>" x="<s:property value="x"/>" y="<s:property value="y"/>" 
                                        	uuid="<s:property value="uuid"/>" major="<s:property value="major"/>" minor="<s:property value="minor"/>"
                                            title="选中" class="btn btn-info btn-xs selected"><i class="fa fa-folder-o"></i> 选中</a>
                                    </td>
                                </tr>
                            </s:iterator>
                            </tbody>
                        </table>
                        <!-- 分页信息 -->
                        <jsp:include page="/common/jsp/page.jsp"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
    	$('#tbody a').click(function(){
    		obj = {
    			id : $(this).attr('id'),
   				x : $(this).attr('x'),
   				y : $(this).attr('y'),
   				uuid : $(this).attr('uuid'),
   				major : $(this).attr('major'),
   				minor : $(this).attr('minor'),
   			};
    		//top.addRabbitHook(obj);
    		ajaxPostRequest('activity_addActivityRabbitRel.action?dto.id=<s:property value="rabbitDto.aid"/>&rabbitDto.id='+obj.id, 'fo', function callback(result){
        		 if (result && result.status == '1') {
    	    		top.refreshSetRabbit(<s:property value="dto.id"/>);
    	   			top["openerstack"].pop();
    	   			top.artDialog({
    	   				id : 'chooseAddRabbit'
    	   			}).close();
    	   			
             	}else{
    				alert('添加失败！' + result.message);
             	}
             });
    		
    	});
    });
</script>

</body>
</html>