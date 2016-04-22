<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html>
<head>
  <meta name="viewport"
        content="width=100%, initial-scale=1.0, user-scalable=no" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  [#include "/common/meta.html"]
  <title>${course.name}</title>
  <link rel="stylesheet" href="${basePath}/css/main/web-main.css">

[#include "/common/new_header.html"]
<!--主体-->
<div class="content_div min_width">
  <div class="item_detail">
    <div class="item_detail_logo">
      <img src="" />
      <p><span>111<br />课程人气</span><span>111<br />已报名人数</span><span style="border-right: none;">111条<br />课程评价</span></p>
    </div>
    <div class="item_detail_content">
      <p style="margin-bottom: 0;"><span class="big_title">1232121212/span></p>
      <div class="div_content">
        <p class="content">
          <span class="first"><span>课程发布&nbsp;：&nbsp;</span><span>232323232323232323</span></span>
	        				<span>
		        				<span>ddddd323232323232323</span>
	        				   </span>
        </p>
        <p class="content">
          <span class="first"><span>招生名额&nbsp;：&nbsp;</span><span>121212121212人</span></span>
          <span><span>授课模式&nbsp;：&nbsp;</span><span>dafdeafadsfadsfadsf</span></span>
        </p>
        <p class="content">
          <span class="first"><span>课时数目&nbsp;：&nbsp;</span><span>1212121212个课时</span></span>
          <span><span>授课方式&nbsp;：&nbsp;</span><span>1212121212</span></span>
        </p>
        <p class="content">
          <span class="first"><span>授课时间&nbsp;：&nbsp;</span><span>111111111111111111&nbsp;&nbsp;&nbsp;&nbsp;111111至 111111</span></span>
          <span><span>开课时间&nbsp;：&nbsp;</span><span>1212121212</span></span>
        </p>
        <p class="content">
          <span class="first"><span>报名截止&nbsp;：&nbsp;</span><span>1212121212</span></span>
        </p>
      </div>
      <p class="price">
        <span><span>市场价格&nbsp;：&nbsp;</span><span><span style="text-decoration:line-through;">12121212</span> 元</span></span>
        <span style="margin-top:10px"> <span>门道价格&nbsp;：&nbsp;</span><span><span style="font-size: 30px;color: #D84634;">121212121</span>元</span></span>
      </p>
      <div class="clear" style="padding-top: 3px;height: 30px;line-height: 28px; float:left;">
        <span class="floatL">授课地址&nbsp;：&nbsp;</span><span class="floatL" >12121212</span>
      </div>
      <div class="clear"></div>
      <div class="button button_p share">
        <div style="height: 32px;float: left;line-height: 28px;">
        					<span class="praise" onclick="upwork();">
        						<img id="praiseImg" src="${cdn}/images/front/u595.png" />
        						<span id="praiseCt" class="count">
									12121212
								</span>点赞
        					</span>
          <span class="collect" [#if hasFav=false] onclick="favwork();"[/#if]>
          <img id="collectImg" src="[#if hasFav]${cdn}/images/front/u604.png[#else]${cdn}/images/front/u613.png[/#if]" />
        						<span id="collectCt" class="count">
									12121212
								</span>收藏
          </span>
        </div>
        <!-- 课程如果已经报满 则按钮置成灰不可用 -->
        <a target="_blank" href="${siteurl}/course/preenroll.htm?courseid=${course.id}&state=1" class="w120_h32 floatR" >立即报名</a>
        <!-- <a target="_blank" href="javascript:void(0);" class="w120_h32 floatR" style="background:#CCCCCC">预约试听</a> -->
        <a class="w120_h32 floatR" href="javascript:;" data-toggle="modal" data-target="#myModal_1111">免费通话</a>
        <div class="clear"></div>
      </div>
      <div class="clear"></div>
    </div>
  </div>
  <div class="item_content_left">
    <div class="school_attestation">
      <div>
        <img src="${cdn}/images/front/u499.png"/>
        <p>资质认证</p>
      </div>
      <div>
        <img src="${cdn}/images/front/u501.png"/>
        <p>支付安全</p>
      </div>
      <div>
        <img src="${cdn}/images/front/u503.png"/>
        <p>随时退款</p>
      </div>
    </div>
    <div class="item_content_left_honour">
      <div>
        <p>11111111111111111111111111111111111111111111</p>
        <ul class="verticalList teach_idea">
          <li>
            <p>
              333333333333333333333333333333333333333333333333
            </p>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <div class="item_content_right">
    <div style="clear:both;"></div>
    <!--描述：课程介绍-->
    <div class="item_div teach_idea">
      <p class="title">课程介绍</p>
      <p id="tContent">1111111111111111111111111111111111111111111111111111111111111</p>
      <p id="wholeInfo" style="display:none;">
        1111111111111111111111111111111111111
      </p>
      <a id="expand" style="color: #D84634;float: right;" onclick="$('#tContent').hide();$('#wholeInfo').show();$('#cover').show();$(this).hide()" href="javascript:;">+&nbsp;显示完整介绍</a>
      <a id="cover" style="color: #D84634;float: right; display:none;" onclick="$('#tContent').show();$('#wholeInfo').hide();$('#expand').show();$(this).hide()" href="javascript:;">-&nbsp;收起</a>
      [/#if]
      <span class="clear">&nbsp;</span>
    </div>
    <!--描述：课程特色-->
    <div class="item_div teaching_superiority">
      <p class="title">课程特色</p>
      <div class="lineht_30">

        <span class="backcolor0">&nbsp;&nbsp;${item}&nbsp;&nbsp;</span>
        <span class="backcolor1">&nbsp;&nbsp;${item}&nbsp;&nbsp;</span>
        <span class="backcolor2">&nbsp;&nbsp;${item}&nbsp;&nbsp;</span>
        <span class="backcolor3">&nbsp;&nbsp;${item}&nbsp;&nbsp;</span>
      </div>
    </div>
    <!--描述：服务保障-->
    <div class="item_div teaching_superiority">
      <p class="title">服务保障</p>
      <div class="lineht_30">

        <span class="backcolor0">&nbsp;&nbsp;${item}&nbsp;&nbsp;</span>
        <span class="backcolor1">&nbsp;&nbsp;${item}&nbsp;&nbsp;</span>
        <span class="backcolor2">&nbsp;&nbsp;${item}&nbsp;&nbsp;</span>
        <span class="backcolor3">&nbsp;&nbsp;${item}&nbsp;&nbsp;</span>

      </div>

    </div>

  </div>
</div>
</body>
</html>
