<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
	<ul class="breadcrumb">
		<li><i class="fa fa-home"></i>首页</li>
		<li>后台管理</li>
		<li>广告管理</li>
		<li class="active">新增广告</li>
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
						<div class="widget-main ">
							<div class="tab-content tabs-flat">
								<div id="home11" class="tab-pane in active">
									<div class="form-group">
										<label class="col-lg-4 control-label">广告名称<span
											style="color: red;">&nbsp;&nbsp;*</span></label>
										<div class="col-lg-8">
											<input type="text" id="name" class="form-control"
												name="dto.name" placeholder="广告名称"
												value="<s:property value="dto.name"/>" required
												data-bv-notempty-message="广告名称为必填项" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">链接地址<span
											style="color: red;">&nbsp;&nbsp;*</span></label>
										<div class="col-lg-8">
											<input type="text" id="skipUrl" class="form-control"
												name="dto.skipUrl" placeholder="链接地址"
												value="<s:property value="dto.skipUrl"/>" required
												data-bv-notempty-message="链接地址为必填项" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">广告图片<!-- <span
											style="color: red;">&nbsp;&nbsp;*比例（4：3）</span> --></label>
										<div class="col-lg-8">
											<input id="uploadLogo" type="file" class="file-loading"
												accept="image/*">
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">广告描述<span
											style="color: red;">&nbsp;&nbsp;*</span></label>
										<div class="col-lg-8">
											<textarea class="form-control" id="remarks" name="dto.remarks" rows="5" cols="20" maxlength="1024"><s:property value="dto.remarks"/></textarea>
											
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-4 control-label">广告有效期<span
											style="color: red;">&nbsp;&nbsp;*</span></label>
										<div class="col-lg-8">
											<input readonly="readonly" type="text" name="time" value="<s:property value="time"/>"
                                                                 class="form-control" id="reservation" placeholder="日期范围"/>
										</div>
									</div>
									
								</div>
							</div>
						</div>
						<div class="form-horizontal">
							<div class="form-group">
								<div class="col-lg-8 col-lg-offset-4">
									<button type="button" class="btn btn-blue" id="submitBtn">确定</button>
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
		$('#reservation').daterangepicker({},function(start, end, label){
            $("#starttime").val(start.format("YYYY-MM-DD 00:00:00"));
            $("#endtime").val(end.format("YYYY-MM-DD 23:59:59"));
        });
		var imgPrefix = "${fileHttpUrl}";
		var fileinput = $("#uploadLogo").fileinput({
			uploadUrl : "leaflet_uploadLeaflet.action",
			type : 'POST',
			cache : false,
			autoReplace : true,
			minFileCount : 1,
			maxFileCount : 1,
			language : "zh",
			minImageWidth : 50,
			minImageHeight : 50,
			maxFileSize : 4 * 1024,
			enctype : 'multipart/form-data',
			uploadExtraData : function(previewId, index) {
				return {
					'dto.name' : $("#name").val(),
					'dto.skipUrl' : $("#skipUrl").val(),
					'dto.remarks' : $("#remarks").val(),
					'time' : $("#reservation").val()
				}
			},
			allowedFileExtensions : [ "jpeg", "jpg", "png", "gif" ]
		});

		$("#fo").bootstrapValidator({
			fields : {
				"dto.name" : {
					validators : {
						stringCNLength : {
							min : 1,
							max : 16,
							message : '长度不能超过16个字节的长度'
						}
					}
				},
				"dto.skipUrl" : {
					validators : {
						stringCNLength : {
							min : 1,
							max : 512,
							message : '链接地址为必填项！格式为:  http://www.baidu.com/'
						}
					}
				},
				"time" : {
					validators : {
						stringCNLength : {
							min : 2,
							max : 64,
							message : '有效期为必填项！'
						}
					}
				}
			},
			submitHandler : function(validator, form, submitButton) {
			}
		});

		$("#submitBtn").on("click", function() {
			$("#fo").submit();
			$(".fileinput-upload-button").click();
		});

		$('#uploadLogo').on('fileuploaded',
						function(event, data, previewId, index) {
							var form = data.form, files = data.files, extra = data.extra, response = data.response, reader = data.reader;
							if (response.error == "") {
								loadPage('leaflet_toList.action');
								Notify('上传成功！', 'bottom-right', '5000',
										'success', 'fa-check', true);
							}
						});

		$('#uploadLogo').on('filepreupload',
				function(event, data, previewId, index) {
					var valid = $("#fo").data("bootstrapValidator").isValid();

					if (!valid) {
						var jqXHR = data.jqXHR;
						jqXHR.abort();
						$(".fileinput-cancel-button").click();
					} else {
					}
				});

		$('#uploadLogo').on('fileselect',
				function(event, data, previewId, index) {
					$(".file-footer-buttons").find("button").eq(0).hide();
					$(".fileinput-upload-button").hide();
				});

		//移除图片
		$(".page-body").on(
				"click",
				".kv-file-remove",
				function() {
					var _self = $(this);
					var id = $(this).attr("id");
					var fileName = $(this).attr("fileName");
					var url = "leaflet_delImage.action";

					$.ajax({
						type : "POST",
						url : url,
						async : false,
						cache : false,
						data : {
							"dto.id" : id,
							"dto.filename" : filename
						},
						dataType : 'json',
						success : function(result) {
							if (result.status == '1') {
								_self.parent().parent().parent().parent()
										.remove();
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
</script>
