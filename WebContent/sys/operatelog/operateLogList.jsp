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
    <link id="bootstrap-rtl-link" href="" rel="stylesheet" />
    <link href="assets/css/font-awesome.min.css" rel="stylesheet" />
    <link href="assets/css/weather-icons.min.css" rel="stylesheet" />

    <!--Fonts-->
    <link href="http://fonts.useso.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,600,700,300" rel="stylesheet" type="text/css">

    <!--Beyond styles-->
    <link id="beyond-link" href="assets/css/beyond.min.css" rel="stylesheet" />
    <link href="assets/css/demo.min.css" rel="stylesheet" />
    <link href="assets/css/typicons.min.css" rel="stylesheet" />
    <link href="assets/css/animate.min.css" rel="stylesheet" />
    <link id="skin-link" href="" rel="stylesheet" type="text/css" />

    <!--Page Related styles-->
    <link href="assets/css/dataTables.bootstrap.css" rel="stylesheet" />

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
                        <li class="active">日志管理</li>
                    </ul>
                </div>
                <!-- /Page Breadcrumb -->
                <!-- Page Body -->
                <div class="page-body">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header bordered-bottom bordered-yellow">
                                    <span class="widget-caption">日志列表</span>
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
											<form method="post" action="log_toList.action">
												<label>
													<div class="input-group">
	                                                    <span class="input-group-addon"><i class="fa fa-user darkorange"></i></span>
	                                                    <input type="text" name="operatelog.account" value="<s:property value="operatelog.account"/>" class="form-control input-sm" placeholder="用户账号">
	                                                </div>
												</label>
												<label>
	                                                <div class="input-group">
	                                                    <span class="input-group-addon">
	                                                        <i class="fa fa-calendar"></i>
	                                                    </span><input type="text" name="operatelog.operatetime" value="<s:property value="operatelog.operatetime"/>" class="form-control input-sm" id="reservation" placeholder="操作时间"/>
	                                                </div>
												</label>
												<label>
													<div class="input-group">
	                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
	                                                    <s:select cssClass="form-control input-sm" name="operatelog.operatetype" list="#{}" headerKey="" headerValue="%{getText('common.info.all')}">
				                                            <s:optgroup label="系统管理" list="%{@com.xiaoguo.yo.common.enums.OperateLogEnum$System@values()}" listKey="code" listValue="name"></s:optgroup>
                                        				</s:select>
	                                                </div>
												</label>
		                                    	<label><a class="btn btn-blue input-sm" href="javascript:$('form').submit();" id="submitBtn">查询</a></label>
											</form>
										</div>
										<table class="table table-bordered table-hover table-striped dataTable no-footer" id="searchable">
											<thead class="bordered-darkorange">
													<tr>
														<th style="width: 90px;">所属驾校</th>
														<th style="width: 90px;">日志编号</th>
														<th style="width: 90px;">用户账号</th>
														<th style="width: 130px;">操作类型代码 </th>
														<th style="width: 243px;">描述</th>
														<th style="width: 189px;">操作时间 </th>
														<th style="width: 148px;">用户登录IP地址 </th>
														<th style="width: 90px;"><s:text name="common.button.operate" /></th>
													</tr>
											</thead>
											<tbody>
												<s:iterator value="dataList" status="status">
													<tr class="<s:if test="status.odd">odd</s:if><s:else>even</s:else>">
														<td><s:property value="drivingschoolname"/></td>
														<td><s:property value="logno"/></td>
														<td><s:property value="account"/></td>
														<td><s:property value="operatetype"/></td>
														<td><s:property value="description"/></td>
														<td><s:property value="operatetime"/></td>
														<td><s:property value="ipaddress"/></td>
														<td><a href="log_toDetail.action?operatelog.logno=<s:property value='logno' />" 
															title="详情" class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> 详情</a></td>
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
            </div>
        </div>
    </div>

    <!--Basic Scripts-->
    <script src="assets/js/jquery-2.0.3.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!--Beyond Scripts-->
    <script src="assets/js/beyond.min.js"></script>

    <!--Bootstrap Date Range Picker-->
    <script src="assets/js/datetime/moment.js"></script>
    <script src="assets/js/datetime/daterangepicker.js"></script>
    <script src="assets/page/js/jquery.twbsPagination.js" type="text/javascript"></script>
    <script src="common/js/common.js"></script>
    <script type="text/javascript">
    	$(function(){
	    	$('#reservation').daterangepicker();
    	});
    </script>
    
</body>
</html>