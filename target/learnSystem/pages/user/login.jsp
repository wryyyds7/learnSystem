<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>在线学习系统-登录</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
    <link rel="stylesheet" href="../../css/font.css">
    <link rel="stylesheet" href="../../css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="../../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/xadmin.js"></script>
    <link type="text/css" rel="stylesheet" href="../../css/img_ver.css">
    <script src="../../js/jquery-1.10.2.js"></script>
    <script src="../../js/img_ver.js"></script>
</head>
<script>
    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var layer = layui.layer;
        if (${user_info!=null}) {
            layer.msg('你已登录，请不要重复登录');
            window.setTimeout(function () {
                // window.location.href = "/";
                self.location=document.referrer;
            }, 2000);
        }
    });
</script>
<body class="login-bg">
<div class="login layui-anim layui-anim-up">
    <div class="message">用户登录</div>
    <div id="darkbannerwrap"></div>

    <form class="layui-form" id="login" action="/login" method="post">
        <div class="layui-form-item">
            <input name="username" id="username" placeholder="用户名" type="text" lay-verify="required"
                   class="layui-input">
        </div>
        <div class="layui-form-item">
            <input name="password" id="password" lay-verify="required" placeholder="密码" type="password"
                   class="layui-input">
        </div>
        <div class="layui-form-item">
            <div id="imgVer" style="display:inline-block;margin-left: 20px;" lay-verify="required"></div>
        </div>
        <div class="layui-form-item">
            <button class="layui-btn" id="log" lay-submit="" style="width:100%;height: 48px;">登录</button>
        </div>
        <span class="x-right"><a href="/register">还没有帐号？点此注册</a></span>
    </form>
</div>
<script>
    layui.use(['form'], function () {
        // $ = layui.jquery;
        var form = layui.form
            , layer = layui.layer;
        form.on('submit()', function (data) {
            console.log(data);
            $.ajax({
                "url": data.form.action,
                "type": data.form.method,
                "data": data.field,
                "dataType": "json",
                success:function (data) {
                    // console.log(data.msg);
                    if (data.msg) {
                        layer.msg('登录成功！即将返回上一页');
                        window.setTimeout(function () {
                            // window.location.href = "/";
                            self.location=document.referrer;
                        }, 2000);
                    } else {
                        layer.msg('登录失败！请检查账户名和密码');
                    }
                }
            });


            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });
    });

    imgVer({
        el: '$("#imgVer")',
        width: '260',
        height: '116',
        img: [
            '../images/ver.png',
            '../images/ver-1.png',
            '../images/ver-2.png',
            '../images/ver-3.png'
        ],
        success: function () {
            //alert('执行登录函数');
            if ($('#username').val() == '' || $('#password').val() == '') {
                layer.msg('请输入用户名/密码');
                $("#imgVer").attr('lay-verify', "required");
            } else {
                $("#imgVer").attr('lay-verify', "false");
            }
        },
        error: function () {
            //alert('错误什么都不执行')
        }
    });

    $(".submit").on('click', function () {

    })
</script>
</body>
</html>
