# 百词斩式单词学习工具 - 项目规范

## 项目概述

一个类似百词斩的单词学习应用，让背单词不再枯燥！

**核心理念**: 极致的用户体验 + 游戏化学习 + 科学的记忆算法

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