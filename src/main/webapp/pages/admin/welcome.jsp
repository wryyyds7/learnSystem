<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />

    <link rel="shortcut icon" href="../../images/logo.png" type="image/x-icon">
    <link rel="stylesheet" href="../../css/font.css">
    <link rel="stylesheet" href="../../css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="../../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/xadmin.js"></script>
    <script language="javascript">
        $(function(){
            //setInterval("$('#currentTime').text(new Date().toLocalsString());",1000);
            setInterval(function(){
                $("#currentTime").text(new Date().toLocaleString());
            },1000);
        });
    </script>
</head>

<body>
    <div class="x-body layui-anim layui-anim-up">
        <blockquote class="layui-elem-quote">欢迎管理员：
            <span class="x-red">${user_info.userName}</span></blockquote>
        <fieldset class="layui-elem-field">
            <legend>数据统计</legend>
            <div class="layui-field-box">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-body">
                            <div class="layui-carousel x-admin-carousel x-admin-backlog" lay-anim="" lay-indicator="inside"
                                lay-arrow="none" style="width: 100%; height: 90px;">
                                <div carousel-item="">
                                    <ul class="layui-row layui-col-space10 layui-this">
                                        <li class="layui-col-xs2">
                                            <a href="javascript:;" class="x-admin-backlog-body">
                                                <h3>会员数</h3>
                                                <p>
                                                    <cite>${userCount}</cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs2">
                                            <a href="javascript:;" class="x-admin-backlog-body">
                                                <h3>主题数</h3>
                                                <p>
                                                    <cite>${topicCount}</cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs2">
                                            <a href="javascript:;" class="x-admin-backlog-body">
                                                <h3>回复数</h3>
                                                <p>
                                                    <cite>${topicBackCount}</cite></p>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
        <fieldset class="layui-elem-field">
            <legend>系统通知</legend>
            <div class="layui-field-box">
                <table class="layui-table" lay-skin="line">
                    <tbody>
                        <tr>
                            <td>
                                <a class="x-a" href="/" target="_blank">在线学习系统1.0上线了</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a class="x-a" href="/" target="_blank">交流qq群:(*******)</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
        <fieldset class="layui-elem-field">
            <legend>系统信息</legend>
            <div class="layui-field-box">
                <table class="layui-table">
                    <tbody>
                        <tr>
                            <th>当前版本</th>
                            <td>1.0</td>
                        </tr>
                        <tr>
                            <th>服务器地址</th>
                            <td>127.0.0.1</td>
                        </tr>
                        <tr>
                            <th>操作系统</th>
                            <td>Windows 10</td>
                        </tr>
                        <tr>
                            <th>服务器版本</th>
                            <td>Apache-Tomcat-9.0.13 (Win64)</td>
                        </tr>
                        <tr>
                            <th>JDK版本</th>
                            <td>11.0.1</td>
                        </tr>
                        <tr>
                            <th>Oracle版本</th>
                            <td>11.2.0</td>
                        </tr>
                        <tr>
                            <th>上传附件限制</th>
                            <td>2M</td>
                        </tr>
                        <tr>
                            <th>执行时间限制</th>
                            <td>30s</td>
                        </tr>
                        <tr>
                            <th>剩余空间</th>
                            <td>809M</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
        <fieldset class="layui-elem-field">
            <legend>开发团队</legend>
            <div class="layui-field-box">
                <table class="layui-table">
                    <tbody>
                        <tr>
                            <th>开发者</th>
                            <td>outas<a href="https://outas.cc" target="_blank">(个人博客)</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
    </div>
</body>

</html>