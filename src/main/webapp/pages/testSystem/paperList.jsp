<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>试卷管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
    <link rel="stylesheet" href="../../css/font.css">
    <link rel="stylesheet" href="../../css/xadmin.css">
    <script type="text/javascript" src="../../js/jq/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/xadmin.js"></script>
</head>

<body class="layui-anim layui-anim-up">
<div class="x-nav">
    <span class="layui-breadcrumb">
      <a href="">首页</a>
      <a href="">演示</a>
      <a>
        <cite>导航元素</cite></a>
    </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);"
       title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so" method="post" action="/paper.html">
            <input type="text" value="${p.condition.paperName}" name="paperName" placeholder="请输入试卷名称" autocomplete="off" class="layui-input">
            <input type="submit" class="layui-btn layui-icon" value="&#xe615;">
        </form>
    </div>
    <xblock>
        <button class="layui-btn" onclick="x_admin_show('添加用户','/addPaper.html',600,400)"><i class="layui-icon"></i>添加</button>
        <span class="x-right" style="line-height:40px">共有数据：${p.total} 条</span>
    </xblock>
    <table class="layui-table layui-form">
        <thead>
        <tr>
            <th>序号</th>
            <th>试卷名</th>
            <th>出卷人</th>
            <th>出卷时间</th>
            <th>试卷总分</th>
            <th>开考时间</th>
            <th>结束时间</th>
            <th>开始总时间（分钟）</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${p.list}" var="item" varStatus="S">
            <tr>
                <td>${S.count}</td>
                <td>${item.paperName}</td>
                <td>${item.userName}</td>
                <td>${item.paperStart}</td>
                <td>${item.score}</td>
                <td>${item.startTime}</td>
                <td>${item.endTime}</td>
                <td>${item.paperTime}</td>
                <td class="td-manage">
                    <a title="编辑" onclick="x_admin_show('编辑','/updatePaper.html?paperid=${item.paperid}',600,400)" href="javascript:;">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <a title="删除" name="delPaper" href="delPaper.html?paperid=${item.paperid}">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="page">
        <div>
            <c:if test="${p.currentPage==1}">
                <a class="prev" href="javascript:void(0);">&lt;&lt;</a>
                <a class="num" href="javascript:void(0);">1</a>
            </c:if>
            <c:if test="${p.currentPage>1}">
                <a class="prev" href="/paper.html?currentPage=${p.currentPage-1}">&lt;&lt;</a>
                <a class="num" href="/paper.html?currentPage=1">1</a>
            </c:if>
            <span class="current">${p.currentPage}</span>
            <c:if test="${p.currentPage==p.totalPage}">
                <a class="num" href="javascript:void(0);">${p.totalPage}</a>
                <a class="next" href="javascript:void(0);">&gt;&gt;</a>
            </c:if>
            <c:if test="${p.currentPage<p.totalPage}">
                <a class="num" href="/paper.html?currentPage=${p.totalPage}">${p.totalPage}</a>
                <a class="next" href="/paper.html?currentPage=${p.currentPage+1}">&gt;&gt;</a>
            </c:if>
        </div>
    </div>

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
                layer.msg('已停用!', { icon: 5, time: 1000 });

            } else {
                $(obj).attr('title', '启用')
                $(obj).find('i').html('&#xe601;');

                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                layer.msg('已启用!', { icon: 5, time: 1000 });
            }

        });
    }

    /*用户-删除*/
    function member_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            //发异步删除数据
            $(obj).parents("tr").remove();
            layer.msg('已删除!', { icon: 1, time: 1000 });
        });
    }



    function delAll(argument) {

        var data = tableCheck.getData();

        layer.confirm('确认要删除吗？' + data, function (index) {
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', { icon: 1 });
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }
</script>
</body>

</html>
