<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
	<div class="error-header"> </div>
    <div class="container ">
        <section class="error-container text-center">
            <h1>出错啦！${code }</h1>
            <div class="error-divider">
                <h2>${msg }</h2>
                <p class="description"></p>
            </div>
            <!-- 
            <a href="javascript:history.back();" class="return-btn"><i class="fa fa-home"></i>返回</a>
             -->
        </section>
    </div>
