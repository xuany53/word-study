# 趣背词 - 单词数据库说明

## 数据概览

**更新时间**: 2026-03-27

### 总体统计

| 数据来源 | 数量 |
|---------|------|
| 汇总词汇 | 6,465 个 |
| RAZ分级词汇 | 13,473 个 |
| **总计** | **19,938 个** |

---

## RAZ分级词汇

### 级别分布

| 级别 | 数量 | 级别 | 数量 | 级别 | 数量 |
|------|------|------|------|------|------|
| AA | 433 | A | 495 | B | 477 |
| C | 492 | D | 464 | E | 455 |
| F | 462 | G | 453 | H | 418 |
| I | 440 | J | 460 | K | 430 |
| L | 442 | M | 437 | N | 407 |
| O | 464 | P | 409 | Q | 483 |
| R | 467 | S | 462 | T | 471 |
| U | 459 | V | 446 | W | 431 |
| X | 601 | Y | 514 | Z | 447 |
| Z1 | 516 | Z2 | 538 | | |

---

## 年级分类

| 年级 | 数量 | 说明 |
|------|------|------|
| 小学 | 1,946 个 | 人教版小学英语大纲词汇 |
| 初中 | 3,027 个 | 人教版初中英语大纲词汇 |
| 高中 | 3,510 个 | 人教版高中英语大纲词汇 |
| 其他 | 4,222 个 | RAZ课外拓展词汇 |

---

## 数据结构

### Word实体

```typescript
@Entity('words')
export class Word {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column({ type: 'varchar' })
  word: string

  @Column({ type: 'varchar' })
  phonetic: string

  @Column({ type: 'varchar', nullable: true })
  pronunciation: string

  @Column({ type: 'json' })
  meanings: Array<{
    partOfSpeech: string
    definition: string
    translation: string
  }>

  @Column({ type: 'json' })
  examples: Array<{
    sentence: string
    translation: string
  }>

  @Column({ type: 'varchar', nullable: true })
  image: string

  @Column({ type: 'varchar', nullable: true })
  category: string

  @Column({ type: 'varchar', nullable: true })
  gradeLevel: string // 小学/初中/高中

  @Column({ type: 'varchar', nullable: true })
  source: string // 汇总/RAZ分级

  @Column({ type: 'varchar', nullable: true })
  razLevel: string // aa, a, b, c... z2

  @Column({ type: 'int', default: 1 })
  difficulty: number

  @CreateDateColumn()
  createdAt: Date
}
```

---

## API接口

### 获取单词列表

```
GET /api/words
```

**参数**:

| 参数 | 类型 | 说明 |
|------|------|------|
| page | number | 页码，默认1 |
| limit | number | 每页数量，默认50 |
| source | string | 数据来源：汇总/RAZ分级 |
| razLevel | string | RAZ级别，支持多选用逗号分隔，如 "a,b,c" |
| gradeLevel | string | 年级：小学/初中/高中 |
| category | string | 分类（兼容旧逻辑） |
| difficulty | number | 难度等级 |

**示例**:

```bash
# 获取RAZ分级 A,B,C级别的单词
GET /api/words?source=RAZ分级&razLevel=a,b,c

# 获取汇总词汇中的初中词汇
GET /api/words?source=汇总&gradeLevel=初中

# 获取RAZ分级A级中的小学词汇
GET /api/words?source=RAZ分级&razLevel=a&gradeLevel=小学
```

### 获取今日学习单词

```
GET /api/learning/today
```

**参数**: 同上

---

## 数据导入脚本

### 汇总词汇导入

```bash
npx tsx src/importRAZWords.ts
```

导入文件: `RAZ所有级别单词词频表.xlsx`

### RAZ分级词汇导入

```bash
npx tsx src/importRAZLevelWords.ts
```

导入文件: `RAZ所有级别单词_详细版.xlsx`

---

## 筛选逻辑说明

### 用户独立性

每个用户的学习记录是独立的：

- A用户学过的单词只会从A用户的新词列表中排除
- B用户有自己的学习记录，不受A用户影响
- 数据库中的单词本身不会被删除

### 筛选组合

支持以下筛选组合：

1. **单一来源**: 汇总 或 RAZ分级
2. **RAZ级别多选**: 可同时选择多个级别
3. **年级筛选**: 小学/初中/高中
4. **组合筛选**: RAZ级别 + 年级

---

## 注意事项

1. RAZ级别参数使用小写: `a`, `b`, `c`... 而非 `raz-a`, `raz-b`
2. 年级参数使用中文: `小学`, `初中`, `高中`
3. 来源参数使用中文: `汇总`, `RAZ分级`