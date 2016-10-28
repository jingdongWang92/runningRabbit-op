<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="navbar">
	<div class="navbar-inner">
		<div class="navbar-container">
			<!-- Navbar Barnd -->
			<div class="navbar-header pull-left">
				<a href="index.action" class="navbar-brand" style="margin-top: 9px;">
					<strong>TWOTWO GO</strong>
				</a>
			</div>
			<!-- /Navbar Barnd -->

			<!-- Sidebar Collapse -->
			<div class="sidebar-collapse" id="sidebar-collapse">
				<i class="collapse-icon fa fa-bars"></i>
			</div>
			<!-- /Sidebar Collapse -->
			<!-- Account Area and Settings --->
			<div class="navbar-header pull-right">
				<div class="navbar-account">
					<ul class="account-area">
						<li><a class="login-area dropdown-toggle"
							data-toggle="dropdown">
								<section>
									<h2>
										<span class="profile"> <span> <s:property
													value="#session.Operator.enterprise.ename" /> - <s:property
													value="#session.Operator.depart.dname" /> - <s:property
													value="#session.Operator.operatorname" />
										</span>
										</span>
									</h2>
								</section>
						</a> <!--Login Area Dropdown-->
							<ul
								class="pull-right dropdown-menu dropdown-arrow dropdown-login-area">
								<!--Avatar Area-->
								<li class="edit"><s:if
										test="#session.Operator.shop_id !=null && #session.Operator.shop_id!=-1">
										<a href="javascript:myshopInfo();" class="pull-left">我的店铺详情</a>
									</s:if> <!--  <a href="javascript:setSelfPwd();" class="pull-right">设置个人密码</a> -->
								</li>
								<!--Theme Selector Area-->
								<li class="theme-area"></li>
								<!--/Theme Selector Area-->
								<li class="dropdown-footer"><a
									href="login_logout.action?operator.account=<s:property value="#session.Operator.account"/>">退出</a>
								</li>
							</ul> <!--/Login Area Dropdown--></li>
					</ul>
					<div class="setting">
						<a title="退出"
							href="login_logout.action?operator.account=<s:property value='#session.Operator.account'/>">
							<i class="icon" style="font-size: larger;">退出</i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--Basic Scripts-->
<script src="assets/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript">
    $(function() {
    });

    //修改个人信息
    function setSelfInfo() {
        loadCustomHtml("mainFrame", '${pageContext.request.contextPath}/index_toSelfInfo.action');
    }
    //修改个人密码
    function setSelfPwd() {
        loadCustomHtml("mainFrame", '${pageContext.request.contextPath}/index_toSelfPwd.action');
    }
    //我的店铺详情
    function myshopInfo() {
        loadCustomHtml("mainFrame", '${pageContext.request.contextPath}/index_toShopDetail.action?dto.id=<s:property value='#session.Operator.shop_id'/>');
    }

    
</script>