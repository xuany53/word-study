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
import { reactive, onMounted, ref, watch, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores'
import { authApi } from '@/services/api'

const router = useRouter()
const authStore = useAuthStore()
const showSaved = ref(false)

const settings = reactive({
  source: 'all', // all / 汇总 / RAZ分级
  razLevels: [] as string[], // 多选RAZ级别
  gradeLevels: [] as string[], // 多选年级
  dailyNewWords: 20,
  learningMode: 'choice',
  soundEnabled: true,
  autoPlayAudio: true,
  showPhonetic: true,
  showExamples: true,
  theme: 'auto'
})

// 数据来源统计
const sourceCounts = reactive({
  '汇总': 6465,
  'RAZ分级': 13473
})

// RAZ级别列表
const razLevels = [
  { value: 'aa', label: 'AA', count: 433 },
  { value: 'a', label: 'A', count: 495 },
  { value: 'b', label: 'B', count: 477 },
  { value: 'c', label: 'C', count: 492 },
  { value: 'd', label: 'D', count: 464 },
  { value: 'e', label: 'E', count: 455 },
  { value: 'f', label: 'F', count: 462 },
  { value: 'g', label: 'G', count: 453 },
  { value: 'h', label: 'H', count: 418 },
  { value: 'i', label: 'I', count: 440 },
  { value: 'j', label: 'J', count: 460 },
  { value: 'k', label: 'K', count: 430 },
  { value: 'l', label: 'L', count: 442 },
  { value: 'm', label: 'M', count: 437 },
  { value: 'n', label: 'N', count: 407 },
  { value: 'o', label: 'O', count: 464 },
  { value: 'p', label: 'P', count: 409 },
  { value: 'q', label: 'Q', count: 483 },
  { value: 'r', label: 'R', count: 467 },
  { value: 's', label: 'S', count: 462 },
  { value: 't', label: 'T', count: 471 },
  { value: 'u', label: 'U', count: 459 },
  { value: 'v', label: 'V', count: 446 },
  { value: 'w', label: 'W', count: 431 },
  { value: 'x', label: 'X', count: 601 },
  { value: 'y', label: 'Y', count: 514 },
  { value: 'z', label: 'Z', count: 447 },
  { value: 'z1', label: 'Z1', count: 516 },
  { value: 'z2', label: 'Z2', count: 538 }
]

// 年级列表
const gradeLevels = [
  { value: '小学', label: '小学', icon: '🎒', count: 1946 },
  { value: '初中', label: '初中', icon: '📖', count: 3027 },
  { value: '高中', label: '高中', icon: '🎓', count: 3510 }
]

// 计算选中的RAZ级别单词数
const selectedRazWordCount = computed(() => {
  if (settings.razLevels.length === 0) return 0
  return razLevels
    .filter(l => settings.razLevels.includes(l.value))
    .reduce((sum, l) => sum + l.count, 0)
})

// 计算筛选后的单词数
const filteredWordCount = computed(() => {
  let count = 0

  // 计算来源数量
  if (settings.source === 'all') {
    count = sourceCounts['汇总'] + sourceCounts['RAZ分级']
  } else if (settings.source === '汇总') {
    count = sourceCounts['汇总']
  } else {
    // RAZ分级
    if (settings.razLevels.length > 0) {
      count = selectedRazWordCount.value
    } else {
      count = sourceCounts['RAZ分级']
    }
  }

  // 如果选择了年级，估算比例
  if (settings.gradeLevels.length > 0) {
    const totalGrade = gradeLevels.reduce((sum, g) => sum + g.count, 0)
    const selectedGrade = gradeLevels
      .filter(g => settings.gradeLevels.includes(g.value))
      .reduce((sum, g) => sum + g.count, 0)
    count = Math.round(count * selectedGrade / totalGrade)
  }

  return count
})

// 切换RAZ级别
const toggleLevel = (level: string) => {
  const index = settings.razLevels.indexOf(level)
  if (index > -1) {
    settings.razLevels.splice(index, 1)
  } else {
    settings.razLevels.push(level)
  }
}

// 切换年级
const toggleGrade = (grade: string) => {
  const index = settings.gradeLevels.indexOf(grade)
  if (index > -1) {
    settings.gradeLevels.splice(index, 1)
  } else {
    settings.gradeLevels.push(grade)
  }
}

const updateWordCount = () => {
  // 切换来源时重置级别选择
  if (settings.source === '汇总') {
    settings.razLevels = []
  }
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