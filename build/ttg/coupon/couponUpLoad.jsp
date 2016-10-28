<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>商户管理</li>
        <li class="active">奖券管理</li>
    </ul>
</div>
<!-- Page Body -->
<div class="page-body">
	<div class="row">
		<div class="col-xs-12 col-md-12">
			<div class="widget radius-bordered">
				<div class="widget-header">
					<span class="widget-caption">上传奖券图片</span>
				</div>
				<div class="widget-body">
					<div class="widget-main ">
						<div class="tabbable">
							<ul class="nav nav-tabs tabs-flat" id="myTab11">
								<li class="active"><a data-toggle="tab" href="#home11">奖券图片</a></li>
							</ul>
							<input type="hidden" id="dtoId" name="dto.id"
								value="<s:property value="dto.id"/>" />
							<div class="tab-content tabs-flat">
								<div id="home11" class="tab-pane in active">
									<input id="uploadStyle" type="file" class="file-loading"
										accept="image/*">
								</div>
							</div>
						</div>
					</div>
					<div class="form-horizontal">
						<div class="form-group">
							<div class="col-lg-8 col-lg-offset-4">
								<button type="button" class="btn btn-default"
									onclick="loadPage('coupon_toList.action')">返回</button>
							</div>
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
					<span class="widget-caption">展示奖券图片</span>
				</div>
				<div class="widget-body">
					<div class="widget-main ">
						<div class="tabbable">
							<ul class="nav nav-tabs tabs-flat" id="myTab11">
								<li class="active"><a data-toggle="tab" href="#home12">奖券图片</a></li>
							</ul>
							<div class="tab-content tabs-flat">
								<div id="home12" class="tab-pane in active">
									<div class="file-input has-error">
										<div class="file-preview">
											<div class=" file-drop-zone">
												<div class="file-preview-thumbnails">
													<s:iterator value='dto.styleList' id="url">
														<div class="file-preview-frame file-preview-error"
															id="preview" data-fileindex="0">
															<img src="${fileHttpUrl}/${url}"
																class="file-preview-image"
																title="${url}"
																alt="${url}"
																style="width: auto; height: 160px;">
															<div class="file-thumbnail-footer">
																<div class="file-footer-caption">${url}</div>
																<div class="file-actions">
																	<div class="file-footer-buttons">
																		<button imgType="风采照"
																			id="<s:property value="dto.id"/>"
																			fileName="${url}" type="button"
																			class="kv-file-remove btn btn-xs btn-default"
																			title="移除文件">
																			<i class="glyphicon glyphicon-trash text-danger"></i>
																		</button>
																	</div>
																	<div class="clearfix"></div>
																</div>
															</div>
														</div>
													</s:iterator>
												</div>
												<div class="clearfix"></div>
												<div class="file-preview-status text-center text-success"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="form-horizontal">
						<div class="form-group">
							<div class="col-lg-8 col-lg-offset-4">
								<button type="button" class="btn btn-default"
									onclick="loadPage('coupon_toList.action')">返回</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function() {
		$("#uploadStyle").fileinput({
			uploadUrl : "coupon_uploadStyle.action",
			type : 'POST',
			cache : false,
			autoReplace : true,
			minFileCount : 1,
			maxFileCount : 1,
			language : "zh",
			minImageWidth : 950,
			minImageHeight : 240,
			maxImageWidth : 970,
			maxImageHeight : 260,
			maxFileSize : 2 * 1024,
			enctype : 'multipart/form-data',
			textEncoding : 'UTF-8',
			uploadExtraData : {
				'dto.id' : $("#dtoId").val()
			},
			allowedFileExtensions : [ "jpeg", "jpg", "png", "gif" ]
		});
		//移除图片
		$(".page-body").on(
				"click",
				".kv-file-remove",
				function() {
					var _self = $(this);
					var id = $(this).attr("id");
					var fileName = $(this).attr("fileName");
					var type = $(this).attr("imgType");
					var url = "coupon_delImage.action";
					$.ajax({
						type : "POST",
						url : url,
						async : true,
						cache : false,
						data : {
							"dto.id" : id,
							"dto.filename" : fileName,
							"dto.imgType" : type
						},
						dataType : 'json',
						success : function(result) {
							if (result.status == '1') {
					        	loadPage('coupon_toUpload.action?dto.id=<s:property value="dto.id"/>');
								Notify(result.message, 'bottom-right', '5000',
										'success', 'fa-check', true);
							} else {
								Notify(result.message, 'bottom-right', '5000',
										'danger', 'fa-bolt', true);
							}
						},
						error : function() {
						}
					});
				});
		});
	    $('#uploadStyle').on('fileuploaded', function(event, data, previewId, index) {
	        var form = data.form, files = data.files, extra = data.extra,
	                response = data.response, reader = data.reader;
	        if(response.error == "") {
	        	loadPage('coupon_toUpload.action?dto.id=<s:property value="dto.id"/>');
				Notify('上传成功！', 'bottom-right', '5000', 'success', 'fa-check', true);
	        }
	    });
</script>