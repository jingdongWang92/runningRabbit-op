<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
	<ul class="breadcrumb">
		<li><i class="fa fa-home"></i>首页</li>
		<li>系统管理</li>
		<li>角色管理</li>
		<li class="active">新增角色信息</li>
	</ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
	<form id="fo" method="post" class="form-horizontal"
		  data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
		  data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
		  data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
		<div class="row">
			<div class="col-xs-12 col-md-12">
				<div class="widget radius-bordered">
					<div class="widget-header">
						<span class="widget-caption">角色基本信息</span>
					</div>
					<div class="widget-body">
						<div class="form-group">
							<label class="col-lg-4 control-label">角色名称<span style="color:red;">&nbsp;&nbsp;*</span></label>
							<div class="col-lg-8"><input type="text" name="role.rolename" class="form-control" required data-bv-notempty-message="角色名称为必填项"
														 value="<s:property value="role.rolename"/>" placeholder="角色名称"/></div>
						</div>
						<div class="form-group has-feedback">
                            <label class="col-lg-4 control-label">数据范围<span style="color:red;">&nbsp;&nbsp;*</span></label>
                            <div class="col-lg-8">
                           		<s:select cssClass="form-control" list="@baseproj.common.constants.EnumUtil@getValues(@com.xiaoguo.jc.common.enums.RoleEnum$RoleType@values(),false)"
              						name="role.roletype" />
                            </div>
                        </div>
						<div class="form-group">
							<label class="col-lg-4 control-label">角色描述&nbsp;&nbsp;&nbsp;&nbsp;</label>
							<div class="col-lg-8">
								<textarea rows="" cols="" maxlength="200" placeholder="角色描述" class="form-control" name="role.roledesc"><s:property value="role.roledesc"/></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-md-12">
				<div class="widget radius-bordered">
					<div class="widget-header">
						<span class="widget-caption">角色权限信息<span style="color:red;">&nbsp;&nbsp;*</span></span>
					</div>
					<div class="widget-body">
						<div class="form-horizontal">
							<s:iterator value="role.groupList" status="idx">
								<span class="widget-caption"><s:property value="privgroupname" /></span>
								<s:iterator value="privList" status="idx1">
									<div class="row" id="<s:property value='#idx.index'/>_<s:property value='#idx1.index'/>">
										<div class="col-lg-4 col-sm-4 col-xs-4" style="width: 18.33%;">
											<div class="checkbox">
												<label>
													<%--
													<input type="checkbox" id="mainCheckbox_<s:property value='#idx.index'/>_<s:property value='#idx1.index'/>"
														   class="mainCheckbox" value="<s:property value='#idx.index'/>_<s:property value='#idx1.index'/>">
													<span class="text"><s:property value="privname" /></span>
													 --%>
													<input type="checkbox" class="checkbox <s:property value='#idx.index'/>_<s:property value='#idx1.index'/>"
														   onclick="isAll(this,'<s:property value='#idx.index'/>_<s:property value='#idx1.index'/>')"
														   name="role.opernoList" value="<s:property value="operno" />">
													<span class="text"><s:property value="privname" /></span>
												</label>
											</div>
										</div>
										<%--
										<s:iterator value="operList" status="idx2">
											<div class="col-lg-4 col-sm-4 col-xs-4" style="width: 13.33%;">
												<div class="checkbox">
													<label>
														<input type="checkbox" class="checkbox <s:property value='#idx.index'/>_<s:property value='#idx1.index'/>"
															   onclick="isAll(this,'<s:property value='#idx.index'/>_<s:property value='#idx1.index'/>')"
															   name="role.opernoList" value="<s:property value="operno" />">
														<span class="text"><s:property value="opername" /></span>
													</label>
												</div>
											</div>
										</s:iterator>
										 --%>
									</div>
								</s:iterator>
							</s:iterator>
						</div>
						<div class="form-group" style="margin-top:30px;">
							<div class="col-lg-8 col-lg-offset-4">
								<button type="submit" class="btn btn-blue" id="submitBtn">确定</button>
								<button type="button" class="btn btn-default" onclick="loadPage('role_toList.action')">返回</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<script type="text/javascript">
	$(function(){
		$(".mainCheckbox").click(function(){
			var id = $(this).val();
			$(".checkbox ." + id).prop("checked",this.checked);
		});

		//校验提交操作
		$('#fo').bootstrapValidator({
			fields: {
	            "role.rolename": {
                    validators: {
                        stringCNLength: {
                            min:0,
                            max:20,
                            message: '角色名称长度不能超过20个字符'
                        }
                    }
	        	}
	        },
			submitHandler:function(form){
				if($("input[type='checkbox']:checked").length <= 0){
					$("#submitBtn").prop("disabled",false);
					Notify('请先选择角色所属权限', 'bottom-right', '5000', 'danger','fa-bolt', true);
					return false;
				}
				ajaxPostRequest('role_add.action', 'fo', function callback(result){
                	if (result && result.status == '1') {
                    	loadPage('role_toList.action');
        			}
                });
			}
		});

		$(".form-control-feedback").remove();
	});
	//是否选择
	function isAll(_this,index){
		var size = $(".checkbox ." + index).length;
		var le = 0;
		$(".checkbox ." + index).each(function(){
			if(!$(this).prop("checked")){
				le++;
			}
		});
		if(size == le){
			$("#mainCheckbox_" + index).prop("checked","");
		}else{
			$("#mainCheckbox_" + index).prop("checked","checked");
		}
	}
</script>
