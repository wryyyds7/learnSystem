<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!-- saved from url=(0023)http://x.xuebingsi.com/ -->
<html>

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <title>
    在线学习
  </title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="format-detection" content="telephone=no">
  <link rel="stylesheet" href="../../lib/layui/css/layui.css" media="all">
  <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
  <script src="../../lib/layui/layui.js" charset="utf-8"></script>
  <script type="text/javascript" src="../../js/xadmin.js"></script>
  <link rel="stylesheet" href="../../css/global.css" media="all">

  <style>

  </style>
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
      <li class="layui-nav-item layui-this">
        <a href="/examSelect.html" target="_self">
          考试
        </a>
      </li>
      <li class="layui-nav-item ">
        <a href="/pages/notice.html" target="_self">
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
<div class="layui-main">
  <div class="layui-row  layui-col-md-offset4 layui-col-md8">
    <form class="layui-form layui-col-md12 x-so" method="post" action="/examSelect.html" id="form1">
      <div class="layui-unselect layui-form-select">
        <input type="text" name="paperName" placeholder="请输入试卷名称" autocomplete="off" class="layui-input-block" value="${ex.paperName}" style="width: 150px">
        <button class="layui-btn layui-input-inline" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
      </div>
    </form>
  </div>
  <xblock>
    <span class="x-right" style="line-height:40px">共有数据：2 条</span>
  </xblock>
  <table class="layui-table layui-form">
    <thead>
    <tr>
      <th>序号</th>
      <th>试卷名称</th>
      <th>开考时间</th>
      <th>考试时长</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="item" varStatus="s">
      <tr>
        <td>${s.count}</td>
        <td>${item.paperName}</td>
        <td>${item.startTime}</td>
        <td>${item.paperTime}分钟</td>
        <td class="td-manage">
          <a href="javascript:;" >
            <i class="layui-icon">开始考试</i>
          </a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
  <div class="page">
    <div id="text1">

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
      <a href="https://outas.cc">我的博客</a>
      <a href="#" target="_self">网站源码免费下载</a>
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