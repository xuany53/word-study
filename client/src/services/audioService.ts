/**
 * Audio Service - 音频播放服务
 * 支持多种音频源：本地音频、在线TTS、Web Speech API
 */

// 在线TTS服务配置
const TTS_SERVICES = {
  // Google Translate TTS (免费)
  google: (word: string) =>
    `https://translate.google.com/translate_tts?ie=UTF-8&q=${encodeURIComponent(word)}&tl=en&client=tw-ob`,

  // ResponsiveVoice API (需要API key，这里用免费模式)
  responsivevoice: (word: string) =>
    `https://code.responsivevoice.org/getvoice.php?t=${encodeURIComponent(word)}&tl=en-US`,

  // Dictionary.com 音频
  dictionary: (word: string) =>
    `https://api.dictionaryapi.dev/api/v2/entries/en/${word}`
}

// 音频缓存
const audioCache = new Map<string, HTMLAudioElement>()

// 当前播放的音频
let currentAudio: HTMLAudioElement | null = null

/**
 * 播放单词发音
 * @param word - 要发音的单词
 * @param pronunciationUrl - 可选的音频URL
 */
export async function playWordAudio(word: string, pronunciationUrl?: string): Promise<boolean> {
  try {
    // 停止当前播放
    stopCurrentAudio()

    // 1. 尝试使用提供的音频URL
    if (pronunciationUrl) {
      const success = await playAudioUrl(pronunciationUrl)
      if (success) return true
    }

    // 2. 尝试使用缓存的音频
    if (audioCache.has(word)) {
      const cachedAudio = audioCache.get(word)!
      await playAudioElement(cachedAudio)
      return true
    }

    // 3. 尝试使用在线TTS服务
    const ttsUrl = TTS_SERVICES.google(word)
    const success = await playAudioUrl(ttsUrl)
    if (success) {
      // 缓存成功的音频
      cacheAudio(word, ttsUrl)
      return true
    }

    // 4. 最后使用 Web Speech API
    return await playWithWebSpeech(word)
  } catch (error) {
    console.error('Audio playback error:', error)
    // 最终fallback: Web Speech API
    return await playWithWebSpeech(word)
  }
}

/**
 * 播放音频URL
 */
async function playAudioUrl(url: string): Promise<boolean> {
  return new Promise((resolve) => {
    const audio = new Audio(url)

    audio.oncanplaythrough = async () => {
      try {
        await audio.play()
        currentAudio = audio
        resolve(true)
      } catch {
        resolve(false)
      }
    }

    audio.onerror = () => resolve(false)

    // 设置超时
    setTimeout(() => resolve(false), 5000)

    // 开始加载
    audio.load()
  })
}

/**
 * 播放音频元素
 */
async function playAudioElement(audio: HTMLAudioElement): Promise<boolean> {
  return new Promise((resolve) => {
    audio.currentTime = 0
    audio.play()
      .then(() => {
        currentAudio = audio
        resolve(true)
      })
      .catch(() => resolve(false))
  })
}

/**
 * 使用 Web Speech API 播放
 */
async function playWithWebSpeech(word: string): Promise<boolean> {
  return new Promise((resolve) => {
    if (!('speechSynthesis' in window)) {
      resolve(false)
      return
    }

    // 取消之前的播放
    speechSynthesis.cancel()

    const utterance = new SpeechSynthesisUtterance(word)
    utterance.lang = 'en-US'
    utterance.rate = 0.9
    utterance.pitch = 1

    // 尝试获取英语语音
    const voices = speechSynthesis.getVoices()
    const englishVoice = voices.find(v =>
      v.lang.startsWith('en') && v.name.includes('Female')
    ) || voices.find(v => v.lang.startsWith('en'))

    if (englishVoice) {
      utterance.voice = englishVoice
    }

    utterance.onend = () => resolve(true)
    utterance.onerror = () => resolve(false)

    speechSynthesis.speak(utterance)

    // 某些浏览器需要延迟才能获取语音列表
    if (voices.length === 0) {
      speechSynthesis.onvoiceschanged = () => {
        const newVoices = speechSynthesis.getVoices()
        const enVoice = newVoices.find(v => v.lang.startsWith('en'))
        if (enVoice) {
          utterance.voice = enVoice
        }
        speechSynthesis.speak(utterance)
      }
    }
  })
}

/**
 * 停止当前音频播放
 */
export function stopCurrentAudio(): void {
  if (currentAudio) {
    currentAudio.pause()
    currentAudio.currentTime = 0
    currentAudio = null
  }

  if ('speechSynthesis' in window) {
    speechSynthesis.cancel()
  }
}

/**
 * 缓存音频
 */
function cacheAudio(word: string, url: string): void {
  if (audioCache.has(word)) return

  const audio = new Audio(url)
  audio.preload = 'auto'
  audioCache.set(word, audio)

  // 限制缓存大小
  if (audioCache.size > 100) {
    const firstKey = audioCache.keys().next().value
    audioCache.delete(firstKey)
  }
}

/**
 * 预加载单词音频
 */
export function preloadWordAudio(word: string): void {
  if (audioCache.has(word)) return

  const url = TTS_SERVICES.google(word)
  cacheAudio(word, url)
}

/**
 * 批量预加载音频
 */
export function preloadWordsAudio(words: string[]): void {
  words.forEach(word => preloadWordAudio(word))
}

/**
 * 检查音频是否可用
 */
export function isAudioAvailable(): boolean {
  return typeof Audio !== 'undefined' || 'speechSynthesis' in window
}

// 初始化语音合成
if ('speechSynthesis' in window) {
  // 某些浏览器需要这个来加载语音列表
  speechSynthesis.getVoices()
}

export default {
  playWordAudio,
  stopCurrentAudio,
  preloadWordAudio,
  preloadWordsAudio,
  isAudioAvailable
}