# 趣背词 - 项目启动指南

> 让背单词不再枯燥！RAZ分级单词学习、闯关模式、游戏化系统。

## 项目结构

```
word_study/
├── server/          # 后端 (Node.js + Express + MySQL)
├── client/          # 前端 (Vue 3 + TypeScript + Pinia)
└── CLAUDE.md        # 项目规范
```

## 快速启动

### 1. 配置数据库

**方式一：使用 MySQL 命令行**
```bash
# 登录 MySQL
mysql -u root -p

# 执行初始化脚本
source server/database/init.sql
```

**方式二：使用 MySQL Workbench 或 Navicat**
- 打开 `server/database/init.sql`
- 执行整个脚本

### 2. 配置后端环境变量

编辑 `server/.env`，修改数据库密码：
```
DB_PASSWORD=你的MySQL密码
```

### 3. 启动后端

```bash
cd server
npm run dev
```

后端启动成功后会显示：
```
✅ Database connected successfully
🚀 Server is running on http://localhost:3000
```

### 4. 启动前端（新终端）

```bash
cd client
npm run dev
```

前端启动成功后访问：http://localhost:5173

---

## API 端点

| 方法 | 端点 | 说明 |
|------|------|------|
| POST | /api/auth/register | 用户注册 |
| POST | /api/auth/login | 用户登录 |
| GET | /api/auth/me | 获取当前用户 |
| GET | /api/words | 获取单词列表 |
| GET | /api/learning/today | 获取今日学习单词 |
| POST | /api/learning/answer | 提交答题结果 |
| POST | /api/stats/checkin | 每日打卡 |
| GET | /api/challenge/levels | 获取闯关关卡 |

---

## 测试账号

首次使用需要注册，或者使用 API 注册：

```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"username":"test","email":"test@example.com","password":"123456"}'
```

---

## 开发命令

### 后端
```bash
cd server
npm run dev        # 开发模式
npm run build      # 构建
npm run test       # 测试
```

### 前端
```bash
cd client
npm run dev        # 开发模式
npm run build      # 构建
npm run test       # 测试
```

---

## 常见问题

### 数据库连接失败
1. 确认 MySQL 服务已启动
2. 检查 `.env` 中的数据库配置
3. 确认数据库 `word_study` 已创建

### 前端无法访问 API
1. 确认后端已启动在 3000 端口
2. 检查 Vite 代理配置

### 登录后 Token 失效
1. 检查 JWT_SECRET 配置
2. 清除浏览器 localStorage 重新登录