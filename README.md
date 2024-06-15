# learnSystem - 在线学习系统

> 更新时间：2024年6月

## 项目简介

learnSystem 是一个基于 Java Web 技术的在线学习系统，集成了用户管理、在线考试、论坛交流、交友聊天等核心功能。

## 技术栈

| 技术 | 说明 |
|------|------|
| Java | 后端开发语言 (JDK 11) |
| Servlet/JSP | Web 框架 |
| MySQL | 数据库 |
| LayUI + jQuery | 前端 UI 框架 |
| Maven | 项目构建工具 |
| GitHub Actions | CI/CD 自动化部署 |

## 功能模块

- ✅ 用户注册与登录
- ✅ 个人资料管理
- ✅ 在线考试系统
- ✅ 题库管理
- ✅ 论坛交流
- ✅ 交友聊天
- ✅ 笔记功能
- ✅ 后台管理系统

## 项目结构

```
learnSystem/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── controller/    # 控制器层
│   │   │   ├── dao/          # 数据访问层
│   │   │   ├── pojo/         # 实体类
│   │   │   ├── service/      # 业务逻辑层
│   │   │   └── utils/       # 工具类
│   │   └── webapp/
│   │       ├── pages/        # JSP 页面
│   │       ├── css/          # 样式文件
│   │       ├── js/           # JavaScript 文件
│   │       └── images/       # 图片资源
│   └── test/
├── .github/
│   └── workflows/             # CI/CD 配置
│       └── ci.yml
├── pom.xml
└── README.md
```

## CI/CD 流水线

本项目配置了 GitHub Actions 自动化流水线：

- **触发条件**：推送到 `master`、`main` 或 `develop` 分支时自动触发
- **构建阶段**：Maven 编译 + 单元测试
- **部署阶段**：仅在 `master` 分支推送时执行

详细配置请查看 [.github/workflows/ci.yml](.github/workflows/ci.yml)

## 快速开始

### 环境要求

- JDK 11+
- Maven 3.6+
- MySQL 5.7+ / 8.0+

### 构建项目

```bash
# 克隆项目
git clone https://github.com/wryyyds7/learnSystem.git

# 进入项目目录
cd learnSystem

# 编译打包
mvn clean package

# 运行测试
mvn test
```

### 部署到 Tomcat

1. 将 `target/learnSystem.war` 复制到 Tomcat 的 `webapps` 目录
2. 启动 Tomcat
3. 访问 `http://localhost:8080/learnSystem`

## 数据库配置

项目使用 MySQL 数据库，数据库文件位于 `数据库/learnSys.sql`，请先创建数据库并导入 SQL 文件。

## 许可证

本项目仅供学习交流使用。

---

**作者**：wry
**GitHub**：https://github.com/wryyyds7/learnSystem
**创建日期**：2024年6月
