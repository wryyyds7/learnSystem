<%--
  Created by IntelliJ IDEA.
  User: 雷 福 贵
  Date: 2018/12/13
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
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

<body>
<div class="x-body layui-anim layui-anim-up">
    <form class="layui-form" action="/admin/board/add" method="post">

        <div class="layui-form-item">
            <label for="L_username" class="layui-form-label">
                <span class="x-red">*</span>板块名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_username" name="boardName" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_pass" class="layui-form-label">
                <%--<span class="x-red">*</span>密码--%>
                <span class="x-red">*</span>版主编号
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_pass" name="userId" required="" lay-verify="required"
                        autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">

            </div>
        </div>

        <div class="layui-form-item">
            <%--<label for="L_repass" class="layui-form-label">--%>
            <%--</label>--%>
            <button class="layui-btn" lay-filter="add" lay-submit>
                增加
            </button>
            <%--<button class="layui-btn" type="submit">增加</button>--%>
        </div>
    </form>
</div>
<script>
    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var form = layui.form
            , layer = layui.layer;
        //监听提交
        form.on('submit(add)', function (data) {
            console.log(data);
            //发异步，把数据提交给php

            console.log(data);
            $.ajax({
                url:"/admin/board/add",
                type:"post",
                data: data.field,
                success:function(data){
                    var msg="增加失败";
                    if(data==1){
                        msg = "增加成功"
                    }
                    layer.alert(msg, {icon: 6}, function () {
                        // 获得frame索引
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        window.parent.location.reload();
                        parent.layer.close(index);
                    });

                }
            })

            return false;
        });


    });
</script>
</body>

</html>
