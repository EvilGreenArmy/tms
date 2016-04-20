<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>个人中心-用户信息</title>
  <script src="${cdn}/assets/js/jquery-1.11.1.min.js"></script>
  <style type="text/css">
    select {
      height: 25px
    }
  </style>
  [#include "course_css.html"]
  <script type="text/javascript" src="${cdn}/assets/plugs/nicevalidator/jquery.validator.js"></script>
  <script type="text/javascript" src="${cdn}/assets/plugs/nicevalidator/local/zh_CN.js"></script>
  <script type="text/javascript" src="${cdn}/assets/plugs/my97datepicker/WdatePicker.js"></script>
  <script charset="utf-8" src="${cdn}/assets/plugs/kindeditor/kindeditor-min.js"></script>
  <script type="text/javascript" src="${cdn}/assets/js/jquery.form.js"></script>
  <script type="text/javascript">
    $.ajaxSetup({cache:false});
    $(document).ready(function(){
      var url="${siteurl}/member/modifyuserinfopre.htm";
      showProcess();
      $.get(url,function(data){
        $("#divcontent").empty();
        $("#divcontent").prepend(data);
        hiddenProcess();
      });

      $(function(){
        //$(".registerform").Validform();  //就这一行代码！;

        $(".content_right_content").Validform({
          tiptype:2
        });
      })
    });
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
      <span><a id="link1" href="#" onclick="showlink('link1','modifyuserinfopre.htm');" class="active">基本信息</a></span>
      <span><a id="link4" href="#" onclick="showlink('link4','modifypasswordpre.htm');">密码修改</a></span>
    </div>
    <div id="divcontent" class="content_right_content">

    </div>
  </div>
</div>
<div class="clear"></div>
[#include "talk.html"]

</body>
</html>

