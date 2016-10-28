<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>商户管理</li>
        <li>奖券管理</li>
        <li class="active">奖券修改</li>
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
                        <input type="hidden" name="dto.id" value="<s:property value="dto.id"/>" />
                        <div class="form-group">
                            <label class="col-lg-4 control-label">活动名称<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <select class="form-control" name="dto.act_id">
                                <s:iterator value="actList" var="act">
                                <option <s:if test="dto.act_id==#act.id">selected="selected" </s:if>value="<s:property value="#act.id"/>"><s:property value="#act.name"/></option>
                                </s:iterator>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">奖券名称<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="20" class="form-control" name="dto.name" required data-bv-notempty-message="奖券名称为必填项"
                                placeholder="奖券名称" value="<s:property value="dto.name"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">奖券标题<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="20" class="form-control" name="dto.title" required data-bv-notempty-message="奖券标题为必填项"
                                placeholder="奖券标题" value="<s:property value="dto.title"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">奖券类型<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="20" class="form-control" name="dto.type" required data-bv-notempty-message="奖券类型为必填项"
                                placeholder="奖券类型" value="<s:property value="dto.type"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">活动地址<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="200" class="form-control" name="dto.activityAddress" required data-bv-notempty-message="活动地址为必填项"
                                placeholder="活动地址" value="<s:property value="dto.activityAddress"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">积分数量<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="20" class="form-control" name="dto.integral" required data-bv-notempty-message="积分数量为必填项"
                                placeholder="积分数量" value="<s:property value="dto.integral"/>" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" />
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
                            <label class="col-lg-4 control-label">发行总量<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="20" class="form-control" name="dto.total" required data-bv-notempty-message="发行总量为必填项"
                                placeholder="发行总量" value="<s:property value="dto.total"/>" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-8 col-lg-offset-4">
                                <button type="submit" class="btn btn-blue" id="submitBtn">确定</button>
                                <button type="button" class="btn btn-default" onclick="loadPage('coupon_toList.action')">返回</button>
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
                ajaxPostRequest('coupon_edit.action', 'fo', function callback(result){
                	if (result && result.status == '1') {
                    	loadPage('coupon_toList.action');
        			}
                });
            }
        });
        
        $('#startDate').datetimepicker({
            format: 'yyyy-mm-dd',
            autoclose:true,
            language:'zh-CN',
            startView:2,
            minView:2,
            maxView:4,
            todayHighlight:1
        }).on('changeDate', function(ev){
            var _changeEvent = $("#fo").data("bootstrapValidator")._changeEvent;
            $('#startDate').trigger(_changeEvent);
        }); 
        
        $('#endDate').datetimepicker({
            format: 'yyyy-mm-dd',
            autoclose:true,
            language:'zh-CN',
            startView:2,
            minView:2,
            maxView:4,
            todayHighlight:1
        }).on('changeDate', function(ev){
            var _changeEvent = $("#fo").data("bootstrapValidator")._changeEvent;
            $('#endDate').trigger(_changeEvent);
        });
    });
</script>
