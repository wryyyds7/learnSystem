<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 雷 福 贵
  Date: 2018/12/12
  Time: 18:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>论坛板块</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="shortcut icon" href="../../images/logo.png" type="image/x-icon">
    <link rel="stylesheet" href="../../css/font.css">
    <link rel="stylesheet" href="../../css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/xadmin.js"></script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">论坛管理</a>
        <a>
          <cite>板块列表</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right;"
       href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">

        <form class="layui-form layui-col-md12 x-so">
            <%--<input class="layui-input" placeholder="分类名" name="cate_name">--%>
            <a class="layui-btn" lay-submit="" onclick="x_admin_show('添加板块','/admin/board/add',400,300)"><i
                    class="layui-icon"></i>增加板块</a>
        </form>
    </div>
    <!-- <blockquote class="layui-elem-quote">每个tr 上有两个属性 cate-id='1' 当前分类id fid='0' 父级id ,顶级分类为 0，有子分类的前面加收缩图标<i class="layui-icon x-show" status='true'>&#xe623;</i></blockquote> -->
    <xblock>
        <%--<button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>--%>
            <form class="layui-form layui-col-md12 x-so" action="/admin/board/list" method="get">
                <input type="hidden" name="currentPage">
                <xblock>
                    <input class="layui-input" type="text" name="boardName" value="${p.condition.boardName}">
                    <input class="layui-btn" type="submit" value="搜索"><span class="x-right" style="line-height:40px">共有数据：${count} 条</span>
                </xblock>
            </form>
    </xblock>
    <table class="layui-table layui-form">
        <thead>
        <tr>
            <%--<th width="20">--%>
                <%--<div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i--%>
                        <%--class="layui-icon">&#xe605;</i></div>--%>
            <%--</th>--%>
            <th width="70">板块ID</th>
            <th>版块名</th>
            <th width="70">版主</th>
            <th width="50">状态</th>
            <th width="185">操作</th>
        </thead>
        <tbody class="x-cate">

        <c:forEach items="${p.list}" var="i">
            <tr cate-id='1' fid='0'>
                <td>${i.boardId}</td>
                <td>${i.boardName}</td>
                <td>${i.userName}</td>
                <td>
                    <input type="checkbox" name="switch" lay-text="开启|停用" checked="" lay-skin="switch">
                </td>
                <td class="td-manage">
                    <button class="layui-btn layui-btn layui-btn-xs"  onclick="x_admin_show('编辑','/admin/board/edit?boardId=${i.boardId}',400,300)" ><i class="layui-icon">&#xe642;</i>编辑</button>
                    <button class="layui-btn-danger layui-btn layui-btn-xs" style="margin-left: 0px;" onclick="board_del(this,'${i.boardId}')"><i class="layui-icon">&#xe640;</i>删除</button>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
    <%--<%@include file="../pages/Page.jsp" %>--%>
</div>
<style type="text/css">

</style>
<script>
    layui.use(['form'], function () {
        form = layui.form;
    });

    /*用户-删除*/
    function board_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            //发异步删除数据
            $.ajax({
                url:"/admin/board/del",
                type:"get",
                data:{boardId:id}
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
