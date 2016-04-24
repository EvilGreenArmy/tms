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
            <c:if test="${obj.content != null}">
              <p>我的回复：${obj.content}</p>
            </c:if>
            <c:if test="${obj.comValue > 0}">
            <p>我的出价：<span style="color:red">${obj.comValue}</span></p>
            </c:if>
          </div>
        </div>
      </div>
    </li>
  </c:forEach>
</ul>
<jsp:include page="../common/ajaxpager.jsp" flush="true" >
  <jsp:param name="url" value="${basePath}/competition/list.htm" />
</jsp:include>