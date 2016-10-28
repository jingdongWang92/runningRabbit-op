<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>系统管理</li>
        <li>操作员管理</li>
        <li class="active">操作员详情信息</li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget radius-bordered">
                <div class="widget-header">
                    <span class="widget-caption">操作员基本信息</span>
                </div>
                <div class="widget-body">
                    <form id="fo" method="post" class="form-horizontal"
                          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                        <input type="hidden" name="operator.operatorno" value="<s:property value="operator.operatorno"/>">
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员姓名&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="operator.operatorname" value="<s:property value="operator.operatorname"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">手机号码&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="operator.mobile" value="<s:property value="operator.mobile"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">商铺地址&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" maxlength="64"  name="dto.address" value="<s:property value="dto.address"/>"/>
                            </div>
                        </div>
                        <s:if test="operator.roleno != 1 || operator.mobile != #session.Operator.account">
	                        <div class="form-group">
	                            <label class="col-lg-4 control-label">所属角色&nbsp;&nbsp;&nbsp;&nbsp;</label>
	                            <div class="col-lg-8">
	                            	<input type="text" disabled="disabled" class="form-control" name="operator.rolename" value="<s:property value="operator.rolename"/>"/>
	                        	</div>
	                        </div>
	                        <s:if test="operator.shop_name !=null && operator.shop_name !='' && operator.shop_id !=null && operator.shop_id !='' ">
	                          <div class="form-group" id="shop"> 
					         <label class="col-lg-4 control-label">商铺<span
									style="color: red;">&nbsp;&nbsp;*</span></label>
					         <div class="col-lg-8">
					             <input type="text" id="shopname" name="operator.shop_name" value="<s:property value="operator.shop_name"/>" class="input-sm" />
					         </div>
					        </div>
					        </s:if>
                        </s:if>
						<!-- 
						<div class="form-group">
                            <label class="col-lg-4 control-label">所属部门&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                            	<input type="text" disabled="disabled" class="form-control" name="operator.department" value="<s:property value="operator.department"/>"/>
                        	</div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员性别&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                            	<input type="text" class="form-control" disabled="disabled" value="<s:property value="@baseproj.common.constants.EnumUtil@getNameByCode(@com.xiaoguo.yo.common.enums.CommonEnum$SexType@values(), operator.sex)" />"/>
                            </div>
                        </div>
						 -->
                      <%--   <div class="form-group">
                            <label class="col-lg-4 control-label">操作员邮箱&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="operator.email" value="<s:property value="operator.email"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员编号&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="operator.code" value="<s:property value="operator.code"/>"/>
                            </div>
                        </div> --%>
                        <!-- 
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员职位&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="operator.position" value="<s:property value="operator.position"/>"/>
                            </div>
                        </div>
                         -->
                        <div class="form-group">
                            <div class="col-lg-8 col-lg-offset-4">
                                <button type="button" class="btn btn-default" onclick="loadPage('operator_toList.action')">返回</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>