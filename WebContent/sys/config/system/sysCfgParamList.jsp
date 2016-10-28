<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ism" uri="http://www.baseproj.org/rd/html"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
	<ul class="breadcrumb">
		<li><i class="fa fa-home"></i>首页</li>
		<li>系统管理</li>
		<li class="active">全局参数管理</li>
	</ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
	<div class="row">
		<div class="col-xs-12 col-md-12">
			<div class="widget">
				<div class="widget-header bordered-bottom bordered-yellow">
					<span class="widget-caption">全局参数列表</span>
					<div class="widget-buttons">
						<a href="#" data-toggle="maximize"> <i class="fa fa-expand"></i>
						</a> <a href="#" data-toggle="collapse"> <i class="fa fa-minus"></i>
						</a>
					</div>
				</div>
				<div class="widget-body no-padding">
					<div id="searchable_wrapper"
						class="dataTables_wrapper form-inline no-footer">
						<div id="searchable_filter" class="dataTables_filter">
							<form id="fo" onsubmit="return false" method="post" action="globalSet_toList.action">
								<label>
									<div class="input-group">
										<span class="input-group-addon"><i
											class="fa fa-user darkorange"></i></span> <input type="text"
											name="sysCfgParam.paramname"
											value="<s:property value="sysCfgParam.paramname"/>"
											class="form-control input-sm" placeholder="参数名称">
									</div>
								</label> 
								<%--
								<label>
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-search"></i></span>
										<s:select cssClass="form-control input-sm"
											name="sysCfgParam.paramtype"
											list="@baseproj.common.constants.EnumUtil@getValues(@com.xiaoguo.jc.common.enums.SysCfgEnum$Type@values(),true)"></s:select>
									</div>
								</label>
								 --%>
								 <label><a class="btn btn-blue input-sm"
									href="javascript:void(0);" onclick="queryAsyncByPage(1);"
									id="submitBtn">查询</a></label>
								<ism:right url="globalSet_sync">
									<label><a class="btn btn-blue input-sm"
										href="javascript:void(0);" id="syncBtn">同步</a></label>
								</ism:right>
							</form>
						</div>
						<table
							class="table table-bordered table-hover table-striped dataTable no-footer"
							id="searchable">
							<thead class="bordered-darkorange">
								<tr>
									<th style="width: 150px;"><s:text name="sys.syscfg.name" /></th>
									<th style="width: 130px;">参数代码</th>
									<th style="width: 100px;"><s:text name="sys.syscfg.type" /></th>
									<th style="width: 100px;"><s:text name="sys.syscfg.value" />
									</th>
									<th style="width: 100px;"><s:text
											name="sys.syscfg.minvalue" /></th>
									<th style="width: 100px;"><s:text
											name="sys.syscfg.maxvalue" /></th>
									<ism:right url="globalSet_toEdit">
										<th style="width: 90px;"><s:text
												name="common.button.operate" /></th>
									</ism:right>
								</tr>
							</thead>
							<tbody>
								<s:iterator value="dataList" status="status">
									<tr
										class="<s:if test="status.odd">odd</s:if><s:else>even</s:else>"
										title="<s:property value='paramdesc' />">
										<td><s:property value="paramname" /></td>
										<td><s:property value="paramcode" /></td>
										<td><s:property
												value="@baseproj.common.constants.EnumUtil@getNameByCode(@com.xiaoguo.jc.common.enums.SysCfgEnum$Type@values(), paramtype)" />
										</td>
										<td><s:property value="paramvalue" /></td>
										<td><s:property value="min" /></td>
										<td><s:property value="max" /></td>
										<ism:right url="globalSet_toEdit">
											<td><s:if
													test="@baseproj.common.constants.EnumUtil@isEquals(@com.xiaoguo.jc.common.enums.SysCfgEnum$ParamFlag@Edit, paramflag)">
													<a href="javascript:void(0);"
														onclick="loadPage('globalSet_toEdit.action?sysCfgParam.id=<s:property value='id' />');"
														title="修改" class="btn btn-info btn-xs edit"><i
														class="fa fa-edit"></i> 修改</a>
												</s:if> <s:else>--</s:else></td>
										</ism:right>
									</tr>
								</s:iterator>
							</tbody>
						</table>
						<!-- 分页信息 -->
						<jsp:include page="/common/jsp/page.jsp" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
        $(function(){
           $("#syncBtn").on("click", function(){
               var url = "globalSet_sync.action";
               $.ajax({
                   type : "POST",
                   url : url,
                   async : false,
                   cache : false,
                   beforeSend : null,
                   data : $('#fo').serialize(),
                   dataType : 'json',
                   success : function(result) {
                       if (result.status == '1') {
                           Notify(result.message, 'bottom-right', '5000', 'success', 'fa-check', true);
                       } else {
                           Notify(result.message, 'bottom-right', '5000', 'danger', 'fa-bolt', true);
                       }
                   },
                   error : function() {
                   }
               });
           });
        });
    </script>
