<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ism" uri="http://www.baseproj.org/rd/html"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>后台管理</li>
        <li class="active">用户管理</li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget">
                <div class="widget-header bordered-bottom bordered-yellow">
                    <span class="widget-caption">用户列表</span>
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
                            <form id="fo" method="post" action="user_toList.action">
                                <label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user darkorange"></i></span>
                                        <input type="text" name="dto.account" value="<s:property value="dto.account"/>" class="form-control input-sm" placeholder="account">
                                    </div>
                                </label>
                                <label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user darkorange"></i></span>
                                        <input type="text" name="dto.nickname" value="<s:property value="dto.nickname"/>" class="form-control input-sm" placeholder="昵称">
                                    </div>
                                </label>
                                <label><a class="btn btn-blue input-sm" href="javascript:void(0);" onclick="queryAsyncByPage(1);" id="submitBtn">查询</a></label>
                            </form>
                        </div>
                        <table class="table table-bordered table-hover table-striped dataTable no-footer" id="searchable">
                            <thead class="bordered-darkorange">
                            <tr>
                                <th style="width: 100px;">account</th>
                                <th style="width: 100px;">昵称</th>
                                <th style="width: 100px;">头像</th>
                                <th style="width: 100px;">积分</th>
                                <th style="width: 100px;">app类型</th>
                                <th style="width: 100px;">注册时间</th>
                                <th style="width: 100px;">最后登陆时间</th>
                                <!-- <th style="width: 150px;"><s:text name="common.button.operate" /></th> -->
                            </tr>
                            </thead>
                            <tbody>
                            <s:iterator value="dataList" status="status">
                                <tr class="<s:if test="status.odd">odd</s:if><s:else>even</s:else>" title="<s:property value='paramdesc' />">
                                    <td><s:property value="account"/></td>
                                    <td><s:property value="nickname"/></td>
                                    <td><img width="50px" height="50px" src="<s:property value="headUrl"/>" /></td>
                                    <td><s:property value="integral"/></td>
                                    <td><s:property
												value="@baseproj.common.constants.EnumUtil@getNameByCode(@com.xiaoguo.jc.common.enums.CommonEnum$AppType@values(), appType)" /></td>
                                    <td><s:property value="regtime"/></td>
                                    <td><s:property value="recentLoginTime"/></td>
                                    	<!-- 
                                    <td>
                                    	<ism:right url="user_toDetail">
	                                        <a href="javascript:void(0);" onclick="loadPage('user_toDetail.action?dto.id=<s:property value="id"/>');"
	                                            title="详情" class="btn btn-info btn-xs edit"><i class="fa fa-folder-o"></i> 详情</a>
                                        </ism:right>
                                    </td>
                                    	 -->
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
</script>