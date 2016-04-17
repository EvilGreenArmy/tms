<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    StringBuffer redirectUrl = new StringBuffer();
    redirectUrl.append(request.getScheme()).append("://");
    redirectUrl.append(request.getServerName()).append(":");
    redirectUrl.append(request.getServerPort()).append(request.getContextPath());
    redirectUrl.append("/index.htm");
    response.sendRedirect(redirectUrl.toString());
%>

