<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="logo_title">
  <div class="logo_img">
    <img src="${basePath}/img/main/male.jpg"/>
  </div>
  <p>${login_user.userName}&nbsp;你好!</p>
</div>
<ul class="verticalList">

  <li <c:if test="${indx == 1}">class="active"</c:if>>
    <span class="item_icon img1"/></span><span class="span1"><a href="${basePath}/central.htm">用户信息</a></span>
    <c:if test="${indx == 1}">
      <img src="${basePath}/img/admin/login/u561.png" class="arrow"/>
    </c:if>
  </li>
  <li <c:if test="${indx == 2}">class="active"</c:if>>
    <span class="item_icon img6"/></span><span class="span6"><a href="${basePath}/favourite.htm">我的收藏</a></span>
    <c:if test="${indx == 2}">
      <img src="${basePath}/img/admin/login/u561.png" class="arrow"/>
    </c:if>
  </li>
  <li <c:if test="${indx == 3}">class="active"</c:if>>
    <span class="item_icon img7"/></span><span class="span7"><a href="${basePath}/competition.htm">我的竞价</a></span>
    <c:if test="${indx == 3}">
    <img src="${basePath}/img/admin/login/u561.png" class="arrow"/>
    </c:if>
  </li>
 </ul>