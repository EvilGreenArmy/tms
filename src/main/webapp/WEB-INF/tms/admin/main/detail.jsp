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
  <title>${course.name}</title>
  <link rel="stylesheet" href="${basePath}/css/main/web-main.css">
  <script src="${basePath}/js/main/jquery-1.11.1.min.js"></script>
  <script src="${basePath}/js/main/jquery.cookie.js"></script>
  <script type="text/javascript" src="${basePath}/js/admin/layer/layer.js"></script>
  <script>
    function replyComment(commentid){
      $('#'+commentid).slideToggle();
    }
    function checkNum(obj) {

      obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
      obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是.
      obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
      obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
      obj.value=obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
      var val = $(obj).val();
      if($.trim(val) == '' || isNaN(val)) {
          $(obj).val('');
      }
    }
    var isup=false;
    var isfav = false;
    function upwork(){
      if(isUpded() || isup){
        return ;
      }
      $.get("${basePath}/product/up.htm?id=${product.id}",function(data){
        var num=parseInt(data);
        if(num>0){
          layer.msg('点赞成功！');
          $('#praiseCt').text(num);
          $('#praiseImg').attr('src', '${basePath}/img/main/u586.png');
          $.cookie("post_${product.id}", "1");
          isup=true;
        }
      });
    };
    function favwork() {
      if(isFav() || isfav){
        return ;
      }
      $.get("${basePath}/product/fav.htm?id=${product.id}",function(data){
        var num=parseInt(data);
        if(num>0){
          layer.msg('收藏成功！');
          $('#collectCt').text(num);
          $('#collectImg').attr('src', '${basePath}/img/main/u604.png');
          $.cookie("fav_${product.id}", "1");
          isup=true;
        }
      });
    }
    function isUpded(){
      var aid=$.cookie("post_${product.id}");
      return aid == 1;
    }
    function isFav(){
      var aid=$.cookie("fav_${product.id}");
      return aid == 1;
    }
    function pubcomments(comment, mon) {
      var word = $("#" +comment).val();
      var money = $("#" +mon).val();
      if($.trim(word) == '' && $.trim(money) == '') {
          layer.msg('请输入回复内容！');
        return;
      }
      if($.trim(money) != '' && parseFloat(money) <= 0) {
        layer.msg('出价应大于0！');
        return;
      }
      $.ajax({
        type: "POST",
        url: '${basePath}/product/competition.htm',
        data: {id:'${product.id}',content:word,money:money},
        dataType: "json",
        success: function(data) {
          data = JSON.parse(data);
          if(data.state == '1') {
            if($.trim(money) == '') {
              layer.msg('评论成功！');
            } else {
              layer.msg('竞价成功！');
            }

            $("#maxValue").val(data.maxValue);
            var str = "&nbsp;" + data.maxAmount + "&nbsp;";
            $("#maxAmount").html(str);
            setTimeout(function() {
              parent.layer.closeAll();
              location.reload();
            },1000);
          }
        }
      });
    }
    function pubsubcomments(comment, userid) {
      if($.trim($("#" +comment).val()) == '') {
        layer.msg('请输入回复内容！');
        return;
      }
      $.ajax({
        type: "POST",
        url: '${basePath}/product/reply.htm',
        data: {id:'${product.id}',content:$("#" +comment).val(),userId:userid},
        dataType: "json",
        success: function(data) {
          data = JSON.parse(data);
          if(data.state == '1') {
            layer.msg('评论成功！');
            setTimeout(function() {
              parent.layer.closeAll();
              location.reload();
            },1000);
          }
        }
      });
    }
  </script>
</head>
  <jsp:include page="../main/header.jsp" flush="true" />
<!--主体-->
<div class="content_div min_width">
  <div class="item_detail">
    <div class="item_detail_logo">
      &nbsp;
    </div>
    <div class="item_detail_content">
      <p style="margin-bottom: 0;"><span class="big_title">${product.name}</span></p>
      <div class="div_content">
        <p class="content">
          <span class="first"><span>联系人&nbsp;：&nbsp;</span><span>${product.linkman}</span></span>
          <span><span>单位&nbsp;：&nbsp;</span><span>${product.organization}</span></span>
        </p>
        <p class="content">
          <span class="first"><span>所在区域&nbsp;：&nbsp;</span><span>${product.area}</span></span>
          <span><span>通讯地址&nbsp;：&nbsp;</span><span>${product.addr}</span></span>
        </p>
        <p class="content">
          <span class="first"><span>类型&nbsp;：&nbsp;</span>
            <span>
                <c:if test="${product.type eq '1'}">成果</c:if>
                <c:if test="${product.type eq '2'}">专利</c:if>
            </span>
          </span>
          <span><span>邮编&nbsp;：&nbsp;</span><span>${product.zipCode}</span></span>
        </p>
        <p class="content">
          <span class="first"><span>开始时间&nbsp;：&nbsp;</span><span><fmt:formatDate value="${product.startDate}"  pattern="yyyy-MM-dd"/></span></span>
          <span><span>结束时间&nbsp;：&nbsp;</span><span><fmt:formatDate value="${product.startDate}"  pattern="yyyy-MM-dd"/></span></span>
        </p>
      </div>
      <p class="price">
        <%--<span><span>市场价格&nbsp;：&nbsp;</span><span><span style="text-decoration:line-through;">12121212</span> 元</span></span>--%>
        <span style="margin-top:10px"> <span>最高价&nbsp;：&nbsp;</span><span><span style="font-size: 30px;color: #D84634;" id="maxValue">${maxValue}</span>&nbsp;&nbsp;${product.priceUnit}</span></span>
      </p>
      <div class="clear" style="padding-top: 3px;height: 30px;line-height: 28px; float:left;">
        <span class="floatL">&nbsp;</span><span class="floatL" >&nbsp;</span>
      </div>
      <div class="clear"></div>
      <div class="button button_p share">
        <div style="height: 32px;float: left;line-height: 28px;">
        					<span class="praise" onclick="upwork();">
                              <c:if test="${praiseFlag eq '1'}">
                                <img id="praiseImg" src="${basePath}/img/main/u586.png" />
                              </c:if>
                              <c:if test="${praiseFlag ne '1'}">
                                <img id="praiseImg" src="${basePath}/img/main/u595.png" />
                              </c:if>

        						<span id="praiseCt" class="count">
									${praiseCount}
								</span>点赞
        					</span>
          <span class="collect" [#if hasFav=false] onclick="favwork();"[/#if]>
                              <c:if test="${favFlag eq '1'}"><img id="collectImg" src="${basePath}/img/main/u604.png" /></c:if>
                              <c:if test="${favFlag ne '1'}"><img id="collectImg" src="${basePath}/img/main/u613.png" /></c:if>
        						<span id="collectCt" class="count">
                                  ${favCount}
								</span>收藏
          </span>
        </div>
        <%--<a target="_blank" href="${siteurl}/course/preenroll.htm?courseid=${course.id}&state=1" class="w120_h32 floatR" >竞价</a>--%>
       <%-- <a class="w120_h32 floatR" href="javascript:;" data-toggle="modal" data-target="#myModal_1111">免费通话</a>--%>
        <div class="clear"></div>
      </div>
      <div class="clear"></div>
    </div>
  </div>
  <div class="item_content_left">
    <div class="school_attestation">
      <div>
        <p>&nbsp;</p>
      </div>
      <div>
        <p>&nbsp;</p>
      </div>
      <div>
        <p>&nbsp;</p>
      </div>
    </div>
    <div class="item_content_left_honour">
      <div>
        <p>&nbsp;</p>
        <ul class="verticalList teach_idea">
          <li>
            <p>
              &nbsp;
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
      <p class="title">内容介绍</p>
      <p id="tContent">${product.content}</p>
      <p id="wholeInfo" style="display:none;">
        &nbsp;
      </p>
     <%-- <a id="expand" style="color: #D84634;float: right;" onclick="$('#tContent').hide();$('#wholeInfo').show();$('#cover').show();$(this).hide()" href="javascript:;">+&nbsp;显示完整介绍</a>
      <a id="cover" style="color: #D84634;float: right; display:none;" onclick="$('#tContent').show();$('#wholeInfo').hide();$('#expand').show();$(this).hide()" href="javascript:;">-&nbsp;收起</a>--%>
      <span class="clear">&nbsp;</span>
    </div>
    <div class="item_div teaching_superiority">
      <p class="title">竞价</p>
      <div class="lineht_30">
      </div>
    </div>
    <div class="message">
      <div class="message_board">
        <!--评论区域-->
        <div class="message_ipt">
          <p>
           <%-- <span><span class="num">360&nbsp;</span>人参与</span>--%>
            <span>共<span class="num" id="maxAmount">&nbsp;${comAmount}&nbsp;</span>人出价</span>
          </p>
          <textarea id="content" placeholder="所有评论仅代表网友意见，延安市科技局保持中立" style="height:94px;"></textarea>
          出价&nbsp;<input type="text" name="money" id="money" maxlength="8" placeholder="出价" onkeyup="checkNum(this);"/>&nbsp;&nbsp;${product.priceUnit}
          <a href="javascript:;" onclick="pubcomments('content', 'money');">竞价</a>
        </div>
      </div>
      <div id="myComments">
        <div id="commentsDiv">
          <ul class="verticalList message_list">
            <c:forEach items="${comList}" var="com">
            <li>
              <div class="first">
                <div class="user_head_img">
                    <img src="${basePath}/img/main/male.jpg"/>
                </div>
                <div class="message_content">
                  <p class="message_content_top"><span></span>
                      <span>${com.userInfo.userName}</span>
                    <span class="message_time"><fmt:formatDate value="${com.createTime}"  pattern="yyyy-MM-dd"/></span>
                  </p>
                  <p style="width:88%;">
                    <c:if test="${com.replyUser != null && com.replyUser.id != null}">
                        回复@${com.replyUser.userName}:&nbsp;
                    </c:if>
                    ${com.content}
                  </p>
                  <c:if test="${com.comValue > 0}">
                  <p style="width:88%;">出价：<span style="color:red">${com.comValue}</span>&nbsp;&nbsp;${product.priceUnit}</p>
                  </c:if>
                </div>
                <ul class="horizontalListComment message_list_tools" style="padding-bottom:5px;">
                  <li><span ><a href="javascript:void(0);" onclick="replyComment('comdiv_${com.id}', '${com.userInfo.id}')">回复</a></span></li>
                </ul>
                <div class="clear"></div>
              </div>
              <div style="display:none;" id="comdiv_${com.id}">

                <div class="message_ipt">
                  <textarea name="content" id="cont_${com.id}" style="margin-top:40px;" placeholder="所有评论仅代表网友意见，延安市科技局保持中立"></textarea>
                  <a href="javascript:void(0);" onclick="pubsubcomments('cont_${com.id}', '${com.userInfo.id}');" class="subcomments">发布</a>
                </div>
              </div>
            </li>
            </c:forEach>
          </ul>
        </div>
        <div class="page_number_div clear" style="text-align: center;line-height:40px;" id="resPager">
          <ul class="horizontalList clear page_number">
          </ul>
        </div>

      </div>
    </div>


  </div>
</div>
</body>
</html>
