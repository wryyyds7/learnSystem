<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>在线学习系统-论坛</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="../../images/logo.png" type="image/x-icon">
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
        <a class="logo" href="#" style="color:#fff;font-size:28px;">
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
                        <img src="../${user_info.getFace()}" width="28px">
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
        <div class="layui-col-md8 content detail">
            <div class="fly-panel detail-box">
                <h1>${topic.title}</h1>
                <div class="fly-detail-info">
                    <c:if test="${topic.top==1}">
                        <span class="layui-badge layui-bg-black">置顶</span>
                    </c:if>
                    <c:if test="${topic.highlight==1}">
                        <span class="layui-badge layui-bg-red">精帖</span>
                    </c:if>

                    <div class="fly-admin-box">
                        <c:if test="${topic.userId==user_info.userId||user_info.roleId==1||user_info.roleId==2}">
                            <a type="del" class="layui-btn layui-btn-xs jie-admin option" type="del">删除</a>
                        </c:if>

                        <c:if test="${user_info.roleId==1||user_info.roleId==2}">
                            <c:if test="${topic.top==0}">
                                <a type="top" class="layui-btn layui-btn-xs jie-admin option">置顶</a>

                            </c:if>
                            <c:if test="${topic.top==1}">
                                <a type="detop" class="layui-btn layui-btn-xs jie-admin option">取消置顶</a>

                            </c:if>
                            <c:if test="${topic.highlight==0}">
                                <a type="hl" class="layui-btn layui-btn-xs jie-admin option">加精</a>
                            </c:if>
                            <c:if test="${topic.highlight==1}">
                                <a type="dehl" class="layui-btn layui-btn-xs jie-admin option">取消加精</a>
                            </c:if>
                        </c:if>

                    </div>
                    <span class="fly-list-nums">
                  <a href="#comment"><i class="iconfont" title="回答"></i>${topic.repliesCount}</a>
                </span>
                </div>
                <div class="detail-about">
                    <a class="fly-avatar" onclick="x_admin_show('查看信息','/user/info?uid=${topic.userId}',500,505)"
                       href="javascript:(0);">
                        <img src="../${topic.face}"
                             alt="${topic.userName}">
                    </a>
                    <div class="fly-detail-user">
                        <a onclick="x_admin_show('查看信息','/user/info?uid=${topic.userId}',500,505)"
                           href="javascript:(0);" class="fly-link">
                            <cite>${topic.userName}</cite>
                            <c:if test="${topic.roleId==1}">
                                <i class="iconfont icon-renzheng" title="认证信息：管理员"></i>
                                <i class="layui-badge fly-badge-vip">管理员</i>
                            </c:if>
                            <c:if test="${topic.roleId==2}">
                                <i class="iconfont icon-renzheng" title="认证信息：版主"></i>
                                <i class="layui-badge fly-badge-accept">版主</i>
                            </c:if>
                        </a>
                        <span id="release-time"></span>
                    </div>
                    <div class="detail-hits">
                        <c:if test="${user_info.userId==topic.userId}">
                            <span class="layui-btn layui-btn-xs jie-admin" type="edit"><a onclick="x_admin_show('编辑帖子','/forum/detail/edit?tid=${topic.topicId}',550,600)">编辑此贴</a></span>
                        </c:if>
                        <c:if test="${user_info.userId!=topic.userId}">
                            <span class="layui-btn" style="visibility: hidden"></span>
                        </c:if>
                    </div>
                </div>
                <div class="detail-body">
                    ${topic.content}
                </div>
            </div>

            <div class="fly-panel detail-box" id="flyReply">
                <ul class="jieda" id="jieda">
                    <c:forEach items="${page.list}" var="item" varStatus="S">
                        <li>
                            <div class="detail-about detail-about-reply">
                                <a class="fly-avatar" href="">
                                    <img src="../${item.face}"
                                         alt=" ">
                                </a>
                                <div class="fly-detail-user">
                                    <a href="" class="fly-link">
                                        <cite>${item.userName}</cite>
                                    </a>
                                    <span style="float: right;padding-right: 20px">#${(page.currentPage-1)*page.pageSize+S.count} 楼</span>
                                </div>
                                <div class="detail-hits">
                                    <span id="t${S.count}"></span>
                                </div>
                            </div>
                            <div class="detail-body jieda-body photos">
                                    ${item.content}
                            </div>
                            <div class="jieda-reply">
                            <span type="reply">
                      <i class="iconfont icon-svgmoban53"></i>
                      回复
                    </span>
                                <div class="jieda-admin">
                                    <span type="del">删除</span>
                                </div>
                            </div>
                        </li>
                    </c:forEach>


                    <!-- 无数据时 -->
                    <c:if test="${page.total==0}">
                        <li class="fly-none">还没有人发表回复，快来抢沙发吧！</li>
                    </c:if>
                </ul>
                <c:if test="${page.total>0}">
                    <div id="split" class="" align="right" style=""></div>
                </c:if>
                <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
                    <legend>回帖</legend>
                </fieldset>

                <div class="layui-form layui-form-pane">
                    <form action="/forum/detail" method="post">
                        <div class="layui-form-item layui-form-text">
                            <div class="layui-input-block">
                                <c:if test="${user_info!=null}">
                                <input type="hidden" name="tid" value="${topic.topicId}">
                                <textarea id="content" name="content"
                                          placeholder="请输入内容" lay-verify="content" class="layui-textarea fly-editor"
                                          style="height: 150px;"></textarea>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <input type="hidden" name="jid" value="123">
                            <button class="layui-btn" lay-filter="*" lay-submit="">提交回复</button>
                        </div>
                        </c:if>
                        <c:if test="${user_info==null}">
                        <div align="center"> 登录后才可回帖，是否<a style="color: #009688;" href="/login">登录</a></div>
                </div>
            </div>
            </c:if>
            </form>
        </div>
    </div>
</div>
<div class="layui-col-md4">

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

<script>
    layui.use(['element', 'form', 'layedit', 'util', 'laypage'], function () {
        var element = layui.element,
            form = layui.form,
            layedit = layui.layedit,
            util = layui.util,
            laypage = layui.laypage,
            layer = layui.layer;
        var index = layedit.build('content'); //建立编辑器
        form.render();
        element.on('tab(demo)', function (data) {
            console.log(data);
        });
        var time = "${topic.releaseTime}";
        time = time.replace(new RegExp("-", "gm"), "/").substr(0, time.length - 2);
        // console.log(time);
        $("#release-time").html(util.timeAgo(new Date(time).getTime(), true));

        <c:forEach items="${page.list}" var="item" varStatus="S">
        var time1 = "${item.releaseTime}";
        time1 = time1.replace(new RegExp("-", "gm"), "/").substr(0, time.length - 2);
        // console.log(time);
        $("#t${S.count}").html(util.timeAgo(new Date(time1).getTime(), true));
        </c:forEach>

        $(".option").click(function () {
            var type = this.getAttribute("type"),
                tid = ${topic.topicId};
            console.log(type);
            console.log(tid);
            $.ajax({
                url: "/forum/detail",
                type: "post",
                data: {
                    type: type,
                    tid:tid
                },
                success: function () {
                    layer.msg('操作成功');
                    setTimeout(function () {
                        if (type=="del"){
                            location.href = "/forum";
                        }else{
                            location.reload();
                        }
                    }, 1000);
                }
            });
        });
        form.verify({
            content: function (value) {
                return layedit.sync(index);
            }
        });

        form.on('submit()', function (data) {
            console.log(data);
            $.ajax({
                url: data.form.action,
                type: data.form.method,
                data: data.field,
                dataType: "json",
                success: function (data) {
                    $.each(data, function (i, n) {
                        console.log(n);//显示name和test
                    });
                }
            });
            if (data.field.content != '') {
                layer.alert("回复成功", {icon: 1}, function () {
                    window.location.reload();
                });
            } else {
                layer.alert("回复失败，请输入回复内容", {icon: 2});
            }

            return false;
        });
        laypage.render({
            elem: 'split',
            count: ${page.total}, //数据总数
            limit: 6,
            curr:${page.currentPage},
            jump: function (obj, first) {
                //obj包含了当前分页的所有参数，比如：
                console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                console.log(obj.limit); //得到每页显示的条数

                //首次不执行
                if (!first) {
                    location.href = "/forum/detail?tid=${topic.topicId}&currPage=" + obj.curr;
                }
            }
        });
    });

</script>
</body>

</html>