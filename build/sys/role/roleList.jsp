<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ism" uri="http://www.baseproj.org/rd/html"%>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li><i class="fa fa-home"></i>首页</li>
        <li>系统管理</li>
        <li class="active">角色管理</li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<!-- Page Body -->
<div class="page-body">
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget">
                <div class="widget-header bordered-bottom bordered-yellow">
                    <span class="widget-caption">角色列表</span>
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
                            <form method="post" id="fo" onsubmit="return false" action="role_toList.action">
                                <label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user darkorange"></i></span>
                                        <input type="text" name="role.rolename" value="<s:property value="role.rolename"/>" class="form-control input-sm" placeholder="角色名称">
                                    </div>
                                </label>
                                <label><a class="btn btn-blue input-sm" href="javascript:void(0);" onclick="queryAsyncByPage(1);" id="submitBtn">查询</a></label>
                               	<ism:right url="role_toAdd">
                                	<label><a class="btn btn-success input-sm" href="javascript:void(0);" onclick="loadPage('role_toAdd.action');">新增</a></label>
                            	</ism:right>
                            </form>
                        </div>
                        <table class="table table-bordered table-hover table-striped dataTable no-footer" id="searchable">
                            <thead class="bordered-darkorange">
                            <tr>
                                <th style="width: 150px;"><s:text name="sys.role.name" /></th>
                                <th style="width: 190px;"><s:text name="common.lable.desc" /></th>
                                <th style="width: 100px;"><s:text name="common.button.operate" /></th>
                            </tr>
                            </thead>
                            <tbody>
                            <s:iterator value="dataList" status="status">
                                <tr class="<s:if test="status.odd">odd</s:if><s:else>even</s:else>" title="<s:property value='paramdesc' />">
                                    <td><s:property value="rolename" /></td>
                                    <td><s:property value="roledesc" /></td>
                                    <td class="alignCenter">
                                    	<ism:right url="role_toDetail">
	                                        <a href="javascript:void(0);" onclick="loadPage('role_toDetail.action?role.roleno=<s:property value="roleno"/>');"
	                                           title="详情" class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> 详情</a>
                                        </ism:right>
                                        <s:if test="roleno != 1">
                                            <s:if test="#session.Operator.operatorno == operatorno || #session.Operator.roleno != roleno">
                                                <ism:right url="role_toEdit">
                                                    <a href="javascript:void(0);" onclick="loadPage('role_toEdit.action?role.roleno=<s:property value="roleno"/>');"
                                                       title='修改' class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> 修改</a>
                                                </ism:right>
                                                <ism:right url="role_del">
                                                    <a href="javascript:void(0);" onclick="del('<s:property value="roleno"/>');"
                                                       title='删除' class="btn btn-danger btn-xs delete"><i class="fa fa-trash-o"></i> 删除</a>
                                                </ism:right>
                                            </s:if>
                                        </s:if>
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
    /**
     * 删除
     */
    function del(id){
        bootbox.confirm('<s:text name="common.page.del.prompt"/>', function (result) {
            if (result) {
                ajaxRequest("role_del.action", {"role.roleno":id}, function(result){
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
