<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>后台管理</li>
        <li>兔子管理</li>
        <li class="active">新增兔子</li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget radius-bordered">
                <div class="widget-header">
                    <span class="widget-caption">兔子基本信息</span>
                </div>
                <div class="widget-body">
                    <form id="fo" method="post" class="form-horizontal"
                          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                        <div class="form-group">
                            <label class="col-lg-4 control-label">坐标<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input readonly="readonly" type="text" class="form-control" required data-bv-notempty-message="坐标为必填项"
                                placeholder="点击获取坐标" id="xy" onclick="mapCoordinate();"/>
                                <input type="hidden" id="x" name="dto.x" value="<s:property value="dto.x"/>" />
                                <input type="hidden" id="y" name="dto.y" value="<s:property value="dto.y"/>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">uuid<span style="color:red;">&nbsp;&nbsp;</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="64" class="form-control" name="dto.uuid"
                                placeholder="uuid" value="<s:property value="dto.uuid"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">major<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="16" class="form-control" name="dto.major" required data-bv-notempty-message="major为必填项"
                                placeholder="major" value="<s:property value="dto.major"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label">minor<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                                <input type="text" maxlength="16" class="form-control" name="dto.minor" required data-bv-notempty-message="minor为必填项"
                                placeholder="minor" value="<s:property value="dto.minor"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-8 col-lg-offset-4">
                                <button type="submit" class="btn btn-blue" id="submitBtn">确定</button>
                                <button type="button" class="btn btn-default" onclick="loadPage('rabbit_toList.action')">返回</button>
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
                ajaxPostRequest('rabbit_add.action', 'fo', function callback(result){
                	if (result && result.status == '1') {
                    	loadPage('rabbit_toList.action');
        			}
                });
            }
        });
    });
    
    function mapCoordinate(){
    	popup('获取高德地图坐标', '<s:url value="popup_mapCoordinate.action"/>', 700, 480, 'chooseMapCoordinate',true);
    }
    
    function mapCoordinateHook(map){
        if(map){
        	$('#xy').val(map.x + ',' + map.y);
        	$('#x').val(map.x);
        	$('#y').val(map.y);
        }
    }
</script>
