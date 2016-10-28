<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<title><s:text name="common.label.system.title" /></title>
	<meta name="description" content="data tables" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" href="assets/img/logo108.png" type="image/x-icon">

    <!--Basic Styles-->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="assets/css/font-awesome.min.css" rel="stylesheet" />

    <!--Fonts-->
    <link href="http://fonts.useso.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,600,700,300" rel="stylesheet" type="text/css">

    <!--Beyond styles-->
    <link id="beyond-link" href="assets/css/beyond.min.css" rel="stylesheet" />
    <link href="assets/css/typicons.min.css" rel="stylesheet" />
    <link href="assets/css/animate.min.css" rel="stylesheet" />
    <!--Skin Script: Place this script in head to load scripts for skins and rtl support-->
    <script src="assets/js/skins.min.js"></script>
</head>
<body>
    <jsp:include page="/common/jsp/loading.jsp"/>
    <!-- Navbar -->
    <!-- head -->
    <jsp:include page="/common/jsp/head.jsp"/>
    <!-- /Navbar -->
    <!-- Main Container -->
    <div class="main-container container-fluid">
        <!-- Page Container -->
        <div class="page-container">
            <!-- 左侧菜单 -->
            <jsp:include page="/common/jsp/left.jsp"/>
            <!-- /Page Sidebar -->
            <!-- Page Content -->
            <div class="page-content">
                <!-- Page Breadcrumb -->
                <div class="page-breadcrumbs">
                    <ul class="breadcrumb">
                        <li><i class="fa fa-home"></i>首页</li>
                        <li>系统管理</li>
                        <li>日志管理</li>
                        <li class="active">日志详情信息</li>
                    </ul>
                </div>
                <!-- /Page Breadcrumb -->
                <!-- Page Body -->
                <div class="page-body">
                	<form id="fo" method="post" class="form-horizontal" 
                			data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                            data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                            data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
	                    <div class="row">
	                        <div class="col-xs-12 col-md-12">
	                        	<div class="widget radius-bordered">
	                                <div class="widget-header">
	                                    <span class="widget-caption">日志详情信息</span>
	                                </div>
		                            <div class="widget-body">
	                                    <div class="form-group">
	                                    	<label class="col-lg-4 control-label">日志编号</label>
	                                        <div class="col-lg-8"><input type="text" disabled="disabled" class="form-control"
	                                        value="<s:property value="operatelog.logno"/>"/></div>
	                                    </div>
	                                    <div class="form-group">
	                                        <label class="col-lg-4 control-label">用户账号</label>
	                                        <div class="col-lg-8">
	                                        	<input type="text" disabled="disabled" class="form-control" value="<s:property value="operatelog.account"/>"/>
	                                        </div>
	                                    </div>
	                                    <div class="form-group">
	                                        <label class="col-lg-4 control-label">操作类型</label>
	                                        <div class="col-lg-8">
	                                        	<input type="text" disabled="disabled" class="form-control" value="<s:property value="operatelog.operatetype"/>"/>
	                                        </div>
	                                    </div>
	                                    <div class="form-group">
	                                        <label class="col-lg-4 control-label">操作时间</label>
	                                        <div class="col-lg-8">
	                                        	<input type="text" disabled="disabled" class="form-control" value="<s:property value="operatelog.operatetime"/>"/>
	                                        </div>
	                                    </div>
	                                    <div class="form-group">
	                                        <label class="col-lg-4 control-label">用户登录IP地址</label>
	                                        <div class="col-lg-8">
	                                        	<input type="text" disabled="disabled" class="form-control" value="<s:property value="operatelog.ipaddress"/>"/>
	                                        </div>
	                                    </div>
	                                    <div class="form-group">
	                                        <label class="col-lg-4 control-label">日志描述</label>
	                                        <div class="col-lg-8">
	                                        	<textarea rows="" cols="" disabled="disabled" class="form-control"><s:property value="operatelog.description"/></textarea>
	                                        </div>
	                                    </div>
	                                    <div class="form-group" style="margin-top:30px;">
                                            <div class="col-lg-8 col-lg-offset-4">
                                                <button type="button" class="btn btn-default" onclick="backToList('log_toList.action')">返回</button>
                                            </div>
                                        </div>
		                             </div>
	                       		</div>
	                        </div>
	                    </div>
                   </form>
                </div>
            </div>
        </div>
    </div>

    <!--Basic Scripts-->
    <script src="assets/js/jquery-2.0.3.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!--Beyond Scripts-->
    <script src="assets/js/beyond.min.js"></script>
    <script src="common/js/common.js"></script>
</body>
</html>