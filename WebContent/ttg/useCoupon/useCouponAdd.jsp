<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>商户管理</li>
        <li>奖券管理</li>
        <li class="active">奖券核销</li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget radius-bordered">
                <div class="widget-header">
                    <span class="widget-caption">奖券基本信息</span>
                </div>
                <div class="widget-body">
                    <form id="fo" method="post" class="form-horizontal"
                          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                        <s:if test="1==dto.operatorno">
                        <div class="form-group">
                            <label class="col-lg-4 control-label">所属商户<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" id="operatorName" name="dto.operatorName" required data-bv-notempty-message="商户名称为必填项"
                                placeholder="所属商户" value="<s:property value="dto.operatorName"/>" onclick="operatorPopup();" />
                                <input type="hidden" name="dto.operatorno" id="operatorno" value="<s:property value="dto.operatorno"/>" />
                            </div>
                        </div>
                        </s:if> 
                        <div class="form-group">
                            <label class="col-lg-4 control-label">奖券兑换码<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="20" class="form-control" id="code" name="dto.code" required data-bv-notempty-message="奖券兑换码为必填项"
                                placeholder="奖券兑换码" value="<s:property value="dto.code"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-8 col-lg-offset-4">
                                <button type="submit" class="btn btn-blue" id="submitBtn">确定</button>
                                <button type="button" class="btn btn-blue" onclick="getCouponDetail()">查询</button>
                                <button type="button" class="btn btn-default" onclick="loadPage('useCoupon_toList.action')">返回</button>
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
        //校验提交操作
        $('#fo').bootstrapValidator({
            fields: {
            	"operator.code": {
                    validators: {
                        stringCNLength:{
                            min:4,
                            max:16,
                            message:"最大长度16个字符"
                        }
                    }
                }
            },
            submitHandler:function(form){
                ajaxPostRequest('useCoupon_add.action', 'fo', function callback(result){
                	if (result && result.status == '1') {
                    	loadPage('useCoupon_toList.action');
        			}
                });
            }
        });
        
    });
    
    function getCouponDetail(){
    	loadPage('useCoupon_toConfirm.action?dto.code='+$('#code').val());
    }
    
    function operatorPopup(){
        popup('选择商户列表', 'popup_toOperatorPopup.action', 700, 480, 'chooseOperator',true);
    }

    function operatorPopupHook(operator){
        if(operator.id){
            $('#operatorno').val(operator.id);
            $('#operatorName').val(operator.name);
        }
    }
</script>
