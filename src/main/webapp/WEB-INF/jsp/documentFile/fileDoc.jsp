<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=contextPath%>/layui/css/layui.css" media="all">
    <script type="text/javascript" src="<%=contextPath%>/static/jquery-2.1.3.min.js"></script>
</head>
<body>
<div style="padding: 20px; background-color: #F2F2F2;">
    <div class="layui-row layui-col-space15">

        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
            <legend>下载文件中心</legend>
        </fieldset>
        <div class="layui-form" style="text-align: center">
            <table class="layui-table">
                <colgroup>
                    <col width="150">
                    <col width="250">
                    <col width="250">
                    <col width="250">
                    <col width="150">
                    <col width="50">
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th style="text-align: center">文件名</th>
                    <th style="text-align: center">文件描述</th>
                    <th style="text-align: center">上传用户</th>
                    <th style="text-align: center">上传时间</th>
                    <th style="text-align: center">操作</th>
                </tr>
                </thead>
                <c:forEach items="${downloadDcoList}" var="d">
                    <tbody>
                    <tr>
                        <td style="text-align: center">${d.filename}</td>
                        <td style="text-align: center">${d.filemsg}</td>
                        <td style="text-align: center">${d.fileadmin}</td>
                        <td style="text-align: center"><fmt:formatDate value="${d.createtime}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td style="text-align: center"><a href="/download/fileDown?id=${d.id}">下载</a>
                    </tr>
                    </tbody>
                </c:forEach>
            </table>
        </div>
    </div>
    <div style="text-align: center">

        当前第<b style="color: red"> ${page.pageNum} </b>页.总共 <b style="color: red">${page.pages} </b>页.共 <b style="color: red">${page.total} </b>条记录
        <b style="color: red">[${page.pageNum}</b>/<b style="color: red">${page.total}]</b>&nbsp;&nbsp;&nbsp;&nbsp;
        <%--第一页不能点击--%>
        <c:choose>
            <c:when test="${page.pageNum==1 }">
                <span>首页</span>
                <span>上一页</span>
            </c:when>
            <c:otherwise>
                <a href="downloadView?pageIndex=1">首页</a>
                <a href="downloadView?pageIndex=${page.pageNum-1}">上一页</a>
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${page.firstPage == page.total}">
                <span>下一页</span>
                <span>末页</span>
            </c:when>
            <c:otherwise>
                <a href="downloadView?pageIndex=${page.pageNum +1}">下一页</a>
                <a href="downloadView?pageIndex=${page.pages}">尾页</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="<%=contextPath%>/layui/layui.js"></script>
</body>
</html>
