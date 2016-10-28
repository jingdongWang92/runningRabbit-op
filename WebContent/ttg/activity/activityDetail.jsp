<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>后台管理</li>
        <li>活动管理</li>
        <li class="active">活动详情</li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget radius-bordered">
                <div class="widget-header">
                    <span class="widget-caption">活动基本信息</span>
                </div>
                <div class="widget-body">
                    <form id="fo" method="post" class="form-horizontal"
                          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                        <input type="hidden" name="dto.id" value="<s:property value="dto.id"/>" />
                        <div class="form-group">
                            <label class="col-lg-4 control-label">活动名称<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.name" required data-bv-notempty-message="活动名称为必填项"
                                placeholder="活动名称" value="<s:property value="dto.name"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">开始日期<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" readonly="readonly" id="startDate" maxlength="20" class="form-control" name="dto.startDate" required data-bv-notempty-message="开始日期为必填项"
                                placeholder="开始日期" value="<s:property value="dto.startDate"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">结束日期<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" readonly="readonly" id="endDate" maxlength="20" class="form-control" name="dto.endDate" required data-bv-notempty-message="结束日期为必填项"
                                placeholder="结束日期" value="<s:property value="dto.endDate"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">灵敏度<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.sensitivity" required data-bv-notempty-message="灵敏度为必填项"
                                placeholder="灵敏度" value="<s:property value="dto.sensitivity"/>"onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">用户可见度 单位:米<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.jl" required data-bv-notempty-message="用户可见度为必填项"
                                placeholder="用户可见度" value="<s:property value="dto.jl"/>"onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">单个兔子奖励积分<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.integral" required data-bv-notempty-message="积分数量为必填项"
                                placeholder="积分数量" value="<s:property value="dto.integral"/>"onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">兔子刷新周期 单位:分钟<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.refreshTime" required data-bv-notempty-message="兔子刷新周期为必填项"
                                placeholder="兔子刷新周期 单位:分钟" value="<s:property value="dto.refreshTime"/>"onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-8 col-lg-offset-4">
                                <button type="button" class="btn btn-default" onclick="loadPage('activity_toList.action')">返回</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <%--
            <div class="well with-header">
                <div class="header bordered-darkorange">注意事项：</div>

                <div class="alert alert-info fade in" style="color:red;">
                    <i class="fa-fw fa fa-info"></i>
                    <strong>提示!</strong> 手机号码，作为代理人的默认账号.
                </div>
            </div>
             --%>
        </div>
    </div>
</div>
    
<script type="text/javascript">
    $(function(){
    });
</script>
