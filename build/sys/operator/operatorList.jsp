<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ism" uri="http://www.baseproj.org/rd/html"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>系统管理</li>
        <li class="active">操作员管理</li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget">
                <div class="widget-header bordered-bottom bordered-yellow">
                    <span class="widget-caption">操作员列表</span>
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
                            <form id="fo" method="post" action="operator_toList.action">
                                <label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user darkorange"></i></span>
                                        <input type="text" name="operator.operatorname" value="<s:property value="operator.operatorname"/>" class="form-control input-sm" placeholder="操作员姓名">
                                    </div>
                                </label>
                                <label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user darkorange"></i></span>
                                        <input type="text" name="operator.mobile" value="<s:property value="operator.mobile"/>" class="form-control input-sm" placeholder="手机号码">
                                    </div>
                                </label>
                                <label><a class="btn btn-blue input-sm" href="javascript:void(0);" onclick="queryAsyncByPage(1);" id="submitBtn">查询</a></label>
                                <ism:right url="operator_toAdd">
                                    <label><a class="btn btn-success input-sm" href="javascript:void(0);" onclick="loadPage('operator_toAdd.action');">新增</a></label>
                                </ism:right>
                            </form>
                        </div>
                        <table class="table table-bordered table-hover table-striped dataTable no-footer" id="searchable">
                            <thead class="bordered-darkorange">
                            <tr>
                            	<!-- <th style="width: 100px;">所在部门</th> -->
                                <th style="width: 100px;">操作员姓名</th>
                                <th style="width: 90px;">操作员账号</th>
                                <th style="width: 90px;">手机号码</th>
                                <th style="width: 90px;">所属角色</th>
                                <th style="width: 90px;">账号状态</th>
                                <th style="width: 150px;"><s:text name="common.button.operate" /></th>
                            </tr>
                            </thead>
                            <tbody>
                            <s:iterator value="dataList" status="status">
                                <tr class="<s:if test="status.odd">odd</s:if><s:else>even</s:else>" title="<s:property value='paramdesc' />">
                                   <!-- 	<td><s:property value="department"/></td> -->
                                    <td><s:property value="operatorname"/></td>
                                    <td><s:property value="account" /></td>
                                    <td><s:property value="mobile"/></td>
                                    <td><s:property value="rolename"/></td>
                                    <td>
                                        <div class="col-xs-4">
                                            <label>
                                                <input cid="<s:property value='operatorno'/>" class="checkbox-slider yesno colored-blue" type="checkbox"
                                                       <s:if test="@baseproj.common.constants.EnumUtil@isEquals(@com.xiaoguo.jc.common.enums.CommonEnum$Status@START,status)">title="已启用"</s:if>
                                                       <s:else>title="已禁用"</s:else>
                                                       <s:if test="@baseproj.common.constants.EnumUtil@isEquals(@com.xiaoguo.jc.common.enums.CommonEnum$Status@START,status)">checked</s:if>>
                                                <span class="text"> </span>
                                            </label>
                                        </div>
                                    </td>
                                    <td>
                                    	<ism:right url="operator_toDetail">
	                                        <a href="javascript:void(0);" onclick="loadPage('operator_toDetail.action?operator.operatorno=<s:property value="operatorno"/>');"
	                                            title="详情" class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> 详情</a>
                                        </ism:right>
                                        <ism:right url="operator_toEdit">
                                            <a href="javascript:void(0);" onclick="loadPage('operator_toEdit.action?operator.operatorno=<s:property value="operatorno"/>');"
                                               title='修改' class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> 修改</a>
                                        </ism:right>
                                        <s:if test="mobile != #session.Operator.account">
	                                        <ism:right url="operator_toResetPwd">
	                                            <a href="javascript:void(0);" onclick="loadPage('operator_toResetPwd.action?operator.operatorno=<s:property value="operatorno"/>');"
	                                               title='重置密码' class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> 重置密码</a>
	                                        </ism:right>
                                        </s:if>
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
        $('.checkbox-slider').on('click', function () {
            var self = $(this);
            var id = $(this).attr("cid");
            var status = $(this).prop("checked") ? 1 : 2;

            var url = "operator_changeStatus.action";
            var data = {"operator.status":status, "operator.operatorno":id};

            changeStatus(url, data, self);
        });
    });
</script>