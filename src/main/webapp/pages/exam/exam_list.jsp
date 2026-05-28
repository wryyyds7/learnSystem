<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/15
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
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
        <cite>答卷列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so" action="/examInfoList.html" method="post">
            <input type="text" name="paperName" placeholder="请输入试卷名称" autocomplete="off" class="layui-input" value="${p.condition.paperName}">
            <input type="text" name="studentName" placeholder="请输入考生姓名" autocomplete="off" class="layui-input" value="${p.condition.studentName}">
            <div class="layui-unselect layui-form-select" style="width: 150px;display: inline-block">
                <select name="isTested" id="isTested">
                    <option value="-1">请选择考试状态</option>
                    <option value="1" ${p.condition.isTested==1?"selected":""}>已考</option>
                    <option value="0" ${p.condition.isTested==0?"selected":""}>未考</option>
                </select>
            </div>
            <div class="layui-unselect layui-form-select" style="width: 150px;display: inline-block">
                <select name="isRead" id="isRead">
                    <option value="-1">请选择批阅状态</option>
                    <option value="1" ${p.condition.isRead==1?"selected":""}>已批阅</option>
                    <option value="0" ${p.condition.isRead==0?"selected":""}>未批阅</option>
                </select>
            </div>
            <button class="layui-btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <xblock>
        <button style="visibility: hidden;" class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>
        <span class="x-right" style="line-height:40px">共有数据：${p.total} 条</span>
    </xblock>
    <table class="layui-table layui-form">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th>编号</th>
            <th>考生名</th>
            <th>试卷名</th>
            <th>是否已考</th>
            <th>是否批阅</th>
            <th>批阅人</th>
            <th>试卷得分</th>
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
                <td>${item.studentName}</td>
                <td>${item.paperName}</td>
                <td>
                    <c:if test="${item.isTested==1}">
                        已考
                    </c:if>
                    <c:if test="${item.isTested==0}">
                        未考
                    </c:if>
                </td>
                <td>
                    <c:if test="${item.isRead==1}">
                        已批阅
                    </c:if>
                    <c:if test="${item.isRead==0}">
                        未批阅
                    </c:if>
                </td>
                <td>${item.teacherName}</td>
                <td>${item.score}</td>
                <td class="td-manage">
                    <a title="批阅" onclick="x_admin_show('批阅','member-edit.html',600,400)" href="javascript:;">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <a title="删除" onclick="member_del(this,'${item.paperId}','${item.studentId}')" href="javascript:;">
                        <i class="layui-icon">&#xe640;</i>
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
                    location.href="/examInfoList.html?currentPage="+obj.curr;
                }
            }
        });
    });
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        //执行一个laydate实例
        laydate.render({

        });

//        //执行一个laydate实例
//        laydate.render({
//            elem: '#end' //指定元素
//        });
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

    /*试卷信息-删除*/
    function member_del(obj, paperid,studentid) {
        layer.confirm('确认要删除吗？', function(index) {
            console.log(paperid,studentid)
            //发异步删除数据
            $.ajax({
                url:"/examDel.html",
                type:"post",
                data:{
                    paperId:paperid,
                    studentId:studentid
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
