<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>商户管理</li>
        <li class="active">修改我的信息</li>
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
                                <input type="text" class="form-control" maxlength="16" name="dto.operatorname" value="<s:property value="dto.operatorname"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">手机号码&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" minlength="11" maxlength="11" class="form-control" name="dto.mobile" value="<s:property value="dto.mobile"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">商铺地址&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" maxlength="64"  name="dto.address" value="<s:property value="dto.address"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label"></label>
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
var popupShopUrl = '<s:url value="popup_toShopList.action"/>';
    $(function(){
        //校验提交操作
        $('#fo').bootstrapValidator({
            fields: {
            	"operator.operatorname": {
                    validators: {
                        stringCNLength:{
                            min:1,
                            max:50,
                            message:"最大长度50个字符"
                        }
                    }
                }
            },
            submitHandler:function(form){
                ajaxPostRequest('myOperator_edit.action', 'fo', function callback(result){
                	if (result && result.status == '1') {
                    	loadPage('myOperator_toList.action');
        			}
                });
            }
        });
        
    });
</script>