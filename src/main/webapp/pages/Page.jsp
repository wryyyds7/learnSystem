<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 雷 福 贵
  Date: 2018/12/3
  Time: 17:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
function go(page) {
//跳转到第n页，并提交表单
var crtPage = document.getElementsByName("currentPage")[0];
if(crtPage){
crtPage.value = page;
}
var form = document.getElementsByTagName("form")[0];
if(form){
form.submit();
}

}
</script>
<div align="right">
    <c:if test="${p.currentPage==1}">
        <a href="javascript:void(0);">首页</a> <a href="javascript:void(0);">上一页</a>
    </c:if>
    <c:if test="${p.currentPage>1}">
        <a href="javascript:go(1)">首页</a> <a href="javascript:go(${p.currentPage-1})">上一页</a>
    </c:if>
    当前页数:[${p.currentPage}/${p.totalPage}]
    <c:if test="${p.currentPage==p.totalPage}">
        <a href="javascript:void(0);">下一页</a> <a href="javascript:void(0);">末页</a>
    </c:if>
    <c:if test="${p.currentPage<p.totalPage}">
        <a href="javascript:go(${p.currentPage+1})">下一页</a> <a href="javascript:go(${p.totalPage})">末页</a>
    </c:if>
</div>