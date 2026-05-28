
$(function () {

    var socket,
        ip = '127.0.0.1', // 可自行修改为你的服务端IP
        headsrc = "", // 用户头像
        uname = null;

    /* 初始化登录界面 */
    login();

    /* 建立WebSocket连接，使用websocket协议，端口号是服务器端监听端口号 */
    socket = io('ws://' + ip + ':8084');

    /* 主函数 */
    function main() {

        /* 当名字不为空时，去掉两头空格并发给服务端 */
        uname = $.trim($('#loginName').val());
        if (uname) {
            /*向服务端发送登录事件*/
            socket.emit('login', { username: uname })
        } else {
            alert('请先登录');
            window.location.href="/login";
        }

        /* 发送消息 */
        $('.sendBtn').click(function () {
            sendMessage(socket);
        });

        /* 登录成功 */
        socket.on('loginSuccess', function (data) {
            if (data.username === uname) {
                checkin(data)
            } else {
                alert('用户名不匹配，请重试')
            }
        })

        /* 登录失败 */
        socket.on('loginFail', function () {
            alert('请不要重复登录');
            socket.close();
            socket = io('ws://' + ip + ':8084');
            window.close();
        })

        /* 新人加入提示 */
        socket.on('add', function (data) {
            var html = '<p>系统消息:欢迎' + data.username + '加入聊天室</p>' + '<br>';
            $('.chat-con').append(html);
        })

        /* 接收消息 */
        socket.on('receiveMessage', function (messageObject) {
            showMessage(messageObject);
        })
        /* 接受图片 */
        socket.on('receiveImage', function (imgObject) {
            showImage(imgObject);
        })

        /* 退出群聊提示 */
        socket.on('leave', function (name) {
            if (name != null) {
                var html = '<p>系统消息:' + name + '已退出聊天室</p>' + '<br>';
                $('.chat-con').append(html);
            }
        })


        /* 点击表情按钮时 */
        document.getElementById('emoji').addEventListener('click', function (e) {
            var emojiwrapper = document.getElementById('emojiWrapper');
            if (emojiwrapper.style.display != 'block') {
                emojiwrapper.style.display = 'block';
            } else {
                emojiwrapper.style.display = 'none';
            }
            e.stopPropagation();
        }, false);

        /* 如果点击的不是头像界面或表情界面，则将其隐藏 */
        document.body.addEventListener('click', function (e) {
            if ($('#chat-wrap').css("display") === "none") //位于登录界面
            {
                var headportrait = document.getElementById('headportrait');
                if (e.target != headportrait) {
                    headportrait.style.display = 'none';
                };
            } else {
                var emojiwrapper = document.getElementById('emojiWrapper');
                if (e.target != emojiwrapper) {
                    emojiwrapper.style.display = 'none';
                };
            }
        });

        /* emoji */
        document.getElementById('emojiWrapper').addEventListener('click', function (e) {
            /* 获取被点击的对象 */
            var target = e.target;
            console.log(target);
            if (target.nodeName.toLowerCase() == 'img') { //如果是表情图像则发送
                var sendtxt = document.getElementById('sendtxt');
                sendtxt.focus();
                sendtxt.value = sendtxt.value + '[emoji:' + target.num + ']';
            };
        }, false);

        /* 页面滚动事件 */
        document.getElementById("chat-wrap").onscroll = function () {
            this.scrollIntoView();
        }

        /* 图片发送 */
        document.getElementById('sendImage').addEventListener('change', function () {

            var img = new Image();
            var reader = new FileReader();

            // 缩放图片需要的canvas
            var canvas = document.createElement('canvas');
            var context = canvas.getContext('2d');

            // base64地址图片加载完毕后
            img.onload = function () {
                // 图片原始尺寸
                var originWidth = this.width;
                var originHeight = this.height;
                // 最大尺寸限制
                var maxWidth = 400,
                    maxHeight = 400;
                // 目标尺寸
                var targetWidth = originWidth,
                    targetHeight = originHeight;
                // 图片尺寸超过400x400的限制
                if (originWidth > maxWidth || originHeight > maxHeight) {
                    if (originWidth / originHeight > maxWidth / maxHeight) {
                        // 更宽，按照宽度限定尺寸
                        targetWidth = maxWidth;
                        targetHeight = Math.round(maxWidth * (originHeight / originWidth));
                    } else {
                        targetHeight = maxHeight;
                        targetWidth = Math.round(maxHeight * (originWidth / originHeight));
                    }
                }

                // canvas对图片进行缩放
                canvas.width = targetWidth;
                canvas.height = targetHeight;
                // 清除画布
                context.clearRect(0, 0, targetWidth, targetHeight);
                // 图片压缩
                context.drawImage(img, 0, 0, targetWidth, targetHeight);
                var result = canvas.toDataURL('image/jpeg');
                console.log('result done!', result);
                socket.emit('sendImg', { username: uname, image: result, date: new Date().toTimeString().substr(0, 8), headsrc: headsrc });
            };

            /* 检查是否有文件被选中 */
            if (this.files.length != 0) {
                //获取文件并用FileReader进行读取
                for (let i = 0; i < this.files.length; i++) {
                    var file = this.files[i];

                    if (!reader) {
                        return;
                    };
                    reader.onload = function (e) {
                        console.log('read')
                        img.src = e.target.result;
                        // //读取成功，发送到服务器
                        // socket.emit('sendImg',{username:uname,image: e.target.result,date:new Date().toTimeString().substr(0, 8),headnum:headnum});
                    };
                    reader.readAsDataURL(file);
                };
            };
        }, false);

    }

    /*登录界面函数*/
    function login() {

        loadHeadPortrait(); //头像初始化

        /*键盘回车事件*/
        keydown();


        //点击登录后，确认IP地址
        // $('.login-btn').click(function() {
        //     main();
        // });

        //自动登录~~~
        $(document).ready(function () {
            main();
        });

    }

    /*头像初始化*/
    function loadHeadPortrait() {
        var headFragment = document.createDocumentFragment(); //创建文档块

        var headItem = document.createElement('img');

        // headsrc = '../images/user/user12.jpg';
        headsrc = $("#face").val();

        headFragment.appendChild(headItem);

    }

    /*键盘回车事件*/
    function keydown() {

        $(document).keydown(function (event) {
            /*回车事件*/
            if (event.keyCode == 13 && $('#chat-wrap').css("display") === "none") { //登录界面
                uname = $.trim($('#loginName').val());
                if (uname) {
                    main();
                } else {
                    alert('请登录')
                }
            } else if (event.keyCode == 13 && $('#chat-wrap').css("display") !== "none") { //聊天界面
                sendMessage(socket);
            }
        })
    }

    /*隐藏登录界面 显示聊天界面*/
    function checkin(data) {
        // $('.login-wrap').hide('slow');
        var emojiContainer = document.getElementById('emojiWrapper'),
            docFragment = document.createDocumentFragment();

        // 初始化加载emoji
        for (let i = 0; i < 38; i++) {

            var emojiItem = document.createElement('img');
            emojiItem.src = 'https://kmknkk.oss-cn-beijing.aliyuncs.com/chat-img/emoji/' + i + '.gif';
            emojiItem.title = i;
            emojiItem.num = i;

            docFragment.appendChild(emojiItem);

        };
        emojiContainer.appendChild(docFragment);
        $('.chat-wrap').show('slow');
    }

    /*发送消息*/
    function sendMessage(socket) {
        var txt = filterXSS($('#sendtxt').val());
        $('#sendtxt').val('');
        if (txt) {
            socket.emit('sendMessage', { username: uname, message: txt, date: new Date().toTimeString().substr(0, 8), headsrc: headsrc });
        }
    }

    /*显示消息*/
    function showMessage(data) {
        var html
        msg = showEmoji(data.message);
        if (data.username === uname) {
            html = '<div class="chat-item item-right clearfix rela"><span class="abs uname">' + data.date + '&nbsp;' + '&nbsp;' + '&nbsp;' + data.username + '</span><img class="fr img" src="' + headsrc + '"><span class="fr message">' + msg + '</span></div>'
        } else {
            html = '<div class="chat-item item-left clearfix rela"><span class="abs uname">' + data.username + '&nbsp;' + '&nbsp;' + '&nbsp;' + data.date + '</span><img class="fl img" src="' + data.headsrc + '"></span><span class="fl message">' + msg + '</span></div>'
        }
        $('.chat-con').append(html);
        // if (isNewInWindow()) { //当用户正在界面底端时，实时显示最新消息，当用户在查看历史消息时，不跳转到最新消息
        //     scrollToEnd();
        // }
        scrollToEnd();

    }

    /*将页面下拉到最新消息处*/
    function scrollToEnd() {
        var height = document.getElementById("chat-wrap").scrollHeight;
        document.getElementById("chat-wrap").scrollTop = height;
    }

    /*判断当有新信息来时，用户是否在页面底端*/
    // function isNewInWindow() {
    //     var div = document.getElementById("chat-con");
    //     console.log(div);
    //     var div_length = div.length - 6;

    //     if (isInWindow(div[div_length])) {
    //         return true;
    //     }
    //     return false;
    // }

    /*判定元素是否在界面内*/
    // function isInWindow(x) {
    //     if (x.getBoundingClientRect().top > window.innerHeight) {
    //         // 元素低于当前界面
    //         return false;
    //     } else if (x.getBoundingClientRect().bottom < 0) {
    //         // 元素高于当前界面
    //         return false;
    //     }
    //     return true;
    // }

    /*分析文字并用表情包替换emoji*/
    function showEmoji(msg) {
        var match, result = msg,
            reg = /\[emoji:\d+\]/g,
            emojiIndex,
            totalEmojiNum = document.getElementById('emojiWrapper').children.length;
        while (match = reg.exec(msg)) {
            emojiIndex = match[0].slice(7, -1);
            if (emojiIndex > totalEmojiNum) {
                result = result.replace(match[0], '[X]');
            } else {
                result = result.replace(match[0], '<img class="emoji" src="https://kmknkk.oss-cn-beijing.aliyuncs.com/chat-img/emoji/' + emojiIndex + '.gif" />');
            };
        };
        return result;
    }

    /*显示图片*/
    function showImage(data) {
        var msgToDisplay = document.createElement('p');
        msgToDisplay.style.color = '#000';
        if (data.username === uname) {
            html = '<div class="chat-item item-right clearfix rela"><span class="abs uname">' + data.date + '&nbsp;' + '&nbsp;' + '&nbsp;' + data.username + '</span><img class="fr img" src="' + headsrc + '"><img src="' + data.image + '" style = "margin-top:20px; max-width: 200px;max-height: 200px;float: right"/></div>'

        } else {
            html = '<div class="chat-item item-left clearfix rela"><span class="abs uname">' + data.username + '&nbsp;' + '&nbsp;' + '&nbsp;' + data.date + '</span><img class="fl img" src="' + data.headsrc + '"><img src="' + data.image + '" style = "margin-top:20px; max-width: 200px;max-height: 200px;float: left"/></div>'
        }
        $('.chat-con').append(html);
        // if (isNewInWindow()) { //当用户正在界面底端时，实时显示最新消息，当用户在查看历史消息时，不跳转到最新消息
        // scrollToEnd();
        // }
    }

})

function clickImageButton() {
    document.getElementById("sendImage").click();
}