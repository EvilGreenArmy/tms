<%@ page contentType="text/html;charset=UTF-8" import="com.tms.entities.SourceInfo"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<dl class="leftmenu">
  <c:forEach var="parent" items="${parentList}">
    <dd>
        <div class="title">
          <span><img src="${basePath}/img/admin/login/leftico01.png" /></span><c:out value="${parent.name}" />
          <div class="clear"></div>
        </div>

        <ul class="menuson">
          <c:forEach var="menu" items="${menuList}">
            <c:if test="${menu.parentInfo.id == parent.id}">
              <li><cite></cite><a href="javascript:;" onclick="getData('${basePath}/${menu.code }','','workspace');"><c:out value="${menu.name}"/></a><i></i></li>
            </c:if>
          </c:forEach>
        </ul>
    </dd>
  </c:forEach>
</dl>
<script type="text/javascript">
  $(function(){
    //导航切换
    $(".menuson li").click(function(){
      $(".menuson li.active").removeClass("active")
      $(this).addClass("active");
    });

    $('.title').click(function(){
      var $ul = $(this).next('ul');
      $('dd').find('ul').slideUp();
      if($ul.is(':visible')){
        $(this).next('ul').slideUp();
      }else{
        $(this).next('ul').slideDown();
      }
    });
  })
</script>