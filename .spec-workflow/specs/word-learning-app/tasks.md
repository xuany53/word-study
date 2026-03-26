# Tasks Document - 百词斩式单词学习工具

## 阶段零：后端基础设施

- [x] 0.1 创建后端项目结构
  - File: server/package.json, server/tsconfig.json, server/.env.example, server/src/config/database.ts
  - 创建 Node.js + Express + TypeORM + MySQL 后端项目基础
  - Purpose: 建立后端服务基础
  - _Leverage: 无_
  - _Requirements: Backend 1.1_

- [x] 0.2 创建数据库实体
  - File: server/src/entities/*.ts
  - 创建所有数据库实体：User, Word, LearningRecord, Badge, UserBadge, ChallengeLevel, ChallengeResult
  - Purpose: 定义数据库模型
  - _Leverage: TypeORM_
  - _Requirements: Backend 1.2_

- [x] 0.3 创建后端路由和控制器
  - File: server/src/routes/*.ts, server/src/controllers/*.ts, server/src/middlewares/*.ts
  - 实现 RESTful API 路由和控制器
  - Purpose: 提供 API 接口
  - _Leverage: Express_
  - _Requirements: Backend 1.3_

- [ ] 0.4 安装依赖并初始化数据库
  - 运行 npm install 安装依赖
  - 配置 MySQL 数据库
  - 运行数据库迁移
  - Purpose: 初始化后端环境
  - _Leverage: npm, MySQL_
  - _Requirements: Backend 1.4_

---

## 阶段一：前端基础设施搭建

- [x] 1.1 创建 TypeScript 类型定义
  - File: src/types/word.ts, src/types/learning.ts, src/types/stats.ts, src/types/settings.ts, src/types/gamification.ts, src/types/challenge.ts
  - 定义所有核心数据模型的 TypeScript 接口
  - Purpose: 建立类型安全基础，确保代码质量
  - _Leverage: 无_
  - _Requirements: 1.1_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: TypeScript Developer specializing in Vue 3 type systems
      Task: Create comprehensive TypeScript interfaces for all data models following the design document. Create files:
      - src/types/word.ts (Word, Meaning, Example interfaces)
      - src/types/learning.ts (LearningRecord, LearningStatus types)
      - src/types/stats.ts (UserStats, DailyStats, CheckInRecord interfaces)
      - src/types/settings.ts (UserSettings interface)
      - src/types/gamification.ts (Badge, UserLevel interfaces)
      - src/types/challenge.ts (ChallengeLevel, ChallengeSession interfaces)

      Restrictions:
      - Use interface not type for object definitions
      - All properties must have explicit types, no any
      - Follow naming conventions from CLAUDE.md

      Success: All interfaces compile without errors, 100% type coverage for all data models
      Instructions: Set task to in-progress in tasks.md by changing [ ] to [-], implement the code, log implementation with log-implementation tool, then mark complete by changing [-] to [x]_

- [ ] 1.2 创建存储服务
  - File: src/services/storageService.ts
  - 实现 LocalStorage 封装，支持数据持久化
  - Purpose: 提供统一的数据存储接口
  - _Leverage: src/types/*.ts_
  - _Requirements: 1.2_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Frontend Developer with expertise in browser storage APIs
      Task: Create storageService.ts that wraps LocalStorage with type-safe methods:
      - get\<T\>(key: string): T | null
      - set\<T\>(key: string, value: T): void
      - remove(key: string): void
      - clear(): void
      - isAvailable(): boolean

      Include error handling for unavailable LocalStorage (fallback to memory)

      _Leverage: Use types from src/types/*.ts

      Restrictions:
      - Must handle LocalStorage not available scenario
      - All methods must be type-safe using generics
      - No direct LocalStorage access outside this service

      Success: Service handles all edge cases, provides type-safe storage, works when LocalStorage is unavailable
      Instructions: Set task to in-progress in tasks.md, implement the code, log implementation with log-implementation tool, then mark complete_

- [ ] 1.3 创建 Pinia Stores
  - File: src/stores/word.ts, src/stores/learning.ts, src/stores/stats.ts, src/stores/settings.ts, src/stores/gamification.ts, src/stores/challenge.ts
  - 实现所有 Pinia stores 的基础结构
  - Purpose: 状态管理核心
  - _Leverage: src/types/*.ts, src/services/storageService.ts_
  - _Requirements: 1.3_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Developer specializing in Pinia state management
      Task: Create all Pinia stores with basic structure following design document:
      - src/stores/word.ts (words, currentIndex, getters, actions)
      - src/stores/learning.ts (currentSession, learningRecords)
      - src/stores/stats.ts (userStats, dailyStats)
      - src/stores/settings.ts (userSettings)
      - src/stores/gamification.ts (badges, userLevel, streak)
      - src/stores/challenge.ts (currentSession, levels)

      Each store should have:
      - State interface with proper typing
      - Initial state from storage service
      - Basic getters
      - Actions for state mutations

      _Leverage: src/types/*.ts, src/services/storageService.ts

      Restrictions:
      - Use defineStore with setup store syntax
      - All state must be typed
      - Initialize from storage on store creation

      Success: All stores compile, provide type-safe state access, persist to storage
      Instructions: Set task to in-progress, implement, log with log-implementation, mark complete_

- [ ] 1.4 配置路由
  - File: src/router/index.ts
  - 配置所有页面路由
  - Purpose: 页面导航管理
  - _Leverage: 无_
  - _Requirements: 1.4_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue Router Developer
      Task: Configure Vue Router with all application routes:
      - / (Home) - 主页
      - /learning - 学习页面
      - /stats - 统计页面
      - /challenge - 闯关模式
      - /badges - 徽章画廊
      - /settings - 设置页面

      Use lazy loading for all routes

      Restrictions:
      - All routes must use lazy loading
      - Include route meta for page titles
      - No authentication guards needed (pure frontend)

      Success: All routes configured, lazy loading works, navigation functions correctly
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 1.5 创建项目入口文件
  - File: src/main.ts, src/App.vue
  - 配置 Vue 应用入口
  - Purpose: 应用初始化
  - _Leverage: src/stores/*.ts, src/router/index.ts_
  - _Requirements: 1.5_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Application Developer
      Task: Create main.ts and App.vue:
      - main.ts: Create Vue app, register Pinia, register Router, mount app
      - App.vue: Root component with router-view and basic layout

      _Leverage: src/stores/*.ts, src/router/index.ts

      Restrictions:
      - Use createApp from Vue 3
      - Register Pinia before Router
      - App.vue should be minimal, just router-view

      Success: Application starts without errors, Pinia and Router work correctly
      Instructions: Set task to in-progress, implement, log, mark complete_

---

## 阶段二：单词库和基础组件

- [ ] 2.1 创建单词库数据
  - File: src/data/wordLibrary.ts
  - 创建内置单词库（至少100个单词）
  - Purpose: 提供学习内容
  - _Leverage: src/types/word.ts_
  - _Requirements: 2.1_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Content Developer with ESL knowledge
      Task: Create wordLibrary.ts with at least 100 English words:
      - Each word: id, word, phonetic, pronunciation URL, meanings[], examples[], difficulty
      - Cover categories: animals, food, technology, daily life, etc.
      - Difficulty range: 1-5

      _Leverage: src/types/word.ts

      Restrictions:
      - All words must have complete data
      - Use realistic pronunciation URLs (can be placeholder)
      - Each word needs at least 1 example sentence

      Success: Library contains 100+ words with complete data, all typed correctly
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 2.2 实现 WordService
  - File: src/services/wordService.ts
  - 实现单词相关业务逻辑
  - Purpose: 单词获取和处理
  - _Leverage: src/types/word.ts, src/data/wordLibrary.ts_
  - _Requirements: 2.2_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Frontend Developer with business logic expertise
      Task: Create wordService.ts with methods:
      - getAllWords(): Word[]
      - getWordById(id: string): Word | undefined
      - getRandomWords(count: number, exclude?: string[]): Word[]
      - generateOptions(word: Word, count: number): string[] (生成选择题选项)
      - getWordsByDifficulty(difficulty: number): Word[]
      - getWordsForReview(): Word[] (根据艾宾浩斯曲线)

      _Leverage: src/types/word.ts, src/data/wordLibrary.ts

      Restrictions:
      - Options generation must include correct answer
      - Random selection should be truly random
      - No duplicate words in selection

      Success: All methods work correctly, options generation produces valid choices
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 2.3 创建基础组件
  - File: src/components/common/BaseButton.vue, src/components/common/BaseCard.vue
  - 创建通用 UI 组件
  - Purpose: UI 组件基础
  - _Leverage: 无_
  - _Requirements: 2.3_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Component Developer
      Task: Create reusable base components:

      BaseButton.vue:
      - Props: variant ('primary' | 'secondary' | 'danger'), size ('sm' | 'md' | 'lg'), disabled
      - Slots: default slot for button text
      - Emit: click event

      BaseCard.vue:
      - Props: title, padding
      - Slots: default slot for content
      - Style: rounded corners, shadow

      Restrictions:
      - Use scoped CSS
      - Follow Vue 3 script setup syntax
      - All props must have TypeScript types

      Success: Components render correctly with all variants, accessible
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 2.4 实现音频服务
  - File: src/services/audioService.ts
  - 实现单词发音播放
  - Purpose: 音频播放管理
  - _Leverage: 无_
  - _Requirements: 2.4_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Frontend Developer with Web Audio API expertise
      Task: Create audioService.ts with methods:
      - play(url: string): Promise\<void\>
      - stop(): void
      - preload(urls: string[]): void
      - isPlaying(): boolean
      - setVolume(volume: number): void

      Handle audio loading errors gracefully

      Restrictions:
      - Use HTML5 Audio API
      - Handle play() failures (browser autoplay policy)
      - Only one audio at a time

      Success: Audio plays correctly, errors handled gracefully, preloading works
      Instructions: Set task to in-progress, implement, log, mark complete_

---

## 阶段三：学习流程实现

- [ ] 3.1 实现调度服务（艾宾浩斯）
  - File: src/services/schedulerService.ts
  - 实现艾宾浩斯遗忘曲线算法
  - Purpose: 科学复习调度
  - _Leverage: src/types/learning.ts_
  - _Requirements: 3.1_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Algorithm Developer with memory science knowledge
      Task: Create schedulerService.ts implementing Ebbinghaus forgetting curve:
      - calculateNextReview(masteryLevel: number, correct: boolean): Date
      - getReviewInterval(masteryLevel: number): number (days: 1,2,4,7,15,30)
      - getWordsForToday(records: LearningRecord[]): LearningRecord[]
      - shouldReview(record: LearningRecord): boolean

      Review intervals: 1→2→4→7→15→30 days (increasing on correct answer)
      Reset to 1 day on incorrect answer

      _Leverage: src/types/learning.ts

      Restrictions:
      - Must follow Ebbinghaus curve intervals
      - Handle edge cases (new words, mastered words)
      - Pure functions, no side effects

      Success: Algorithm correctly calculates review dates, tests pass
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 3.2 创建单词卡片组件
  - File: src/components/learning/WordCard.vue
  - 实现单词展示卡片
  - Purpose: 核心学习 UI
  - _Leverage: src/types/word.ts, src/services/audioService.ts, src/components/common/BaseCard.vue_
  - _Requirements: 3.2_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 UI Component Developer
      Task: Create WordCard.vue displaying:
      - Word text (large, centered)
      - Phonetic notation
      - Audio play button
      - Meaning (hidden until answered)
      - Example sentence (hidden until answered)
      - Image (optional)

      Props: word: Word, showAnswer: boolean, mode: 'choice' | 'spelling'
      Emits: play-audio, answer

      _Leverage: src/types/word.ts, src/services/audioService.ts, src/components/common/BaseCard.vue

      Restrictions:
      - Use scoped CSS with nice animations
      - Show/hide answer with transition
      - Accessible with keyboard

      Success: Card displays all word info, audio plays, smooth animations
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 3.3 创建选项按钮组件
  - File: src/components/learning/OptionButton.vue
  - 实现选择题选项按钮
  - Purpose: 选择交互
  - _Leverage: src/components/common/BaseButton.vue_
  - _Requirements: 3.3_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 UI Component Developer
      Task: Create OptionButton.vue for multiple choice:
      - Display option text
      - Show correct/incorrect state with colors
      - Animated feedback on selection
      - Disabled state after selection

      Props: option: string, isCorrect: boolean | null, isSelected: boolean, disabled: boolean
      Emits: select

      _Leverage: src/components/common/BaseButton.vue

      Restrictions:
      - Use green for correct, red for incorrect
      - Smooth color transitions
      - Support keyboard navigation

      Success: Button shows states correctly, animations smooth, accessible
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 3.4 创建输入框组件
  - File: src/components/learning/TextInput.vue
  - 实现拼写输入框
  - Purpose: 拼写练习
  - _Leverage: 无_
  - _Requirements: 3.4_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Form Component Developer
      Task: Create TextInput.vue for spelling practice:
      - Text input field
      - Case-insensitive validation
      - Show correct answer on wrong
      - Submit on Enter key

      Props: correctAnswer: string, placeholder: string
      Emits: submit, correct, incorrect

      Restrictions:
      - Case-insensitive comparison
      - Trim whitespace
      - Clear on correct answer

      Success: Input validates correctly, shows answer on error, keyboard friendly
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 3.5 创建反馈动画组件
  - File: src/components/learning/FeedbackAnimation.vue
  - 实现正误反馈动画
  - Purpose: 学习反馈
  - _Leverage: 无_
  - _Requirements: 3.5_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Animation Developer
      Task: Create FeedbackAnimation.vue:
      - Correct: Green checkmark with scale animation + confetti
      - Incorrect: Red X with shake animation
      - Auto-hide after duration

      Props: type: 'correct' | 'incorrect', duration: number

      Restrictions:
      - Use Vue transition or CSS animations
      - Performance optimized
      - Accessible (doesn't rely only on color)

      Success: Animations play smoothly, auto-hide works, visually clear feedback
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 3.6 实现学习主页面
  - File: src/views/Learning.vue
  - 整合所有学习组件
  - Purpose: 完整学习流程
  - _Leverage: src/stores/learning.ts, src/stores/word.ts, src/components/learning/*.vue_
  - _Requirements: 3.6_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Page Developer
      Task: Create Learning.vue integrating all learning components:
      - Header with progress bar
      - WordCard display
      - OptionButton grid (choice mode) or TextInput (spelling mode)
      - FeedbackAnimation overlay
      - Next button after answer

      Flow: Show word → User answers → Show feedback → Next word

      _Leverage: src/stores/learning.ts, src/stores/word.ts, src/components/learning/*.vue

      Restrictions:
      - Manage loading states
      - Handle last word (show completion)
      - Save progress on each answer

      Success: Complete learning flow works, progress saved, smooth UX
      Instructions: Set task to in-progress, implement, log, mark complete_

---

## 阶段四：统计功能实现

- [ ] 4.1 完善统计 Store
  - File: src/stores/stats.ts
  - 实现统计逻辑
  - Purpose: 数据统计核心
  - _Leverage: src/types/stats.ts, src/services/storageService.ts_
  - _Requirements: 4.1_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Pinia Store Developer
      Task: Complete stats.ts store with:
      - updateDailyStats(correct: boolean): void
      - checkIn(): void (打卡)
      - getStreak(): number
      - getTotalCorrectRate(): number
      - getCheckInDates(): Date[]
      - resetTodayStats(): void

      State: userStats, todayStats, checkInCalendar

      _Leverage: src/types/stats.ts, src/services/storageService.ts

      Restrictions:
      - Persist to storage on each update
      - Calculate streak correctly (consecutive days)
      - Reset today stats at midnight (detect date change)

      Success: Stats calculate correctly, persist across sessions
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 4.2 创建每日统计卡片
  - File: src/components/stats/DailyStats.vue
  - 实现今日学习统计展示
  - Purpose: 统计展示
  - _Leverage: src/stores/stats.ts, src/components/common/BaseCard.vue_
  - _Requirements: 4.2_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 UI Developer
      Task: Create DailyStats.vue showing:
      - Today's new words count
      - Today's review words count
      - Today's correct rate (percentage)
      - Visual progress indicators

      Props: newWords, reviewWords, correctRate

      _Leverage: src/stores/stats.ts, src/components/common/BaseCard.vue

      Restrictions:
      - Use nice visual design
      - Animate number changes
      - Show empty state when no data

      Success: Stats display correctly with nice visuals
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 4.3 创建打卡日历组件
  - File: src/components/stats/CheckInCalendar.vue
  - 实现打卡日历
  - Purpose: 打卡可视化
  - _Leverage: src/stores/stats.ts_
  - _Requirements: 4.3_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Calendar Component Developer
      Task: Create CheckInCalendar.vue:
      - Monthly calendar grid
      - Highlight checked-in days
      - Show streak indicator
      - Navigate between months

      Props: year, month, checkInDates: Date[]

      _Leverage: src/stores/stats.ts

      Restrictions:
      - Use CSS Grid for layout
      - Responsive design
      - Accessible date labels

      Success: Calendar displays correctly, check-ins highlighted, navigation works
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 4.4 创建正确率仪表盘
  - File: src/components/stats/AccuracyGauge.vue
  - 实现正确率环形图
  - Purpose: 正确率可视化
  - _Leverage: 无_
  - _Requirements: 4.4_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Data Visualization Developer
      Task: Create AccuracyGauge.vue:
      - Circular progress gauge (0-100%)
      - Color changes based on value (red < 60, yellow < 80, green >= 80)
      - Animated on mount
      - Center shows percentage number

      Props: accuracy: number (0-100)

      Restrictions:
      - Use SVG or CSS for circle
      - Smooth animation
      - Accessible (aria-label with value)

      Success: Gauge animates correctly, shows accuracy clearly
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 4.5 创建统计页面
  - File: src/views/Stats.vue
  - 整合所有统计组件
  - Purpose: 统计主页面
  - _Leverage: src/stores/stats.ts, src/components/stats/*.vue_
  - _Requirements: 4.5_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Page Developer
      Task: Create Stats.vue integrating all stats components:
      - Header: "我的统计"
      - DailyStats card
      - AccuracyGauge
      - CheckInCalendar
      - Total stats summary

      _Leverage: src/stores/stats.ts, src/components/stats/*.vue

      Restrictions:
      - Load stats from store on mount
      - Handle empty state
      - Refresh on data change

      Success: Stats page displays all data correctly
      Instructions: Set task to in-progress, implement, log, mark complete_

---

## 阶段五：主页和设置

- [ ] 5.1 创建主页
  - File: src/views/Home.vue
  - 实现应用主页
  - Purpose: 用户入口
  - _Leverage: src/stores/stats.ts, src/stores/gamification.ts_
  - _Requirements: 5.1_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Page Developer
      Task: Create Home.vue with:
      - Welcome message with user level/title
      - Today's progress summary
      - Streak display (连续打卡)
      - Quick action buttons: "开始学习", "闯关模式", "统计"
      - Navigation to other pages

      _Leverage: src/stores/stats.ts, src/stores/gamification.ts

      Restrictions:
      - Show encouraging messages based on streak
      - Display learning reminder if not completed today
      - Nice visual design

      Success: Home page is welcoming, shows progress, navigates correctly
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 5.2 创建设置页面
  - File: src/views/Settings.vue
  - 实现设置页面
  - Purpose: 用户设置
  - _Leverage: src/stores/settings.ts_
  - _Requirements: 5.2_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Settings Page Developer
      Task: Create Settings.vue with:
      - Daily new words count setting (slider: 5-50)
      - Learning mode selection (choice/spelling/mixed)
      - Sound toggle
      - Auto-play audio toggle
      - Theme selection (light/dark/auto)
      - Reset data button (with confirmation)

      _Leverage: src/stores/settings.ts

      Restrictions:
      - All changes save immediately
      - Reset data requires confirmation dialog
      - Show current values

      Success: Settings work correctly, persist, reset requires confirmation
      Instructions: Set task to in-progress, implement, log, mark complete_

---

## 阶段六：游戏化系统

- [ ] 6.1 创建徽章数据
  - File: src/data/badges.ts
  - 定义所有徽章
  - Purpose: 徽章定义
  - _Leverage: src/types/gamification.ts_
  - _Requirements: 6.1_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Game Designer / Content Developer
      Task: Create badges.ts with at least 15 badges:
      - Streak badges: 3天, 7天, 14天, 30天, 60天
      - Word count badges: 100词, 500词, 1000词
      - Accuracy badges: 80%准确率, 90%准确率
      - Challenge badges: 完成关卡, 全三星通关
      - Special badges: 隐藏成就

      Each badge: id, name, icon, description, rarity, unlockCondition

      _Leverage: src/types/gamification.ts

      Restrictions:
      - Mix of rarities: common, rare, epic, legendary
      - Clear unlock conditions
      - Fun names and descriptions

      Success: Badge data complete with variety of achievements
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 6.2 完善游戏化 Store
  - File: src/stores/gamification.ts
  - 实现游戏化逻辑
  - Purpose: 游戏化核心
  - _Leverage: src/types/gamification.ts, src/data/badges.ts, src/services/storageService.ts_
  - _Requirements: 6.2_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Pinia Store Developer with gamification expertise
      Task: Complete gamification.ts store with:
      - checkBadgeUnlock(): Badge[] (检查并解锁新徽章)
      - addXp(amount: number): void
      - checkLevelUp(): boolean
      - getCurrentTitle(): string
      - updateStreak(): void
      - getUnlockedBadges(): Badge[]
      - getNextBadge(): Badge | null

      State: badges, userLevel, streak, xp

      _Leverage: src/types/gamification.ts, src/data/badges.ts, src/services/storageService.ts

      Restrictions:
      - Persist all state to storage
      - Calculate level from XP correctly
      - Streak resets on missed day

      Success: Gamification logic works, badges unlock, levels progress
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 6.3 创建连续打卡展示组件
  - File: src/components/gamification/StreakDisplay.vue
  - 实现打卡火焰动画
  - Purpose: 打卡展示
  - _Leverage: src/stores/gamification.ts_
  - _Requirements: 6.3_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Animation Developer
      Task: Create StreakDisplay.vue:
      - Fire icon with animation
      - Streak number (large)
      - "天连续打卡" text
      - Fire animation intensity based on streak length

      Props: streak: number, showAnimation: boolean

      _Leverage: src/stores/gamification.ts

      Restrictions:
      - Use CSS animations
      - More fire effects for longer streaks
      - Accessible

      Success: Fire animation looks great, streak displays clearly
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 6.4 创建徽章奖励弹窗
  - File: src/components/gamification/BadgeReward.vue
  - 实现徽章解锁弹窗
  - Purpose: 徽章奖励展示
  - _Leverage: src/types/gamification.ts, src/components/common/Confetti.vue_
  - _Requirements: 6.4_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Modal Developer
      Task: Create BadgeReward.vue:
      - Modal overlay with badge display
      - Badge icon (large, animated)
      - Badge name and description
      - Rarity indicator (color/border)
      - Unlock time
      - Confetti celebration
      - Close button

      Props: badge: Badge, visible: boolean
      Emits: close

      _Leverage: src/types/gamification.ts, src/components/common/Confetti.vue

      Restrictions:
      - Use Vue transition for modal
      - Play confetti on show
      - Click outside to close

      Success: Modal looks exciting, shows badge clearly, celebrations work
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 6.5 创建庆祝彩带动画
  - File: src/components/common/Confetti.vue
  - 实现彩带效果
  - Purpose: 庆祝动画
  - _Leverage: 无_
  - _Requirements: 6.5_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Animation Developer
      Task: Create Confetti.vue:
      - Colorful confetti particles
      - Fall animation from top
      - Random colors and positions
      - Auto-clear after duration

      Props: duration: number, intensity: 'low' | 'medium' | 'high'

      Restrictions:
      - Use requestAnimationFrame
      - Performance optimized
      - Clean up on unmount

      Success: Confetti looks great, performs well, cleans up properly
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 6.6 创建段位进度组件
  - File: src/components/gamification/LevelProgress.vue
  - 实现等级进度条
  - Purpose: 等级展示
  - _Leverage: src/stores/gamification.ts_
  - _Requirements: 6.6_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 UI Developer
      Task: Create LevelProgress.vue:
      - Current level number
      - Current title
      - XP progress bar
      - XP numbers (current / next level)
      - Visual level badge

      Props: currentLevel, xp, xpToNext

      _Leverage: src/stores/gamification.ts

      Restrictions:
      - Animate progress bar changes
      - Show level up animation
      - Clear visual hierarchy

      Success: Progress shows clearly, animations smooth
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 6.7 创建徽章画廊页面
  - File: src/views/Badges.vue
  - 实现徽章展示页面
  - Purpose: 徽章收藏
  - _Leverage: src/stores/gamification.ts, src/data/badges.ts_
  - _Requirements: 6.7_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Page Developer
      Task: Create Badges.vue:
      - Header: "徽章画廊"
      - Badge grid display
      - Show locked/unlocked states
      - Click badge for details
      - Filter by rarity
      - Total unlocked count

      _Leverage: src/stores/gamification.ts, src/data/badges.ts

      Restrictions:
      - Gray out locked badges
      - Show unlock condition on hover
      - Responsive grid

      Success: All badges display, filtering works, locked state clear
      Instructions: Set task to in-progress, implement, log, mark complete_

---

## 阶段七：闯关模式

- [ ] 7.1 创建关卡数据
  - File: src/data/levels.ts
  - 定义所有关卡
  - Purpose: 关卡定义
  - _Leverage: src/types/challenge.ts_
  - _Requirements: 7.1_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Game Designer
      Task: Create levels.ts with 10+ levels:
      - Level 1: 新手训练营 (5词, 无限时, 2次错误)
      - Level 2: 速度挑战 (10词, 60秒, 2次错误)
      - Level 3: 完美挑战 (15词, 90秒, 0次错误)
      - Level 4: 终极挑战 (20词, 120秒, 1次错误)
      - ... (more levels with increasing difficulty)

      Each level: id, name, description, wordCount, timeLimit?, maxErrors, difficulty, xpReward

      _Leverage: src/types/challenge.ts

      Restrictions:
      - Progressive difficulty
      - Clear descriptions
      - Balanced rewards

      Success: Level data complete with good progression
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 7.2 完善闯关 Store
  - File: src/stores/challenge.ts
  - 实现闯关逻辑
  - Purpose: 闯关状态管理
  - _Leverage: src/types/challenge.ts, src/data/levels.ts, src/services/storageService.ts_
  - _Requirements: 7.2_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Pinia Store Developer
      Task: Complete challenge.ts store with:
      - startLevel(levelId: string): void
      - answerQuestion(correct: boolean): void
      - updateTimeRemaining(seconds: number): void
      - endChallenge(): void
      - calculateStarRating(): 0 | 1 | 2 | 3
      - unlockNextLevel(): void
      - isLevelUnlocked(levelId: string): boolean

      State: levels, currentSession, completedLevels

      _Leverage: src/types/challenge.ts, src/data/levels.ts, src/services/storageService.ts

      Restrictions:
      - Persist completed levels
      - Handle timer correctly
      - Calculate stars based on accuracy

      Success: Challenge flow works, progress saved, unlocking correct
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 7.3 创建关卡卡片组件
  - File: src/components/challenge/LevelCard.vue
  - 实现关卡展示卡片
  - Purpose: 关卡选择 UI
  - _Leverage: src/types/challenge.ts, src/components/common/BaseCard.vue_
  - _Requirements: 7.3_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Card Component Developer
      Task: Create LevelCard.vue:
      - Level name
      - Difficulty badge
      - Star rating display (0-3 stars)
      - Lock overlay if not unlocked
      - Time limit indicator
      - Click to select

      Props: level: ChallengeLevel, isUnlocked: boolean, starRating: 0|1|2|3
      Emits: select

      _Leverage: src/types/challenge.ts, src/components/common/BaseCard.vue

      Restrictions:
      - Gray out locked levels
      - Show lock icon
      - Hover effects on unlocked

      Success: Cards look great, show all info clearly
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 7.4 创建倒计时显示组件
  - File: src/components/challenge/TimerDisplay.vue
  - 实现倒计时器
  - Purpose: 时间限制展示
  - _Leverage: 无_
  - _Requirements: 7.4_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Timer Component Developer
      Task: Create TimerDisplay.vue:
      - Large countdown display (MM:SS)
      - Warning state when low time (red, pulsing)
      - Circular progress indicator (optional)
      - Paused state display

      Props: seconds: number, isWarning: boolean

      Restrictions:
      - Update every second
      - Format as MM:SS
      - Warning at < 10 seconds

      Success: Timer counts down, warning state visible
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 7.5 创建闯关结果组件
  - File: src/components/challenge/ChallengeResult.vue
  - 实现闯关结果展示
  - Purpose: 结果反馈
  - _Leverage: src/components/common/Confetti.vue_
  - _Requirements: 7.5_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Result Component Developer
      Task: Create ChallengeResult.vue:
      - Pass/Fail header with animation
      - Star rating (1-3 stars or 0 for fail)
      - Stats: correct count, wrong count, time taken
      - XP earned
      - Retry button
      - Exit button
      - Confetti on pass

      Props: isPassed: boolean, starRating: 0|1|2|3, correctCount, wrongCount, xpEarned
      Emits: retry, exit

      _Leverage: src/components/common/Confetti.vue

      Restrictions:
      - Different visuals for pass/fail
      - Show earned XP
      - Celebration on pass

      Success: Results display clearly, actions work
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 7.6 创建闯关页面
  - File: src/views/Challenge.vue
  - 整合闯关组件
  - Purpose: 完整闯关流程
  - _Leverage: src/stores/challenge.ts, src/components/challenge/*.vue_
  - _Requirements: 7.6_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Vue 3 Page Developer
      Task: Create Challenge.vue with two modes:
      1. Level selection view:
         - Level cards grid
         - Back button
      2. Challenge play view:
         - Timer (if time limit)
         - Progress indicator
         - WordCard
         - Options/Input
         - Result modal

      Flow: Select level → Play challenge → Show result → Retry or exit

      _Leverage: src/stores/challenge.ts, src/components/challenge/*.vue

      Restrictions:
      - Handle both timed and untimed levels
      - Auto-submit on time end
      - Save progress on completion

      Success: Complete challenge flow works, all features functional
      Instructions: Set task to in-progress, implement, log, mark complete_

---

## 阶段八：测试和完善

- [ ] 8.1 编写单元测试
  - File: src/**/__tests__/*.spec.ts
  - 编写所有模块的单元测试
  - Purpose: 确保代码质量
  - _Leverage: Vitest, @vue/test-utils_
  - _Requirements: 8.1_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: QA Engineer specializing in Vue testing
      Task: Write comprehensive unit tests for:
      - All services (wordService, storageService, schedulerService, audioService)
      - All stores (word, learning, stats, settings, gamification, challenge)
      - Key components (WordCard, OptionButton, TextInput, etc.)

      Use Vitest + @vue/test-utils

      Target: 80%+ coverage, aim for 100%

      _Leverage: Vitest, @vue/test-utils

      Restrictions:
      - Test both success and error cases
      - Mock external dependencies
      - Follow AAA pattern (Arrange, Act, Assert)

      Success: All tests pass, coverage >= 80%
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 8.2 编写集成测试
  - File: src/**/__tests__/*.integration.spec.ts
  - 编写关键流程的集成测试
  - Purpose: 确保流程正确
  - _Leverage: Vitest_
  - _Requirements: 8.2_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Integration Test Engineer
      Task: Write integration tests for key flows:
      - Complete learning flow (start → answer → complete)
      - Badge unlock flow (meet condition → unlock → display)
      - Challenge flow (select → play → complete)
      - Settings change flow (change → save → persist)

      _Leverage: Vitest

      Restrictions:
      - Test real store interactions
      - Verify data persistence
      - Test error recovery

      Success: All integration flows work correctly
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 8.3 性能优化
  - File: Various
  - 优化应用性能
  - Purpose: 提升用户体验
  - _Leverage: 无_
  - _Requirements: 8.3_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Performance Engineer
      Task: Optimize application:
      - Lazy load route components
      - Implement component lazy loading
      - Add loading states
      - Optimize bundle size
      - Add Service Worker for offline support

      Restrictions:
      - Don't break functionality
      - Measure before/after performance
      - Document optimizations

      Success: First load < 2s, smooth interactions
      Instructions: Set task to in-progress, implement, log, mark complete_

- [ ] 8.4 最终测试和清理
  - File: Various
  - 全面测试和代码清理
  - Purpose: 发布准备
  - _Leverage: 无_
  - _Requirements: 8.4_
  - _Prompt: |
      Implement the task for spec word-learning-app, first run spec-workflow-guide to get the workflow guide then implement the task:

      Role: Senior Developer
      Task: Final review and cleanup:
      - Run all tests, ensure 100% pass
      - Check test coverage >= 80%
      - Run ESLint, fix all issues
      - Run Prettier, format all code
      - Remove unused code/comments
      - Update documentation
      - Manual testing of all features

      Restrictions:
      - No breaking changes
      - Maintain test coverage
      - Document all changes

      Success: All tests pass, coverage >= 80%, no lint errors, clean code
      Instructions: Set task to in-progress, implement, log, mark complete_