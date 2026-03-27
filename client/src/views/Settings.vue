<template>
  <div class="settings-page">
    <div class="container">
      <!-- 顶部导航 -->
      <div class="page-header">
        <button class="back-btn" @click="$router.push('/')">
          <span>←</span>
          <span>返回</span>
        </button>
        <h1>⚙️ 设置</h1>
      </div>

      <!-- 单词筛选设置 -->
      <div class="settings-section card">
        <h2>📚 单词筛选</h2>
        <p class="section-desc">选择学习单词的来源和难度</p>

        <!-- 数据来源 -->
        <div class="setting-item">
          <label>数据来源</label>
          <select v-model="settings.source" class="input" @change="updateWordCount">
            <option value="all">全部词汇</option>
            <option value="汇总">汇总词汇 ({{ sourceCounts.汇总 }})</option>
            <option value="RAZ分级">RAZ分级词汇 ({{ sourceCounts['RAZ分级'] }})</option>
          </select>
        </div>

        <!-- RAZ级别多选 -->
        <div class="setting-item vertical" v-if="settings.source !== '汇总'">
          <label>RAZ级别（可多选）</label>
          <div class="level-grid">
            <button
              v-for="level in razLevels"
              :key="level.value"
              class="level-btn"
              :class="{ active: settings.razLevels.includes(level.value) }"
              @click="toggleLevel(level.value)"
            >
              {{ level.label }}
            </button>
          </div>
          <div class="selected-count" v-if="settings.razLevels.length > 0">
            已选 {{ settings.razLevels.length }} 个级别，共 {{ selectedRazWordCount }} 个单词
          </div>
        </div>

        <!-- 年级筛选 -->
        <div class="setting-item vertical">
          <label>年级筛选（可多选）</label>
          <div class="grade-grid">
            <button
              v-for="grade in gradeLevels"
              :key="grade.value"
              class="grade-btn"
              :class="{ active: settings.gradeLevels.includes(grade.value) }"
              @click="toggleGrade(grade.value)"
            >
              <span class="grade-icon">{{ grade.icon }}</span>
              <span class="grade-name">{{ grade.label }}</span>
              <span class="grade-count">{{ grade.count }}</span>
            </button>
          </div>
        </div>

        <!-- 当前筛选统计 -->
        <div class="filter-summary">
          <div class="summary-item">
            <span class="summary-label">筛选结果:</span>
            <span class="summary-value">{{ filteredWordCount }} 个单词</span>
          </div>
        </div>
      </div>

      <!-- 学习设置 -->
      <div class="settings-section card">
        <h2>📖 学习设置</h2>
        <div class="setting-item">
          <label>每日新词数量</label>
          <div class="setting-control">
            <input type="range" v-model="settings.dailyNewWords" min="5" max="50" step="5" />
            <span class="value-badge">{{ settings.dailyNewWords }} 词</span>
          </div>
        </div>
        <div class="setting-item">
          <label>学习模式</label>
          <select v-model="settings.learningMode" class="input">
            <option value="choice">选择题</option>
            <option value="spelling">拼写</option>
            <option value="mixed">混合模式</option>
          </select>
        </div>
        <div class="setting-item">
          <label>显示音标</label>
          <input type="checkbox" v-model="settings.showPhonetic" />
        </div>
        <div class="setting-item">
          <label>显示例句</label>
          <input type="checkbox" v-model="settings.showExamples" />
        </div>
      </div>

      <!-- 音效设置 -->
      <div class="settings-section card">
        <h2>🔊 音效设置</h2>
        <div class="setting-item">
          <label>音效开关</label>
          <input type="checkbox" v-model="settings.soundEnabled" />
        </div>
        <div class="setting-item">
          <label>自动播放发音</label>
          <input type="checkbox" v-model="settings.autoPlayAudio" />
        </div>
      </div>

      <!-- 主题设置 -->
      <div class="settings-section card">
        <h2>🎨 主题设置</h2>
        <div class="setting-item">
          <label>主题模式</label>
          <select v-model="settings.theme" class="input">
            <option value="light">浅色模式</option>
            <option value="dark">深色模式</option>
            <option value="auto">跟随系统</option>
          </select>
        </div>
      </div>

      <!-- 账号管理 -->
      <div class="settings-section card">
        <h2>👤 账号管理</h2>
        <div class="setting-item">
          <span>当前账号: {{ authStore.user?.username || '未登录' }}</span>
        </div>
        <div class="setting-item">
          <span>退出登录</span>
          <button class="btn btn-danger" @click="handleLogout">退出</button>
        </div>
      </div>

      <button class="btn btn-primary full-width" @click="saveSettings">
        💾 保存设置
      </button>

      <!-- 保存成功提示 -->
      <Transition name="fade">
        <div v-if="showSaved" class="save-toast">
          ✅ 设置已保存
        </div>
      </Transition>
    </div>
  </div>
</template>

<script setup lang="ts">
import { reactive, onMounted, ref, watch } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores'
import { authApi } from '@/services/api'

const router = useRouter()
const authStore = useAuthStore()
const showSaved = ref(false)

const settings = reactive({
  razLevel: 'all',
  dailyNewWords: 20,
  learningMode: 'choice',
  soundEnabled: true,
  autoPlayAudio: true,
  showPhonetic: true,
  showExamples: true,
  theme: 'auto'
})

// RAZ级别描述
const levelDescriptions: Record<string, string> = {
  'raz-aa': '最基础词汇，适合零基础学习者。包含数字、颜色、动物等基本概念。',
  'raz-a': '基础动词和名词，开始学习简单动作和日常用语。',
  'raz-b': '形容词和常用词汇，学习描述事物特征。',
  'raz-c': '时间、日期词汇，扩展日常生活表达。',
  'raz-d': '自然和季节词汇，描述环境和天气。',
  'raz-e': '感官动词，学习表达感觉和动作。',
  'raz-f': '疑问词和基础语法词汇。',
  'raz-g': '频率副词和不定代词。',
  'raz-h': '时间介词和方位词。',
  'raz-i': '动词时态和状态表达。',
  'raz-j': '情态动词和意愿表达。',
  'raz-k': '情态动词进阶。',
  'raz-l': '比较级和最高级。',
  'raz-m': '形容词和副词扩展。',
  'raz-n': '形容词进阶。',
  'raz-o': '可能性词汇。',
  'raz-p': '安全和健康词汇。',
  'raz-q': '认知动词。',
  'raz-r': '思维和学习词汇。',
  'raz-s': '思考和判断词汇。',
  'raz-t': '成功和进步词汇。',
  'raz-u': '环境和经验词汇。',
  'raz-v': '高级概念词汇。',
  'raz-w': '性格和品质词汇。',
  'raz-x': '高级品质词汇。',
  'raz-y': '高级情感词汇。',
  'raz-z': '最高级词汇，接近母语水平。'
}

const getLevelDisplayName = (level: string): string => {
  if (level === 'all') return '全部'
  return level.replace('raz-', '').toUpperCase() + ' 级'
}

const getLevelClass = (level: string): string => {
  const levelNum = level.replace('raz-', '')
  if (['aa', 'a', 'b', 'c'].includes(levelNum)) return 'level-beginner'
  if (['d', 'e', 'f'].includes(levelNum)) return 'level-elementary'
  if (['g', 'h', 'i', 'j', 'k'].includes(levelNum)) return 'level-intermediate'
  if (['l', 'm', 'n', 'o', 'p'].includes(levelNum)) return 'level-advanced'
  return 'level-expert'
}

const getLevelDescription = (level: string): string => {
  return levelDescriptions[level] || ''
}

const getLevelWordCount = (level: string): number => {
  // 真实数据库统计数据 (2026-03-26 更新)
  const counts: Record<string, number> = {
    'raz-aa': 61, 'raz-a': 65, 'raz-b': 62, 'raz-c': 50,
    'raz-d': 50, 'raz-e': 50, 'raz-f': 40, 'raz-g': 30,
    'raz-h': 5, 'raz-i': 16, 'raz-j': 7, 'raz-k': 5,
    'raz-l': 10, 'raz-m': 12, 'raz-n': 6, 'raz-o': 5,
    'raz-p': 3, 'raz-q': 22, 'raz-r': 4, 'raz-s': 4,
    'raz-t': 4, 'raz-u': 7, 'raz-v': 3, 'raz-w': 3,
    'raz-x': 3, 'raz-y': 2, 'raz-z': 4
  }
  return counts[level] || 0
}

onMounted(async () => {
  if (!authStore.isAuthenticated) {
    router.push('/login')
    return
  }

  // 从localStorage加载设置
  const savedSettings = localStorage.getItem('wordStudySettings')
  if (savedSettings) {
    const parsed = JSON.parse(savedSettings)
    Object.assign(settings, parsed)
  }

  const user = authStore.user
  if (user) {
    settings.dailyNewWords = user.dailyNewWords || settings.dailyNewWords
    settings.learningMode = user.learningMode || settings.learningMode
  }
})

const saveSettings = async () => {
  try {
    // 保存到localStorage
    localStorage.setItem('wordStudySettings', JSON.stringify(settings))

    // 同步到服务器
    await authApi.updateProfile({
      dailyNewWords: settings.dailyNewWords,
      learningMode: settings.learningMode
    })

    showSaved.value = true
    setTimeout(() => {
      showSaved.value = false
    }, 2000)
  } catch (error) {
    console.error('Save settings failed:', error)
    // 即使服务器同步失败，本地设置已保存
    showSaved.value = true
    setTimeout(() => {
      showSaved.value = false
    }, 2000)
  }
}

const handleLogout = () => {
  if (confirm('确定要退出登录吗？')) {
    authStore.logout()
    router.push('/')
  }
}

// 监听主题变化
watch(() => settings.theme, (newTheme) => {
  document.documentElement.setAttribute('data-theme', newTheme)
})
</script>

<style scoped>
.settings-page {
  min-height: 100vh;
  padding: 20px 0;
}

.page-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 24px;
}

.back-btn {
  display: flex;
  align-items: center;
  gap: 4px;
  background: var(--bg-secondary);
  border: none;
  padding: 8px 16px;
  border-radius: var(--border-radius);
  cursor: pointer;
  font-size: 16px;
  color: var(--text-primary);
  transition: all var(--transition-fast);
}

.back-btn:hover {
  background: var(--primary-light);
  color: var(--primary-color);
}

.page-header h1 {
  flex: 1;
  text-align: center;
  margin: 0;
  padding-right: 80px;
  font-size: 24px;
}

.settings-section {
  margin-bottom: 16px;
  padding: 20px;
}

.settings-section h2 {
  font-size: 18px;
  margin-bottom: 8px;
}

.section-desc {
  color: var(--text-secondary);
  font-size: 14px;
  margin-bottom: 16px;
}

.setting-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 0;
  border-bottom: 1px solid var(--bg-secondary);
}

.setting-item:last-child {
  border-bottom: none;
}

.setting-item label {
  color: var(--text-primary);
  font-weight: 500;
}

.setting-control {
  display: flex;
  align-items: center;
  gap: 12px;
}

.value-badge {
  background: var(--primary-color);
  color: white;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: bold;
}

.level-select {
  min-width: 180px;
}

.level-info {
  margin-top: 16px;
  padding: 16px;
  background: var(--bg-secondary);
  border-radius: 12px;
}

.level-badge {
  display: inline-block;
  padding: 8px 16px;
  border-radius: 20px;
  font-weight: bold;
  color: white;
  margin-bottom: 8px;
}

.level-beginner { background: linear-gradient(135deg, #4CAF50, #2E7D32); }
.level-elementary { background: linear-gradient(135deg, #2196F3, #1565C0); }
.level-intermediate { background: linear-gradient(135deg, #FF9800, #E65100); }
.level-advanced { background: linear-gradient(135deg, #9C27B0, #6A1B9A); }
.level-expert { background: linear-gradient(135deg, #FFD700, #FF9800); }

.level-desc {
  color: var(--text-primary);
  font-size: 14px;
  margin-bottom: 8px;
}

.word-count {
  color: var(--text-secondary);
  font-size: 13px;
}

.full-width {
  margin-top: 24px;
  padding: 16px;
  font-size: 16px;
}

.save-toast {
  position: fixed;
  bottom: 100px;
  left: 50%;
  transform: translateX(-50%);
  background: #4CAF50;
  color: white;
  padding: 12px 24px;
  border-radius: 24px;
  font-weight: bold;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  z-index: 1000;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* Range slider styling */
input[type="range"] {
  width: 120px;
  accent-color: var(--primary-color);
}

/* Checkbox styling */
input[type="checkbox"] {
  width: 20px;
  height: 20px;
  accent-color: var(--primary-color);
}
</style>