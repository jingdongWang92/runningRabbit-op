<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>商户管理</li>
        <li class="active">我的信息</li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget radius-bordered">
                <div class="widget-header">
                    <span class="widget-caption">我的信息</span>
                </div>
                <div class="widget-body">
                    <form id="fo" method="post" class="form-horizontal"
                          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                        <input type="hidden" name="dto.operatorno" value="<s:property value="dto.operatorno"/>">
                        <div class="form-group">
                            <label class="col-lg-4 control-label">商户名称&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="dto.operatorname" value="<s:property value="dto.operatorname"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">商户图片&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <img width="160px" height="120px" src="${fileHttpUrl}/<s:property value="dto.pic"/>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">手机号码&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="dto.mobile" value="<s:property value="dto.mobile"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">商铺地址&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="dto.address" value="<s:property value="dto.address"/>"/>
                            </div>
                        </div>
                        <s:if test="dto.roleno != 1 || dto.mobile != #session.Operator.account">
	                        <div class="form-group">
	                            <label class="col-lg-4 control-label">所属角色&nbsp;&nbsp;&nbsp;&nbsp;</label>
	                            <div class="col-lg-8">
	                            	<input type="text" disabled="disabled" class="form-control" name="dto.rolename" value="<s:property value="dto.rolename"/>"/>
	                        	</div>
	                        </div>
	                        <s:if test="dto.shop_name !=null && dto.shop_name !='' && dto.shop_id !=null && dto.shop_id !='' ">
	                          <div class="form-group" id="shop"> 
					         <label class="col-lg-4 control-label">商铺<span
									style="color: red;">&nbsp;&nbsp;*</span></label>
					         <div class="col-lg-8">
					             <input type="text" id="shopname" name="dto.shop_name" value="<s:property value="dto.shop_name"/>" class="input-sm" />
					         </div>
					        </div>
					        </s:if>
                        </s:if>
						<!-- 
						<div class="form-group">
                            <label class="col-lg-4 control-label">所属部门&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                            	<input type="text" disabled="disabled" class="form-control" name="dto.department" value="<s:property value="dto.department"/>"/>
                        	</div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员性别&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                            	<input type="text" class="form-control" disabled="disabled" value="<s:property value="@baseproj.common.constants.EnumUtil@getNameByCode(@com.xiaoguo.yo.common.enums.CommonEnum$SexType@values(), dto.sex)" />"/>
                            </div>
                        </div>
						 -->
                      <%--   <div class="form-group">
                            <label class="col-lg-4 control-label">操作员邮箱&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="dto.email" value="<s:property value="dto.email"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员编号&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="dto.code" value="<s:property value="dto.code"/>"/>
                            </div>
                        </div> --%>
                        <!-- 
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员职位&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="dto.position" value="<s:property value="dto.position"/>"/>
                            </div>
                        </div>
                         -->
                        <div class="form-group">
                            <label class="col-lg-4 control-label"></label>
                            <div class="col-lg-8">
                         		<ism:right url="myOperator_toResetPwd">
                                    <a href="javascript:void(0);" onclick="loadPage('myOperator_toEdit.action?dto.operatorno=<s:property value="dto.operatorno"/>');"
                                       title='修改信息' class="btn"><i class="fa"></i> 修改信息</a>
                                </ism:right>
                         		<ism:right url="myOperator_toResetPwd">
                                    <a href="javascript:void(0);" onclick="loadPage('myOperator_toResetPwd.action?dto.operatorno=<s:property value="dto.operatorno"/>');"
                                       title='修改密码' class="btn"><i class="fa"></i> 修改密码</a>
                                </ism:right>
                                <ism:right url="myOperator_toUpLoad">
                                    <a href="javascript:void(0);" onclick="loadPage('myOperator_toUpload.action?dto.operatorno=<s:property value="dto.operatorno"/>');"
                                       title='更换图片' class="btn"><i class="fa"></i> 更换图片</a>
                                </ism:right>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>