<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%
    String contextPath = request.getContextPath();
%>
<html>
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
        <div class="layui-form" style="text-align: center">
            <table class="layui-table">
                <colgroup>
                    <col width="120">
                    <col width="300">
                    <col width="60">
                    <col width="200">
                    <col width="60">
                </colgroup>
                <thead>
                <tr>
                    <th style="text-align: center">公告标题</th>
                    <th style="text-align: center">公告描述</th>
                    <th style="text-align: center">操作用户</th>
                    <th style="text-align: center">创建时间</th>
                    <th style="text-align: center">操作</th>
                </tr>
                </thead>
                <c:forEach items="${docList}" var="d">
                    <tbody>
                    <tr>
                        <td style="text-align: center">${d.docname}</td>
                        <td style="text-align: center">${d.docmsg}</td>
                        <td style="text-align: center">${d.useraction}</td>
                        <td style="text-align: center"><fmt:formatDate value="${d.createtime}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td style="text-align: center"><a href="/notice/noticeDelete?id=${d.id}">删除</a>
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
                <a href="noticeView?pageIndex=1">首页</a>
                <a href="noticeView?pageIndex=${page.pageNum-1}">上一页</a>
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${page.firstPage == page.total}">
                <span>下一页</span>
                <span>末页</span>
            </c:when>
            <c:otherwise>
                <a href="noticeView?pageIndex=${page.pageNum +1}">下一页</a>
                <a href="noticeView?pageIndex=${page.pages}">尾页</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<script src="<%=contextPath%>/layui/layui.js"></script>
<script>

</script>
</body>
</html>
