<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
                <div class="page-breadcrumbs">
                    <ul class="breadcrumb">
                        <li><i class="fa fa-home"></i>首页</li>
                        <li>系统管理</li>
                        <li>全局参数管理</li>
                        <li class="active">修改全局参数</li>
                    </ul>
                </div>
                <!-- /Page Breadcrumb -->
                <!-- Page Body -->
                <div class="page-body">
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="widget radius-bordered">
                                <div class="widget-header">
                                    <span class="widget-caption">参数基本信息</span>
                                </div>
                                <div class="widget-body">
                                    <form id="fo" method="post" class="form-horizontal"
                                          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                                          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                                          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                                        <input type="hidden" value="<s:property value="sysCfgParam.id"/>" name="sysCfgParam.id"/>
                                        <input type="hidden" value="<s:property value="sysCfgParam.paramcode"/>" name="sysCfgParam.paramcode"/>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label">参数名称<span style="color:red;">&nbsp;&nbsp;*</span></label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" name="sysCfgParam.paramname" placeholder="参数名称" value="<s:property value="sysCfgParam.paramname"/>"
                                                       required data-bv-notempty-message="参数名称为必填项"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label">参数代码</label>
                                            <div class="col-lg-8"><s:property value="sysCfgParam.paramcode"/></div>
                                        </div>
                                        <div class="form-group has-feedback">
                                            <label class="col-lg-4 control-label">参数类型<span style="color:red;">&nbsp;&nbsp;*</span></label>
                                            <div class="col-lg-8">
                                           		<s:select id="paramTypeSelect" cssClass="form-control" list="@baseproj.common.constants.EnumUtil@getValues(@com.xiaoguo.jc.common.enums.SysCfgEnum$Type@values(),false)"
                              						name="sysCfgParam.paramtype" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label">参数值<span style="color:red;">&nbsp;&nbsp;*</span></label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" name="sysCfgParam.paramvalue" placeholder="参数值" value="<s:property value="sysCfgParam.paramvalue"/>"
                                                       required data-bv-notempty-message="参数值为必填项"/>
                                            </div>
                                        </div>
                                        <div class="form-group" id="min">
                                            <label class="col-lg-4 control-label">最小值(数字)</label>
                                            <div class="col-lg-8">
                                                <input type="number" class="form-control" name="sysCfgParam.min" placeholder="最小值(数字)"
                                                data-bv-message="最小值必须为整数" value="<s:property value="sysCfgParam.min"/>"/>
                                            </div>
                                        </div>
                                        <div class="form-group" id="max">
                                            <label class="col-lg-4 control-label">最大值(数字)</label>
                                            <div class="col-lg-8">
                                                <input type="number" class="form-control" name="sysCfgParam.max" placeholder="最大值(数字)" 
                                                data-bv-message="最大值必须为整数" value="<s:property value="sysCfgParam.max"/>"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label">参数描述</label>
                                            <div class="col-lg-8">
                                            	<textarea class="form-control" name="sysCfgParam.paramdesc" rows="3" cols="" placeholder="参数描述" maxlength="1024"><s:property value="sysCfgParam.paramdesc"/></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-8 col-lg-offset-4">
                                                <button type="button" class="btn btn-blue" id="submitBtn">确定</button>
                                                <button type="button" class="btn btn-default" onclick="loadPage('globalSet_toList.action')">返回</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
    <script type="text/javascript">
    	var type = '<s:property value="@com.xiaoguo.jc.common.enums.SysCfgEnum$Type@String.getCode()"/>';
    	$(function(){
    	    $('#fo').bootstrapValidator().find('#submitBtn').on('click',function(e){
    	        e.preventDefault();
    	        var _this = this;
    	        $(_this).prop("disabled",true);
                var url = 'globalSet_edit.action';
                ajaxPostRequest(url);
    	    });
    	    setMaxMinStatus();
    	    $("#paramTypeSelect").change(setMaxMinStatus);
    	});
    	//最大值最小值状态
    	function setMaxMinStatus(){
    	    if(type == $("#paramTypeSelect").val()){
	            $("#min").hide();
	            $("#max").hide();
	        }else{
	            $("#min").show();
	            $("#max").show();
	        }
    	}
    </script>
