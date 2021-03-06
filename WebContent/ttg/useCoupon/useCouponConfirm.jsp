<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>商户管理</li>
        <li>奖券管理</li>
        <li class="active">奖券核销查询</li>
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
                            </div>
                            <input type="hidden" name="dto.operatorno" id="operatorno" value="<s:property value="dto.operatorno"/>" />
                        </div>
                        </s:if> 
                        <div class="form-group">
                            <label class="col-lg-4 control-label">活动名称<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.actName"
                                placeholder="活动名称" value="<s:property value="dto.actName"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">奖券名称<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.name" 
                                placeholder="奖券名称" value="<s:property value="dto.name"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">奖券标题<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.title" 
                                placeholder="奖券标题" value="<s:property value="dto.title"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">奖券类型<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.type"
                                placeholder="奖券类型" value="<s:property value="dto.type"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">商家图片<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <img width="160px" height="120px" src="<s:property value="dto.operatorPic"/>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">奖券图片<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <img width="480px" height="125px" src="<s:property value="dto.pic"/>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">积分数量<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.integral"
                                placeholder="积分数量" value="<s:property value="dto.integral"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">开始日期<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.startDate" 
                                placeholder="开始日期" value="<s:property value="dto.startDate"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">结束日期<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.startDate" 
                                placeholder="结束日期" value="<s:property value="dto.endDate"/>"/>
                            </div>
                        </div>
                        <!-- 
                        <div class="form-group">
                            <label class="col-lg-4 control-label">用户头像<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <img width="160px" height="120px" src="<s:property value="dto.userPic"/>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">用户昵称<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" maxlength="20" class="form-control" name="dto.stock" 
                                placeholder="用户昵称" value="<s:property value="dto.userName"/>" />
                            </div>
                        </div>
                         -->
                        <div class="form-group">
                            <div class="col-lg-8 col-lg-offset-4">
                                <button type="submit" class="btn btn-blue" id="submitBtn">兑换</button>
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
            submitHandler:function(form){
            	bootbox.confirm('确认兑换该奖券吗？', function (result) {
                    if (result) {
                        ajaxRequest("useCoupon_add.action", {"dto.operatorno":$('#operatorno').val(),"dto.code":"<s:property value="dto.code"/>"}, function(result){
                            if(result.status == '1'){
                                Notify(result.message, 'bottom-right', '5000', 'success', 'fa-check', true);
                            	loadPage('useCoupon_toList.action');
                            }else{
                                Notify(result.message, 'bottom-right', '5000', 'danger', 'fa-bolt', true);
                            }
                        });
                    }
                });
            }
        });
        
    });
    
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
