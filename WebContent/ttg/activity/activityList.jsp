<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ism" uri="http://www.baseproj.org/rd/html"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>后台管理</li>
        <li class="active">活动管理</li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget">
                <div class="widget-header bordered-bottom bordered-yellow">
                    <span class="widget-caption">活动列表</span>
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
                            <form id="fo" method="post" action="activity_toList.action">
                                <label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user darkorange"></i></span>
                                        <input type="text" name="dto.name" value="<s:property value="dto.name"/>" class="form-control input-sm" placeholder="活动名称">
                                    </div>
                                </label>
                                <label><a class="btn btn-blue input-sm" href="javascript:void(0);" onclick="queryAsyncByPage(1);" id="submitBtn">查询</a></label>
                               <!-- 
                                <ism:right url="activity_toAdd">
                                    <label><a class="btn btn-success input-sm" href="javascript:void(0);" onclick="loadPage('activity_toAdd.action');">新增</a></label>
                                </ism:right>
                                -->
                            </form>
                        </div>
                        <table class="table table-bordered table-hover table-striped dataTable no-footer" id="searchable">
                            <thead class="bordered-darkorange">
                            <tr>
                                <th style="width: 100px;">活动名称</th>
                                <th style="width: 100px;">坐标(X轴,Y轴)</th>
                                <th style="width: 100px;">开始日期</th>
                                <th style="width: 100px;">结束日期</th>
                                <th style="width: 100px;">灵敏度</th>
                                <th style="width: 100px;">用户可见度</th>
                                <th style="width: 100px;">单个兔子奖励积分</th>
                                <th style="width: 100px;">刷新周期</th>
                                <th style="width: 150px;"><s:text name="common.button.operate" /></th>
                            </tr>
                            </thead>
                            <tbody>
                            <s:iterator value="dataList" status="status">
                                <tr class="<s:if test="status.odd">odd</s:if><s:else>even</s:else>" title="<s:property value='paramdesc' />">
                                    <td><s:property value="name"/></td>
                                    <td><s:property value="x"/>,<s:property value="y"/></td>
                                    <td><s:property value="startDate"/></td>
                                    <td><s:property value="endDate"/></td>
                                    <td><s:property value="sensitivity"/></td>
                                    <td><s:property value="jl"/> 米</td>
                                    <td><s:property value="integral"/></td>
                                    <td><s:property value="refreshTime"/> 分钟</td>
                                    <td>
                                    	<ism:right url="activity_toDetail">
	                                        <a href="javascript:void(0);" onclick="loadPage('activity_toDetail.action?dto.id=<s:property value="id"/>');"
	                                            title="详情" class="btn btn-info btn-xs edit"><i class="fa fa-folder-o"></i> 详情</a>
                                        </ism:right>
                                        <ism:right url="activity_toEdit">
                                            <a href="javascript:void(0);" onclick="loadPage('activity_toEdit.action?dto.id=<s:property value="id"/>');"
                                               title='修改' class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> 修改</a>
                                        </ism:right>
                                        <ism:right url="activity_toSetRabbit">
                                            <a href="javascript:void(0);" onclick="setRabbit('<s:property value="id"/>');"
                                               title='设置兔子' class="btn btn-info btn-xs"><i class="fa fa-cutlery"></i> 设置兔子</a>
                                        </ism:right>
                                        <!-- 
                                        <ism:right url="activity_del">
                                            <a href="javascript:void(0);" onclick="del('<s:property value="id"/>');"
                                               title='删除' class="btn btn-info btn-xs del"><i class="fa fa-times"></i> 删除</a>
                                        </ism:right>
                                         -->
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
    
    function setRabbit(id){
        popup('设置兔子', '${pageContext.request.contextPath}/activity_toSetRabbitMap.action?dto.id='+id, document.body.scrollWidth , document.body.scrollHeight , 'chooseSetRabbit',true);
    }
    
    function refreshSetRabbit(id){
    	top["openerstack"].pop();
			top.artDialog({
				id : 'chooseSetRabbit'
			}).close();
		setRabbit(id);
    }
</script>