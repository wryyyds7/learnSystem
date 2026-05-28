<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>发表主题帖</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="shortcut icon" href="../../images/logo.png" type="image/x-icon">
  <link rel="stylesheet" href="../../lib/layui/css/layui.css">
  <link rel="stylesheet" href="../../css/global.css">
  <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
  <script src="../../lib/layui/layui.js"></script>
</head>
<body>
<div class="layui-container fly-marginTop">
  <div class="fly-panel" pad20 style="padding-top: 5px;">
    <div class="layui-form layui-form-pane">
        <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
          <div class="layui-tab-item layui-show">
            <form action="/forum/detail/edit" method="post">
              <input type="hidden" name="tid" value="${topic.topicId}">
              <div class="layui-row layui-col-space15 layui-form-item">
                <div class="layui-col-sm4">
                  <label class="layui-form-label">所在板块</label>
                    <div class="layui-input-block">
                      <select name="bid" lay-verify="required|bid" >
                        <option value="-1">请选择板块</option>
                       <c:forEach items="${boardList}" var="item" varStatus="S">
                         <c:if test="${item.boardId==topic.boardId}">
                           <option value="${S.count}" selected>${item.boardName}</option>
                         </c:if>
                         <c:if test="${item.boardId!=topic.boardId}">
                           <option value="${S.count}">${item.boardName}</option>
                         </c:if>
                       </c:forEach>
                      </select>
                    </div>
                </div>
                <div class="layui-col-sm8">
                  <label for="L_title" class="layui-form-label">标题</label>
                  <div class="layui-input-block">
                    <input type="text" id="L_title" name="title"  lay-verify="title" autocomplete="off" class="layui-input" value="${topic.title}">
                  </div>
                </div>
              </div>
              <div class="layui-form-item layui-form-text">
                <div class="layui-input-block">
                  <textarea id="content" name="content" placeholder="请输入帖子内容" class="layui-textarea" lay-verify="content" style="height: 260px;">${topic.content}</textarea>
                </div>
              </div>
              <div class="layui-form-item">
                <button class="layui-btn"  lay-submit>立即发布</button>
              </div>
            </form>
          </div>
        </div>
      </div>
  </div>
</div>


<script>
    layui.use(['form','layedit'], function(){
        var form = layui.form;
        //监听提交
        var layedit = layui.layedit;
        var index =  layedit.build('content'); //建立编辑器
        form.verify({
            bid:function (value) {
                if(value<0){
                    return '请选择板块';
                }
            },
            title:function (value) {
                if(value.length<=0){
                    return '请输入帖子标题';
                }
            },
            content: function(value) {
                return layedit.sync(index);
            }
        });
        var content ;
        form.on('submit()', function(data){
            $.ajax({
                url:data.form.action,
                type:data.form.method,
                data:data.field,
                dataType: "json",
                success: function(data){
                }
            });
           if(data.field.content!=''){
               layer.alert("发布成功", {icon: 1}, function () {
                   // 获得frame索引
                   window.parent.location.reload();
                   var index = parent.layer.getFrameIndex(window.name);
                   //关闭当前frame
                   parent.layer.close(index);
               });
           }else{
               layer.alert("发布失败，请输入帖子内容", {icon: 2});
           }

            // layer.msg(JSON.stringify(data.field));
            return false;
        });
    });
</script>

</body>
</html>