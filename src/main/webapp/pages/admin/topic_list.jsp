<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 雷 福 贵
  Date: 2018/12/10
  Time: 20:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>贴子</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="../../css/font.css">
    <link rel="stylesheet" href="../../css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/xadmin.js"></script>
</head>

<body class="layui-anim layui-anim-up">
<div class="x-nav">
    <span class="layui-breadcrumb">
      <a href="">首页</a>
      <a href="">论坛管理</a>
      <a>
        <cite>帖子管理</cite></a>
    </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.replace(location.href);"
       title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <xblock>
            <form class="layui-form layui-col-md12 x-so" action="/admin/topic/list" method="get">
                <input type="hidden" name="currentPage">
                <xblock>
                    <input class="layui-input" type="text" name="title" value="${p.condition.title}">
                    <input class="layui-btn" type="submit" value="搜索"><span class="x-right" style="line-height:40px">共有数据：${count} 条</span>
                </xblock>
            </form>
    </xblock>
    <table class="layui-table layui-form">

        <thead>
        <tr>
            <th>帖子ID</th>
            <th>板块名</th>
            <th>标题</th>
            <th>内容</th>
            <th>发布时间</th>
            <th>回复数</th>
            <th>置顶</th>
            <th>加精</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${p.list}" var="i" varStatus="s">
        <tr>
            <td>${i.topicId}</td>
            <td>
                <c:forEach items="${board}" var="item">
                    <c:if test="${item.boardId==i.boardId}">
                        ${item.boardName}
                    </c:if>
                </c:forEach>
            </td>
            <td>${i.title}</td>
            <td>${i.content}</td>
            <td>${i.releaseTime}</td>
            <td>${i.repliesCount}</td>
            <td>
                <c:if test="${i.top==1}">
                    是
                </c:if>
                <c:if test="${i.top==0}">
                    否
                </c:if>
            </td>
            <td>
                <c:if test="${i.highlight==1}">
                    是
                </c:if>
                <c:if test="${i.highlight==0}">
                    否
                </c:if>
            </td>
            <td class="td-manage">
                <button class="layui-btn-danger layui-btn layui-btn-xs" style="margin-left: 0px;"
                        onclick="topic_del(this,'${i.topicId}')"><i class="layui-icon">&#xe640;</i>删除
                </button>
            </td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
    <%@include file="../../pages/Page.jsp" %>
</div>
<script>
    layui.use(['form'], function () {
        form = layui.form;
    });

    layui.use('laydate', function () {
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });

    /*用户-停用*/
    function member_stop(obj, id) {
        layer.confirm('确认要停用吗？', function (index) {

            if ($(obj).attr('title') == '启用') {

                //发异步把用户状态进行更改
                $(obj).attr('title', '停用')
                $(obj).find('i').html('&#xe62f;');

                $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                layer.msg('已停用!', {icon: 5, time: 1000});

            } else {
                $(obj).attr('title', '启用')
                $(obj).find('i').html('&#xe601;');

                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                layer.msg('已启用!', {icon: 5, time: 1000});
            }

        });
    }

    /*用户-删除*/
    function topic_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            //发异步删除数据
            $.ajax({
                url: "/admin/topic/del",
                type: "get",
                data: {topicId: id}
            });
            location.reload();
            $(obj).parents("tr").remove();
            layer.msg('已删除!', {icon: 1, time: 1000});
        });
    }


    function delAll(argument) {

        var data = tableCheck.getData();

        layer.confirm('确认要删除吗？' + data, function (index) {
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {icon: 1});
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }
</script>
</body>

</html>
