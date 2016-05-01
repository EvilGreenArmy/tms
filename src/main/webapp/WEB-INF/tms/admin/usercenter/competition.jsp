<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>个人中心-我的竞价</title>
  <script src="${basePath}/js/main/jquery-1.11.1.min.js"></script>
  <style type="text/css">
    select {
      height: 25px
    }
  </style>
  <link rel="stylesheet" href="${basePath}/css/main/manage.css">
  <script src="${basePath}/js/main/jquery.form.js"></script>
  <script type="text/javascript">
    $(document).ready(function() {
      var url="${basePath}/competition/list.htm?t=" + Math.random();
      $.get(url,function(data){
        $("#divcontent").html('');
        $("#divcontent").html(data);
      });
    });
    function detail(id) {
      window.location.href = "${basePath}/product/detail.htm?id=" + id + "&t=" +Math.random();
    }
  </script>
</head>
<body>
<jsp:include page="../main/header.jsp" flush="true" />
<div class="content_div min_width">
  <div class="content_left">
    <jsp:include page="left.jsp" flush="true" />
  </div>
  <div class="content_right">
    <div class="content_right_header">
    </div>
    <div id="divcontent" class="content_right_content">

    </div>

  </div>
</div>
<div class="clear"></div>
</body>
</html>