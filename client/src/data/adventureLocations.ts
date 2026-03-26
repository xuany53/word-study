/**
 * Adventure Locations Data - 冒险地点数据
 */

import type { AdventureLocation } from '@/types/adventure'

export const adventureLocations: AdventureLocation[] = [
  {
    id: 'forest-1',
    name: '迷雾森林',
    type: 'forest',
    description: '踏入神秘的森林，开始你的单词冒险之旅',
    icon: '🌲',
    daysRequired: 1,
    rewards: {
      xp: 50,
      theme: 'nature'
    },
    story: '欢迎来到迷雾森林！这里是单词冒险的起点。古老的树木低语着自然的秘密，每一片叶子都记载着一个单词...'
  },
  {
    id: 'forest-2',
    name: '精灵村落',
    type: 'forest',
    description: '森林深处的精灵村落，充满了神奇的单词',
    icon: '🧝',
    daysRequired: 3,
    rewards: {
      xp: 100,
      badge: 'forest-explorer'
    },
    story: '精灵们热情地欢迎你的到来！他们用歌声教授你关于音乐和艺术的单词...'
  },
  {
    id: 'desert-1',
    name: '金沙沙漠',
    type: 'desert',
    description: '穿越炎热沙漠，学习关于旅行和地理的单词',
    icon: '🏜️',
    daysRequired: 7,
    rewards: {
      xp: 150,
      theme: 'travel'
    },
    story: '金色的沙丘延绵无尽，驼铃声声。这里藏着关于旅行和探险的单词宝藏...'
  },
  {
    id: 'desert-2',
    name: '古老神殿',
    type: 'desert',
    description: '沙漠中的神秘神殿，记载着古老的智慧',
    icon: '🏛️',
    daysRequired: 10,
    rewards: {
      xp: 200,
      badge: 'desert-wanderer'
    },
    story: '神殿的墙壁上刻满了神秘的符文，每一个符文都是一个历史的见证...'
  },
  {
    id: 'snow-1',
    name: '冰霜山脉',
    type: 'snow',
    description: '攀登雪山之巅，挑战更难的单词',
    icon: '🏔️',
    daysRequired: 14,
    rewards: {
      xp: 250,
      theme: 'weather'
    },
    story: '寒风凛冽，白雪皑皑。在山顶俯瞰世界，感受自然的力量...'
  },
  {
    id: 'snow-2',
    name: '极光之境',
    type: 'snow',
    description: '绚丽的极光下，学习美丽的词汇',
    icon: '🌌',
    daysRequired: 18,
    rewards: {
      xp: 300,
      badge: 'frost-champion'
    },
    story: '极光在天空中舞动，绚丽的光芒照亮了整个冰原，每一道光都是一首诗...'
  },
  {
    id: 'castle-1',
    name: '王者城堡',
    type: 'castle',
    description: '雄伟的城堡，学习关于历史和文化的单词',
    icon: '🏰',
    daysRequired: 22,
    rewards: {
      xp: 400,
      theme: 'history'
    },
    story: '城堡的大门缓缓打开，历史的长廊展现在眼前...'
  },
  {
    id: 'castle-2',
    name: '魔法图书馆',
    type: 'castle',
    description: '城堡中的图书馆，收藏着无尽的单词',
    icon: '📚',
    daysRequired: 26,
    rewards: {
      xp: 500,
      badge: 'castle-sage'
    },
    story: '书架高耸入云，每一本书都是一个世界，每一个单词都是一把钥匙...'
  },
  {
    id: 'sky-1',
    name: '天空之城',
    type: 'sky',
    description: '传说中的天空之城，单词冒险的终点',
    icon: '☁️',
    daysRequired: 30,
    rewards: {
      xp: 1000,
      badge: 'sky-legend',
      theme: 'advanced'
    },
    story: '云端的城堡闪耀着金光，你是第一个到达这里的冒险者！恭喜你完成了单词大冒险！'
  }
]

// 获取地点
export function getLocationById(id: string): AdventureLocation | undefined {
  return adventureLocations.find(l => l.id === id)
}

// 获取下一个地点
export function getNextLocation(currentId: string): AdventureLocation | undefined {
  const currentIndex = adventureLocations.findIndex(l => l.id === currentId)
  if (currentIndex === -1 || currentIndex >= adventureLocations.length - 1) return undefined
  return adventureLocations[currentIndex + 1]
}

// 获取当前应到达的地点
export function getCurrentLocationForDays(days: number): AdventureLocation {
  let current = adventureLocations[0]
  for (const location of adventureLocations) {
    if (days >= location.daysRequired) {
      current = location
    } else {
      break
    }
  }
  return current
}