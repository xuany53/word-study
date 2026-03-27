# 趣背词 - 让背单词不再枯燥

<p align="center">
  <img src="https://img.shields.io/badge/Vue-3.x-4FC08D?style=flat-square&logo=vue.js" alt="Vue 3">
  <img src="https://img.shields.io/badge/TypeScript-5.x-3178C6?style=flat-square&logo=typescript" alt="TypeScript">
  <img src="https://img.shields.io/badge/Node.js-18+-339933?style=flat-square&logo=node.js" alt="Node.js">
  <img src="https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat-square&logo=mysql" alt="MySQL">
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="MIT License">
</p>

<p align="center">
  <b>一个为爱发电的单词学习应用</b><br>
  <sub>为我的孩子学习英语而开发，现开源分享给所有家庭</sub>
</p>

---

## ✨ 功能特性

### 📚 单词学习
- **近 20,000 个单词** - 汇总词汇 + RAZ分级词汇
- **年级分类** - 支持小学/初中/高中
- **RAZ分级** - AA 到 Z2 共29个级别
- **双模式学习** - 选择题 + 拼写模式
- **自动发音** - 显示单词时自动播放读音

### 🧠 科学记忆
- **艾宾浩斯遗忘曲线** - 智能复习算法
- **复习间隔** - 1天→2天→4天→7天→15天→30天
- **掌握度追踪** - 自动记录学习状态

### 🎮 游戏化设计
- **每日打卡** - 连续打卡奖励系统
- **徽章收集** - 青铜/白银/黄金/钻石/王者
- **XP经验值** - 等级成长系统
- **闯关模式** - 5个难度，无限关卡

### 🔊 音效反馈
- **正确提示** - "Excellent!" 语音鼓励
- **错误提示** - 温和的下降音调
- **例句朗读** - 点击喇叭播放例句

---

## 📸 项目截图

<p align="center">
  <table>
    <tr>
      <td align="center"><b>首页</b></td>
      <td align="center"><b>学习页面</b></td>
    </tr>
    <tr>
      <td><img src="docs/screenshots/home.png" width="300"></td>
      <td><img src="docs/screenshots/learning.png" width="300"></td>
    </tr>
    <tr>
      <td align="center"><b>闯关模式</b></td>
      <td align="center"><b>学习统计</b></td>
    </tr>
    <tr>
      <td><img src="docs/screenshots/challenge.png" width="300"></td>
      <td><img src="docs/screenshots/stats.png" width="300"></td>
    </tr>
  </table>
</p>

---

## 🚀 快速开始

### 环境要求

- Node.js >= 18
- MySQL >= 8.0
- npm 或 yarn

### 安装步骤

#### 1. 克隆项目

```bash
git clone https://github.com/xuany53/word-study.git
cd word-study
```

#### 2. 配置数据库

```bash
# 登录 MySQL
mysql -u root -p

# 执行初始化脚本
source server/database/init.sql
```

#### 3. 配置后端环境变量

编辑 `server/.env`：

```env
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=你的MySQL密码
DB_DATABASE=word_study
JWT_SECRET=your-secret-key
PORT=3000
```

#### 4. 安装依赖并启动

```bash
# 安装后端依赖
cd server
npm install
npm run dev

# 新开终端，安装前端依赖
cd ../client
npm install
npm run dev
```

#### 5. 访问应用

打开浏览器访问：http://localhost:5173

---

## 📁 项目结构

```
word_study/
├── server/                    # 后端服务
│   ├── src/
│   │   ├── controllers/       # 控制器
│   │   ├── entities/          # 数据库实体
│   │   ├── middleware/        # 中间件
│   │   └── config/            # 配置文件
│   ├── database/              # 数据库脚本
│   └── package.json
├── client/                    # 前端应用
│   ├── src/
│   │   ├── views/             # 页面组件
│   │   ├── components/        # 通用组件
│   │   ├── stores/            # Pinia 状态管理
│   │   ├── services/          # 业务服务
│   │   └── types/             # TypeScript 类型
│   └── package.json
├── docs/                      # 文档
├── CLAUDE.md                  # 项目规范
└── README.md
```

---

## 🛠️ 技术栈

| 类别 | 技术 |
|------|------|
| **前端框架** | Vue 3 + TypeScript |
| **状态管理** | Pinia |
| **路由** | Vue Router 4 |
| **构建工具** | Vite 5 |
| **后端框架** | Express.js |
| **ORM** | TypeORM |
| **数据库** | MySQL 8.0 |
| **认证** | JWT |

---

## 📖 API 文档

### 认证接口

| 方法 | 端点 | 说明 |
|------|------|------|
| POST | /api/auth/register | 用户注册 |
| POST | /api/auth/login | 用户登录 |
| GET | /api/auth/me | 获取当前用户 |

### 学习接口

| 方法 | 端点 | 说明 |
|------|------|------|
| GET | /api/words | 获取单词列表 |
| GET | /api/learning/today | 获取今日学习单词 |
| POST | /api/learning/answer | 提交答题结果 |

### 闯关接口

| 方法 | 端点 | 说明 |
|------|------|------|
| GET | /api/challenge/levels | 获取关卡列表 |
| POST | /api/challenge/:id/start | 开始闯关 |
| POST | /api/challenge/answer | 提交答案 |

---

## 🤝 贡献指南

欢迎所有形式的贡献！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

---

## 📝 开发故事

这个项目是我在2026年3月用两天时间为孩子开发的单词学习应用。孩子抱怨"背单词好无聊"，作为产品经理爸爸，我决定做一个有趣的应用。

项目采用 AI 辅助开发（Claude Code），大幅提升了开发效率。从想法到上线，仅用了两天时间。


---

## 📄 许可证

本项目基于 MIT 许可证开源 - 详见 [LICENSE](LICENSE) 文件

---

## 🙏 致谢

- [Vue.js](https://vuejs.org/) - 渐进式 JavaScript 框架
- [TypeORM](https://typeorm.io/) - TypeScript ORM
- [Pinia](https://pinia.vuejs.org/) - Vue 状态管理
- [Claude](https://www.anthropic.com/claude) - AI 辅助开发

---

<p align="center">
  <sub>Made with ❤️ by a programmer dad for his kid</sub>
</p>