<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的帖子</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="../../images/logo.png" type="image/x-icon">
    <link rel="stylesheet" href="../../lib/layui/css/layui.css">
    <link rel="stylesheet" href="../../css/global.css">
    <link rel="stylesheet" href="../../css/globalf.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/xadmin.js"></script>
    <script src="../../lib/layui/layui.js"></script>
</head>

<body style="margin-top: 10px;">
<ul class="jie-row" style="margin:0 20px;">
    <c:forEach items="${list}" var="item" varStatus="S">
        <li>
            <a href="" class="jie-title" style="margin-right: 10px;">${item.title}</a>
            <c:if test="${item.highlight==1}">
                <span class="fly-jing">顶</span>
            </c:if>
            <c:if test="${item.top==1}">
                <span class="fly-jing">精</span>
            </c:if>
            <i id="t${S.count}"></i>
            <a tid="${item.topicId}" class="jie-admin ref" style="float: right;">删除</a>
        </li>
    </c:forEach>
</ul>
<script>
    layui.use(['layer','util'], function () {
        var util = layui.util;
        layer=layui.layer;
        <c:forEach items="${list}" var="item" varStatus="S">
        var time = "${item.releaseTime}";
        time = time.replace(new RegExp("-", "gm"), "/").substr(0, time.length - 2);
        // console.log(time);
        $("#t${S.count}").html(util.timeAgo(new Date(time).getTime(), true));
        </c:forEach>
    });
    $(".ref").click(function () {
        var tid = this.getAttribute("tid");
        console.log(tid);
        $.ajax({
           url:"/forum/myPost",
           type:"post",
           data:{
               tid:tid
           },
            success:function () {
                layer.msg('删除成功');
                setTimeout(function () {
                    location.reload();
                },1000);
            }
        });

    });
</script>
</body>
</html>
