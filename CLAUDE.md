# 趣背词 - 项目规范

## 项目概述

一个创新的单词学习应用，让背单词不再枯燥！

**核心理念**: 极致的用户体验 + 游戏化学习 + 科学的记忆算法

---

## 功能特性

### 🔐 用户认证

- **登录验证**: 学习相关页面需要登录才能访问
- **路由守卫**: 自动检测登录状态，未登录用户跳转到登录页
- **保护页面**: 学习、统计、闯关、徽章、设置等页面均需登录

### 📚 学习功能

- **多种学习模式**: 选择题、拼写模式
- **自动播放发音**: 显示新单词时自动播放读音
- **手动发音按钮**: 可点击喇叭图标重新播放
- **闯关模式题型**: 40% 概率出现中文→英文题型

### 🔊 音效反馈

- **正确提示音**: 播放 "excellent" 语音，给予积极反馈
- **错误提示音**: 下降音调，温和提示
- **音效开关**: 可在设置中开启/关闭

### ✅ 打卡机制

- **自动打卡**: 完成一组学习后自动打卡，无需手动操作
- **打卡限制**: 每日学习未达标时禁止手动打卡
- **达标标准**: 根据设置中的"每日新词数量"判断（默认20个）
- **提示信息**: 显示"今日已学 X 个单词，需完成 Y 个才能打卡"

---

## 单词数据库

### 数据统计（2026-03-27更新）

| 分类 | 数量 |
|------|------|
| 汇总词汇 | 6,465 个 |
| RAZ分级词汇 | 13,473 个 |
| **总计** | **19,938 个** |

### RAZ分级级别

共29个级别：AA, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Z1, Z2

### 年级分类

| 年级 | 数量 |
|------|------|
| 小学 | 1,946 个 |
| 初中 | 3,027 个 |
| 高中 | 3,510 个 |
| 其他 | 4,222 个 |

### 数据结构

```typescript
interface Word {
  id: string
  word: string
  phonetic: string
  pronunciation?: string
  meanings: Array<{ partOfSpeech: string; definition: string; translation: string }>
  examples: Array<{ sentence: string; translation: string }>
  image?: string
  category?: string
  gradeLevel?: string  // 小学/初中/高中
  source?: string      // 汇总/RAZ分级
  razLevel?: string    // aa, a, b, c... z2
  difficulty: number
  createdAt: Date
}
```

### API筛选示例

```bash
# 按RAZ级别筛选（支持多选）
GET /api/words?razLevel=a,b,c

# 按RAZ级别 + 年级筛选
GET /api/words?razLevel=a,b,c&gradeLevel=初中

# 按汇总 + 年级筛选
GET /api/words?source=汇总&gradeLevel=初中

# 按RAZ分级 + 年级筛选
GET /api/words?source=RAZ分级&gradeLevel=小学
```

---

## 技术栈

### 核心框架
| 技术 | 版本 | 用途 |
|------|------|------|
| Vue | 3.x | 前端框架 |
| TypeScript | 5.x | 类型安全 |
| Pinia | 2.x | 状态管理 |
| Vue Router | 4.x | 路由管理 |

### 开发工具
| 工具 | 用途 |
|------|------|
| Vite | 构建工具 |
| ESLint | 代码检查 |
| Prettier | 代码格式化 |
| Vitest | 单元测试 |
| Vue Test Utils | 组件测试 |

---

## 代码规范

### 文件命名规范
```
组件文件: PascalCase.vue    (例: WordCard.vue)
Store文件: camelCase.ts     (例: wordStore.ts)
类型文件: camelCase.ts      (例: word.ts)
服务文件: camelCase.ts      (例: wordService.ts)
视图文件: PascalCase.vue    (例: Learning.vue)
```

### 组件结构规范
```vue
<template>
  <!-- 模板内容 -->
</template>

<script setup lang="ts">
// 1. 导入
import { ref, computed } from 'vue'

// 2. 类型定义
interface Props { ... }

// 3. Props/Emits
const props = defineProps<Props>()
const emit = defineEmits<{ ... }>()

// 4. 响应式状态
const state = ref(...)

// 5. 计算属性
const computed = computed(() => ...)

// 6. 方法
function handleClick() { ... }

// 7. 生命周期
onMounted(() => { ... })
</script>

<style scoped>
/* 样式 */
</style>
```

### TypeScript 规范
```typescript
// ✅ 推荐：使用 interface 定义类型
interface Word {
  id: string
  word: string
  phonetic: string
}

// ✅ 推荐：使用类型推断
const words = ref<Word[]>([])

// ✅ 推荐：函数参数和返回值类型
function getWord(id: string): Word | undefined { ... }

// ❌ 避免：使用 any
const data: any = {} // 不推荐
```

### Store 规范 (Pinia)
```typescript
// stores/word.ts
import { defineStore } from 'pinia'
import type { Word } from '@/types/word'

interface WordState {
  words: Word[]
  currentIndex: number
}

export const useWordStore = defineStore('word', {
  state: (): WordState => ({
    words: [],
    currentIndex: 0
  }),

  getters: {
    currentWord: (state) => state.words[state.currentIndex],
    totalWords: (state) => state.words.length
  },

  actions: {
    async loadWords() { ... },
    nextWord() { ... }
  }
})
```

---

## 测试要求

### 🎯 Completeness Principle - 测试必须达到 100% 覆盖

**核心理念**: 每个模块开发完成后必须完成测试才能进入下一个模块！

### 测试层级
1. **单元测试** - 每个函数、方法必须有测试
2. **组件测试** - 每个组件必须有交互测试
3. **集成测试** - Store 和 Service 必须有集成测试
4. **E2E 测试** - 关键用户流程必须有端到端测试

### 测试文件结构
```
src/
├── components/
│   └── learning/
│       ├── WordCard.vue
│       └── __tests__/
│           └── WordCard.spec.ts    # 组件测试
├── stores/
│   ├── word.ts
│   └── __tests__/
│       └── word.spec.ts            # Store 测试
├── services/
│   ├── wordService.ts
│   └── __tests__/
│       └── wordService.spec.ts     # Service 测试
```

### 测试用例规范
```typescript
// __tests__/WordCard.spec.ts
import { describe, it, expect, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import WordCard from '../WordCard.vue'

describe('WordCard', () => {
  // ✅ 渲染测试
  it('should render word correctly', () => {
    const wrapper = mount(WordCard, {
      props: { word: mockWord }
    })
    expect(wrapper.text()).toContain('hello')
  })

  // ✅ 交互测试
  it('should emit click event when clicked', async () => {
    const wrapper = mount(WordCard, {
      props: { word: mockWord }
    })
    await wrapper.find('.word-card').trigger('click')
    expect(wrapper.emitted('click')).toBeTruthy()
  })

  // ✅ 边缘情况测试
  it('should handle empty word gracefully', () => {
    const wrapper = mount(WordCard, {
      props: { word: null }
    })
    expect(wrapper.find('.empty-state').exists()).toBe(true)
  })
})
```

### 测试覆盖率要求
| 类型 | 最低覆盖率 | 目标覆盖率 |
|------|-----------|-----------|
| 语句覆盖率 | 80% | 100% |
| 分支覆盖率 | 75% | 100% |
| 函数覆盖率 | 80% | 100% |
| 行覆盖率 | 80% | 100% |

### 测试运行命令
```bash
# 运行所有测试
npm run test

# 运行特定文件测试
npm run test WordCard

# 运行测试并生成覆盖率报告
npm run test:coverage

# 监听模式
npm run test:watch
```

---

## 模块开发流程

### 🔄 每个模块必须按此流程执行

```
1. 编码实现
   ↓
2. 编写测试
   ↓
3. 运行测试，确保通过
   ↓
4. 检查测试覆盖率，达到目标
   ↓
5. 代码审查
   ↓
6. 合并到主分支
   ↓
7. 进入下一个模块
```

### 模块依赖顺序
```
阶段一: 基础设施
    ├── 1.1 TypeScript 类型定义
    ├── 1.2 存储服务
    ├── 1.3 Pinia Stores
    └── 1.4 路由配置

阶段二: 单词库和基础组件
    ├── 2.1 单词库数据
    ├── 2.2 WordService
    ├── 2.3 基础组件
    └── 2.4 音频服务

阶段三: 学习流程
    ├── 3.1 调度服务
    ├── 3.2 学习组件
    └── 3.3 学习页面

阶段四: 统计功能
    ├── 4.1 统计逻辑
    └── 4.2 统计组件

阶段五: 主页和设置
    ├── 5.1 主页
    └── 5.2 设置页面

阶段六: 游戏化系统
    ├── 6.1 打卡奖励
    └── 6.2 徽章系统

阶段七: 闯关模式
    ├── 7.1 关卡数据
    ├── 7.2 闯关组件
    └── 7.3 闯关页面
```

---

## 目录结构

```
src/
├── assets/              # 静态资源
│   ├── images/          # 图片
│   ├── sounds/          # 音频
│   └── styles/          # 样式
├── components/          # 组件
│   ├── common/          # 通用组件
│   ├── learning/        # 学习组件
│   ├── gamification/    # 游戏化组件
│   ├── challenge/       # 闯关组件
│   └── stats/           # 统计组件
├── stores/              # Pinia 状态管理
├── types/               # TypeScript 类型
├── services/            # 业务服务
├── data/                # 静态数据
├── views/               # 页面视图
├── router/              # 路由配置
└── main.ts              # 入口文件
```

---

## Git 提交规范

### 提交信息格式
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type 类型
- `feat`: 新功能
- `fix`: 修复 bug
- `test`: 添加测试
- `refactor`: 重构代码
- `style`: 代码格式
- `docs`: 文档更新
- `chore`: 构建/工具变动

### 示例
```
feat(learning): 实现单词卡片组件

- 添加 WordCard 组件
- 支持单词显示和发音
- 添加选择正确/错误反馈

Closes #123
```

---

## 音频服务

### 功能概述

`audioService.ts` 提供单词发音和音效播放功能。

### 核心方法

```typescript
// 播放单词发音
playWordAudio(word: string, pronunciationUrl?: string): Promise<boolean>

// 播放正确提示音 ("excellent" 语音)
playCorrectSound(): void

// 播放错误提示音 (下降音调)
playWrongSound(): void

// 停止当前音频
stopCurrentAudio(): void
```

### 音频源优先级

1. 提供的音频 URL
2. 缓存的音频
3. 有道词典 TTS（国内可用）
4. Web Speech API（最终回退）

---

## 打卡逻辑

### 自动打卡流程

```
用户完成学习 → 调用 nextWord() → 判断是否最后一个单词
    ↓
是最后一个 → 调用 statsStore.checkIn() → 自动打卡
    ↓
跳转到统计页面
```

### 手动打卡限制

```typescript
// 从设置中获取每日目标
const dailyGoal = settings.dailyNewWords || 20

// 计算今日已学单词数
const todayLearnedWords = todayStats.newWords + todayStats.review

// 判断是否可以打卡
const canCheckIn = todayLearnedWords >= dailyGoal
```

### 后端处理

- 重复打卡返回 400 错误 "Already checked in today"
- 前端用 try-catch 捕获，不影响用户体验

---

## 性能优化要求

1. **组件懒加载**: 路由组件使用动态导入
2. **状态持久化**: LocalStorage 缓存关键数据
3. **图片优化**: 使用 WebP 格式，懒加载
4. **音频预加载**: 关键音频预加载
5. **防抖节流**: 高频操作使用防抖/节流

---

## 无障碍要求

1. **键盘导航**: 所有交互元素支持键盘操作
2. **ARIA 标签**: 添加适当的 aria 属性
3. **颜色对比**: 符合 WCAG 2.1 AA 标准
4. **屏幕阅读器**: 重要信息支持屏幕阅读器

---

## 开发命令

```bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 构建生产版本
npm run build

# 运行测试
npm run test

# 运行测试覆盖率
npm run test:coverage

# 代码检查
npm run lint

# 代码格式化
npm run format
```

---

## 注意事项

1. ⚠️ **每个模块完成后必须完成测试才能进入下一个模块**
2. ⚠️ **测试覆盖率必须达到目标才能提交**
3. ⚠️ **所有代码必须通过 ESLint 检查**
4. ⚠️ **所有组件必须使用 TypeScript 类型定义**
5. ⚠️ **所有 Store 必须有完整的单元测试**