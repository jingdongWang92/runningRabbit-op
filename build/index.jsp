<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
	<!-- Loading Container -->
	<jsp:include page="/common/jsp/loading.jsp" />
	<!--  /Loading Container -->
	<!-- Navbar -->
	<jsp:include page="/common/jsp/navbar.jsp" />
	<!-- /Navbar -->
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- 左侧菜单 -->
			<jsp:include page="/common/jsp/left.jsp" />
			<!-- 中心页面 -->
			<div class="page-content" id="mainFrame">
				<jsp:include page="/common/jsp/main.jsp" />
			</div>
		</div>
	</div>

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

	<script type="text/javascript">
        $(function() {

            $('.nav a').click(function() {
                $('.nav li').removeClass('active');
                $(this).parent().addClass('active');
            });

            $.each($(".nav").find("li"), function(idx, item) {
                var ga = $(item).find("a");
                $(ga).on("click", function() {
                    var ahref = $(this).attr("ahref");
                    if (ahref) {
                        loadMianFrame(ahref);
                    }
                });
            });
        });

        function loadMianFrame(url) {
            loadCustomHtml("mainFrame", url);
        }

    </script>
</body>
</html>