prompt PL/SQL Developer import file
prompt Created on 2019年2月25日 星期一 by Administrator
set feedback off
set define off
prompt Dropping TB_BOARD...
drop table TB_BOARD cascade constraints;
prompt Dropping TB_GENDER...
drop table TB_GENDER cascade constraints;
prompt Dropping TB_ROLE...
drop table TB_ROLE cascade constraints;
prompt Dropping TB_TOPIC...
drop table TB_TOPIC cascade constraints;
prompt Dropping TB_TOPIC_BACK...
drop table TB_TOPIC_BACK cascade constraints;
prompt Dropping TB_USER...
drop table TB_USER cascade constraints;
prompt Dropping TB_USER_INFO...
drop table TB_USER_INFO cascade constraints;
prompt Dropping T_ANSWER...
drop table T_ANSWER cascade constraints;
prompt Dropping T_CHOSE...
drop table T_CHOSE cascade constraints;
prompt Dropping T_EXAM_INFO...
drop table T_EXAM_INFO cascade constraints;
prompt Dropping T_PAPER_INFO...
drop table T_PAPER_INFO cascade constraints;
prompt Dropping T_PAPER_QUESTION...
drop table T_PAPER_QUESTION cascade constraints;
prompt Dropping T_QUESTIONS...
drop table T_QUESTIONS cascade constraints;
prompt Dropping T_SCORE...
drop table T_SCORE cascade constraints;
prompt Dropping T_TYPE...
drop table T_TYPE cascade constraints;
prompt Creating TB_BOARD...
create table TB_BOARD
(
  BOARD_ID   NUMBER not null,
  BOARD_NAME VARCHAR2(200),
  USER_ID    NUMBER
)
;
comment on column TB_BOARD.BOARD_ID
  is 'BID';
comment on column TB_BOARD.BOARD_NAME
  is '板块名';
alter table TB_BOARD
  add constraint PK_BOARD_ID primary key (BOARD_ID);

prompt Creating TB_GENDER...
create table TB_GENDER
(
  GENDER_ID NUMBER not null,
  GENDER    VARCHAR2(4)
)
;
comment on column TB_GENDER.GENDER_ID
  is 'GID
';
comment on column TB_GENDER.GENDER
  is '性别
';
alter table TB_GENDER
  add constraint PK_GENDER_ID primary key (GENDER_ID);

prompt Creating TB_ROLE...
create table TB_ROLE
(
  ROLE_ID   NUMBER not null,
  ROLE_NAME VARCHAR2(200)
)
;
alter table TB_ROLE
  add constraint PK_ROLE_ID primary key (ROLE_ID);

prompt Creating TB_TOPIC...
create table TB_TOPIC
(
  TOPIC_ID      NUMBER not null,
  BOARD_ID      NUMBER,
  USER_ID       NUMBER,
  TITLE         VARCHAR2(200),
  CONTENT       VARCHAR2(2000),
  RELEASE_TIME  DATE,
  REPLIES_COUNT NUMBER,
  PICTURE       VARCHAR2(2000),
  TOP           NUMBER default 0,
  HIGHLIGHT     NUMBER default 0
)
;
comment on column TB_TOPIC.TOPIC_ID
  is 'tid';
comment on column TB_TOPIC.BOARD_ID
  is 'bid';
comment on column TB_TOPIC.USER_ID
  is 'uid';
comment on column TB_TOPIC.TITLE
  is '标题';
comment on column TB_TOPIC.CONTENT
  is '内容';
comment on column TB_TOPIC.RELEASE_TIME
  is '发帖时间';
comment on column TB_TOPIC.REPLIES_COUNT
  is '回复数';
comment on column TB_TOPIC.TOP
  is '1=true,0=false';
comment on column TB_TOPIC.HIGHLIGHT
  is '1=true,0=false';
alter table TB_TOPIC
  add constraint PK_TOPIC_ID primary key (TOPIC_ID);

prompt Creating TB_TOPIC_BACK...
create table TB_TOPIC_BACK
(
  TOPIC_BACK_ID NUMBER not null,
  TOPIC_ID      NUMBER,
  USER_ID       NUMBER,
  CONTENT       VARCHAR2(2000),
  RELEASE_TIME  DATE
)
;
comment on column TB_TOPIC_BACK.TOPIC_BACK_ID
  is 'TBID
';
comment on column TB_TOPIC_BACK.TOPIC_ID
  is 'TID
';
comment on column TB_TOPIC_BACK.USER_ID
  is 'UID
';
comment on column TB_TOPIC_BACK.CONTENT
  is '内容
';
comment on column TB_TOPIC_BACK.RELEASE_TIME
  is '发帖时间
';
alter table TB_TOPIC_BACK
  add constraint PK_TOPIC_BACK_ID primary key (TOPIC_BACK_ID);

prompt Creating TB_USER...
create table TB_USER
(
  USER_ID      NUMBER not null,
  USER_NAME    VARCHAR2(200),
  USER_PWD     VARCHAR2(200),
  ROLE_ID      NUMBER default 3,
  BAN          NUMBER default 0,
  TEL          VARCHAR2(200),
  FACE         VARCHAR2(200),
  GENDER       NUMBER,
  AGE          NUMBER,
  BIRTHDAY     DATE,
  QQ           NUMBER,
  EMAIL        VARCHAR2(200),
  INTRODUCTION VARCHAR2(2000)
)
;
comment on column TB_USER.USER_ID
  is 'UID
';
comment on column TB_USER.USER_NAME
  is '用户名
';
comment on column TB_USER.USER_PWD
  is '密码
';
comment on column TB_USER.ROLE_ID
  is '角色id
';
comment on column TB_USER.BAN
  is '是否封禁
(1为被封禁，0正常)';
comment on column TB_USER.TEL
  is '电话';
alter table TB_USER
  add constraint PK_USER_ID primary key (USER_ID);
alter table TB_USER
  add constraint UK_USER_NAME unique (USER_NAME);

prompt Creating TB_USER_INFO...
create table TB_USER_INFO
(
  USER_ID      NUMBER not null,
  FACE         VARCHAR2(200),
  GENDER       NUMBER,
  AGE          NUMBER,
  BIRTHDAY     DATE,
  QQ           NUMBER,
  EMAIL        VARCHAR2(200),
  INTRODUCTION VARCHAR2(200)
)
;
comment on column TB_USER_INFO.USER_ID
  is 'UID
';
comment on column TB_USER_INFO.FACE
  is '头像
';
comment on column TB_USER_INFO.GENDER
  is '性别
';
comment on column TB_USER_INFO.AGE
  is '年龄
';
comment on column TB_USER_INFO.BIRTHDAY
  is '生日
';
comment on column TB_USER_INFO.QQ
  is 'qq
';
comment on column TB_USER_INFO.EMAIL
  is '邮箱
';
comment on column TB_USER_INFO.INTRODUCTION
  is '简介
';
alter table TB_USER_INFO
  add constraint PK_USERINFO_ID primary key (USER_ID);

prompt Creating T_ANSWER...
create table T_ANSWER
(
  QUESTION_ID NUMBER not null,
  ANSWER      VARCHAR2(10) not null
)
;
comment on column T_ANSWER.QUESTION_ID
  is '题目编号';
comment on column T_ANSWER.ANSWER
  is '题目答案';

prompt Creating T_CHOSE...
create table T_CHOSE
(
  QUESTION_ID NUMBER not null,
  CHOSE_ID    VARCHAR2(10) not null,
  CHOSE       VARCHAR2(200) not null
)
;
comment on column T_CHOSE.QUESTION_ID
  is '题目编号';
comment on column T_CHOSE.CHOSE_ID
  is '选项编号';
comment on column T_CHOSE.CHOSE
  is '选项内容';

prompt Creating T_EXAM_INFO...
create table T_EXAM_INFO
(
  STUDENT_ID NUMBER not null,
  PAPER_ID   NUMBER not null,
  ROCORD     VARCHAR2(400),
  IS_TESTED  NUMBER default 0,
  IS_READ    NUMBER default 0,
  READ_NAME  VARCHAR2(20)
)
;
comment on column T_EXAM_INFO.STUDENT_ID
  is '学生编号';
comment on column T_EXAM_INFO.PAPER_ID
  is '试卷编号';
comment on column T_EXAM_INFO.ROCORD
  is '答案记录';
comment on column T_EXAM_INFO.IS_TESTED
  is '是否已考';
comment on column T_EXAM_INFO.IS_READ
  is '是否批阅';
comment on column T_EXAM_INFO.READ_NAME
  is '批阅人';

prompt Creating T_PAPER_INFO...
create table T_PAPER_INFO
(
  PAPER_ID    NUMBER not null,
  PAPER_NAME  VARCHAR2(40) not null,
  USER_NAME   VARCHAR2(20) not null,
  START_TIME  DATE not null,
  END_TIME    DATE not null,
  PAPER_TIME  NUMBER not null,
  SCORE       NUMBER not null,
  PAPER_START DATE
)
;
comment on column T_PAPER_INFO.PAPER_ID
  is '试卷编号';
comment on column T_PAPER_INFO.PAPER_NAME
  is '试卷名称';
comment on column T_PAPER_INFO.USER_NAME
  is '出卷人姓名';
comment on column T_PAPER_INFO.START_TIME
  is '开始时间';
comment on column T_PAPER_INFO.END_TIME
  is '结束时间';
comment on column T_PAPER_INFO.PAPER_TIME
  is '考试时长';
comment on column T_PAPER_INFO.SCORE
  is '总分';
alter table T_PAPER_INFO
  add primary key (PAPER_ID);

prompt Creating T_PAPER_QUESTION...
create table T_PAPER_QUESTION
(
  PAPER_ID    NUMBER not null,
  QUESTION_ID NUMBER not null
)
;
comment on column T_PAPER_QUESTION.PAPER_ID
  is '试卷编号';
comment on column T_PAPER_QUESTION.QUESTION_ID
  is '题目编号';

prompt Creating T_QUESTIONS...
create table T_QUESTIONS
(
  QUESTION_ID NUMBER not null,
  QUESTION    VARCHAR2(1000) not null,
  TYPE_ID     NUMBER not null,
  ADD_TIME    DATE
)
;
comment on column T_QUESTIONS.QUESTION_ID
  is '题目编号';
comment on column T_QUESTIONS.QUESTION
  is '题目内容';
comment on column T_QUESTIONS.TYPE_ID
  is '类型编号';
alter table T_QUESTIONS
  add primary key (QUESTION_ID);

prompt Creating T_SCORE...
create table T_SCORE
(
  STUDENT_ID NUMBER not null,
  PAPER_ID   NUMBER not null,
  SCORE      NUMBER
)
;
comment on column T_SCORE.STUDENT_ID
  is '考试人员id';
comment on column T_SCORE.PAPER_ID
  is '试卷ID';
comment on column T_SCORE.SCORE
  is '成绩';

prompt Creating T_TYPE...
create table T_TYPE
(
  TYPE_ID   NUMBER not null,
  TYPE_NAME VARCHAR2(20) not null
)
;
comment on column T_TYPE.TYPE_ID
  is '类型名称';
alter table T_TYPE
  add primary key (TYPE_ID);

prompt Disabling triggers for TB_BOARD...
alter table TB_BOARD disable all triggers;
prompt Disabling triggers for TB_GENDER...
alter table TB_GENDER disable all triggers;
prompt Disabling triggers for TB_ROLE...
alter table TB_ROLE disable all triggers;
prompt Disabling triggers for TB_TOPIC...
alter table TB_TOPIC disable all triggers;
prompt Disabling triggers for TB_TOPIC_BACK...
alter table TB_TOPIC_BACK disable all triggers;
prompt Disabling triggers for TB_USER...
alter table TB_USER disable all triggers;
prompt Disabling triggers for TB_USER_INFO...
alter table TB_USER_INFO disable all triggers;
prompt Disabling triggers for T_ANSWER...
alter table T_ANSWER disable all triggers;
prompt Disabling triggers for T_CHOSE...
alter table T_CHOSE disable all triggers;
prompt Disabling triggers for T_EXAM_INFO...
alter table T_EXAM_INFO disable all triggers;
prompt Disabling triggers for T_PAPER_INFO...
alter table T_PAPER_INFO disable all triggers;
prompt Disabling triggers for T_PAPER_QUESTION...
alter table T_PAPER_QUESTION disable all triggers;
prompt Disabling triggers for T_QUESTIONS...
alter table T_QUESTIONS disable all triggers;
prompt Disabling triggers for T_SCORE...
alter table T_SCORE disable all triggers;
prompt Disabling triggers for T_TYPE...
alter table T_TYPE disable all triggers;
prompt Loading TB_BOARD...
insert into TB_BOARD (BOARD_ID, BOARD_NAME, USER_ID)
values (1, 'JAVA', 23);
insert into TB_BOARD (BOARD_ID, BOARD_NAME, USER_ID)
values (2, 'C', 2);
insert into TB_BOARD (BOARD_ID, BOARD_NAME, USER_ID)
values (3, 'PYTHON', 3);
insert into TB_BOARD (BOARD_ID, BOARD_NAME, USER_ID)
values (4, '5555', 3);
commit;
prompt 4 records loaded
prompt Loading TB_GENDER...
insert into TB_GENDER (GENDER_ID, GENDER)
values (1, '男');
insert into TB_GENDER (GENDER_ID, GENDER)
values (2, '女');
commit;
prompt 2 records loaded
prompt Loading TB_ROLE...
insert into TB_ROLE (ROLE_ID, ROLE_NAME)
values (1, '系统管理员');
insert into TB_ROLE (ROLE_ID, ROLE_NAME)
values (2, '版主');
insert into TB_ROLE (ROLE_ID, ROLE_NAME)
values (3, '会员');
commit;
prompt 3 records loaded
prompt Loading TB_TOPIC...
insert into TB_TOPIC (TOPIC_ID, BOARD_ID, USER_ID, TITLE, CONTENT, RELEASE_TIME, REPLIES_COUNT, PICTURE, TOP, HIGHLIGHT)
values (173, 1, 2, '流加载测试1', 'rt', to_date('17-12-2018 14:20:58', 'dd-mm-yyyy hh24:mi:ss'), 0, null, 0, 0);
insert into TB_TOPIC (TOPIC_ID, BOARD_ID, USER_ID, TITLE, CONTENT, RELEASE_TIME, REPLIES_COUNT, PICTURE, TOP, HIGHLIGHT)
values (169, 1, 23, '测试---这是一个JAVA版块的帖子', 'rtsdfsdf', to_date('18-12-2018 14:28:02', 'dd-mm-yyyy hh24:mi:ss'), 0, null, 1, 1);
insert into TB_TOPIC (TOPIC_ID, BOARD_ID, USER_ID, TITLE, CONTENT, RELEASE_TIME, REPLIES_COUNT, PICTURE, TOP, HIGHLIGHT)
values (171, 2, 23, '测试---这是一个C版块的帖子', 'rt', to_date('17-12-2018 14:18:21', 'dd-mm-yyyy hh24:mi:ss'), 0, null, 0, 0);
insert into TB_TOPIC (TOPIC_ID, BOARD_ID, USER_ID, TITLE, CONTENT, RELEASE_TIME, REPLIES_COUNT, PICTURE, TOP, HIGHLIGHT)
values (172, 3, 23, '测试---这是一个PYTHON版块的帖子', 'rt', to_date('17-12-2018 14:18:51', 'dd-mm-yyyy hh24:mi:ss'), 0, null, 0, 0);
insert into TB_TOPIC (TOPIC_ID, BOARD_ID, USER_ID, TITLE, CONTENT, RELEASE_TIME, REPLIES_COUNT, PICTURE, TOP, HIGHLIGHT)
values (175, 1, 2, '流加载测试3', 'rt', to_date('17-12-2018 14:21:15', 'dd-mm-yyyy hh24:mi:ss'), 0, null, 0, 0);
insert into TB_TOPIC (TOPIC_ID, BOARD_ID, USER_ID, TITLE, CONTENT, RELEASE_TIME, REPLIES_COUNT, PICTURE, TOP, HIGHLIGHT)
values (176, 1, 2, '流加载测试4', 'rt', to_date('17-12-2018 14:24:25', 'dd-mm-yyyy hh24:mi:ss'), 0, null, 0, 0);
insert into TB_TOPIC (TOPIC_ID, BOARD_ID, USER_ID, TITLE, CONTENT, RELEASE_TIME, REPLIES_COUNT, PICTURE, TOP, HIGHLIGHT)
values (51, 2, 3, '123123', '12312312', to_date('13-12-2018 16:49:50', 'dd-mm-yyyy hh24:mi:ss'), 1, null, 0, 0);
insert into TB_TOPIC (TOPIC_ID, BOARD_ID, USER_ID, TITLE, CONTENT, RELEASE_TIME, REPLIES_COUNT, PICTURE, TOP, HIGHLIGHT)
values (85, 1, 23, '大家好，我是管理员', '盛大发售分散富士达发发', to_date('15-12-2018 15:59:18', 'dd-mm-yyyy hh24:mi:ss'), 1, null, 1, 0);
insert into TB_TOPIC (TOPIC_ID, BOARD_ID, USER_ID, TITLE, CONTENT, RELEASE_TIME, REPLIES_COUNT, PICTURE, TOP, HIGHLIGHT)
values (87, 1, 24, '大家好，我是java版主', '阿道夫', to_date('15-12-2018 16:00:31', 'dd-mm-yyyy hh24:mi:ss'), 1, null, 0, 1);
insert into TB_TOPIC (TOPIC_ID, BOARD_ID, USER_ID, TITLE, CONTENT, RELEASE_TIME, REPLIES_COUNT, PICTURE, TOP, HIGHLIGHT)
values (88, 1, 24, '这是一个置顶帖', '请问', to_date('15-12-2018 16:00:54', 'dd-mm-yyyy hh24:mi:ss'), 1, null, 1, 1);
commit;
prompt 10 records loaded
prompt Loading TB_TOPIC_BACK...
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (129, 88, 3, '为请二无群二', to_date('16-12-2018 20:40:55', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (130, 88, 3, '爱如风大是大非富士达', to_date('16-12-2018 20:41:17', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (131, 88, 3, '圣达菲圣达菲', to_date('16-12-2018 20:41:20', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (132, 88, 3, '发斯蒂芬斯蒂芬', to_date('16-12-2018 20:41:22', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (133, 88, 3, '阿萨德飞洒发', to_date('16-12-2018 20:41:26', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (134, 88, 3, '撒飞洒发发', to_date('16-12-2018 20:41:28', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (135, 88, 3, null, to_date('16-12-2018 20:41:30', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (136, 88, 3, '撒发顺丰', to_date('16-12-2018 20:41:32', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (137, 88, 23, '测试测试', to_date('17-12-2018 01:24:23', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (138, 88, 3, '发大水口了放假', to_date('17-12-2018 09:15:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (139, 88, 3, '啊啊啊', to_date('17-12-2018 09:15:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (140, 88, 3, '圣达菲v', to_date('17-12-2018 09:15:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (141, 88, 3, '水电费从', to_date('17-12-2018 09:15:52', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (178, 177, 23, '撒大声地', to_date('17-12-2018 15:05:43', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (180, 179, 3, 'sdf', to_date('17-12-2018 17:02:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (181, 179, 3, 'sdf', to_date('17-12-2018 17:03:09', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (182, 87, 3, 'sgfdsg', to_date('17-12-2018 17:03:28', 'dd-mm-yyyy hh24:mi:ss'));
insert into TB_TOPIC_BACK (TOPIC_BACK_ID, TOPIC_ID, USER_ID, CONTENT, RELEASE_TIME)
values (184, 169, 3, 'dfdsf', to_date('18-12-2018 14:26:33', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 18 records loaded
prompt Loading TB_USER...
insert into TB_USER (USER_ID, USER_NAME, USER_PWD, ROLE_ID, BAN, TEL, FACE, GENDER, AGE, BIRTHDAY, QQ, EMAIL, INTRODUCTION)
values (2, 'outas', '122136', 3, 0, '13576591119', 'images/face/1545027625488.jpg', 1, 7, to_date('27-11-2011', 'dd-mm-yyyy'), null, null, '啊啊啊');
insert into TB_USER (USER_ID, USER_NAME, USER_PWD, ROLE_ID, BAN, TEL, FACE, GENDER, AGE, BIRTHDAY, QQ, EMAIL, INTRODUCTION)
values (3, '123', '666666', 3, 0, '13576565665', 'images/face/1544885304272.jpg', 2, 7, to_date('17-11-2011', 'dd-mm-yyyy'), null, '88888999@sd.ca', '这个人很懒，什么都没留下！111');
insert into TB_USER (USER_ID, USER_NAME, USER_PWD, ROLE_ID, BAN, TEL, FACE, GENDER, AGE, BIRTHDAY, QQ, EMAIL, INTRODUCTION)
values (23, 'admin', 'admin', 1, 0, '12345678999', 'images/face/default_face.png', 2, 0, to_date('04-12-2018', 'dd-mm-yyyy'), null, null, '这个人很懒，什么都没留下！');
insert into TB_USER (USER_ID, USER_NAME, USER_PWD, ROLE_ID, BAN, TEL, FACE, GENDER, AGE, BIRTHDAY, QQ, EMAIL, INTRODUCTION)
values (24, 'java版主', '666666', 2, 0, '12345678999', 'images/face/default_face.png', null, null, null, null, null, null);
insert into TB_USER (USER_ID, USER_NAME, USER_PWD, ROLE_ID, BAN, TEL, FACE, GENDER, AGE, BIRTHDAY, QQ, EMAIL, INTRODUCTION)
values (43, '66666', '123456789', 3, 0, '17779118154', 'images/face/default_face.png', null, null, null, null, null, null);
insert into TB_USER (USER_ID, USER_NAME, USER_PWD, ROLE_ID, BAN, TEL, FACE, GENDER, AGE, BIRTHDAY, QQ, EMAIL, INTRODUCTION)
values (44, '555555', '555555', 3, 0, '12345678999', 'images/face/default_face.png', null, null, null, null, null, null);
insert into TB_USER (USER_ID, USER_NAME, USER_PWD, ROLE_ID, BAN, TEL, FACE, GENDER, AGE, BIRTHDAY, QQ, EMAIL, INTRODUCTION)
values (45, '444444', '444444', 3, 0, '13576591119', 'images/face/default_face.png', null, null, null, null, null, null);
commit;
prompt 7 records loaded
prompt Loading TB_USER_INFO...
prompt Table is empty
prompt Loading T_ANSWER...
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (61, 'D');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (60, '0');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (81, '0');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (82, 'B');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (201, 'A');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (84, '1');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (86, 'A');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (86, 'B');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (86, 'C');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (121, 'B');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (122, 'D');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (90, 'B');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (124, 'B');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (92, 'B');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (92, 'C');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (93, '0');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (94, 'C');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (95, 'A');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (95, 'B');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (95, 'C');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (124, 'C');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (61, 'B');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (125, 'A');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (202, 'A');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (61, 'C');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (125, 'C');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (126, 'C');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (124, 'C');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (200, 'A');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (203, 'C');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (85, 'B');
insert into T_ANSWER (QUESTION_ID, ANSWER)
values (85, 'C');
commit;
prompt 32 records loaded
prompt Loading T_CHOSE...
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (61, 'C', 'a3');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (61, 'D', 'a4');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (61, 'A', 'aaaaa1');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (61, 'B', 'a2');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (121, 'C', '66');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (121, 'D', 's');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (122, 'A', 'ds');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (200, 'B', '1');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (85, 'A', 'svdvassdbfs');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (85, 'B', 'vsdv');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (85, 'C', 'sdavsds');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (85, 'D', 'ddddddddddd');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (86, 'A', 'ddd');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (86, 'B', 'dd');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (86, 'C', 'd');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (86, 'D', 'd');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (92, 'C', 's');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (92, 'D', 's');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (200, 'C', '1');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (200, 'D', '1');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (92, 'A', 'ssss');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (92, 'B', 'sss');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (201, 'A', '1');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (121, 'A', 'sss');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (122, 'B', 'sa');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (121, 'B', 'sss');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (122, 'C', 'a');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (122, 'D', 'a');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (201, 'B', '1');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (201, 'C', '1');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (201, 'D', '1');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (202, 'A', 'xxxx');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (124, 'A', 'xxx');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (124, 'B', 'cc');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (124, 'C', 'ss');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (124, 'D', 'ss');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (125, 'A', 'dd');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (125, 'B', 'dd');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (125, 'C', 'd');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (125, 'D', 'd');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (126, 'A', 'xxx');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (126, 'B', 'zz');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (126, 'C', 'aaa');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (126, 'D', 'aaasss');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (124, 'A', 's');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (124, 'B', 's');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (124, 'C', 's');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (124, 'D', 's');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (200, 'A', '1');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (202, 'B', 'xx');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (202, 'C', 'xxxx');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (203, 'A', 'ssss');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (203, 'B', 's');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (203, 'C', 'ss');
insert into T_CHOSE (QUESTION_ID, CHOSE_ID, CHOSE)
values (203, 'D', 'sssss');
commit;
prompt 55 records loaded
prompt Loading T_EXAM_INFO...
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (1, 1, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (23, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (2, 6, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (1, 6, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (2, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (3, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (24, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (43, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (44, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (45, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (2, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (3, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (23, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (24, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (43, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (44, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (45, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (2, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (3, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (23, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (24, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (43, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (44, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (45, 0, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (2, 2, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (3, 2, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (24, 2, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (43, 2, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (44, 2, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (45, 2, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (2, 3, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (3, 3, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (23, 3, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (24, 3, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (43, 3, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (44, 3, null, 0, 0, null);
insert into T_EXAM_INFO (STUDENT_ID, PAPER_ID, ROCORD, IS_TESTED, IS_READ, READ_NAME)
values (45, 3, null, 0, 0, null);
commit;
prompt 37 records loaded
prompt Loading T_PAPER_INFO...
insert into T_PAPER_INFO (PAPER_ID, PAPER_NAME, USER_NAME, START_TIME, END_TIME, PAPER_TIME, SCORE, PAPER_START)
values (6, 'ddddd', 'aa', to_date('17-12-2018', 'dd-mm-yyyy'), to_date('17-12-2018', 'dd-mm-yyyy'), 120, 20, to_date('17-12-2018 19:53:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_PAPER_INFO (PAPER_ID, PAPER_NAME, USER_NAME, START_TIME, END_TIME, PAPER_TIME, SCORE, PAPER_START)
values (2, '1', '1', to_date('18-12-2018', 'dd-mm-yyyy'), to_date('01-12-2018', 'dd-mm-yyyy'), 1, 14, to_date('18-12-2018 13:19:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_PAPER_INFO (PAPER_ID, PAPER_NAME, USER_NAME, START_TIME, END_TIME, PAPER_TIME, SCORE, PAPER_START)
values (3, '1', '11', to_date('18-12-2018', 'dd-mm-yyyy'), to_date('01-12-2018', 'dd-mm-yyyy'), 1, 4, to_date('18-12-2018 13:20:31', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 3 records loaded
prompt Loading T_PAPER_QUESTION...
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (6, 102);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (6, 122);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (6, 121);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (6, 92);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (6, 85);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (6, 61);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (6, 86);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 122);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 121);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 85);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 125);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 84);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 93);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 87);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 83);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 126);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 124);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 93);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 83);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 126);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 125);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 93);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (0, 83);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (2, 127);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (2, 92);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (2, 84);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (2, 93);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (2, 83);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (3, 122);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (3, 92);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (3, 93);
insert into T_PAPER_QUESTION (PAPER_ID, QUESTION_ID)
values (3, 87);
commit;
prompt 32 records loaded
prompt Loading T_QUESTIONS...
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (201, '1', 1, to_date('18-12-2018 13:26:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (202, 'dddvvx', 1, to_date('18-12-2018 14:46:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (121, 'ddd', 1, to_date('17-12-2018 16:10:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (61, 'fa cjknv salvddd', 2, to_date('12-12-2018 17:02:08', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (83, 'gffhsafjafugifbal', 4, to_date('13-12-2018 10:55:42', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (84, '7', 3, to_date('13-12-2018 10:55:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (85, 'gshrs', 2, to_date('13-12-2018 10:56:11', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (86, 'ddddddssss', 2, to_date('13-12-2018 10:56:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (87, '还是个燃烧热那个   ddd', 4, to_date('13-12-2018 10:56:52', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (122, 'dddd', 1, to_date('17-12-2018 16:36:11', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (124, 'sss', 2, to_date('17-12-2018 21:15:18', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (93, 'rrrrrrr', 3, to_date('13-12-2018 19:13:30', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (125, 'dddds', 2, to_date('17-12-2018 21:16:17', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (92, 'fkgasbjvud', 2, to_date('13-12-2018 19:11:32', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (126, 'aaaaddds', 1, to_date('17-12-2018 21:19:18', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (200, '1', 2, to_date('18-12-2018 13:22:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into T_QUESTIONS (QUESTION_ID, QUESTION, TYPE_ID, ADD_TIME)
values (203, 'ss', 1, to_date('18-12-2018 14:46:45', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 17 records loaded
prompt Loading T_SCORE...
prompt Table is empty
prompt Loading T_TYPE...
insert into T_TYPE (TYPE_ID, TYPE_NAME)
values (1, '单选题');
insert into T_TYPE (TYPE_ID, TYPE_NAME)
values (2, '多选题');
insert into T_TYPE (TYPE_ID, TYPE_NAME)
values (3, '判断题');
insert into T_TYPE (TYPE_ID, TYPE_NAME)
values (4, '主观题');
commit;
prompt 4 records loaded
prompt Enabling triggers for TB_BOARD...
alter table TB_BOARD enable all triggers;
prompt Enabling triggers for TB_GENDER...
alter table TB_GENDER enable all triggers;
prompt Enabling triggers for TB_ROLE...
alter table TB_ROLE enable all triggers;
prompt Enabling triggers for TB_TOPIC...
alter table TB_TOPIC enable all triggers;
prompt Enabling triggers for TB_TOPIC_BACK...
alter table TB_TOPIC_BACK enable all triggers;
prompt Enabling triggers for TB_USER...
alter table TB_USER enable all triggers;
prompt Enabling triggers for TB_USER_INFO...
alter table TB_USER_INFO enable all triggers;
prompt Enabling triggers for T_ANSWER...
alter table T_ANSWER enable all triggers;
prompt Enabling triggers for T_CHOSE...
alter table T_CHOSE enable all triggers;
prompt Enabling triggers for T_EXAM_INFO...
alter table T_EXAM_INFO enable all triggers;
prompt Enabling triggers for T_PAPER_INFO...
alter table T_PAPER_INFO enable all triggers;
prompt Enabling triggers for T_PAPER_QUESTION...
alter table T_PAPER_QUESTION enable all triggers;
prompt Enabling triggers for T_QUESTIONS...
alter table T_QUESTIONS enable all triggers;
prompt Enabling triggers for T_SCORE...
alter table T_SCORE enable all triggers;
prompt Enabling triggers for T_TYPE...
alter table T_TYPE enable all triggers;
set feedback on
set define on
prompt Done.
