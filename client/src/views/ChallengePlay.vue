<template>
  <div class="challenge-play-page">
    <div class="container">
      <!-- 顶部信息栏 -->
      <div class="game-header">
        <button class="back-btn" @click="confirmExit">
          ← 退出
        </button>
        <div class="level-info">
          <span class="level-name">{{ level?.name }}</span>
          <div class="progress-dots">
            <span
              v-for="i in totalWords"
              :key="i"
              class="dot"
              :class="{
                correct: i <= currentIndex && answers[i-1],
                wrong: i <= currentIndex && !answers[i-1],
                current: i === currentIndex + 1
              }"
            ></span>
          </div>
        </div>
        <div class="stats">
          <div class="timer" :class="{ warning: timeLeft <= 10 }">
            ⏱️ {{ formatTime(timeLeft) }}
          </div>
          <div class="errors" :class="{ danger: wrongCount >= maxErrors - 1 }">
            ❌ {{ wrongCount }}/{{ maxErrors }}
          </div>
        </div>
      </div>

      <!-- 单词卡片 -->
      <div v-if="currentWord && !showResult" class="word-card-wrapper">
        <div class="word-card">
          <!-- 题型指示器 -->
          <div class="question-type-badge">
            {{ questionType === 'word-to-meaning' ? '📝 英文→中文' : '🔤 中文→英文' }}
          </div>

          <!-- 英文→中文 题型：显示英文单词 -->
          <template v-if="questionType === 'word-to-meaning'">
            <div class="word">{{ currentWord.word }}</div>
            <div class="phonetic">{{ currentWord.phonetic }}</div>
          </template>

          <!-- 中文→英文 题型：显示中文释义 -->
          <template v-else>
            <div class="word meaning-display">
              {{ currentWord.meaning || (currentWord as any).meanings?.[0]?.translation || '' }}
            </div>
            <div class="phonetic hint-text">请选择正确的英文单词</div>
          </template>

          <!-- 选项 -->
          <div class="options">
            <button
              v-for="option in options"
              :key="option"
              class="option-btn"
              :class="{ selected: selectedOption === option }"
              :disabled="selectedOption !== null"
              @click="selectOption(option)"
            >
              {{ option }}
            </button>
          </div>
        </div>
      </div>

      <!-- 反馈动画 -->
      <div v-if="showFeedback" class="feedback-overlay" :class="feedbackType">
        <div class="feedback-content">
          <span class="feedback-icon">{{ feedbackType === 'correct' ? '✓' : '✗' }}</span>
          <span class="feedback-text">{{ feedbackType === 'correct' ? '正确!' : '错误!' }}</span>
          <p v-if="feedbackType === 'wrong'" class="correct-answer">
            正确答案: {{ currentWord?.meaning }}
          </p>
        </div>
      </div>

      <!-- 结果页面 -->
      <div v-if="showResult" class="result-screen">
        <div class="result-card">
          <div class="result-icon" :class="isPassed ? 'pass' : 'fail'">
            {{ isPassed ? '🎉' : '😢' }}
          </div>

          <h2>{{ isPassed ? '闯关成功!' : '闯关失败' }}</h2>

          <div class="stars">
            <span v-for="i in 3" :key="i" :class="{ filled: i <= starRating }">⭐</span>
          </div>

          <div class="result-stats">
            <div class="stat-item">
              <span class="label">正确</span>
              <span class="value correct">{{ correctCount }}</span>
            </div>
            <div class="stat-item">
              <span class="label">错误</span>
              <span class="value wrong">{{ wrongCount }}</span>
            </div>
            <div class="stat-item">
              <span class="label">用时</span>
              <span class="value">{{ formatTime(timeTaken) }}</span>
            </div>
            <div class="stat-item">
              <span class="label">正确率</span>
              <span class="value">{{ Math.round(accuracy * 100) }}%</span>
            </div>
          </div>

          <div v-if="isPassed && xpEarned > 0" class="xp-reward">
            <span class="xp-icon">✨</span>
            <span class="xp-text">+{{ xpEarned }} XP</span>
          </div>

          <div class="result-actions">
            <button class="retry-btn" @click="retry">
              🔄 再试一次
            </button>
            <button class="home-btn" @click="goHome">
              🏠 返回列表
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useChallengeStore, useWordStore, useAuthStore } from '@/stores'
import type { Word } from '@/types/word'

const route = useRoute()
const router = useRouter()
const challengeStore = useChallengeStore()
const wordStore = useWordStore()
const authStore = useAuthStore()

// Game state
const sessionId = ref<string>('')
const level = ref<any>(null)
const words = ref<Word[]>([])
const currentIndex = ref(0)
const correctCount = ref(0)
const wrongCount = ref(0)
const totalWords = ref(0)
const timeLimit = ref<number | null>(null)
const maxErrors = ref(3)
const xpReward = ref(0)

// Timer
const timeLeft = ref(0)
const timeTaken = ref(0)
let timer: ReturnType<typeof setInterval> | null = null

// UI state
const options = ref<string[]>([])
const selectedOption = ref<string | null>(null)
const showFeedback = ref(false)
const feedbackType = ref<'correct' | 'wrong'>('correct')
const showResult = ref(false)
const isPassed = ref(false)
const starRating = ref(0)
const xpEarned = ref(0)
const answers = ref<boolean[]>([])

// Question type: 'word-to-meaning' or 'meaning-to-word'
const questionType = ref<'word-to-meaning' | 'meaning-to-word'>('word-to-meaning')

// Computed
const currentWord = computed(() => words.value[currentIndex.value])
const accuracy = computed(() => {
  const total = correctCount.value + wrongCount.value
  return total > 0 ? correctCount.value / total : 0
})

onMounted(async () => {
  if (!authStore.isAuthenticated) {
    router.push('/login')
    return
  }

  const levelId = route.params.id as string

  // 从设置中获取 RAZ 级别
  const savedSettings = localStorage.getItem('wordStudySettings')
  const settings = savedSettings ? JSON.parse(savedSettings) : {}
  const razLevel = settings.razLevel || 'all'

  try {
    // Load all words for option generation with RAZ level filter
    await wordStore.fetchWords(1, razLevel === 'all' ? undefined : razLevel)

    // Start challenge with RAZ level filter
    const response = await challengeStore.startChallenge(levelId, razLevel)

    if (response?.success && response.data) {
      const data = response.data as any
      sessionId.value = data.sessionId
      words.value = data.words
      totalWords.value = data.totalWords
      timeLimit.value = data.timeLimit
      maxErrors.value = data.maxErrors
      xpReward.value = data.xpReward

      // Set timer
      if (timeLimit.value) {
        timeLeft.value = timeLimit.value
        startTimer()
      } else {
        timeLeft.value = 0
        startCountUpTimer()
      }

      // Generate options for first word
      generateOptions()

      // Get level info
      level.value = challengeStore.levels.find(l => l.id === levelId)
    }
  } catch (error) {
    console.error('Failed to start challenge:', error)
    router.push('/challenge')
  }
})

onUnmounted(() => {
  stopTimer()
})

function startTimer() {
  timer = setInterval(() => {
    timeLeft.value--
    timeTaken.value++

    if (timeLeft.value <= 0) {
      stopTimer()
      finishChallenge()
    }
  }, 1000)
}

function startCountUpTimer() {
  timer = setInterval(() => {
    timeTaken.value++
  }, 1000)
}

function stopTimer() {
  if (timer) {
    clearInterval(timer)
    timer = null
  }
}

function generateOptions() {
  if (!currentWord.value) return

  // 40% 概率是中文→英文题型
  questionType.value = Math.random() < 0.4 ? 'meaning-to-word' : 'word-to-meaning'

  const allWords = wordStore.words

  if (questionType.value === 'meaning-to-word') {
    // 中文→英文 题型：选项是英文单词
    const correctWord = currentWord.value.word

    // 获取其他单词作为错误选项
    const otherWords = allWords
      .filter(w => w.id !== currentWord.value?.id)
      .map(w => w.word)
      .filter(w => w && w !== correctWord)

    // 随机选3个错误选项
    const shuffled = otherWords.sort(() => Math.random() - 0.5)
    const wrongOptions = shuffled.slice(0, 3)

    // 如果不够3个，添加占位符
    while (wrongOptions.length < 3) {
      wrongOptions.push(`word${wrongOptions.length + 1}`)
    }

    // 合并并打乱
    const allOptions = [correctWord, ...wrongOptions]
    options.value = allOptions.sort(() => Math.random() - 0.5)
  } else {
    // 英文→中文 题型：选项是中文释义（原有逻辑）
    const correctMeaning = currentWord.value.meaning ||
      (currentWord.value as any).meanings?.[0]?.translation || ''

    // Get other meanings for wrong options
    const otherMeanings = allWords
      .filter(w => w.id !== currentWord.value?.id)
      .map(w => (w as any).meaning || (w as any).meanings?.[0]?.translation || '')
      .filter(m => m && m !== correctMeaning)

    // Shuffle and take 3 wrong options
    const shuffled = otherMeanings.sort(() => Math.random() - 0.5)
    const wrongOptions = shuffled.slice(0, 3)

    // If not enough wrong options, add some placeholders
    while (wrongOptions.length < 3) {
      wrongOptions.push(`选项${wrongOptions.length + 1}`)
    }

    // Combine and shuffle
    const allOptions = [correctMeaning, ...wrongOptions]
    options.value = allOptions.sort(() => Math.random() - 0.5)
  }
}

async function selectOption(option: string) {
  if (selectedOption.value !== null) return

  selectedOption.value = option

  let isCorrect: boolean
  let correctAnswer: string

  if (questionType.value === 'meaning-to-word') {
    // 中文→英文 题型：正确答案是英文单词
    correctAnswer = currentWord.value?.word || ''
    isCorrect = option === correctAnswer
  } else {
    // 英文→中文 题型：正确答案是中文释义
    correctAnswer = currentWord.value?.meaning ||
      (currentWord.value as any)?.meanings?.[0]?.translation || ''
    isCorrect = option === correctAnswer
  }

  // Show feedback
  feedbackType.value = isCorrect ? 'correct' : 'wrong'
  showFeedback.value = true

  // Update stats
  if (isCorrect) {
    correctCount.value++
  } else {
    wrongCount.value++
  }
  answers.value.push(isCorrect)

  // Submit answer
  try {
    await challengeStore.submitAnswer(currentWord.value?.id || '', isCorrect)
  } catch (error) {
    console.error('Failed to submit answer:', error)
  }

  // Wait and move to next word
  setTimeout(() => {
    showFeedback.value = false
    selectedOption.value = null

    // Check if should end
    if (wrongCount.value > maxErrors.value) {
      finishChallenge()
      return
    }

    currentIndex.value++

    if (currentIndex.value >= totalWords.value) {
      finishChallenge()
    } else {
      generateOptions()
    }
  }, 1000)
}

async function finishChallenge() {
  stopTimer()
  showResult.value = true

  try {
    const response = await challengeStore.finishChallenge()

    if (response?.success && response.data) {
      const data = response.data as any
      isPassed.value = data.isPassed
      starRating.value = data.starRating
      xpEarned.value = data.xpEarned
    }
  } catch (error) {
    console.error('Failed to finish challenge:', error)
  }
}

function formatTime(seconds: number): string {
  const mins = Math.floor(seconds / 60)
  const secs = seconds % 60
  return `${mins}:${secs.toString().padStart(2, '0')}`
}

function confirmExit() {
  if (confirm('确定要退出闯关吗？当前进度将不会保存。')) {
    stopTimer()
    router.push('/challenge')
  }
}

function retry() {
  // Reset state and restart
  showResult.value = false
  currentIndex.value = 0
  correctCount.value = 0
  wrongCount.value = 0
  answers.value = []
  timeTaken.value = 0
  xpEarned.value = 0

  // Restart challenge
  const levelId = route.params.id as string
  router.go(0) // Reload page to restart
}

function goHome() {
  router.push('/challenge')
}
</script>

<style scoped>
.challenge-play-page {
  min-height: 100vh;
  padding: 16px 0;
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
}

.game-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  margin-bottom: 24px;
}

.back-btn {
  background: none;
  border: none;
  color: #fff;
  font-size: 16px;
  cursor: pointer;
  padding: 8px 12px;
  border-radius: 8px;
  transition: background 0.2s;
}

.back-btn:hover {
  background: rgba(255, 255, 255, 0.1);
}

.level-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.level-name {
  font-weight: bold;
  color: #fff;
}

.progress-dots {
  display: flex;
  gap: 4px;
}

.dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.3);
  transition: all 0.3s;
}

.dot.current {
  background: #ffd700;
  transform: scale(1.3);
}

.dot.correct {
  background: #4caf50;
}

.dot.wrong {
  background: #f44336;
}

.stats {
  display: flex;
  gap: 16px;
}

.timer, .errors {
  font-size: 16px;
  font-weight: bold;
  color: #fff;
}

.timer.warning {
  color: #ff9800;
  animation: pulse 1s infinite;
}

.errors.danger {
  color: #f44336;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.word-card-wrapper {
  display: flex;
  justify-content: center;
  padding: 40px 0;
}

.word-card {
  background: #fff;
  border-radius: 20px;
  padding: 40px;
  text-align: center;
  max-width: 400px;
  width: 100%;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
}

.word {
  font-size: 36px;
  font-weight: bold;
  margin-bottom: 8px;
  color: #1a1a2e;
}

.phonetic {
  font-size: 18px;
  color: #666;
  margin-bottom: 32px;
}

.options {
  display: grid;
  gap: 12px;
}

.option-btn {
  padding: 16px 24px;
  font-size: 16px;
  background: #f5f5f5;
  border: 2px solid transparent;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.2s;
  text-align: left;
}

.option-btn:hover:not(:disabled) {
  background: #e3f2fd;
  border-color: #2196f3;
}

.option-btn.selected {
  background: #e3f2fd;
  border-color: #2196f3;
}

.option-btn:disabled {
  cursor: not-allowed;
}

/* Feedback Overlay */
.feedback-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
  animation: fadeIn 0.3s ease;
}

.feedback-overlay.correct {
  background: rgba(76, 175, 80, 0.9);
}

.feedback-overlay.wrong {
  background: rgba(244, 67, 54, 0.9);
}

.feedback-content {
  text-align: center;
  color: #fff;
}

.feedback-icon {
  font-size: 80px;
  display: block;
  margin-bottom: 16px;
}

.feedback-text {
  font-size: 32px;
  font-weight: bold;
}

.correct-answer {
  margin-top: 16px;
  font-size: 18px;
  opacity: 0.9;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

/* Result Screen */
.result-screen {
  display: flex;
  justify-content: center;
  padding: 40px 0;
}

.result-card {
  background: #fff;
  border-radius: 24px;
  padding: 40px;
  text-align: center;
  max-width: 400px;
  width: 100%;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
}

.result-icon {
  font-size: 64px;
  margin-bottom: 16px;
}

.result-card h2 {
  font-size: 28px;
  margin-bottom: 16px;
}

.stars {
  font-size: 32px;
  margin-bottom: 24px;
}

.stars span {
  opacity: 0.3;
  margin: 0 4px;
  transition: all 0.3s;
}

.stars span.filled {
  opacity: 1;
  transform: scale(1.2);
}

.result-stats {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
  margin-bottom: 24px;
}

.stat-item {
  padding: 12px;
  background: #f5f5f5;
  border-radius: 12px;
}

.stat-item .label {
  display: block;
  font-size: 12px;
  color: #666;
  margin-bottom: 4px;
}

.stat-item .value {
  font-size: 24px;
  font-weight: bold;
}

.stat-item .value.correct {
  color: #4caf50;
}

.stat-item .value.wrong {
  color: #f44336;
}

.xp-reward {
  background: linear-gradient(135deg, #ffd700, #ff9800);
  padding: 16px;
  border-radius: 12px;
  margin-bottom: 24px;
  animation: glow 1s ease-in-out infinite alternate;
}

.xp-icon {
  font-size: 24px;
  margin-right: 8px;
}

.xp-text {
  font-size: 24px;
  font-weight: bold;
  color: #fff;
}

@keyframes glow {
  from { box-shadow: 0 0 10px rgba(255, 215, 0, 0.5); }
  to { box-shadow: 0 0 20px rgba(255, 215, 0, 0.8); }
}

.result-actions {
  display: flex;
  gap: 12px;
}

.retry-btn, .home-btn {
  flex: 1;
  padding: 16px;
  font-size: 16px;
  border: none;
  border-radius: 12px;
  cursor: pointer;
  transition: transform 0.2s;
}

.retry-btn {
  background: #2196f3;
  color: #fff;
}

.home-btn {
  background: #f5f5f5;
  color: #333;
}

.retry-btn:hover, .home-btn:hover {
  transform: translateY(-2px);
}
</style>