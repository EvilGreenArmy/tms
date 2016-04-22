<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="user_step">
  <div class="round_mark floatL bD8">

  </div>
  <span>基本资料</span>
</div>
<form id="form"
      method="post" data-validator-option="{stopOnError:true,timely:2}">
  <input type="hidden" name="id" value="${login_user.id}" />
  <div class="floatL"><span>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 名：</span>
    <input class="ipt" type="text"   name="userName" id="userName" placeholder="姓名"/>
  </div>
  <div class="floatL" style="height:33px;line-height:33px;margin-left: 20px;"><span id="userNameSpan" style="color:red"></span></div>
  <div class="clear">&nbsp;</div>
  <div class="floatL">
    <span>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 别：</span>
    <input style="height: auto;"  name="gender" type="radio" id="boy" value="1" checked />男
    <input type="radio" style="height: auto;margin-left: 20px;" id="girl" name="gender"  type="radio" value="0" />女</div>
  <div class="floatL"><span style="color:red" id="genderSpan"></span></div>
  <div class="clear">&nbsp;</div>
  <div class="floatL"><span>手机号码：</span>
    <input  type="text" datatype="m"  name="phone" id="phone" placeholder="手机号" />
  </div>
  <div class="floatL"><span style="color:red" id="phoneSpan"></span></div>
  <div style="margin-left: 65px;font-size: 11px;margin-top: 10px;clear: both;"></div>
  <div class="floatL">
    <span>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 箱：</span>
    <input class="ipt"  type="text" name="email" id="email" type="text"  datatype="*1-20" placeholder="邮箱"/></i>
  </div>
  <div class="floatL"><span style="color:red" id="emailSpan"></span></div>
  <div class="clear">&nbsp;</div>
  <div class="button">
    <a class="w230_h33 first_to_second" style="margin-left: 65px;margin-top: 30px;cursor: pointer;" onclick="saveUser();">提交</a>
  </div>
</form>



