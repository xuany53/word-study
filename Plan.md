# 百词斩式单词学习工具 - 实施计划

## 📋 项目概述

在 `C:/Users/86155/my-vue-project` 基础上构建一个类似百词斩的单词学习工具。

**技术栈**：Vue 3 + TypeScript + Pinia + Vue Router

**核心功能**：
- 每日单词学习
- 学习统计
- 🔥 连续打卡奖励系统（游戏化）
- 🎮 闯关模式

---

## 🎯 目标

打造一个极致体验的单词学习应用，让背单词不再枯燥！

---

## 📁 项目结构

```
my-vue-project/
├── src/
│   ├── assets/
│   │   ├── images/              # 单词图片资源
│   │   ├── sounds/              # 单词发音音频
│   │   └── styles/              # 全局样式
│   ├── components/
│   │   ├── learning/            # 学习相关组件
│   │   │   ├── WordCard.vue           # 单词卡片组件
│   │   │   ├── ProgressBar.vue        # 进度条组件
│   │   │   ├── FeedbackAnimation.vue  # 正误反馈动画
│   │   │   ├── OptionButton.vue       # 选项按钮
│   │   │   └── TextInput.vue          # 拼写输入
│   │   ├── gamification/        # 游戏化组件
│   │   │   ├── StreakDisplay.vue      # 连续打卡展示
│   │   │   ├── BadgeReward.vue        # 徽章奖励弹窗
│   │   │   ├── AchievementToast.vue   # 成就通知
│   │   │   └── LevelProgress.vue      # 段位进度
│   │   ├── challenge/           # 闯关模式组件
│   │   │   ├── LevelCard.vue          # 关卡卡片
│   │   │   ├── ChallengeResult.vue    # 闯关结果
│   │   │   ├── TimerDisplay.vue       # 倒计时显示
│   │   │   └── LevelMap.vue           # 关卡地图
│   │   ├── stats/               # 统计相关组件
│   │   │   ├── DailyStats.vue         # 每日统计卡片
│   │   │   ├── CheckInCalendar.vue    # 打卡日历
│   │   │   ├── AccuracyGauge.vue      # 正确率仪表盘
│   │   │   └── BadgeGallery.vue       # 徽章画廊
│   │   └── common/              # 通用组件
│   │       ├── BaseButton.vue         # 基础按钮
│   │       ├── BaseCard.vue           # 基础卡片
│   │       └── Confetti.vue           # 庆祝彩带动画
│   ├── stores/                  # Pinia stores
│   │   ├── word.ts              # 单词 store
│   │   ├── learning.ts          # 学习流程 store
│   │   ├── stats.ts             # 统计数据 store
│   │   ├── settings.ts          # 设置 store
│   │   ├── gamification.ts      # 游戏化 store（打卡、徽章）
│   │   └── challenge.ts         # 闯关模式 store
│   ├── types/                   # TypeScript 类型定义
│   │   ├── word.ts              # 单词相关类型
│   │   ├── learning.ts          # 学习相关类型
│   │   ├── stats.ts             # 统计相关类型
│   │   ├── settings.ts          # 设置相关类型
│   │   ├── gamification.ts      # 游戏化类型（徽章、成就）
│   │   └── challenge.ts         # 闯关模式类型
│   ├── services/                # 业务逻辑服务
│   │   ├── wordService.ts       # 单词服务
│   │   ├── storageService.ts    # LocalStorage 服务
│   │   ├── audioService.ts      # 音频播放服务
│   │   └── schedulerService.ts  # 学习调度服务（艾宾浩斯曲线）
│   ├── data/                    # 静态数据
│   │   ├── wordLibrary.ts       # 内置单词库
│   │   ├── badges.ts            # 徽章定义
│   │   └── levels.ts            # 闯关关卡数据
│   ├── views/                   # 页面视图
│   │   ├── Home.vue             # 主页（学习选择）
│   │   ├── Learning.vue         # 学习页面
│   │   ├── Challenge.vue        # 闯关模式页面
│   │   ├── Stats.vue            # 统计页面
│   │   ├── Badges.vue           # 徽章画廊页面
│   │   └── Settings.vue         # 设置页面
│   ├── router/                  # 路由配置
│   │   └── index.ts
│   └── main.ts                  # 入口文件
```

---

## 🏗️ 实施步骤

### 阶段一：基础设施搭建（最高优先级）

| 步骤 | 任务 | 文件 |
|------|------|------|
| 1.1 | 安装 Pinia 并替换 Vuex | `package.json`, `main.ts` |
| 1.2 | 创建 TypeScript 类型定义 | `src/types/*.ts` |
| 1.3 | 实现存储服务 | `src/services/storageService.ts` |
| 1.4 | 创建基础 Pinia stores | `src/stores/*.ts` |
| 1.5 | 配置路由 | `src/router/index.ts` |

### 阶段二：单词库和基础组件（高优先级）

| 步骤 | 任务 | 文件 |
|------|------|------|
| 2.1 | 准备单词库数据 | `src/data/wordLibrary.ts` |
| 2.2 | 实现 WordService | `src/services/wordService.ts` |
| 2.3 | 创建单词卡片组件 | `src/components/learning/WordCard.vue` |
| 2.4 | 实现音频服务 | `src/services/audioService.ts` |
| 2.5 | 创建基础组件库 | `src/components/common/*.vue` |

### 阶段三：学习流程实现（高优先级）

| 步骤 | 任务 | 文件 |
|------|------|------|
| 3.1 | 实现调度服务（艾宾浩斯） | `src/services/schedulerService.ts` |
| 3.2 | 创建选项按钮组件 | `src/components/learning/OptionButton.vue` |
| 3.3 | 创建输入框组件 | `src/components/learning/TextInput.vue` |
| 3.4 | 创建反馈动画组件 | `src/components/learning/FeedbackAnimation.vue` |
| 3.5 | 实现学习主页面 | `src/views/Learning.vue` |

### 阶段四：统计功能实现（中优先级）

| 步骤 | 任务 | 文件 |
|------|------|------|
| 4.1 | 实现统计逻辑 | `src/stores/stats.ts` |
| 4.2 | 创建每日统计卡片 | `src/components/stats/DailyStats.vue` |
| 4.3 | 创建打卡日历组件 | `src/components/stats/CheckInCalendar.vue` |
| 4.4 | 创建统计页面 | `src/views/Stats.vue` |

### 阶段五：主页和设置（中优先级）

| 步骤 | 任务 | 文件 |
|------|------|------|
| 5.1 | 重新设计主页 | `src/views/Home.vue` |
| 5.2 | 创建设置页面 | `src/views/Settings.vue` |

### 阶段六：完善和优化

| 步骤 | 任务 |
|------|------|
| 6.1 | 完善数据持久化 |
| 6.2 | 添加错误处理 |
| 6.3 | 样式优化 |

---

### 阶段七：游戏化 - 连续打卡奖励系统（新增）

| 步骤 | 任务 | 文件 |
|------|------|------|
| 7.1 | 创建游戏化类型定义 | `src/types/gamification.ts` |
| 7.2 | 实现游戏化 store | `src/stores/gamification.ts` |
| 7.3 | 创建徽章数据 | `src/data/badges.ts` |
| 7.4 | 创建连续打卡展示组件 | `src/components/gamification/StreakDisplay.vue` |
| 7.5 | 创建徽章奖励弹窗 | `src/components/gamification/BadgeReward.vue` |
| 7.6 | 创建成就通知组件 | `src/components/gamification/AchievementToast.vue` |
| 7.7 | 创建段位进度组件 | `src/components/gamification/LevelProgress.vue` |
| 7.8 | 创建庆祝彩带动画 | `src/components/common/Confetti.vue` |
| 7.9 | 创建徽章画廊页面 | `src/views/Badges.vue` |

**奖励等级设计：**
```
🔥 3天连续打卡 → 获得"初学者"称号 + 🎓 青铜徽章
🔥 7天连续打卡 → 获得"勤奋达人"称号 + 🥈 白银徽章 + 解锁新主题
🔥 14天连续打卡 → 获得"坚持不懈"称号 + 🥇 黄金徽章
🔥 30天连续打卡 → 获得"单词大师"称号 + 💎 钻石徽章 + 特殊头像框
🔥 60天连续打卡 → 获得"传奇人物"称号 + 👑 王者徽章 + 隐藏成就
```

---

### 阶段八：闯关模式（新增）

| 步骤 | 任务 | 文件 |
|------|------|------|
| 8.1 | 创建闯关类型定义 | `src/types/challenge.ts` |
| 8.2 | 实现闯关 store | `src/stores/challenge.ts` |
| 8.3 | 创建关卡数据 | `src/data/levels.ts` |
| 8.4 | 创建关卡卡片组件 | `src/components/challenge/LevelCard.vue` |
| 8.5 | 创建倒计时显示组件 | `src/components/challenge/TimerDisplay.vue` |
| 8.6 | 创建闯关结果组件 | `src/components/challenge/ChallengeResult.vue` |
| 8.7 | 创建关卡地图组件 | `src/components/challenge/LevelMap.vue` |
| 8.8 | 创建闯关模式页面 | `src/views/Challenge.vue` |

**关卡设计：**
```
第 1 关：新手训练营
- 5 个基础单词
- 无时间限制
- 允许 2 次错误

第 2 关：速度挑战
- 10 个单词
- 60 秒时间限制
- 允许 2 次错误

第 3 关：完美挑战
- 15 个单词
- 90 秒时间限制
- 不允许错误！

第 4 关：终极挑战
- 20 个高难度单词
- 120 秒时间限制
- 只允许 1 次错误
- 连续答对 5 题有双倍积分
```

---

## 🔑 关键依赖关系

```
阶段一 (基础设施)
    ↓
阶段二 (单词库) ────────┐
    ↓                    │
阶段三 (学习流程) ───────┼──→ 阶段四 (统计)
    ↓                    │
阶段五 (主页设置) ───────┘
    ↓
阶段六 (完善优化)
    ↓
阶段七 (打卡奖励) ────────┐
    ↓                    │
阶段八 (闯关模式) ────────┘
```

---

## 📝 核心数据模型

### Word（单词）
```typescript
{
  id: string;
  word: string;
  phonetic: string;
  pronunciation: string;
  meanings: Meaning[];
  examples: Example[];
  image?: string;
  category?: string;
  difficulty: 1-5;
}
```

### LearningRecord（学习记录）
```typescript
{
  id: string;
  wordId: string;
  status: 'new' | 'learning' | 'reviewing' | 'mastered';
  masteryLevel: 0-5;
  correctCount: number;
  wrongCount: number;
  nextReviewAt: Date;
}
```

### UserStats（用户统计）
```typescript
{
  totalDays: number;
  totalWords: number;
  masteredWords: number;
  correctRate: number;
  todayStats: DailyStats;
  streak: number;
  checkInCalendar: CheckInCalendar;
}
```

### Badge（徽章）
```typescript
{
  id: string;
  name: string;
  icon: string;
  description: string;
  rarity: 'common' | 'rare' | 'epic' | 'legendary';
  unlockCondition: {
    type: 'streak' | 'words' | 'accuracy' | 'challenge';
    value: number;
  };
  isUnlocked: boolean;
  unlockedAt?: Date;
}
```

### UserLevel（用户段位）
```typescript
{
  currentLevel: number;        // 当前等级
  currentTitle: string;        // 当前称号
  xp: number;                  // 经验值
  xpToNext: number;            // 下一级所需经验
  levelProgress: number;       // 进度百分比
}
```

### ChallengeLevel（关卡）
```typescript
{
  id: string;
  name: string;
  description: string;
  wordCount: number;
  timeLimit?: number;          // 秒数，无限制则 undefined
  maxErrors: number;           // 最大错误次数
  difficulty: 'easy' | 'medium' | 'hard' | 'extreme';
  starRating: 0 | 1 | 2 | 3;   // 星级评价
  isUnlocked: boolean;
  requiredLevel?: number;      // 解锁所需等级
}
```

### ChallengeSession（闯关会话）
```typescript
{
  levelId: string;
  wordIds: string[];
  currentIndex: number;
  startTime: Date;
  endTime?: Date;
  correctCount: number;
  wrongCount: number;
  timeRemaining: number;
  isCompleted: boolean;
  isFailed: boolean;
}
```

---

## 🧪 验证方式

1. **启动开发服务器**
   ```bash
   cd C:/Users/86155/my-vue-project
   npm run serve
   ```

2. **验证核心功能**
   - 主页显示每日学习进度
   - 点击"开始学习"进入学习页面
   - 完成单词学习并记录正确/错误
   - 查看统计页面确认数据正确
   - 重新打开应用验证数据持久化

3. **验证连续打卡奖励**
   - 连续打卡 3 天 → 获得"初学者"徽章
   - 连续打卡 7 天 → 获得"勤奋达人"称号
   - 查看徽章画廊确认徽章解锁
   - 查看段位进度确认等级提升

4. **验证闯关模式**
   - 进入关卡地图查看所有关卡
   - 开始第 1 关（无时间限制）
   - 通过第 1 关解锁第 2 关
   - 尝试第 2 关（60秒倒计时）
   - 挑战失败后查看结果页面

5. **关键测试点**
   - [ ] 单词卡片正确显示
   - [ ] 选项选择正确判断
   - [ ] 音频播放正常
   - [ ] 学习进度正确更新
   - [ ] 数据成功保存到 LocalStorage
   - [ ] 刷新页面后数据保持
   - [ ] 连续打卡天数正确计算
   - [ ] 徽章解锁动画正常
   - [ ] 闯关倒计时准确
   - [ ] 关卡解锁逻辑正确

---

## ⚙️ 配置要求

### 安装依赖
```bash
cd C:/Users/86155/my-vue-project
npm install pinia
```

### 删除旧依赖
```bash
npm uninstall vuex vue-class-component
```

---

## 📊 预计时间

- 阶段一：4小时
- 阶段二：4小时
- 阶段三：5小时
- 阶段四：3小时
- 阶段五：2小时
- 阶段六：2小时
- 阶段七（连续打卡奖励）：5小时
- 阶段八（闯关模式）：5小时

**总计：约 30 小时**

---

## 🚀 技术亮点

1. **Pinia 状态管理** - 替代 Vuex，更现代、更简洁
2. **Composition API** - 使用 `<script setup>` 语法，代码更优雅
3. **艾宾浩斯遗忘曲线** - 科学的复习算法
4. **LocalStorage 持久化** - 纯前端实现，无需后端
5. **TypeScript 全覆盖** - 类型安全，开发更可靠
6. **游戏化元素** - 连续打卡奖励、徽章系统、段位系统
7. **闯关模式** - 有挑战性的关卡设计，增加学习趣味性