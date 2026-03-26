<template>
  <Teleport to="body">
    <Transition name="fade">
      <div v-if="visible" class="feedback-overlay" :class="type" @click="$emit('close')">
        <div class="feedback-content">
          <!-- Correct feedback -->
          <div v-if="type === 'correct'" class="correct-animation">
            <div class="icon-wrapper correct">
              <span class="checkmark">✓</span>
            </div>
            <p class="feedback-text">正确!</p>
            <div class="xp-gain" v-if="xpGain > 0">+{{ xpGain }} XP</div>
          </div>

          <!-- Incorrect feedback -->
          <div v-else class="incorrect-animation">
            <div class="icon-wrapper incorrect">
              <span class="cross">✗</span>
            </div>
            <p class="feedback-text">错误</p>
            <p class="correct-answer" v-if="correctAnswer">
              正确答案: <strong>{{ correctAnswer }}</strong>
            </p>
          </div>
        </div>

        <!-- Confetti for correct answers -->
        <div v-if="type === 'correct' && showConfetti" class="confetti-container">
          <div
            v-for="i in 20"
            :key="i"
            class="confetti"
            :style="getConfettiStyle(i)"
          ></div>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  visible: boolean
  type: 'correct' | 'incorrect'
  xpGain?: number
  correctAnswer?: string
  showConfetti?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  xpGain: 0,
  correctAnswer: '',
  showConfetti: true
})

defineEmits<{
  close: []
}>()

const getConfettiStyle = (index: number) => {
  const colors = ['#4CAF50', '#8BC34A', '#CDDC39', '#FFEB3B', '#FFC107']
  const left = Math.random() * 100
  const delay = Math.random() * 0.5
  const duration = 1 + Math.random()

  return {
    left: `${left}%`,
    backgroundColor: colors[index % colors.length],
    animationDelay: `${delay}s`,
    animationDuration: `${duration}s`
  }
}
</script>

<style scoped>
.feedback-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  cursor: pointer;
}

.feedback-overlay.correct {
  background: rgba(76, 175, 80, 0.9);
}

.feedback-overlay.incorrect {
  background: rgba(244, 67, 54, 0.9);
}

.feedback-content {
  text-align: center;
  color: white;
}

.icon-wrapper {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 24px;
  animation: scaleIn 0.3s ease-out;
}

.icon-wrapper.correct {
  background: white;
  color: #4CAF50;
}

.icon-wrapper.incorrect {
  background: white;
  color: #f44336;
}

.checkmark, .cross {
  font-size: 60px;
  font-weight: bold;
}

.correct-animation .checkmark {
  animation: checkBounce 0.5s ease-out;
}

.incorrect-animation .cross {
  animation: shake 0.5s ease-out;
}

.feedback-text {
  font-size: 32px;
  font-weight: bold;
  margin-bottom: 16px;
}

.xp-gain {
  font-size: 24px;
  background: rgba(255, 255, 255, 0.2);
  padding: 8px 24px;
  border-radius: 20px;
  display: inline-block;
  animation: fadeSlideUp 0.3s ease-out;
}

.correct-answer {
  font-size: 18px;
  opacity: 0.9;
}

.correct-answer strong {
  font-size: 24px;
}

/* Confetti */
.confetti-container {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  pointer-events: none;
}

.confetti {
  position: absolute;
  width: 10px;
  height: 10px;
  top: -20px;
  animation: confettiFall 2s ease-out forwards;
}

@keyframes scaleIn {
  from {
    transform: scale(0);
  }
  to {
    transform: scale(1);
  }
}

@keyframes checkBounce {
  0% {
    transform: scale(0);
  }
  50% {
    transform: scale(1.2);
  }
  100% {
    transform: scale(1);
  }
}

@keyframes shake {
  0%, 100% {
    transform: translateX(0);
  }
  25% {
    transform: translateX(-10px);
  }
  75% {
    transform: translateX(10px);
  }
}

@keyframes fadeSlideUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes confettiFall {
  0% {
    transform: translateY(0) rotate(0deg);
    opacity: 1;
  }
  100% {
    transform: translateY(100vh) rotate(720deg);
    opacity: 0;
  }
}

/* Transitions */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>