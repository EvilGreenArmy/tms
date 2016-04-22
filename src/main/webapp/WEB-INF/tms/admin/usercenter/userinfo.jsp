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
  <script src="${basePath}/js/main/jquery-1.11.1.min.js"></script>
  <script type="text/javascript" src="${basePath}/js/admin/layer/layer.js"></script>
  <style type="text/css">
    select {
      height: 25px
    }
  </style>
  <link rel="stylesheet" href="${basePath}/css/main/manage.css">
  <script src="${basePath}/js/main/jquery.form.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){
      var url="${basePath}/user/modify.htm?t=" + Math.random();
      $.get(url,function(data){
        $("#divcontent").empty();
        $("#divcontent").prepend(data);
      });
    });
    function changeTab(link, url) {
      url = url + "?t=" + Math.random();
      $.get(url,function(data){
        $("#divcontent").empty();
        $("#divcontent").prepend(data);
        if('link1' == link) {
          $("#link1").addClass('active');
          $("#link4").removeClass('active');
        } else {
          $("#link4").addClass('active');
          $("#link1").removeClass('active');
        }
      });
    }
    /**
     * 修改密码
     * */
    function changePassword() {
        var oldPassword = $("#oldPassword").val();
        if(oldPassword== null || oldPassword == '') {
          layer.msg('原密码不能为空！');
          return;
        }
        var newPassword = $("#newPassword").val();
        if(newPassword== null || newPassword == '') {
          layer.msg('新密码不能为空！');
          return;
        }
        var newPasswordReply = $("#newPasswordReply").val();
        if(newPasswordReply== null || newPasswordReply == '') {
          layer.msg('两次密码不一致！');
          return;
        }
        if(newPasswordReply != newPassword) {
          layer.msg('两次密码不一致！');
          return;
        }
        $.ajax({
          type: "POST",
          url: '${basePath}/user/modifyPassword.htm',
          data: {oldPassword:oldPassword,newPassword:newPassword,newPasswordReply:newPasswordReply},
          dataType: "json",
          success: function(data) {
            data = JSON.parse(data);
            if(data.state != '1') {
              layer.msg(data.errMsg);
              return;
            } else {
              layer.msg('密码修改成功！');
              setTimeout(function() {
                parent.layer.closeAll();
              },1000);


            }
          }
        });
    }
    function saveUser() {
      var flag = false;
      if($("#userName").val() == '') {
        $("#userNameSpan").text('姓名不能为空');
        flag = true;
      } else {
        $("#userNameSpan").text('')
      }
      var email = $("#email").val();
      if(email == '') {
        $("#emailSpan").text("邮箱不能为空");
        flag = true;
      } else {
        if (!isEmail(email)) {
          $("#emailSpan").text("您输入的邮箱有误,请重新核对后再输入");
          flag = true;
        } else {
          $("#emailSpan").text('');
        }
      }
      var phone = $("#phone").val();
      if(phone == '') {
        $("#phoneSpan").text("电话不能为空");
        flag = true;
      } else {
        if (!checkPhone(phone)) {
          $("#phoneSpan").text("请输入正确的手机号");
          flag = true;
        } else {
          $("#phoneSpan").text('');
        }
      }
      //保存
      if(!flag) {
        $.ajax({
          type: "POST",
          url: '${basePath}/user/modify.htm?t=' + Math.random(),
          data: $("#form").serialize(),
          dataType: "json",
          success: function(data) {
            data = eval("(" + data +")");
            if(data.state != '0') {
              layer.msg('资料修改成功！');
              $("#userName").val('');
              $("#phone").val('');
              $("#email").val('');
              $("#boy").attr('checked', 'checked');
              $("#girl").attr('checked', '');
            } else {
              layer.msg('资料修改失败！');
            }
          }
        });
      }
    }
    function checkEmail() {
      var email = $("#email").val();
      alert(email);
      if (!isEmail(email) && email != '') {
        return false;
      }
      return true;
    }
    function isEmail(str){
      var reg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
      return reg.test(str);
    }
    function checkPhone(mobile) {
      if(mobile.length > 0) {
        if (mobile.length != 11) {
          return false;
        }
        var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
        if (!myreg.test(mobile)) {
          return false;
        }
        return true;
      }
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
      <span><a id="link1" href="#" onclick="changeTab('link1','${basePath}/user/modify.htm');" class="active">基本信息</a></span>
      <span><a id="link4" href="#" onclick="changeTab('link4','${basePath}/user/password.htm');">密码修改</a></span>
    </div>
    <div id="divcontent" class="content_right_content">

    </div>
  </div>
</div>
<div class="clear"></div>
</body>
</html>

