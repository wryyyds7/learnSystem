var currPage =1;

function getListData(){
    $.ajax({
        type: 'GET',
        url: "/forum/detail", // ajax请求路径
        data: {
            page:currPage, //当前页数
            rows:10
        },
        success: function(data){
            data = JSON.parse(data);
            console.log(data)
            // pageCount =data.result.pageCount;
            // shuju(data.result.dataList);
            // paged(data);
        }
    });
};

function paged(data){
    layui.use(['laypage', 'layer'], function() {
        var laypage = layui.laypage
            , layer = layui.layer;
        var nums =10; //每页出现数量

        laypage.render({
            elem:'split' // 容器id
            , count: pageCount //总页数
            , curr: currPage
            , jump: function (obj,first) {
                currPage =obj.curr;  //这里是后台返回给前端的当前页数
                if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr  ajax 再次请求
                    getListData(currPage);
                }
            }
        });
    });
}