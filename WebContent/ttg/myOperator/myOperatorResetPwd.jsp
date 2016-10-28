<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>商户管理</li>
        <li>我的信息</li>
        <li class="active">重置密码</li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget radius-bordered">
                <div class="widget-header">
                    <span class="widget-caption">商户基本信息</span>
                </div>
                <div class="widget-body">
                    <form id="fo" method="post" class="form-horizontal"
                          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                        <input type="hidden" name="dto.operatorno" value="<s:property value="dto.operatorno"/>" />
                        <div class="form-group">
                            <label class="col-lg-4 control-label">商户名称&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="dto.operatorname" value="<s:property value="dto.operatorname"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">手机号码&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" disabled="disabled" class="form-control" name="dto.account" value="<s:property value="dto.account"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">新密码<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="password" class="form-control" name="dto.password" placeholder="新密码" value="<s:property value="dto.password"/>"
                                       required data-bv-notempty-message="新密码为必填项"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">确认密码<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="password" class="form-control" name="dto.confirmpwd" placeholder="确认密码" value="<s:property value="dto.confirmpwd"/>"
                                       required data-bv-notempty-message="确认密码为必填项"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-8 col-lg-offset-4">
                                <button type="submit" class="btn btn-blue" id="submitBtn">确定</button>
                                <button type="button" class="btn btn-default" onclick="loadPage('myOperator_toList.action')">返回</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        //校验提交操作
        $('#fo').bootstrapValidator({
            fields: {
                "dto.password": {
                    validators: {
                        identical: {
                            field: 'dto.confirmpwd',
                            message: '用户密码和确认密码不相同'
                        },
                        stringCNLength:{
                            min:1,
                            max:32,
                            message:"最大长度32个字符"
                        },
                        regexp: {
                            regexp:/^(?=.{8,}).*$/g,
                            message:"至少8个字符"
                        }
                    }
                },
                "dto.confirmpwd": {
                    validators: {
                        identical: {
                            field: 'dto.password',
                            message: '用户密码和确认密码不相同'
                        },
                        stringCNLength:{
                            min:1,
                            max:32,
                            message:"最大长度32个字符"
                        },
                        regexp: {
                            regexp:/^(?=.{8,}).*$/g,
                            message:"至少8个字符"
                        }
                    }
                }

            },
            submitHandler:function(form){
                ajaxPostRequest('myOperator_resetPwd.action', 'fo', function callback(result){
                	if (result && result.status == '1') {
                    	loadPage('myOperator_toList.action');
        			}
                });
            }
        });
    });
</script>
