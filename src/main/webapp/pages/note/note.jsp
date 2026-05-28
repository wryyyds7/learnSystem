<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>在线学习系统-交友</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="../../css/layui.css" media="all">
    <link rel="stylesheet" href="../../css/global.css" media="all">
    <link rel="stylesheet" href="../../css/note.css" media="all">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <link href="../../css/chat.css" rel="stylesheet" id="chat-css">
    <script type="text/javascript" src="../../js/xadmin.js"></script>
    <script src="../../lib/layui/layui.js" charset="utf-8"></script>
</head>

<body class="site-home" id="LAY_home" style="background-color: #eee;">
<div class="layui-header header header-index">
    <div class="layui-main">
        <a class="logo" href="/" style="color:#fff;font-size:28px;">
            在线学习系统
        </a>
        <ul class="layui-nav">

            <li class="layui-nav-item">
                <a href="/" target="_self">
                    首页
                </a>
            </li>
            <li class="layui-nav-item ">
                <a href="#" target="_self">
                    考试
                </a>
            </li>
            <li class="layui-nav-item layui-this">
                <a href="#" target="_self">
                    笔记
                </a>
            </li>
            <li class="layui-nav-item">
                <a href="/im" target="_self">
                    交友
                </a>
            </li>
            <li class="layui-nav-item">
                <a href="/forum" target="_self">
                    论坛
                </a>
            </li>
            <c:if test="${user_info==null}">
                <li class="layui-nav-item ">
                    <a href="/login" target="_self">
                        用户登录
                    </a>
                </li>
            </c:if>
            <c:if test="${user_info!=null}">
                <li class="layui-nav-item ">
                    <a href="javascript:(0);" target="_self">
                        <img src="${user_info.getFace()}" width="28px">
                        <span style="padding-left:5px;">${user_info.getUserName()}</span>
                    </a>
                    <dl class="layui-nav-child">
                        <dd class="remove-layui-this"><a onclick="x_admin_show('修改信息','/user/infoUpdate',500,600)" href="javascript:(0);">修改信息</a></dd>
                        <c:if test="${user_info.roleId==1}">
                            <dd><a href="/admin">进入后台</a></dd>
                        </c:if>
                        <c:if test="${user_info.roleId==2}">
                            <dd class="remove-layui-this"><a href="/admin">帖子管理</a></dd>
                        </c:if>
                        <dd class="remove-layui-this"><a href="/logout">注销</a></dd>
                    </dl>
                </li>
            </c:if>
        </ul>

    </div>
</div>
<div class="layui-main">
    <div class="layui-row" >
        <div class="layui-col-md3">
            <div class="layui-bg-green main">6/12</div>
        </div>
        <div class="layui-col-md3">
            <div class="layui-bg-cyan main">6/12</div>
        </div>
        <div class="layui-col-md6">
            <div class="layui-bg-blue  main">6/12</div>
        </div>
    </div>
</div>
<div class="layui-footer footer footer-index">
    <div class="layui-main">
        <p>
            2018 ©
            <a href="#">www.xxx.com</a> By outas.
        </p>
        <p>
            <a href="https://outas.cc">作者博客</a>
            <a href="#" target="_self">网站源码</a>
        </p>
    </div>
</div>
<script>
    layui.use('element', function(){
        var element = layui.element;
        //一些事件监听
        element.on('tab(demo)', function(data){
            console.log(data);
        });
    });
    layui.use('form', function(){
        var form = layui.form;
        form.render();
    });
    $(".remove-layui-this").click(function () {
        $(this).addClass("layui-this");
        setTimeout(function () {
            $(".remove-layui-this").removeClass("layui-this");
        },500);
    })
</script>
</body>

</html>
