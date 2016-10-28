<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>系统管理</li>
        <li>操作员管理</li>
        <li class="active">修改密码</li>
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
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员账号</label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" name="operator.account" placeholder="操作员账号" value="<s:property value="#session.Operator.account"/>"
                                       readonly />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员密码<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="password" class="form-control" name="operator.password" placeholder="操作员密码" value="<s:property value="operator.password"/>"
                                       required data-bv-notempty-message="操作员密码为必填项"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">确认密码<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="password" class="form-control" name="operator.confirmpwd" placeholder="确认密码" value="<s:property value="operator.confirmpwd"/>"
                                       required data-bv-notempty-message="确认密码为必填项"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-8 col-lg-offset-4">
                                <button type="submit" class="btn btn-blue" id="submitBtn">确定</button>
                                <button type="button" class="btn btn-default" onclick="loadPage('operator_toList.action')">返回</button>
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
                "operator.password": {
                    validators: {
                        identical: {
                            field: 'operator.confirmpwd',
                            message: '操作员密码和确认密码不相同'
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
                "operator.confirmpwd": {
                    validators: {
                        identical: {
                            field: 'operator.password',
                            message: '操作员密码和确认密码不相同'
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
                ajaxPostRequest('operator_editPwd.action');
            }
        });
    });
</script>
