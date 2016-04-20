<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="top">
  <div class="min_width">
    <div class="top_menu"><a href="http://www.91mydoor.com/index.htm" class="top_menu_span"><span>个人中心</span></a></div>
    <div class="top_menu item_name">
      <span class="top_menu_span">mydooradmi</span>
      <div class="nav-popup">
        <ul class="verticalList">
          <li><a href="${basePath}/center.htm">管理中心</a></li>
          <li><a href="${basePath}/loginout.htm">退出</a></li>
        </ul>
      </div>
    </div>
    <div class="top_menu"><a href="http://www.91mydoor.com/index.htm" class="top_menu_span"><span>首页</span></a></div>

  </div>
</div>