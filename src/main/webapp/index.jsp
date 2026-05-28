<%@ page import="dao.UserDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>
        在线学习系统
    </title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="lib/layui/css/layui.css" media="all">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <link rel="stylesheet" href="css/global.css" media="all">

</head>

<body class="site-home" id="LAY_home" style="background-color: #eee;">
<div class="layui-header header header-index">
    <div class="layui-main">
        <a class="logo" href="/" style="color:#fff;font-size:28px;">
            在线学习系统
        </a>
        <ul class="layui-nav">

            <li class="layui-nav-item layui-this">
                <a href="/" target="_self">
                    首页
                </a>
            </li>
            <li class="layui-nav-item ">
                <a href="/examSelect.html" target="_self">
                    考试
                </a>
            </li>
            <li class="layui-nav-item ">
                <a href="http://192.168.137.108:9090/file" target="_self">
                    笔记
                </a>
            </li>
            <li class="layui-nav-item ">
                <a href="/im" target="_self">
                    交友
                </a>
            </li>
            <li class="layui-nav-item ">
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
                            <dd class="remove-layui-this"><a href="/admin">进入后台</a></dd>
                        </c:if>
                        <dd class="remove-layui-this"><a href="/logout">注销</a></dd>
                    </dl>
                </li>
            </c:if>
        </ul>

    </div>
</div>
<div class="site-banner">
    <div class="site-banner-bg" style="background-color: #080018;background-size: cover;">
    </div>
    <div class="site-banner-main">
        <div class="site-zfj site-zfj-anim">
            <i class="layui-icon" style="color: #FBDAC7; color: rgba(255,255,255,.5);"><img width="150px;" src="/images/logo.png" alt="" style="opacity:0.8"></i>
        </div>
        <div class="layui-anim site-desc site-desc-anim">
            <cite>
                欢迎来到在线学习系统！
            </cite>
        </div>
        <div class="site-download">
            <a href="#" class="layui-inline site-down" target="_self">
                <cite class="layui-icon"><img src="images/pencil.png" style="opacity:0.8;margin-top: 2px;" width="24px"></cite> 开始学习
            </a>
        </div>
        <div class="site-version">
            <span>当前版本：<cite class="site-showv">1.0</cite></span>
            <span>用户总数：<em class="site-showdowns"><%=new UserDao().getCount()%></em></span>
        </div>
        <div class="site-banner-other" style="color:#fff">
            基于 <a href="https://www.layui.com/" style="color:white;" target="_blank"> LayUI </a> ，  <a href="http://jquery.com/" style="color:white;" target="_blank"> JQuery </a>  。
        </div>
    </div>
</div>
<div class="layui-main">
    <ul class="site-idea">
        <li>
            <fieldset class="layui-elem-field layui-field-title">
                <legend>返璞归真</legend>
                <p>高质量的代码就是对程序自己最好的注释。当你打算要添加注释时，问问自己，“我如何能改进编码以至于根本不需要添加注释？”改进你的代码，然后才是用注释使它更清楚。</p>
            </fieldset>
        </li>
        <li>
            <fieldset class="layui-elem-field layui-field-title">
                <legend>种瓜得瓜</legend>
                <p>好的代码会促生好的代码，糟糕的代码亦是如此。别低估了习惯的力量，没人想去整理糟糕的代码，同样没人想把完美的代码弄得一团糟。写好你的代码，它才更可能经得住时间的考验。</p>
            </fieldset>
        </li>
        <li>
            <fieldset class="layui-elem-field layui-field-title">
                <legend>滴水穿石</legend>
                <p>如果调试一个程序让你很苦恼，千万不要放弃，成功永远在拐角之后，除非你走到拐角，否则你永远不知道你离他多远，所以，请记住，坚持不懈，直到成功。</p>
            </fieldset>
        </li>
    </ul>
</div>
<div class="layui-footer footer footer-index">
    <div class="layui-main">
        <p>2018 ©
            <a href="#">www.xxx.com</a> By outas.
        </p>
        <p>
            <a href="https://outas.cc">作者博客</a>
            <a href="#" target="_self">源码下载</a>
        </p>
    </div>
</div>
<script>
    layui.use('element', function(){
        var element = layui.element;
        //一些事件监听
        element.on('tab(demo)', function(data){
            // console.log(data);
        });
    });
    $("#check_user").on('click', function () {
        if(${user_info==null}){
            return false;
        }
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