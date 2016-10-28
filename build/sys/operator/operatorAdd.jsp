<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>系统管理</li>
        <li>操作员管理</li>
        <li class="active">新增操作员</li>
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
                            <label class="col-lg-4 control-label">操作员姓名<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="20" class="form-control" name="operator.operatorname" required data-bv-notempty-message="操作员姓名为必填项"
                                placeholder="操作员姓名" value="<s:property value="operator.operatorname"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">手机号码<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="11" class="form-control" name="operator.mobile" required data-bv-notempty-message="手机号码为必填项"
                                	placeholder="手机号码" value="<s:property value="operator.mobile"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">商铺地址&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" maxlength="64"  name="dto.address" value="<s:property value="dto.address"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">登录帐号<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="16" class="form-control" name="operator.account" required data-bv-notempty-message="帐号为必填项"
                                	placeholder="登录帐号" value="<s:property value="operator.account"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">初始密码<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="16" class="form-control" name="operator.password" required data-bv-notempty-message="初始密码为必填项"
                                	placeholder="初始密码" value="<s:property value="operator.password"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">所属角色<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <select class="form-control" name='operator.roleno' id='roleno' onchange="chooseroleno(this)"
                                        required data-bv-notempty-message="请选择操作员所属角色"></select></div>
                        </div>
	                     <div class="form-group" id="shop"> 
				         <label class="col-lg-4 control-label">商铺<span
								style="color: red;">&nbsp;&nbsp;*</span></label>
				         <div class="col-lg-8">
				             <input type="text" id="shopname" name="operator.shop_name" class="input-sm" data-bv-notempty-message="商铺为必填项"   placeholder="商铺"  readonly/>
				             <input type="hidden" id="shopid" class="input-sm" name="operator.shop_id" />
				             <a class="btn btn-default purple input-sm" href="javascript:popupShop();"><i class="fa fa-plus"></i></a>
				         </div>
				        </div>
						<%-- 
						<div class="form-group">
                            <label class="col-lg-4 control-label">所属部门<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <select class="form-control" name='operator.did' id='department'
                                        required data-bv-notempty-message="请选择操作员所在部门"></select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员性别&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <s:select cssClass="form-control" name="operator.sex"
                                          list="@baseproj.common.constants.EnumUtil@getValues(@com.xiaoguo.yo.common.enums.CommonEnum$SexType@values(),false)"></s:select>
                            </div>
                        </div>
						 --%>
                      <%--   <div class="form-group">
                            <label class="col-lg-4 control-label">操作员邮箱&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" name="operator.email" placeholder="操作员邮箱" value="<s:property value="operator.email"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员编号&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" name="operator.code" placeholder="操作员编号" value="<s:property value="operator.code"/>"/>
                            </div>
                        </div> --%>
                        <!-- 
                        <div class="form-group">
                            <label class="col-lg-4 control-label">操作员职位&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" name="operator.position" placeholder="操作员职位" value="<s:property value="operator.position"/>"/>
                            </div>
                        </div>
                         -->
                        <div class="form-group">
                            <div class="col-lg-8 col-lg-offset-4">
                                <button type="submit" class="btn btn-blue" id="submitBtn">确定</button>
                                <button type="button" class="btn btn-default" onclick="loadPage('operator_toList.action')">返回</button>
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
        $("#shop").hide();
        initRoleList();

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
                },"operator.mobile": {
                    validators: {
                        stringCNLength:{
                            min:11,
                            max:11,
                            message:"长度11个字符"
                        },
                        integer: {
                            message:"必须是数字"
                        }
                    }
                },"operator.account": {
                    validators: {
                        stringCNLength:{
                            min:6,
                            max:16,
                            message:"帐号必须大于6个字符，小于16个字符"
                        }
                    }
                },"operator.password": {
                    validators: {
                        stringCNLength:{
                            min:6,
                            max:16,
                            message:"密码必须大于6个字符，小于16个字符"
                        }
                    }
                },"operator.email": {
                    validators: {
                        stringCNLength:{
                            min:1,
                            max:50,
                            message:"最大长度50个字符"
                        }
                    }
                },
                "operator.code": {
                    validators: {
                        stringCNLength:{
                            min:0,
                            max:20,
                            message:"最大长度20个字符"
                        }
                    }
                },
                "operator.position": {
                    validators: {
                        stringCNLength:{
                            min:0,
                            max:30,
                            message:"最大长度30个字符"
                        }
                    }
                }
            },
            submitHandler:function(form){
                var checkText=$("#roleno").find("option:selected").text(); 
                if(checkText=="商户管理员"){
                }else{
                    $("#shopname").val("");
                    $("#shopid").val("");
                }
                ajaxPostRequest('operator_add.action', 'fo', function callback(result){
                	if (result && result.status == '1') {
                    	loadPage('operator_toList.action');
        			}
                });
            }
        });
    });
    /**
     * 初始化角色下拉列表
     */
    function initRoleList(){
        $("#roleno").empty();

        ajaxRequest("operator_loadRoleList.action", {}, function(roleList){
            var str="<option value=''>请选择操作员所属角色</option>";
            if(roleList){
                $.each(roleList, function(key, role) {
                    str = str + "<option value='" + role.roleno + "'>" + role.rolename + "</option>";
                });
            }
            $("#roleno").append(str);
        });
    }
    
    function chooseroleno(){
        var checkText=$("#roleno").find("option:selected").text(); 
        if(checkText=="商户管理员"){
            $("#shop").show();
        }else{
            $("#shop").hide();
            $("#shop_name").val("");
            $("#shop_id").val("");
        }
    }
    function popupShop(){
        popup('获取商铺信息', popupShopUrl, 700, 480, 'chooseShop',true);
    }
    function shopHook(shop){
        if(shop.id){
            var _changeEvent = $("#fo").data("bootstrapValidator")._changeEvent;
            $('#shopid').val(shop.id).trigger(_changeEvent);
            $('#shopname').val(shop.name).trigger(_changeEvent);
        }
    }
</script>
