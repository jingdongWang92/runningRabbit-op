<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ism" uri="http://www.baseproj.org/rd/html"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>后台管理</li>
        <li class="active">广告管理</li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget">
                <div class="widget-header bordered-bottom bordered-yellow">
                    <span class="widget-caption">广告列表</span>
                    <div class="widget-buttons">
                        <a href="#" data-toggle="maximize">
                            <i class="fa fa-expand"></i>
                        </a>
                        <a href="#" data-toggle="collapse">
                            <i class="fa fa-minus"></i>
                        </a>
                    </div>
                </div>
                <div class="widget-body no-padding">
                    <div id="searchable_wrapper" class="dataTables_wrapper form-inline no-footer">
                        <div id="searchable_filter" class="dataTables_filter">
                            <form id="fo" method="post" action="leaflet_toList.action">
                                <label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user darkorange"></i></span>
                                        <input type="text" name="dto.name" value="<s:property value="dto.name"/>" class="form-control input-sm" placeholder="广告名称">
                                    </div>
                                </label>
                                <label><a class="btn btn-blue input-sm" href="javascript:void(0);" onclick="queryAsyncByPage(1);" id="submitBtn">查询</a></label>
                                <ism:right url="leaflet_toAdd">
                                    <label><a class="btn btn-success input-sm" href="javascript:void(0);" onclick="loadPage('leaflet_toAdd.action');">新增</a></label>
                                </ism:right>
                            </form>
                        </div>
                        <table class="table table-bordered table-hover table-striped dataTable no-footer" id="searchable">
                            <thead class="bordered-darkorange">
                            <tr>
                                <th style="width: 100px;">广告名称</th>
                                <th style="width: 100px;">广告图片</th>
                                <th style="width: 100px;">连接地址</th>
                                <th style="width: 100px;">开始日期</th>
                                <th style="width: 100px;">结束日期</th>
                                <th style="width: 150px;"><s:text name="common.button.operate" /></th>
                            </tr>
                            </thead>
                            <tbody>
                            <s:iterator value="dataList" status="status">
                                <tr class="<s:if test="status.odd">odd</s:if><s:else>even</s:else>" title="<s:property value='paramdesc' />">
                                    <td><s:property value="name"/></td>
                                    <td><img width="54px" height="86px" src="${fileHttpUrl}/<s:property value="pic"/>" /></td>
                                    <td title="<s:property value="skipUrl"/>"><s:property value="skipUrlFormat"/></td>
                                    <td><s:property value="startDate"/></td>
                                    <td><s:property value="endDate"/></td>
                                    <td>
                                    	<ism:right url="leaflet_toDetail">
	                                        <a href="javascript:void(0);" onclick="loadPage('leaflet_toDetail.action?dto.id=<s:property value="id"/>');"
	                                            title="详情" class="btn btn-info btn-xs edit"><i class="fa fa-folder-o"></i> 详情</a>
                                        </ism:right>
                                        <ism:right url="leaflet_toEdit">
                                            <a href="javascript:void(0);" onclick="loadPage('leaflet_toEdit.action?dto.id=<s:property value="id"/>');"
                                               title='修改' class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> 修改</a>
                                        </ism:right>
                                        <ism:right url="leaflet_del">
                                            <a href="javascript:void(0);" onclick="del('<s:property value="id"/>');"
                                               title='删除' class="btn btn-info btn-xs del"><i class="fa fa-times"></i> 删除</a>
                                        </ism:right>
                                    </td>
                                </tr>
                            </s:iterator>
                            </tbody>
                        </table>
                        <!-- 分页信息 -->
                        <jsp:include page="/common/jsp/page.jsp"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
    	
    });

    function del(id){
        bootbox.confirm('确认删除奖券吗？', function (result) {
            if (result) {
                ajaxRequest("leaflet_del.action", {"dto.id":id}, function(result){
                    if(result.status == '1'){
                        Notify(result.message, 'bottom-right', '5000', 'success', 'fa-check', true);
                        queryAsyncByPage(1);
                    }else{
                        Notify(result.message, 'bottom-right', '5000', 'danger', 'fa-bolt', true);
                    }
                });
            }
        });
    }
</script>