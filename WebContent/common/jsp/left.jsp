<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="page-sidebar" id="sidebar">
	<!-- Page Sidebar Header-->
    <div class="sidebar-header-wrapper">
        <a class="searchinput"></a>
        <i class="searchicon"></i>
        <div class="searchhelper"></div>
    </div>
    <!-- /Page Sidebar Header -->
	<ul class="nav sidebar-menu">
		<li class="active">
		    <a href="index.action">
		        <i class="menu-icon glyphicon glyphicon-home"></i>
		        <span class="menu-text"> 平台首页  </span>
		    </a>
		</li>
		<s:iterator value="#session.menuGroups" status="stat" var="groups" > 
			<li>
		        <a href="javascript:void(0);" class="menu-dropdown">
		            <i class="menu-icon <s:property value="iconClass"/>"></i>
		            <span class="menu-text"> <s:property value="name"/></span>
		            <i class="menu-expand"></i>
		        </a>
		        <ul class="submenu">
					<s:iterator value="childgroup" var="childs">
		            	<s:if test="url != null">
		                    <li>
		                        <a href="javascript:void(0);" ahref="<s:property value="url"/>">
		                            <span class="menu-text"><s:property value="name"/></span>
		                        </a>
		                    </li>
		                </s:if>
		                <s:else>
		                	<li>
		                      	<a href="javascript:void(0);" class="menu-dropdown">
		                            <span class="menu-text"><s:property value="name"/></span>
		                            <i class="menu-expand"></i>
		                        </a>
		                        <ul class="submenu">
		                        	<s:iterator value="items">
		                                <li>
		                                    <a href="javascript:void(0);" ahref="<s:property value="url"/>">
		                                        <i class="menu-icon <s:property value="image"/>"></i>
		                                        <span class="menu-text"><s:property value="name"/></span>
		                                    </a>
		                                </li>
		                            </s:iterator>
		                        </ul>
		                    </li>
		                </s:else>
		        	</s:iterator>
		        </ul>
		    </li>
		</s:iterator>
	</ul>
</div>