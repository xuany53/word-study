# Requirements Document - 百词斩式单词学习工具

## Introduction

这是一个类似百词斩的单词学习应用，通过游戏化设计和科学的记忆算法，让背单词不再枯燥。应用采用纯前端实现（Vue 3 + TypeScript），使用 LocalStorage 进行数据持久化，无需后端支持。

**核心价值主张：极致的用户体验 + 游戏化学习 + 科学的记忆算法**

## Alignment with Product Vision

本项目旨在打造一个完整的单词学习解决方案：
- 每日学习流程：帮助用户养成持续学习的习惯
- 游戏化系统：通过打卡奖励、徽章、段位等机制提升用户粘性
- 闯关模式：提供有挑战性的学习体验，增加学习趣味性
- 艾宾浩斯遗忘曲线：科学的复习调度，提高记忆效率

---

## Requirements

### Requirement 1: 每日单词学习

**User Story:** 作为一名学习者，我希望每天都能学习新单词并复习旧单词，以便持续提升词汇量。

#### Acceptance Criteria

1. WHEN 用户打开应用 THEN 系统 SHALL 显示今日学习计划（新词数量、复习数量）
2. WHEN 用户点击"开始学习" THEN 系统 SHALL 展示单词卡片（单词、音标、释义、例句）
3. WHEN 用户选择答案正确 THEN 系统 SHALL 显示正确反馈动画并进入下一个单词
4. WHEN 用户选择答案错误 THEN 系统 SHALL 显示错误反馈动画并展示正确答案
5. IF 用户完成今日学习任务 THEN 系统 SHALL 更新学习统计数据
6. WHEN 单词卡片展示时 THEN 系统 SHALL 自动播放单词发音

### Requirement 2: 单词选择模式

**User Story:** 作为一名学习者，我希望通过选择题的方式学习单词，以便快速建立单词印象。

#### Acceptance Criteria

1. WHEN 展示单词卡片 THEN 系统 SHALL 显示4个选项供用户选择
2. IF 用户选择正确 THEN 系统 SHALL 记录该单词掌握度+1
3. IF 用户选择错误 THEN 系统 SHALL 记录该单词掌握度-1并加入复习队列
4. WHEN 选项生成时 THEN 系统 SHALL 确保正确答案在4个选项中随机位置

### Requirement 3: 拼写模式

**User Story:** 作为一名学习者，我希望通过拼写来巩固单词记忆，以便更牢固地掌握单词。

#### Acceptance Criteria

1. WHEN 用户选择拼写模式 THEN 系统 SHALL 显示单词释义并要求输入单词
2. IF 用户输入正确 THEN 系统 SHALL 记录该单词掌握度+2
3. IF 用户输入错误 THEN 系统 SHALL 显示正确拼写并加入复习队列
4. WHEN 输入时 THEN 系统 SHALL 支持大小写不敏感匹配

### Requirement 4: 学习调度（艾宾浩斯遗忘曲线）

**User Story:** 作为一名学习者，我希望系统智能安排复习时间，以便高效记忆单词。

#### Acceptance Criteria

1. WHEN 用户首次学习新词 THEN 系统 SHALL 设置下次复习时间为1天后
2. IF 用户连续正确回忆 THEN 系统 SHALL 按照遗忘曲线延长复习间隔（1→2→4→7→15天）
3. IF 用户回忆失败 THEN 系统 SHALL 重置复习间隔
4. WHEN 用户打开应用 THEN 系统 SHALL 自动筛选今日需要复习的单词

---

### Requirement 5: 学习统计

**User Story:** 作为一名学习者，我希望查看我的学习统计数据，以便了解学习进度和成果。

#### Acceptance Criteria

1. WHEN 用户查看统计页面 THEN 系统 SHALL 显示累计学习天数、总词汇量、已掌握词汇数
2. WHEN 用户查看统计页面 THEN 系统 SHALL 显示今日学习数据（新词数、复习数、正确率）
3. WHEN 用户查看统计页面 THEN 系统 SHALL 显示打卡日历（标记每日打卡状态）
4. IF 用户当天完成学习任务 THEN 系统 SHALL 在日历上标记打卡

### Requirement 6: 正确率统计

**User Story:** 作为一名学习者，我希望看到我的总体正确率，以便评估学习效果。

#### Acceptance Criteria

1. WHEN 统计页面加载 THEN 系统 SHALL 计算并显示总体正确率
2. WHEN 统计页面加载 THEN 系统 SHALL 显示正确率变化趋势图
3. IF 正确率低于60% THEN 系统 SHALL 显示学习建议提示

---

### Requirement 7: 连续打卡系统

**User Story:** 作为一名学习者，我希望通过连续打卡获得奖励，以便激励我坚持学习。

#### Acceptance Criteria

1. WHEN 用户连续打卡达到3天 THEN 系统 SHALL 解锁"初学者"徽章和称号
2. WHEN 用户连续打卡达到7天 THEN 系统 SHALL 解锁"勤奋达人"称号和白银徽章
3. WHEN 用户连续打卡达到14天 THEN 系统 SHALL 解锁"坚持不懈"称号和黄金徽章
4. WHEN 用户连续打卡达到30天 THEN 系统 SHALL 解锁"单词大师"称号和钻石徽章
5. WHEN 用户连续打卡达到60天 THEN 系统 SHALL 解锁"传奇人物"称号和王者徽章
6. IF 用户中断打卡 THEN 系统 SHALL 重置连续天数但保留总天数
7. WHEN 用户解锁新徽章 THEN 系统 SHALL 显示解锁动画和祝贺弹窗

### Requirement 8: 徽章系统

**User Story:** 作为一名学习者，我希望收集各种徽章，以便展示我的学习成就。

#### Acceptance Criteria

1. WHEN 用户查看徽章画廊 THEN 系统 SHALL 显示所有徽章（已解锁和未解锁）
2. IF 徽章未解锁 THEN 系统 SHALL 显示解锁条件说明
3. IF 徽章已解锁 THEN 系统 SHALL 显示解锁时间和稀有度
4. WHEN 徽章解锁时 THEN 系统 SHALL 触发庆祝动画（彩带效果）

### Requirement 9: 段位系统

**User Story:** 作为一名学习者，我希望通过积累经验提升段位，以便获得成长感。

#### Acceptance Criteria

1. WHEN 用户完成学习任务 THEN 系统 SHALL 根据表现给予经验值
2. WHEN 经验值达到阈值 THEN 系统 SHALL 提升用户等级
3. WHEN 用户查看段位进度 THEN 系统 SHALL 显示当前等级、称号、经验值进度
4. IF 用户升级 THEN 系统 SHALL 显示升级动画

---

### Requirement 10: 闯关模式选择

**User Story:** 作为一名学习者，我希望选择不同难度的关卡进行挑战，以便获得更有趣的学习体验。

#### Acceptance Criteria

1. WHEN 用户进入闯关模式 THEN 系统 SHALL 显示所有关卡地图
2. IF 关卡已解锁 THEN 系统 SHALL 允许用户选择该关卡
3. IF 关卡未解锁 THEN 系统 SHALL 显示解锁条件（前置关卡完成）
4. WHEN 用户选择关卡 THEN 系统 SHALL 显示关卡详情（单词数、时间限制、错误限制）

### Requirement 11: 闯关挑战

**User Story:** 作为一名学习者，我希望在闯关中接受挑战，以便检验我的学习成果。

#### Acceptance Criteria

1. WHEN 闯关开始 THEN 系统 SHALL 随机抽取指定数量的单词
2. IF 关卡有时间限制 THEN 系统 SHALL 显示倒计时器
3. WHEN 用户答题 THEN 系统 SHALL 实时更新正确/错误计数
4. IF 错误次数超过限制 THEN 系统 SHALL 结束闯关并显示失败结果
5. IF 用户在时间内完成所有单词 THEN 系统 SHALL 显示成功结果和星级评价
6. WHEN 闯关结束 THEN 系统 SHALL 根据表现给予经验值奖励

### Requirement 12: 关卡解锁

**User Story:** 作为一名学习者，我希望通过完成前置关卡解锁新关卡，以便有持续的挑战目标。

#### Acceptance Criteria

1. WHEN 用户完成关卡 THEN 系统 SHALL 解锁下一关卡
2. IF 关卡有星级评价 THEN 系统 SHALL 根据正确率计算星级（1-3星）
3. WHEN 用户获得3星评价 THEN 系统 SHALL 显示完美通关动画

---

### Requirement 13: 设置管理

**User Story:** 作为一名学习者，我希望自定义学习设置，以便获得个性化的学习体验。

#### Acceptance Criteria

1. WHEN 用户进入设置页面 THEN 系统 SHALL 显示当前设置选项
2. WHEN 用户修改每日新词数量 THEN 系统 SHALL 保存设置并更新学习计划
3. WHEN 用户切换学习模式 THEN 系统 SHALL 保存偏好设置
4. WHEN 用户开启/关闭音效 THEN 系统 SHALL 立即生效
5. IF 用户选择重置数据 THEN 系统 SHALL 要求确认后清除所有学习记录

### Requirement 14: 数据持久化

**User Story:** 作为一名学习者，我希望我的学习数据能够保存，以便下次打开应用时继续学习。

#### Acceptance Criteria

1. WHEN 用户完成学习任务 THEN 系统 SHALL 自动保存数据到 LocalStorage
2. WHEN 用户关闭应用后重新打开 THEN 系统 SHALL 恢复所有学习数据
3. IF LocalStorage 数据损坏 THEN 系统 SHALL 显示提示并允许重置
4. WHEN 用户切换设备 THEN 系统 SHALL 提示数据无法同步（纯前端限制）

---

## Non-Functional Requirements

### Code Architecture and Modularity

- **Single Responsibility Principle**: 每个文件有单一、明确的目的
- **Modular Design**: 组件、工具和服务应隔离且可复用
- **Dependency Management**: 最小化模块间的相互依赖
- **Clear Interfaces**: 定义清晰的组件和层之间的契约

### Performance

- **首屏加载时间**: < 2秒
- **单词切换响应**: < 100ms
- **音频播放延迟**: < 200ms
- **本地存储读写**: < 50ms
- **支持离线使用**: Service Worker 缓存关键资源

### Security

- **数据安全**: LocalStorage 数据不包含敏感信息
- **输入验证**: 所有用户输入进行验证和清理
- **XSS 防护**: Vue 自动转义，额外注意 v-html 使用

### Reliability

- **数据持久化**: 确保学习数据不丢失
- **错误处理**: 优雅的错误提示，不崩溃
- **离线支持**: 关键功能离线可用

### Usability

- **响应式设计**: 支持手机、平板、桌面设备
- **无障碍访问**: 符合 WCAG 2.1 AA 标准
- **键盘导航**: 所有交互支持键盘操作
- **视觉反馈**: 清晰的操作反馈动画
- **引导提示**: 新用户引导流程

### Maintainability

- **TypeScript 类型覆盖**: 100%
- **单元测试覆盖率**: ≥ 80%（目标 100%）
- **代码规范**: ESLint + Prettier 自动格式化
- **文档完善**: 组件和函数有清晰的注释