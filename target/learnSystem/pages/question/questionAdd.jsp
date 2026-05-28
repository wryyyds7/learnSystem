<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/10
  Time: 19:51
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>添加题目</title>
    <style>
        .hi{
            display: none;
        }
        .show{
            display: block;
        }
    </style>
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

<body>
<div class="x-body layui-anim layui-anim-up">
    <form class="layui-form" action="/questionAdd.html" method="post">
        <div class="layui-form-item">
            <select name="type1" id="type1">
                <c:forEach items="${list}" var="item" varStatus="s">
                    <option value="${item.typeId}">${item.typeName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="layui-form-item">
            <label for="L_email" class="layui-form-label">
                <span class="x-red">*</span>题干
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_email" name="question"  autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div id="xuanzhe" class="hi show">
            <div class="layui-form-item">
                <label  class="layui-form-label">
                    <span class="x-red">*</span>选项A
                </label>
                <div class="layui-input-inline">
                    <input type="text" name="chose1" lay-verify="nikename" autocomplete="off" class="layui-input" id="chose1">
                </div>
            </div>
            <div class="layui-form-item">
                <label  class="layui-form-label">
                    <span class="x-red">*</span>选项B
                </label>
                <div class="layui-input-inline">
                    <input type="text"  name="chose2" lay-verify="" autocomplete="off" class="layui-input" id="chose2">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">
                    <span class="x-red">*</span>选项C
                </label>
                <div class="layui-input-inline">
                    <input type="text" name="chose3" lay-verify="" autocomplete="off" class="layui-input" id="chose3">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">
                    <span class="x-red">*</span>选项D
                </label>
                <div class="layui-input-inline">
                    <input type="text"  name="chose4" lay-verify="" autocomplete="off" class="layui-input" id="chose4">
                </div>
            </div>
            <div class="layui-form-item">
                <label  class="layui-form-label">
                    <span class="x-red">*</span>正确答案
                </label>
                <div class="layui-form-item hi show" id="radio">
                    <div class="layui-input-block" >
                        <label><input type="radio" value="A" name="choseRo" checked>A</label>
                        <label><input type="radio" value="B" name="choseRo">B</label>
                        <label><input type="radio" value="C" name="choseRo">C</label>
                        <label><input type="radio" value="D" name="choseRo">D</label>
                    </div>
                </div>
                <div class="layui-form-item hi" id="check">
                    <div class="layui-input-block" name="checkBox1">
                        <input type="checkbox" name="choseChe" value="A" title="A" checked>
                        <input type="checkbox" name="choseChe" value="B" title="B">
                        <input type="checkbox" name="choseChe" value="C" title="C">
                        <input type="checkbox" name="choseChe" value="D"  title="D">
                    </div>
                </div>
            </div>
        </div>
        <div class="hi" id="judge">
            <div class="layui-form-item">
                <label  class="layui-form-label">
                    <span class="x-red">*</span>正确答案
                </label>
                <div class="layui-input-inline">
                    <label><input type="radio" value="1" name="judge" checked>对</label>
                    <label><input type="radio" value="0" name="judge">错</label>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">
                解析
            </label>
            <div class="layui-input-inline">
                <textarea name="" id="texta" cols="30" rows="10"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">
            </label>
            <button class="layui-btn" lay-filter="add" lay-submit="">
                增加
            </button>
        </div>
    </form>
</div>
<script>
    layui.use(['form', 'layer'], function() {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;

        //监听提交
        form.on('submit()', function (data) {
            $("input:checkbox[name='choseChe']:checked").each(function() { // 遍历name=standard的多选框
                if(checkboxValue==0){
                    checkboxValue = $(this).val();
                    return true;
                }
                checkboxValue += ',' + $(this).val();

            });
            data.field.choseChe=checkboxValue;
            $.ajax({
                url:data.form.action,
                type:data.form.method,
                data:data.field
            })
            layer.alert("添加成功", {icon: 6}, function () {
                // 获得frame索引
                var index = parent.layer.getFrameIndex(window.name);
                window.parent.location.reload();
                //关闭当前frame
                parent.layer.close(index);
                layer.closeAll();
            });
            return false;
        });
        form.on('select', function(data){
            if (data.value==1){
                $("#xuanzhe").addClass("show").siblings().removeClass("show");
                $("#radio").addClass("show").siblings().removeClass("show");
                $("#chose1").attr("lay-verify","required");
                $("#chose2").attr("lay-verify","required");
                $("#chose3").attr("lay-verify","required");
                $("#chose4").attr("lay-verify","required");
            }else if(data.value==2){
                $("#xuanzhe").addClass("show").siblings().removeClass("show");
                $("#check").addClass("show").siblings("#radio").removeClass("show");
                $("#chose1").attr("lay-verify","required");
                $("#chose2").attr("lay-verify","required");
                $("#chose3").attr("lay-verify","required");
                $("#chose4").attr("lay-verify","required");
            }else if(data.value==3){
                $("#judge").addClass("show").siblings().removeClass("show");
                $("#chose1").removeAttr("lay-verify","required");
                $("#chose2").removeAttr("lay-verify","required");
                $("#chose3").removeAttr("lay-verify","required");
                $("#chose4").removeAttr("lay-verify","required");
            }else {
                $("#judge").removeClass("show").siblings().removeClass("show");
                $("#chose1").removeAttr("lay-verify","required");
                $("#chose2").removeAttr("lay-verify","required");
                $("#chose3").removeAttr("lay-verify","required");
                $("#chose4").removeAttr("lay-verify","required");
            }
        });
    });
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
