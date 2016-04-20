<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="logo_title">
  <p>${login_user}&nbsp;你好!</p>
</div>
<ul class="verticalList">
  <li class="active">
    <span class="item_icon img1"/></span><span class="span1"><a href="#">用户信息</a></span><img src="${basePath}/img/admin/login/u561.png" class="arrow"/>
  </li>
  <li class="active">
    <span class="item_icon img6"/></span><span class="span6"><a href="#">我的收藏</a></span><img src="${basePath}/img/admin/login/u561.png" class="arrow"/>
  </li>
  <li class="active">
    <span class="item_icon img7"/></span><span class="span7"><a href="#">我的竞价</a></span><img src="${basePath}/img/admin/login/u561.png" class="arrow"/>
  </li>
 </ul>