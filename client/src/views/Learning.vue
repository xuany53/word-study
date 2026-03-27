<template>
  <div class="learning-page">
    <div class="container">
      <!-- 顶部导航 -->
      <div class="nav-header">
        <button class="back-btn" @click="$router.push('/')">
          <span>←</span>
          <span>返回</span>
        </button>
        <!-- 主题指示器 -->
        <div v-if="currentTheme" class="theme-indicator" :style="{ borderColor: currentTheme.color }">
          <span class="theme-icon">{{ currentTheme.icon }}</span>
          <span class="theme-name">{{ currentTheme.name }}</span>
        </div>
      </div>

      <!-- 进度条 -->
      <div class="progress-bar">
        <div class="progress" :style="{ width: progress + '%' }"></div>
      </div>
      <div class="progress-text">{{ currentIndex + 1 }} / {{ totalWords }}</div>

      <!-- 单词卡片 -->
      <div v-if="currentWord" class="word-card card">
        <div class="word-header">
          <span class="word-text">{{ currentWord.word }}</span>
          <button
            class="audio-btn"
            :class="{ playing: isPlayingAudio }"
            @click="playAudio"
            :disabled="isPlayingAudio"
            title="播放发音"
          >
            {{ isPlayingAudio ? '🔈' : '🔊' }}
          </button>
        </div>
        <div class="phonetic">{{ currentWord.phonetic }}</div>

        <!-- 选择题模式 -->
        <div v-if="mode === 'choice'" class="options">
          <button
            v-for="(option, index) in options"
            :key="index"
            class="option-btn"
            :class="{
              correct: answered && option === currentWord.word,
              wrong: answered && selectedOption === option && option !== currentWord.word
            }"
            :disabled="answered"
            @click="selectOption(option)"
          >
            {{ option }}
          </button>
        </div>

        <!-- 拼写模式 -->
        <div v-else class="spelling-section">
          <div class="spelling-hint" v-if="showHint">
            提示: {{ currentWord.word.charAt(0) }}{{ '_'.repeat(currentWord.word.length - 1) }}
          </div>
          <div class="spelling-input">
            <input
              v-model="userAnswer"
              type="text"
              class="input"
              placeholder="输入单词拼写"
              :disabled="answered"
              @keyup.enter="checkAnswer"
              autofocus
            />
            <button class="btn btn-secondary hint-btn" :disabled="showHint" @click="showHint = true">
              提示
            </button>
            <button class="btn btn-primary" :disabled="answered || !userAnswer" @click="checkAnswer">
              确认
            </button>
          </div>
        </div>

        <!-- 答案展示 -->
        <div v-if="answered" class="answer-section">
          <div class="meaning">
            <strong>释义：</strong>
            <div v-for="(m, i) in currentWord.meanings" :key="i" class="meaning-item">
              <span class="pos">{{ m.partOfSpeech }}</span>
              <span class="definition">{{ m.translation }}</span>
            </div>
          </div>
          <div class="example" v-if="currentWord.examples?.length">
            <strong>例句：</strong>
            <div class="example-content">
              <p class="example-sentence">{{ currentWord.examples[0].sentence }}</p>
              <button
                class="example-audio-btn"
                :class="{ playing: isPlayingExample }"
                @click="playExampleAudio"
                :disabled="isPlayingExample"
                title="朗读例句"
              >
                {{ isPlayingExample ? '🔈' : '🔊' }}
              </button>
            </div>
            <p class="translation">{{ currentWord.examples[0].translation }}</p>
          </div>
        </div>
      </div>

      <!-- 加载状态 -->
      <div v-else class="loading-state">
        <div class="spinner"></div>
        <p>加载中...</p>
      </div>

      <!-- 操作按钮 -->
      <div class="actions">
        <button v-if="answered" class="btn btn-primary btn-lg" @click="nextWord">
          {{ isLastWord ? '完成学习' : '下一个' }}
        </button>
      </div>

      <!-- 模式切换 -->
      <div class="mode-switch" v-if="!answered">
        <button
          class="mode-btn"
          :class="{ active: mode === 'choice' }"
          @click="switchMode('choice')"
        >
          选择题
        </button>
        <button
          class="mode-btn"
          :class="{ active: mode === 'spelling' }"
          @click="switchMode('spelling')"
        >
          拼写
        </button>
      </div>
    </div>

    <!-- 反馈动画 -->
    <FeedbackAnimation
      :visible="showFeedback"
      :type="feedbackType"
      :xp-gain="lastXpGain"
      :correct-answer="lastCorrectAnswer"
      @close="showFeedback = false"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch, nextTick } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useLearningStore, useWordStore, useAuthStore, useStatsStore } from '@/stores'
import { wordService } from '@/services/wordService'
import audioService from '@/services/audioService'
import FeedbackAnimation from '@/components/learning/FeedbackAnimation.vue'
import type { Word } from '@/types/word'
import type { WordTheme } from '@/data/wordThemes'

const router = useRouter()
const route = useRoute()
const learningStore = useLearningStore()
const wordStore = useWordStore()
const authStore = useAuthStore()
const statsStore = useStatsStore()

const mode = ref<'choice' | 'spelling'>('choice')
const options = ref<string[]>([])
const selectedOption = ref<string | null>(null)
const userAnswer = ref('')
const answered = ref(false)
const showHint = ref(false)
const allWords = ref<Word[]>([])
const isInitialized = ref(false)
const currentTheme = ref<WordTheme | null>(null)

// Feedback state
const showFeedback = ref(false)
const feedbackType = ref<'correct' | 'incorrect'>('correct')
const lastXpGain = ref(0)
const lastCorrectAnswer = ref('')

// Audio state
const isPlayingAudio = ref(false)
const isPlayingExample = ref(false)

const currentWord = computed(() => learningStore.currentWord)
const progress = computed(() => learningStore.progress)
const isLastWord = computed(() => learningStore.isSessionComplete)
const currentIndex = computed(() => learningStore.currentSession?.currentIndex ?? 0)
const totalWords = computed(() => learningStore.currentSession?.words.length ?? 0)

onMounted(async () => {
  if (!authStore.isAuthenticated) {
    router.push('/login')
    return
  }

  try {
    // 检查是否有主题参数
    const themeParam = route.query.theme as string | undefined

    // 从设置中获取筛选参数
    const savedSettings = localStorage.getItem('wordStudySettings')
    const settings = savedSettings ? JSON.parse(savedSettings) : {}

    // 构建筛选参数
    const filterParams: any = {}

    // 数据来源
    if (settings.source && settings.source !== 'all') {
      filterParams.source = settings.source
    }

    // RAZ级别（多选）
    if (settings.razLevels && settings.razLevels.length > 0) {
      filterParams.razLevel = settings.razLevels.join(',')
    }

    // 年级（多选，暂时只支持单选）
    if (settings.gradeLevels && settings.gradeLevels.length > 0) {
      filterParams.gradeLevel = settings.gradeLevels[0]
    }

    // Fetch words first (needed for option generation)
    await wordStore.fetchWords(1, undefined, filterParams)
    allWords.value = wordStore.words

    // 如果有主题参数，筛选主题单词
    if (themeParam) {
      const { getThemeById } = await import('@/data/wordThemes')
      const theme = getThemeById(themeParam)
      if (theme) {
        currentTheme.value = theme
        // 筛选出属于该主题的单词
        const themeWordSet = new Set(theme.words.map(w => w.toLowerCase()))
        allWords.value = allWords.value.filter((w: any) =>
          themeWordSet.has(w.word?.toLowerCase())
        )

        // 主题模式：直接使用筛选后的主题单词，不依赖今日学习单词
        if (allWords.value.length > 0) {
          learningStore.startSession(allWords.value.slice(0, 10), 'choice')
          isInitialized.value = true
          await nextTick()
          generateOptions()
          return // 提前返回，跳过下面的今日学习逻辑
        }
      }
    }

    // 非主题模式：使用今日学习单词
    await learningStore.fetchTodayWords(filterParams)

    let words = [
      ...learningStore.todayWords.newWordList,
      ...learningStore.todayWords.reviewRecords.map((r: any) => r.word).filter(Boolean)
    ]

    if (words.length > 0) {
      learningStore.startSession(words.slice(0, 10), 'choice')
      isInitialized.value = true
      await nextTick()
      generateOptions()
    }
  } catch (error) {
    console.error('Failed to initialize learning page:', error)
  }
})

watch(currentWord, async () => {
  if (currentWord.value && isInitialized.value) {
    generateOptions()
    resetState()
    // 自动播放新单词的读音
    await nextTick()
    playAudio()
  }
})

const generateOptions = () => {
  if (!currentWord.value) return

  // If allWords is empty, use the session words as fallback
  const wordPool = allWords.value.length > 0
    ? allWords.value
    : learningStore.currentSession?.words || []

  if (wordPool.length === 0) return

  options.value = wordService.generateOptions(currentWord.value, wordPool, 4)
}

const resetState = () => {
  selectedOption.value = null
  userAnswer.value = ''
  answered.value = false
  showHint.value = false
}

const selectOption = async (option: string) => {
  if (!currentWord.value || answered.value) return

  selectedOption.value = option
  answered.value = true

  const isCorrect = option === currentWord.value.word
  await submitAndShowFeedback(isCorrect)
}

const checkAnswer = async () => {
  if (!currentWord.value || answered.value || !userAnswer.value) return

  answered.value = true
  const isCorrect = userAnswer.value.toLowerCase().trim() === currentWord.value.word.toLowerCase()
  await submitAndShowFeedback(isCorrect)
}

const submitAndShowFeedback = async (isCorrect: boolean) => {
  if (!currentWord.value) return

  // 播放提示音
  if (isCorrect) {
    audioService.playCorrectSound()
  } else {
    audioService.playWrongSound()
  }

  try {
    const response = await learningStore.submitAnswer(currentWord.value.id, isCorrect)

    // Show feedback animation
    feedbackType.value = isCorrect ? 'correct' : 'incorrect'
    lastXpGain.value = response?.data?.xpGain || (isCorrect ? 2 : 0)
    lastCorrectAnswer.value = isCorrect ? '' : currentWord.value.word
    showFeedback.value = true

    // Auto-hide feedback after 1.5 seconds
    setTimeout(() => {
      showFeedback.value = false
    }, 1500)
  } catch (error) {
    console.error('Submit answer error:', error)
  }
}

const playAudio = async () => {
  if (!currentWord.value || isPlayingAudio.value) return

  isPlayingAudio.value = true

  try {
    await audioService.playWordAudio(
      currentWord.value.word,
      currentWord.value.pronunciation
    )
  } catch (error) {
    console.error('Audio playback failed:', error)
  } finally {
    // 延迟重置，给用户视觉反馈
    setTimeout(() => {
      isPlayingAudio.value = false
    }, 500)
  }
}

const playExampleAudio = async () => {
  if (!currentWord.value?.examples?.[0] || isPlayingExample.value) return

  const sentence = currentWord.value.examples[0].sentence
  if (!sentence) return

  isPlayingExample.value = true

  try {
    // 使用 Web Speech API 朗读例句
    if (!('speechSynthesis' in window)) {
      console.warn('Web Speech API not supported')
      isPlayingExample.value = false
      return
    }

    // 取消之前的播放
    speechSynthesis.cancel()

    const utterance = new SpeechSynthesisUtterance(sentence)
    utterance.lang = 'en-US'
    utterance.rate = 0.85
    utterance.pitch = 1
    utterance.volume = 1

    // 获取语音列表 - 某些浏览器需要等待
    const getVoices = (): Promise<SpeechSynthesisVoice[]> => {
      return new Promise((resolve) => {
        const voices = speechSynthesis.getVoices()
        if (voices.length > 0) {
          resolve(voices)
          return
        }

        // 如果语音列表为空，等待加载
        const handler = () => {
          speechSynthesis.removeEventListener('voiceschanged', handler)
          resolve(speechSynthesis.getVoices())
        }
        speechSynthesis.addEventListener('voiceschanged', handler)

        // 超时处理
        setTimeout(() => {
          speechSynthesis.removeEventListener('voiceschanged', handler)
          resolve(speechSynthesis.getVoices())
        }, 1000)
      })
    }

    const voices = await getVoices()
    const englishVoice = voices.find(v =>
      v.lang.startsWith('en') && (v.name.includes('Female') || v.name.includes('Samantha'))
    ) || voices.find(v => v.lang.startsWith('en'))

    if (englishVoice) {
      utterance.voice = englishVoice
    }

    utterance.onend = () => {
      isPlayingExample.value = false
    }
    utterance.onerror = (e) => {
      console.error('Speech synthesis error:', e)
      isPlayingExample.value = false
    }

    // 某些浏览器需要延迟
    setTimeout(() => {
      speechSynthesis.speak(utterance)
    }, 100)
  } catch (error) {
    console.error('Example audio playback failed:', error)
    isPlayingExample.value = false
  }
}

const switchMode = (newMode: 'choice' | 'spelling') => {
  mode.value = newMode
  resetState()
}

const nextWord = async () => {
  if (isLastWord.value) {
    // 完成学习，自动打卡
    try {
      await statsStore.checkIn()
    } catch (error) {
      console.error('自动打卡失败:', error)
    }

    learningStore.endSession()
    router.push('/stats')
    return
  }

  learningStore.nextWord()
}
</script>

<style scoped>
.learning-page {
  min-height: 100vh;
  padding: 20px 0;
}

.nav-header {
  display: flex;
  align-items: center;
  margin-bottom: 16px;
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

.theme-indicator {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-left: auto;
  padding: 8px 16px;
  background: var(--bg-secondary);
  border-radius: 20px;
  border: 2px solid;
  font-size: 14px;
}

.theme-indicator .theme-icon {
  font-size: 18px;
}

.theme-indicator .theme-name {
  font-weight: 600;
  color: var(--text-primary);
}

.progress-bar {
  height: 8px;
  background: var(--bg-dark);
  border-radius: 4px;
  margin-bottom: 8px;
  overflow: hidden;
}

.progress {
  height: 100%;
  background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
  transition: width var(--transition-normal);
}

.progress-text {
  text-align: center;
  color: var(--text-secondary);
  font-size: 14px;
  margin-bottom: 24px;
}

.word-card {
  padding: 32px;
  text-align: center;
  margin-bottom: 24px;
}

.word-header {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  margin-bottom: 8px;
}

.word-text {
  font-size: 40px;
  font-weight: bold;
  color: var(--text-primary);
}

.audio-btn {
  background: var(--bg-secondary);
  border: none;
  font-size: 24px;
  cursor: pointer;
  padding: 12px;
  border-radius: 50%;
  transition: all var(--transition-fast);
}

.audio-btn:hover:not(:disabled) {
  background: var(--primary-light);
  transform: scale(1.1);
}

.audio-btn:disabled {
  cursor: not-allowed;
}

.audio-btn.playing {
  background: var(--primary-color);
  animation: pulse-audio 0.5s ease infinite;
}

@keyframes pulse-audio {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.15);
  }
}

.phonetic {
  color: var(--text-secondary);
  font-size: 18px;
  margin-bottom: 32px;
}

.options {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
  margin-bottom: 24px;
}

.option-btn {
  padding: 20px;
  font-size: 18px;
  border: 2px solid var(--bg-dark);
  border-radius: var(--border-radius);
  background: var(--bg-primary);
  cursor: pointer;
  transition: all var(--transition-fast);
  font-weight: 500;
}

.option-btn:hover:not(:disabled) {
  border-color: var(--primary-color);
  background: var(--primary-light);
}

.option-btn.correct {
  background: var(--success-color);
  border-color: var(--success-color);
  color: white;
  animation: correctPulse 0.5s ease-out;
}

.option-btn.wrong {
  background: var(--danger-color);
  border-color: var(--danger-color);
  color: white;
  animation: wrongShake 0.5s ease-out;
}

.option-btn:disabled {
  cursor: not-allowed;
  opacity: 0.8;
}

.spelling-section {
  margin-bottom: 24px;
}

.spelling-hint {
  color: var(--text-secondary);
  font-size: 18px;
  letter-spacing: 4px;
  margin-bottom: 16px;
}

.spelling-input {
  display: flex;
  gap: 12px;
  justify-content: center;
  flex-wrap: wrap;
}

.spelling-input .input {
  flex: 1;
  max-width: 300px;
  font-size: 18px;
  padding: 16px;
}

.hint-btn {
  padding: 16px 24px;
}

.answer-section {
  text-align: left;
  padding: 20px;
  background: var(--bg-secondary);
  border-radius: var(--border-radius);
  animation: slideUp 0.3s ease-out;
}

.meaning-item {
  margin-bottom: 8px;
}

.meaning-item .pos {
  display: inline-block;
  background: var(--primary-color);
  color: white;
  padding: 2px 8px;
  border-radius: 4px;
  font-size: 12px;
  margin-right: 8px;
}

.meaning-item .definition {
  color: var(--text-primary);
}

.example {
  margin-top: 16px;
  padding-top: 16px;
  border-top: 1px solid var(--bg-dark);
}

.example-content {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 8px;
}

.example-sentence {
  color: var(--text-primary);
  font-style: italic;
  flex: 1;
}

.example-audio-btn {
  background: var(--bg-secondary);
  border: none;
  font-size: 20px;
  cursor: pointer;
  padding: 10px;
  border-radius: 50%;
  transition: all var(--transition-fast);
  flex-shrink: 0;
}

.example-audio-btn:hover:not(:disabled) {
  background: var(--primary-light);
  transform: scale(1.1);
}

.example-audio-btn:disabled {
  cursor: not-allowed;
}

.example-audio-btn.playing {
  background: var(--primary-color);
  animation: pulse-audio 0.5s ease infinite;
}

.example .translation {
  color: var(--text-secondary);
  font-size: 14px;
}

.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px;
  color: var(--text-secondary);
}

.actions {
  display: flex;
  justify-content: center;
  margin-top: 24px;
}

.btn-lg {
  padding: 16px 48px;
  font-size: 18px;
}

.mode-switch {
  display: flex;
  justify-content: center;
  gap: 12px;
  margin-top: 24px;
}

.mode-btn {
  padding: 12px 24px;
  border: 2px solid var(--bg-dark);
  background: var(--bg-primary);
  border-radius: var(--border-radius);
  cursor: pointer;
  transition: all var(--transition-fast);
  font-weight: 500;
}

.mode-btn.active {
  background: var(--primary-color);
  border-color: var(--primary-color);
  color: white;
}

.mode-btn:hover:not(.active) {
  border-color: var(--primary-color);
}

@keyframes correctPulse {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
  100% {
    transform: scale(1);
  }
}

@keyframes wrongShake {
  0%, 100% {
    transform: translateX(0);
  }
  25% {
    transform: translateX(-5px);
  }
  75% {
    transform: translateX(5px);
  }
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>