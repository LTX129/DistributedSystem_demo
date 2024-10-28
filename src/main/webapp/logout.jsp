<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String username = org.apache.commons.text.StringEscapeUtils.escapeHtml4(request.getParameter("username")); %>

<%
    // 使 session 失效
    session.invalidate();
    // 重定向到首页或登录页面
    response.sendRedirect("index.jsp");
%>
