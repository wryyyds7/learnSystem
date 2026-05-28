layui.use(['flow','util'], function () {
    var $ = layui.jquery; //不用额外加载jQuery，flow模块本身是有依赖jQuery的，直接用即可。
    var flow = layui.flow,
        util = layui.util;
    flow.load({
        elem: '#topicList' //流加载容器
        , isAuto: false
        , isLazyimg: true
        , done: function (page, next) { //加载下一页
            $.ajax({
                url: '/forum',
                type: 'post',
                dataType: "json",
                data: {
                    page: page,
                },
                success: function (data) {
                    console.log(data);
                    setTimeout(function(){
                        var lis = [];
                        console.log(data);
                        layui.each(data.currList, function (index, item) {
                            lis.push('<li>');
                            lis.push('<a onclick="x_admin_show(&apos;查看信息&apos;,&apos;/user/info?uid='+item.userId+'&apos;,500,505)" href="javascript:(0);" class="fly-avatar"><img src="../../' + item.face + '" ></a>');
                            lis.push('<h2><a class="layui-badge">主题帖</a><a href="/forum/detail?tid='+item.topicId+'">' + item.title + '</a></h2>');
                            lis.push(' <div class="fly-list-info">');
                            lis.push('<a onclick="x_admin_show(&apos;查看信息&apos;,&apos;/user/info?uid='+item.userId+'&apos;,500,505)" href="javascript:(0);" link>');
                            lis.push('<span>' + item.userName + '</span>');
                            if (item.roleId == 1) {
                                lis.push('<i class="iconfont icon-renzheng" title="认证信息：管理员"></i>');
                                lis.push('<i class="layui-badge fly-badge-vip" style="margin-left:5px;line-height: 17px;">管理员</i>');
                            }else if (item.roleId == 2){
                                lis.push('<i class="iconfont icon-renzheng" title="认证信息：版主"></i>');
                                lis.push('<i class="layui-badge fly-badge-accept" style="margin-left:5px;line-height: 17px;">版主</i>');
                            }
                            lis.push('</a><span>'+util.timeAgo(item.releaseTime, true)+'</span><span class="fly-list-nums">');
                            lis.push('<i class="iconfont icon-pinglun1" title="回答"></i>' + item.repliesCount + '</span></div>');
                            if (item.highlight == 1) {
                                lis.push('<div class="fly-list-badge"><span class="layui-badge layui-bg-red">精品</span></div>');
                            }
                        });
                        next(lis.join(''), page < data.totelPage);
                    }, 1000);

                }
            });



        }
    });
});
