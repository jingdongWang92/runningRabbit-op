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
    <div class="main-container container-fluid">
        <!-- Page Container -->
        <div class="page-container">
            <div class="page-content">
                <div class="page-body">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget">
                                <div class="widget-header bordered-bottom bordered-yellow">
                                    <span class="widget-caption">商户列表</span>
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
											<form method="post" action="popup_toShopList.action">
												<label>
													<div class="input-group">
	                                                    <span class="input-group-addon"><i class="fa fa-user darkorange"></i></span>
	                                                    <input type="text" name="operator.operatorname" value="<s:property value="operator.operatorname"/>" class="form-control input-sm" placeholder="商户名称">
	                                                </div>
												</label>
		                                    	<label><a class="btn btn-blue input-sm" href="javascript:$('form').submit();" id="submitBtn">查询</a></label>
											</form>
										</div>
										<table class="table table-bordered table-hover table-striped dataTable no-footer" id="searchable">
											<thead class="bordered-darkorange">
													<tr>
														<th style="width: 90px;"><input name="form-field-radio" type="radio"/></th>
														<th style="width: 190px;">商户名称</th>
													</tr>
											</thead>
											<tbody>
												<s:iterator value="dataList" status="status">
													<tr class="<s:if test="status.odd">odd</s:if><s:else>even</s:else>" title="<s:property value='paramdesc' />">
														<td align="right">
			                                                <input style="opacity:1;position: inherit;" name="form-field-radio" 
			                                                	data-value="<s:property value="operatorname" />" type="radio" value="<s:property value="operatorno" />"/>
														</td>
														<td><s:property value="operatorname" /></td>
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
    <script src="assets/page/js/jquery.twbsPagination.js" type="text/javascript"></script>
    <script src="common/js/common.js"></script>
    <script type="text/javascript">
	    var shop = {};

		$("#searchable tbody tr").click(function(){
			$("#searchable tbody tr :radio").attr("checked",false);
			$(this).find(":radio").attr("checked",true);
			
			operator = {
				id : $(this).find(":radio").val(),
				name : $(this).find(":radio").attr("data-value"),
			};

			//返回
			top.operatorPopupHook(operator);
			//关闭页面
			popdown('chooseOperator');
		});
    </script>
</body>
</html>