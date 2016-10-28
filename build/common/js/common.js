var popStack = new Stack();
var Opener;
$(function() {
	try {
		Opener = top["openerstack"].get();
	} catch (Exception) {
		top["openerstack"] = popStack;
		Opener = top["openerstack"].get();
	}

	try {
		if (bootbox) {
			bootbox.setDefaults({
				"locale" : "zh_CN"
			});
		}
	} catch (Exception) {
	}

	$.ajaxSetup({
		beforeSend: function(){
			$("#mainFrame").html("<div class='loading-container'><div class='loading-progress'><div class='rotator'><div class='rotator'><div class='rotator colored'><div class='rotator'><div class='rotator colored'><div class='rotator colored'></div> <div class='rotator'></div></div><div class='rotator colored'></div></div><div class='rotator'></div></div><div class='rotator'></div></div><div class='rotator'></div></div><div class='rotator'></div></div></div>");
		}
	});
});

function Stack() {
	if (this.head == undefined) {
		// 初始化堆栈的顶部指针和数据存放域
		this.head = -1;
		this.unit = new Array();
	}

	this.push = function(pushvalue) {
		// 定义压入堆栈的方法
		this.unit[this.head] = pushvalue;
		this.head += 1;
	};

	this.pop = function() {
		// 定义弹出堆栈的方法
		if (this.head == -1) {
			return null;
		}
		var popTo = this.unit[this.head - 1];
		this.head--;
		return (popTo);
	};

	this.get = function() {
		if (this.head == -1) {
			return null;
		}
		var popTo = this.unit[this.head - 1];
		return (popTo);
	};
}
// 弹出窗口
function popup(title, url, w, h, id, lock) {
	try {
		top["openerstack"].push(self);
	} catch (Exception) {
		top["openerstack"] = popStack;
		top["openerstack"].push(self);
	}

	var hh = top.window.document.documentElement.clientHeight
			|| document.body.clientHeight;
	hh = hh - 45;
	if (hh < h) {
		h = hh;
	}
	if (lock == undefined) {
		lock = true;
	}
	top.artDialog.open(url, {
		id : id,
		title : title,
		width : w,
		height : h,
		padding : 0,
		lock : true
	});
}
// 关闭弹出窗口
function popdown(id) {
	top["openerstack"].pop();
	top.artDialog({
		id : id
	}).close();
}
function queryByPage(currentPage) {
	if (!$("#currentPage").val()) {
		$("form").append(
				'<input type="hidden" name="page.currentPage" value="'
						+ currentPage + '" id="currentPage"/>');
	} else {
		$("#currentPage").val(currentPage);
	}
	$("form").submit();
}

function queryAsyncByPage(currentPage, divId, formId) {
	var form;

	if(formId) {
		form = $("#" + formId);
	} else {
		form = $("form");
	}
	if (!$("#currentPage").val()) {
		form.append(
				'<input type="hidden" name="page.currentPage" value="'
				+ currentPage + '" id="currentPage"/>');
	} else {
		$("#currentPage").val(currentPage);
	}
	var url = form.attr("action");
	var data = form.serialize();

	if(!divId) {
		divId = "mainFrame";
	}
	loadPostCustomHtml(divId, url, data);
}
// 返回到指定的列表页面
function backToList(url) {
	top.location.href = url;
}

// 区域加载
function showLocation(province, city, town) {
	var loc = new Location();
	var title = [ '省份', '地级市', '市、县、区' ];
	//
	$.each(title, function(k, v) {
		title[k] = '<option value="">' + v + '</option>';
	});

	$('#loc_province').change(function() {
		$('#loc_city').empty();
		// $('#loc_city').append(title[1]);
		loc.fillOption('loc_city', $('#loc_province').val());
		if ($('#loc_province').val()) {
			$("#prorinceName").val($('#loc_province').select2('data').text);
		}
	});

	$('#loc_city').change(function() {
		$('#loc_town').empty();
		loc.fillOption('loc_town', $('#loc_city').val());
		if ($('#loc_city').val()) {
			$("#cityName").val($('#loc_city').select2('data').text);
		}
	});

	$('#loc_town').change(function() {
		if ($('#loc_town').val()) {
			$("#districtName").val($('#loc_town').select2('data').text);
		}
	});

	if (province) {
		loc.fillOption('loc_province', '0', province);

		if (city) {
			loc.fillOption('loc_city', province, city);

			if (town) {
				loc.fillOption('loc_town', city, town);
			}
		}
	} else {
		loc.fillOption('loc_province', '0', '110000');
	}
}

function loadProvince(selectId, provinceCode) {
	var el = null;
	if(selectId instanceof jQuery){
		el = selectId;
	}else{
		el = $('#' + selectId);
	}
	$.ajax({
		url : 'area_queryProvinceList.action',
		data : {},
		dataType : 'json',
		type : 'post',
		async : true,
		cache : false,
		beforeSend : null,
		success : function(result) {
			json = result;
			if (json) {
				el.append('<option value="">请选择省级区域</option>');
				$.each(json, function(k, v) {
					var option = '<option value="' + v.levelcode + '"';
					if (provinceCode && provinceCode == v.levelcode) {
						option += " selected";
					}
					option += '>' + v.areaname + '</option>';
					el.append(option);
				});
			}
		}
	});
}

function loadCity(selectId, provinceCode, cityCode) {
	var el = null;
	if(selectId instanceof jQuery){
		el = selectId;
	}else{
		el = $('#' + selectId);
	}
	if (provinceCode == '' || cityCode == '') {
		el.append('<option value="">请选择市级区域</option>');
		return;
	}
	var data = {};
	data["area.levelcode"] = provinceCode;
	data["area.type"] = 2;
	$.ajax({
		url : 'area_queryCityOrDistrictList.action',
		data : data,
		type : 'post',
		dataType : 'json',
		async : true,
		cache : false,
		beforeSend : null,
		success : function(result) {
			json = result;
			if (json) {
				el.append('<option value="">请选择市级区域</option>');
				$.each(json, function(k, v) {
					var option = '<option value="' + v.levelcode + '"';
					if (cityCode && cityCode == v.levelcode) {
						option += " selected";
					}
					option += '>' + v.areaname + '</option>';
					el.append(option);
				});
			}
		}
	});
}

function loadDistrict(selectId, cityCode, districtCode) {
	var el = null;
	if(selectId instanceof jQuery){
		el = selectId;
	}else{
		el = $('#' + selectId);
	}
	if (cityCode == '' || districtCode == '') {
		el.append('<option value="">请选择区县级区域</option>');
		return;
	}
	var data = {};
	data["area.levelcode"] = cityCode;
	data["area.type"] = 3;
	$.ajax({
		url : 'area_queryCityOrDistrictList.action',
		data : data,
		type : 'post',
		dataType : 'json',
		async : true,
		cache : false,
		beforeSend : null,
		success : function(result) {
			json = result;
			if (json) {
				el.append('<option value="">请选择区县级区域</option>');
				$.each(json, function(k, v) {
					var option = '<option value="' + v.levelcode + '"';
					if (districtCode && districtCode == v.levelcode) {
						option += " selected";
					}
					option += '>' + v.areaname + '</option>';
					el.append(option);
				});
			}
		}
	});
}

function ajaxRequest(url, data, callback) {
	$.ajax({
		type : "POST",
		url : url,
		async : true,
		cache : false,
		data : data,
		dataType : 'json',
		beforeSend : null,
		success : function(result) {
			if (result.status == 2) { // 会话失效
				top.location.href = "login_logout.action";
			}

			if (callback) {
				callback(result);
			}
		},
		error : function() {
			Notify('系统错误', 'bottom-right', '5000', 'danger',
					'fa-bolt', true);
		}
	});
}

function syncAjaxRequest(url, data, callback) {
	$.ajax({
		type : "POST",
		url : url,
		async : false,
		cache : false,
		data : data,
		dataType : 'json',
		beforeSend : null,
		success : function(result) {
			if (result.status == 2) { // 会话失效
				top.location.href = "login_logout.action";
			}

			if (callback) {
				callback(result);
			}
		},
		error : function() {
			Notify('系统错误', 'bottom-right', '5000', 'danger',
					'fa-bolt', true);
		}
	});
}

function ajaxPostRequest(url, formId, callback) {
	var fId = "fo";
	if (formId) {
		fId = formId;
	}
	$.ajax({
		type : "POST",
		url : url,
		async : true,
		cache : false,
		data : $('#' + fId).serialize(),
		dataType : 'json',
		beforeSend : null,
		success : function(result) {
			if (result && result.status == '1') {
				Notify(result.message, 'bottom-right', '5000', 'success',
						'fa-check', true);
			} else if (result && result.status == '0') {
				Notify(result.message, 'bottom-right', '5000', 'danger',
						'fa-bolt', true);
			} else {
				window.location.href = "login_logout.action";
			}
			$("button[type='submit']").prop("disabled", false);

			if (callback) {
				callback(result);
			}
		},
		error : function() {
			$("button[type='submit']").prop("disabled", false);
		}
	});
}

// 加载页面
function loadPostCustomHtml(divId, url, data, callback) {
	if (!data) {
		data = {};
	}
	$.ajax({
		type : "POST",
		url : url,
		async : true,
		cache : false,
		data : data,
		dataType : 'html',
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
		beforeSend : null,
		success : function(html) {
			try {
				var data = eval( "(" + html + ")" );
				if (data && data.status == "2")  {
					top.location.href = "login_logout.action";
				} else {
					$("#" + divId).html(html);
				}
			} catch(e) {
				$("#" + divId).html(html);
			}

			if (callback) {
				callback(html);
			}
		},
		error : function() {
			Notify("网络异常，请联系管理员", 'bottom-right', '5000', 'danger', 'fa-bolt',
					true);
		}
	});
}

// 加载页面
function loadCustomHtml(divId, url, data, callback) {
	if (!data) {
		data = {};
	}
	$.ajax({
		type : "GET",
		url : url,
		async : true,
		cache : false,
		data : data,
		dataType : 'html',
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
		success : function(html) {
			try {
				var data = eval( "(" + html + ")" );
				if (data && data.status == "2")  {
					top.location.href = "login_logout.action";
				} else {
					$("#" + divId).html(html);
				}
			} catch(e) {
				$("#" + divId).html(html);
			}

			if (callback) {
				callback(html);
			}
		},
		error : function() {
			Notify("网络异常，请联系管理员", 'bottom-right', '5000', 'danger', 'fa-bolt',
					true);
		}
	});
}

function loadUniversity(selectId, provinceCode, cityCode) {
	var el = $('#' + selectId);
	var data = {};
	data["studentDto.levelcode"] = provinceCode;
	$.ajax({
		url : 'student_queryUniversityList.action',
		data : data,
		type : 'post',
		dataType : 'json',
		async : true,
		success : function(result) {
			json = result;
			if (json) {
				el.append('<option value="">请选择学校</option>');
				$.each(json, function(k, v) {
					var option = '<option value="' + v.code + '"';
					if (cityCode && cityCode == v.code) {
						option += " selected";
					}
					option += '>' + v.name + '</option>';
					el.append(option);
				});
			}
		}
	});
}

function changeStatus(url, data, self) {
	if(self){
		self.prop("title", self.prop("checked") ? "已启用" : "已禁用");
	}

	$.ajax({
		url : url,
		type : "post",
		dataType : "json",
		cache : false,
		async : false,
		data : data,
		beforeSend : null,
		success : function(result) {
			if (result.status == '1') {
				Notify(result.message, 'bottom-right', '5000', 'success',
						'fa-check', true);
			} else {
				if(self){
					self.prop("checked", !self.prop("checked"));
				}
				Notify(result.message, 'bottom-right', '5000', 'danger',
						'fa-bolt', true);
			}
		},
		error : function(e) {
		}
	});
}

String.prototype.startWith=function(str){
	var reg=new RegExp("^"+str);
	return reg.test(this);
}

String.prototype.endWith=function(str){
	var reg=new RegExp(str+"$");
	return reg.test(this);
}


// 加载页面
function loadPage(url, divId, data, callback) {
	if (!divId) {
		divId = "mainFrame";
	}
	loadPostCustomHtml(divId, url, data, callback)
}