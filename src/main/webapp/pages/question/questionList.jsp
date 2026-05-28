<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/12
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>题库管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
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
      <a href="">考试管理</a>
      <a>
        <cite>题库列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so" method="post" action="/questionList.html" id="form1">
            <input type="hidden" name="currentPage" id="currentPage1" value="1">
            <input class="layui-input" placeholder="开始时间" name="start" id="start" value="${p.condition.startTime}">
            <input class="layui-input" placeholder="截止时间" name="end" id="end" value="${p.condition.endTime}">
            <input type="text" name="question" placeholder="请输入题目名称" autocomplete="off" class="layui-input" value="${p.condition.question}">
            <div class="layui-unselect layui-form-select" style="width: 150px;display: inline-block">
                <select name="type1" id="type1">
                    <option value="-1">选择题型</option>
                    <c:forEach items="${list}" var="item" varStatus="s">
                        <option value="${item.typeId}"  ${item.typeId==p.condition.typeId?"selected":""}>${item.typeName}</option>
                    </c:forEach>
                </select>
            </div>
            <button class="layui-btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <xblock>
        <button class="layui-btn" onclick="x_admin_show('添加题目','/questionAdd.html',600,400)"><i class="layui-icon"></i>添加</button>
        <span class="x-right" style="line-height:40px">共有数据：${p.total} 条</span>
    </xblock>
    <table class="layui-table layui-form">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th>序号</th>
            <th>题名</th>
            <th>创建时间</th>
            <th>题型</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${p.list}" var="item" varStatus="s">
            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='2'><i class="layui-icon">&#xe605;</i></div>
                </td>
                <td>${s.count}</td>
                <td>${item.question}</td>
                <td>${item.addTime}</td>
                <td>${item.typeName}</td>
                <td>
                    <input type="checkbox" name="switch" lay-text="正常|封禁" checked="" lay-skin="switch">
                </td>
                <td class="td-manage">
                    <%--<a onclick="member_stop(this,'10001')" href="javascript:;" title="启用">--%>
                        <%--<i class="layui-icon">&#xe601;</i>--%>
                    <%--</a>--%>
                    <a title="编辑" onclick="x_admin_show('编辑','/questionUpdate.html?quId=${item.questionId}',600,400)" href="javascript:;" >
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <%--<a onclick="x_admin_show('修改密码','member-password.html',600,400)" title="修改密码" href="javascript:;">--%>
                        <%--<i class="layui-icon">&#xe631;</i>--%>
                    <%--</a>--%>
                    <a title="删除" onclick="member_del(this,'${item.questionId}')" href="javascript:;">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="page">
        <div id="text1">
            <%--<a class="prev" href="">&lt;&lt;</a>--%>
            <%--<a class="" href="">1</a>--%>
            <%--<span class="current">2</span>--%>
            <%--<a class="num" href="">3</a>--%>
            <%--<a class="num" href="">489</a>--%>
            <%--<a class="next" href="">&gt;&gt;</a>--%>
        </div>
    </div>

</div>
<script>
    layui.use(['form'], function() {
        form = layui.form;
    });
    layui.use(['laypage', 'layer'], function() {
        var laypage = layui.laypage
            , layer = layui.layer;
        laypage.render({
            elem:"text1",
            count:${p.total},
            limit:${p.pageSize},
            curr:${p.currentPage},
            jump:function (obj,first) {
                if(!first){
                    location.href="/questionList.html?currentPage="+obj.curr;
                }
            }
        });
    });
    layui.use('laydate', function() {
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#666'//指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });

    /*用户-停用*/
    function member_stop(obj, id) {
        layer.confirm('确认要停用吗？', function(index) {

            if ($(obj).attr('title') == '启用') {

                //发异步把用户状态进行更改
                $(obj).attr('title', '停用')
                $(obj).find('i').html('&#xe62f;');

                $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                layer.msg('已停用!', {
                    icon: 5,
                    time: 1000
                });

            } else {
                $(obj).attr('title', '启用')
                $(obj).find('i').html('&#xe601;');

                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                layer.msg('已启用!', {
                    icon: 5,
                    time: 1000
                });
            }

        });
    }
    /*题目-删除*/
    function member_del(obj, id) {
        layer.confirm('确认要删除吗？', function(index) {
            //发异步删除数据
            $.ajax({
                url:"/questionDel.html",
                type:"post",
                data:{
                    quId:id
                }
            })
            $(obj).parents("tr").remove();
            layer.msg('已删除!', {
                icon: 1,
                time: 1000
            });
        });
    }
    function delAll(argument) {

        var data = tableCheck.getData();

        layer.confirm('确认要删除吗？' + data, function(index) {
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {
                icon: 1
            });
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }
</script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
</body>

</html>
