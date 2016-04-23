<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<ul class="verticalList teacher_list" style="margin-top: 5px;">
  <c:forEach var="obj" items="${page.resultList}">

    <li onclick="detail('${obj.productInfo.id}');">
      <div style="position:relative">
        <div class="teacher_content">
          <div>
            <p class="title"><span class="teacher_name">${obj.productInfo.name}</span>
                <%--<span class="tag">&nbsp;门道文化教育研究院&nbsp;</span>--%>
            </p>
            <p>联系人：${obj.productInfo.linkman}</p>
            <p>通讯地址：${obj.productInfo.addr}
            </p>
            <p>开始时间：<fmt:formatDate value="${obj.productInfo.startDate}"  pattern="yyyy-MM-dd"/></p>
            <p class="button" style="position: relative;">结束时间：<fmt:formatDate value="${obj.productInfo.endDate}"  pattern="yyyy-MM-dd"/>
          </div>
        </div>
      </div>
    </li>
  </c:forEach>
</ul>
<jsp:include page="../common/ajaxpager.jsp" flush="true" >
  <jsp:param name="url" value="${basePath}/favourite/list.htm" />
</jsp:include>