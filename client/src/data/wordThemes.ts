/**
 * Theme Words Data - 主题单词数据
 * 每个地点对应一个主题单词包
 */

export interface WordTheme {
  id: string
  name: string
  icon: string
  description: string
  words: string[]  // 单词列表
  color: string
}

export const wordThemes: WordTheme[] = [
  {
    id: 'nature',
    name: '自然世界',
    icon: '🌲',
    description: '探索大自然的词汇',
    color: '#4caf50',
    words: [
      'tree', 'flower', 'river', 'mountain', 'forest',
      'ocean', 'lake', 'sun', 'moon', 'star',
      'cloud', 'rain', 'wind', 'grass', 'leaf',
      'bird', 'animal', 'sky', 'earth', 'water'
    ]
  },
  {
    id: 'music-art',
    name: '音乐与艺术',
    icon: '🎵',
    description: '精灵传授的艺术词汇',
    color: '#e91e63',
    words: [
      'music', 'song', 'dance', 'paint', 'draw',
      'art', 'melody', 'rhythm', 'guitar', 'piano',
      'voice', 'sing', 'picture', 'color', 'brush'
    ]
  },
  {
    id: 'travel',
    name: '旅行探险',
    icon: '🏜️',
    description: '沙漠中的旅行词汇',
    color: '#ff9800',
    words: [
      'travel', 'journey', 'adventure', 'explore', 'discover',
      'map', 'compass', 'path', 'road', 'desert',
      'camel', 'oasis', 'sand', 'dune', 'horizon'
    ]
  },
  {
    id: 'history',
    name: '历史文明',
    icon: '🏛️',
    description: '古老神殿的历史词汇',
    color: '#795548',
    words: [
      'history', 'ancient', 'temple', 'kingdom', 'emperor',
      'civilization', 'culture', 'tradition', 'legend', 'myth',
      'stone', 'carving', 'treasure', 'artifact', 'ruins'
    ]
  },
  {
    id: 'weather',
    name: '天气气候',
    icon: '❄️',
    description: '雪山的天气词汇',
    color: '#03a9f4',
    words: [
      'weather', 'snow', 'ice', 'cold', 'freeze',
      'winter', 'blizzard', 'frost', 'storm', 'windy',
      'temperature', 'climate', 'season', 'chill', 'frozen'
    ]
  },
  {
    id: 'beauty',
    name: '美丽光芒',
    icon: '🌌',
    description: '极光下的美丽词汇',
    color: '#9c27b0',
    words: [
      'beautiful', 'bright', 'shine', 'glow', 'light',
      'aurora', 'sparkle', 'twinkle', 'radiant', 'brilliant',
      'magnificent', 'gorgeous', 'stunning', 'dazzling', 'luminous'
    ]
  },
  {
    id: 'castle-life',
    name: '城堡生活',
    icon: '🏰',
    description: '城堡中的贵族词汇',
    color: '#673ab7',
    words: [
      'castle', 'king', 'queen', 'prince', 'princess',
      'knight', 'throne', 'crown', 'royal', 'palace',
      'guard', 'servant', 'feast', 'ballroom', 'tower'
    ]
  },
  {
    id: 'knowledge',
    name: '知识智慧',
    icon: '📚',
    description: '图书馆的知识词汇',
    color: '#607d8b',
    words: [
      'book', 'knowledge', 'wisdom', 'learn', 'study',
      'library', 'scroll', 'page', 'chapter', 'story',
      'author', 'reader', 'scholar', 'lesson', 'education'
    ]
  },
  {
    id: 'advanced',
    name: '高级词汇',
    icon: '☁️',
    description: '天空之城的进阶词汇',
    color: '#ffd700',
    words: [
      'eternal', 'infinite', 'magnificent', 'extraordinary', 'phenomenal',
      'transcend', 'immortal', 'legendary', 'miraculous', 'sublime',
      'celestial', 'divine', 'supreme', 'ultimate', 'magnificent'
    ]
  }
]

// 根据地点ID获取对应主题
export function getThemeForLocation(locationId: string): WordTheme | undefined {
  const themeMap: Record<string, string> = {
    'forest-1': 'nature',
    'forest-2': 'music-art',
    'desert-1': 'travel',
    'desert-2': 'history',
    'snow-1': 'weather',
    'snow-2': 'beauty',
    'castle-1': 'castle-life',
    'castle-2': 'knowledge',
    'sky-1': 'advanced'
  }

  const themeId = themeMap[locationId]
  return wordThemes.find(t => t.id === themeId)
}

// 获取主题
export function getThemeById(themeId: string): WordTheme | undefined {
  return wordThemes.find(t => t.id === themeId)
}