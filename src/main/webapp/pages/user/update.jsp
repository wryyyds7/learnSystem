<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html><!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
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
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
</head>

<body>
<div class="x-body">
    <form class="layui-form layui-form-pane" action="/user/infoUpdate" method="post" enctype="multipart/form-data">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-inline" id="user_name">
                <input type="text" required="" value="${user_info.userName}" class="layui-input" disabled>
            </div>
        </div>
        <div style="border: 1px solid #e6e6e6;border-radius:2px;position: absolute;left: 335px;top: 20px;">
            <a href="javascript:(0)" id="upload_face"><img id="face" src="../${user_info.face}" alt="修改头像" width="123"></a>
            <div align="center" style="position:relative;">上传头像</div>
            <input type="hidden"  value="${user_info.face}" id="face-src" name="face">
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-inline">
                <input type="password" id="L_pass" name="password" lay-verify="pass"
                       placeholder="密码为6-16位,空为不修改" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认密码</label>
            <div class="layui-input-inline">
                <input type="password" id="L_repass" lay-verify="repass" placeholder="确认你的密码"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" lay-verify="eamli" name="email" placeholder="选填项，可为空" value="${user_info.email}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" lay-verify="required|phone|number"  placeholder="必填项，不可为空" name="tel" value="${user_info.tel}">
            </div>
        </div>
        <div class="layui-form-item" pane="">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="1" title="男" ${user_info.genderId==1?"checked":" "}>
                <input type="radio" name="sex" value="2" title="女" ${user_info.genderId==2?"checked":" "}>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">生日</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" id="bir" name="bir" value="${user_info.birthday}" placeholder="请选择你的生日">
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">简介</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea" name="introduction"><c:if test="${user_info.introduction!=null}">${user_info.introduction}</c:if><c:if test="${user_info.introduction==null}">这个人很懒，什么都没留下！</c:if></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <button class="layui-btn" lay-submit="">修改</button>
        </div>
    </form>
</div>
<script>
    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var form = layui.form
            , layer = layui.layer;

        //自定义验证规则
        form.verify({
            pass: function (value) {
                if (value.length > 0) {
                    if (!new RegExp("^(.+){6,12}$").test(value)) {
                        return '密码必须6到12位';
                    }
                }
            }
            , repass: function (value) {
                if ($('#L_pass').val() != $('#L_repass').val()) {
                    return '两次密码不一致';
                }
            }
            , eamli: function (value) {
                if (value.length > 0) {
                    if (!new RegExp("^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$").test(value)) {
                        return '请输入正确的邮箱格式';
                    }
                }

            }
        });

        //监听提交
        form.on('submit()', function (data) {
            console.log(data);
            $.ajax({
                url:data.form.action,
                type:data.form.method,
                data:data.field,
                dataType: "json",
                success: function(data){
                    $.each(data,function(i,n){
                        console.log(n);//显示name和test
                    });
                }
            });
            layer.alert("修改成功", {icon: 1}, function () {
                // 获得frame索引
                window.parent.location.reload();
                var index = parent.layer.getFrameIndex(window.name);
                //关闭当前frame
                parent.layer.close(index);
            });
            return false;
        });

        layui.use('laydate', function () {
            var laydate = layui.laydate;
            //执行一个laydate实例
            laydate.render({
                elem: '#bir' //指定元素
            });
        });

        layui.use('upload', function () {
            var upload = layui.upload;
            //执行实例
            var uploadInst = upload.render({
                elem: '#upload_face' //绑定元素
                , url: '/user/faceUpload'
                , acceptMime: 'image/jpg, image/jpeg ,image/png ,image/gif'
                , done: function (res) {
                    //上传完毕回调
                    $("#face").attr("src","../"+res.src);
                    $("#face-src").attr("value",res.src);
                }
                , error: function () {
                    //请求异常回调
                }
            });
        });
    });
    $("#user_name").click(function () {
        layer.msg("用户名可不能更改哟~");
    });
</script>
<script>var _hmt = _hmt || [];
(function () {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();</script>
</body>

</html>