<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:if test="dataList != null and dataList.size() > 0">
	<div class="row DTTTFooter">
		<div class="col-sm-6">
			<div class="dataTables_info">
				<s:text name="common.page.inall" />
		        <!-- 共 -->&nbsp;<s:property value="page.totalCount" />&nbsp;<s:text name="common.page.bperpage" />
		        <!-- 条 -->&nbsp;&nbsp;<s:text name="common.page.number" />
		        <!-- 第 -->&nbsp;<s:property value="page.currentPage" />/<s:property value="page.totalPage" />&nbsp;<s:text name="common.page.page" />
		        <!-- 页 -->&nbsp;
			</div>
		</div>
		<section id="main-content">
	        <div class="text-center" style="text-align: right;">
	            <ul id="pageInfo" class="pagination-sm"></ul>
	        </div>
	    </section>
	</div>
</s:if>
<s:else>
    <div style="color: red; text-align: center;margin-top:10px;text-align:center;">
        <s:text name="common.page.noInfo" />
    </div>
</s:else>
<script type="text/javascript">
	$(function(){
		var total = '<s:property value="page.totalPage"/>';
		var current = '<s:property value="page.currentPage"/>';
		var totalPage = total ? parseInt(total) : 0;
		var currentPage = current ? parseInt(current) : 0;
		var visiblePages = totalPage < 7 ? totalPage : 7;

		if(total > 0) {
			$('#pageInfo').twbsPagination({
				first : '首页',
				prev : '上一页',
				next : '下一页',
				last : '尾页',
				totalPages : totalPage,
				startPage : currentPage,
				visiblePages : visiblePages,
				onPageClick:function(event, page){
					queryAsyncByPage(page);
				}
			});
		}
	});
</script>