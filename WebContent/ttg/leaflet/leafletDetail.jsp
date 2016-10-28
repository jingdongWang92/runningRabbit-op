<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
	<ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>后台管理</li>
        <li>广告管理</li>
        <li class="active">广告详情</li>
	</ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
	<div class="row">
		<div class="col-xs-12 col-md-12">
			<div class="widget radius-bordered">
				<div class="widget-header">
					<span class="widget-caption">广告信息</span>
				</div>
				<div class="widget-body">
					<form id="fo" method="post" class="form-horizontal"
						data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
						data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
						data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
						<input type="hidden" id="id" name="dto.id"
							value="<s:property value="dto.id"/>" />
						<div class="widget-main ">
							<div class="tab-content tabs-flat">
								<div id="home11" class="tab-pane in active">
									<div class="form-group">
										<label class="col-lg-4 control-label">广告名称<span
											style="color: red;">&nbsp;&nbsp;*</span></label>
										<div class="col-lg-8">
											<input readonly="readonly" type="text" id="name" class="form-control"
												name="dto.name" placeholder="广告名称"
												value="<s:property value="dto.name"/>" required
												data-bv-notempty-message="广告名称为必填项" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">链接地址<span
											style="color: red;">&nbsp;&nbsp;*</span></label>
										<div class="col-lg-8">
											<input readonly="readonly" type="text" id="skipUrl" class="form-control"
												name="dto.skipUrl" placeholder="链接地址"
												value="<s:property value="dto.skipUrl"/>" required
												data-bv-notempty-message="链接地址为必填项" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">广告图片<!-- <span
											style="color: red;">&nbsp;&nbsp;*比例（4：3）</span> --></label>
											<img  width="84px" height="156px" src="${fileHttpUrl}/<s:property value="dto.pic"/>" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">广告描述<span
											style="color: red;">&nbsp;&nbsp;*</span></label>
										<div class="col-lg-8">
											<textarea  readonly="readonly" class="form-control" id="remarks" name="dto.remarks" rows="5" cols="20" maxlength="1024"><s:property value="dto.remarks"/></textarea>
											
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">广告有效期<span
											style="color: red;">&nbsp;&nbsp;*</span></label>
										<div class="col-lg-8">
											<input  readonly="readonly" type="text" name="time" value="<s:property value="time"/>"
                                                                 class="form-control" id="reservation" placeholder="日期范围"/>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-horizontal">
							<div class="form-group">
								<div class="col-lg-8 col-lg-offset-4">
									<button type="button" class="btn btn-default"
										onclick="loadPage('leaflet_toList.action')">返回</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function() {
		
	});
</script>
