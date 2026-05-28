<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>在线学习系统-论坛</title>
    <link rel="shortcut icon" href="../../images/logo.png" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../lib/layui/css/layui.css">
    <link rel="stylesheet" href="../../css/global.css">
    <link rel="stylesheet" href="../../css/globalf.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/xadmin.js"></script>
    <script src="../../lib/layui/layui.js"></script>
</head>

<body>
<div class="fly-header layui-header header header-index">
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
            <li class="layui-nav-item ">
                <a href="#" target="_self">
                    笔记
                </a>
            </li>
            <li class="layui-nav-item ">
                <a href="/im" target="_self">
                    交友
                </a>
            </li>
            <li class="layui-nav-item layui-this">
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
                        <dd class="remove-layui-this"><a onclick="x_admin_show('修改信息','/user/infoUpdate',500,600)"
                                                         href="javascript:(0);">修改信息</a></dd>
                        <c:if test="${user_info.roleId==1}">
                            <dd class="remove-layui-this"><a href="/admin">进入后台</a></dd>
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

<div class="fly-panel fly-column">
    <div class="layui-container">
        <ul class="layui-clear">
            <li><span style="padding: 0 20px;font-weight: bold;">板块：</span></li>
            <c:forEach items="${boardList}" var="item" varStatus="S">
                <c:if test="${item.boardId==bid}">
                    <li class="layui-this">
                </c:if>
                <c:if test="${item.boardId!=bid}">
                    <li>
                </c:if>
                <a href="/forum?bid=${item.boardId}">${item.boardName}</a></li>
            </c:forEach>
        </ul>
        <c:if test="${user_info!=null}">
            <div class="fly-column-right layui-hide-xs">
                <a class="layui-btn" onclick="x_admin_show('我的帖子','/forum/myPost?uid=${user_info.userId}',500,600)"
                   href="javascript:(0);">我的帖子</a>
            </div>
            <div class="layui-hide-sm layui-show-xs-block"
                 style="margin-top: -10px; padding-bottom: 10px; text-align: center;">
                <a class="layui-btn" onclick="x_admin_show('我的帖子','/forum/myPost?uid=${user_info.userId}',500,600)"
                   href="javascript:(0);">我的帖子</a>
            </div>
        </c:if>
    </div>
</div>

<div class="layui-container">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">
            <div class="fly-panel">
                <div class="fly-panel-title fly-filter">
                    <a>置顶</a>
                </div>
                <ul class="fly-list">
                    <c:forEach items="${topicList}" var="item" varStatus="S">
                        <c:if test="${item.top==1}">
                            <li>
                                <a onclick="x_admin_show('查看信息','/user/info?uid=${item.userId}',500,505)"
                                   href="javascript:(0);" class="fly-avatar">
                                    <img src="${item.face}" alt="${item.userName}">
                                </a>
                                <h2>
                                    <a class="layui-badge">公告</a>
                                    <a href="/forum/detail?tid=${item.topicId}">${item.title}</a>
                                </h2>
                                <div class="fly-list-info">
                                    <a onclick="x_admin_show('查看信息','/user/info?uid=${item.userId}',500,505)"
                                       href="javascript:(0);" link>
                                        <cite>${item.userName}</cite>
                                        <c:if test="${item.roleId==1}">
                                            <i class="iconfont icon-renzheng" title="认证信息：管理员"></i>
                                            <i class="layui-badge fly-badge-vip">管理员</i>
                                        </c:if>
                                        <c:if test="${item.roleId==2}">
                                            <i class="iconfont icon-renzheng" title="认证信息：版主"></i>
                                            <i class="layui-badge fly-badge-accept">版主</i>
                                        </c:if>
                                    </a>
                                    <span id="t${S.count}"></span>
                                    <span class="fly-list-nums">
                                        <i class="iconfont icon-pinglun1" title="回复数"></i> ${item.repliesCount}
                                    </span>
                                </div>
                                <div class="fly-list-badge">
                                    <c:if test="${item.top==1}">
                                        <span class="layui-badge layui-bg-black">置顶</span>
                                    </c:if>
                                    <c:if test="${item.highlight==1}">
                                        <span class="layui-badge layui-bg-red">精品</span>
                                    </c:if>

                                </div>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>

            <div class="fly-panel" style="padding-bottom: 1px;">

                <div class="fly-panel-title fly-filter">
                    <a>综合</a>
                    <span class="fly-filter-right layui-hide-xs">
                        <c:if test="${sort==1||sort==null}">
                            <a href="javascript:(0);" class="sort layui-this" type="new">按最新</a>
                            <span class="fly-mid"></span>
                            <a href="javascript:(0);" class="sort" type="reply">按热议</a>
                        </c:if>
                        <%--<c:if test="${sort==2}">--%>
                            <%--<a href="javascript:(0);" class="sort" type="new">按最新</a>--%>
                            <%--<span class="fly-mid"></span>--%>
                            <%--<a href="javascript:(0);" class="sort" type="reply" class="layui-this">按热议</a>--%>
                        <%--</c:if>--%>
            </span>
                </div>

                <ul id="topicList" class="fly-list">

                </ul>

            </div>
        </div>
        <div class="layui-col-md4">

            <div class="fly-panel fly-rank fly-rank-reply" id="LAY_replyRank">
                <h3 class="fly-panel-title">活跃用户</h3>
                <dl>
                    <c:forEach items="${userList}" var="item">
                        <dd>
                            <a onclick="x_admin_show('查看信息','/user/info?uid=${item.userId}',500,505)"
                               href="javascript:(0);">
                                <img src="${item.face}" width="65"><cite>${item.userName}</cite>
                            </a>
                        </dd>
                    </c:forEach>
                </dl>
            </div>

            <div class="fly-panel">
                <div class="fly-panel-title">
                    广告
                </div>
                <div class="fly-panel-main">
                    <a href="https://www.layui.com/" target="_blank" class="fly-zanzhu"
                       style="background-color: #5FB878;">LayUI 2.4.5 - 经典模块化前端框架</a>
                    <a href="http://www.biubiubiu.cc/" target="_blank" class="fly-zanzhu">biubiubiu - link start (｡･ω･｡)
                        追番神器</a>
                </div>
            </div>

            <div class="fly-panel fly-link">
                <h3 class="fly-panel-title">友情链接</h3>
                <dl class="fly-panel-main">
                    <dd><a>暂无</a>
                    <dd>
                    <dd><a href="mailto:937023449@qq.com" class="fly-link">申请友链</a>
                    <dd>
                </dl>
            </div>

        </div>
    </div>
</div>

<div class="fly-footer">
    <p>2018 ©
        <a href="#">www.xxx.com</a> By outas.
    </p>
    <p>
        <a href="https://outas.cc">作者博客</a>
        <a href="#" target="_self">源码下载</a>
    </p>
</div>

<script src="../../js/forum.js"></script>
<script>
    layui.use(['element', 'form', 'laypage', 'layer', 'util', 'laydate'], function () {
        var element = layui.element,
            form = layui.form,
            laypage = layui.laypage,
            layer = layui.layer,
            util = layui.util,
            laydate = layui.laydate;
        //一些事件监听
        element.on('tab(demo)', function (data) {
            console.log(data);
        });

        // form.render();

        //调用分页
        util.fixbar({
            bar1: '&#xe642;'
            , bgcolor: '#009688'
            , click: function (type) {
                if (type === 'bar1') {
                    // layer.msg('打开 index.js，开启发表新帖的路径');
                    if (${user_info!=null}) {
                        layer.open({
                            title: '发表主题帖',
                            type: 2,
                            area: ['800px', '550px'],
                            shadeClose: true,
                            anim: 2,
                            maxmin: true,
                            content: ['/forum/addTopic', 'no'] //这里content是一个普通的String
                        });
                    } else {
                        layer.open({
                            content: '登录后才可发帖，是否转至登录界面？',
                            title: '提示',
                            btn: ['确认', '取消'],
                            yes: function (index) {
                                window.location.href = '/login';
                            }
                        });
                    }
                }
            }
        });

        <c:forEach items="${topicList}" var="item" varStatus="S">
        <c:if test="${item.top==1}">
        var time = "${item.releaseTime}";
        time = time.replace(new RegExp("-", "gm"), "/").substr(0, time.length - 2);
        // console.log(time);
        $("#t${S.count}").html(util.timeAgo(new Date(time).getTime(), true));
        </c:if>
        </c:forEach>

        $(".sort").click(function () {
            var type = this.getAttribute("type");
            console.log(type);
            $.ajax({
                url: "/forum",
                type: "get",
                data: {
                    type: type
                },
                success: function () {

                }
            });
        });
    });
</script>
</body>

</html>