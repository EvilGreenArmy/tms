<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge">
  <meta name="applicable-device" content="pc,mobile">
  <title>科技成果追踪转换系统</title>
  <link rel="stylesheet" href="${basePath}/css/main/web-main.css">
  <script charset="utf-8" src="${basePath}/js/main/v.js"></script>
  <script src="${basePath}/js/main/jquery-1.11.1.min.js"></script>
  <script src="${basePath}/js/main/jquery.SuperSlide2.js" charset="utf-8" type="text/javascript"></script>
  <script src="${basePath}/js/main/item.js" type="text/javascript"></script>
  <script src="${basePath}/js/main/slide.js" type="text/javascript"></script>
  <script src="${basePath}/js/main/toastr.min.js"></script>
  <link rel="stylesheet" href="${basePath}/css/main/toastr.css">

  <script src="${basePath}/js/main/manhuatoTop.1.0.js"></script>
  <style type="text/css"></style>
  <link rel="stylesheet" href="${basePath}/css/main/bootstrap.css">
  <script src="${basePath}/js/main/bootstrap.min.js"></script>
  <script>
    function detail(id) {
    window.location.href = "${basePath}/product/detail.htm?id=" + id + "&t=" +Math.random();
    }
    function search() {
      var keyword = $("#searchword").val();
      if($.trim(keyword) != '' && 'undefined' != $.trim(keyword)) {
        window.location.href = "${basePath}/main.htm?keyword=" + keyword;
      }
    }
  </script>
</head>
<body><div id="totop" style="display: none;"></div>
<script src="${basePath}/js/main/mousetrap.min.js"></script>
<jsp:include page="header.jsp" flush="true" />
<div class="menu">
  <div class="min_width_menu">
    <div class="menu_search">
      <input class="menu_div_ipt mousetrap" type="text" id="searchword" value="${paramMap.name}">
      <div class="menu_div_search"><span class="menu_div_search_bt" onclick="search();">搜索</span></div>
    </div>
  </div>
</div>
<div class="content_div min_width">
  <p class="clear tools_p">
  </p>
  <div class="content_left">
    <ul class="verticalList teacher_list">
    <c:forEach var="obj" items="${page.resultList}">

      <li onclick="detail('${obj.id}');">
        <div style="position:relative">
          <div class="teacher_content">
            <div>
              <p class="title"><span class="teacher_name">${obj.name}</span>
                <%--<span class="tag">&nbsp;门道文化教育研究院&nbsp;</span>--%>
              </p>
              <p>联系人：${obj.linkman}</p>
              <p>通讯地址：${obj.addr}
              </p>
              <p>开始时间：<fmt:formatDate value="${obj.startDate}"  pattern="yyyy-MM-dd"/></p>
              <p class="button" style="position: relative;">结束时间：<fmt:formatDate value="${obj.endDate}"  pattern="yyyy-MM-dd"/>
            </div>
          </div>
        </div>
      </li>
    </c:forEach>
    </ul>
    <div class="page_number_div clear">
      <c:if test="${paramMap.name != null && paramMap.name ne ''}">
        <jsp:include page="../common/ajaxpager.jsp" flush="true" >
            <jsp:param name="url" value="${basePath}/main.htm?keyword=${paramMap.name}" />
        </jsp:include>
      </c:if>
    <c:if test="${paramMap.name == null || paramMap.name eq ''}">
      <jsp:include page="../common/ajaxpager.jsp" flush="true" >
        <jsp:param name="url" value="${basePath}/main.htm" />
      </jsp:include>
      </c:if>
    </div>
  </div>
</div>
<style>
  #floatTools img{border: 0 none; vertical-align:inherit;}
  .rides-cs {  font-size: 12px; position: fixed; top: 250px; right: 0px; _position: absolute; z-index: 1500; border-radius:6px 0px 0 6px;}
</style>
<div style="clear:both;"></div>
<div class="copyright">
    <span>
        Copyright © 2016 延安市科技局 &nbsp;&nbsp;&nbsp;&nbsp;陕ICP备88888888号
    </span>
</div>
<script src="${basePath}/js/main/jquery.cookie.js"></script>
</body></html>
