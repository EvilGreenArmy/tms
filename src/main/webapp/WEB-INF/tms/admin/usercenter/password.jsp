<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
  #button {
    width: 200px;
    background-color: #D84634;
    border: none;
    padding: 5px;
    color: white;
    size: 14px;
    margin-left: 80px;
    margin-top: 20px;
  }
  .input{
    width: 230px;
  }
  .passworddiv{
    background-color: white;
  }
</style>
<div class="change_pw">
  <form id="form" method="post" onsubmit="return false">
    <div class="floatL"><span>旧的登陆密码：</span><input type="password" name="oldPassword" id="oldPassword" placeholder="旧密码" /></div>
    <div class="floatL" style="height: 33px;line-height: 33px;"><span class="Validform_checktip"></span></div>
    <div class="clear">&nbsp;</div>
    <div class="floatL" style="margin-top: 15px;"><span>新的登陆密码：</span><input name="newPassword" id="newPassword" type="password" placeholder="必须是6-20英文字母、数字或符号"/></div>
    <div class="floatL" style="height: 33px;line-height: 33px;margin-top: 15px;"><span class="Validform_checktip"></span></div>
    <div class="clear">&nbsp;</div>
    <div class="floatL" style="margin-top: 15px;"><span>确认登陆密码：</span><input id="newPasswordReply" name="newPasswordReply" type="password"  placeholder="确认登陆密码"/></div>
    <div class="floatL" style="height: 33px;line-height: 33px;margin-top: 15px;"><span class="Validform_checktip"></span></div>
    <div class="clear">&nbsp;</div>
    <div class="button" style="margin-top: 20px;margin-left: 90px;">
      <a class="w250_h33 changepw_true" style="cursor: pointer;font-size: 16px;" onclick="changePassword();">确定</a> &nbsp;
    </div>
</div>
