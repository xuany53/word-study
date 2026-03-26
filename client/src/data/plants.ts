/**
 * Plants Data - 植物数据定义
 */

import type { PlantDefinition } from '@/types/farm'

export const plants: PlantDefinition[] = [
  {
    id: 'sunflower',
    name: '向日葵',
    type: 'flower',
    icon: '🌻',
    growthDays: 3,
    xpReward: 30,
    stages: [
      { day: 0, icon: '🌱', description: '刚种下的种子' },
      { day: 1, icon: '🌿', description: '小苗正在成长' },
      { day: 2, icon: '🪴', description: '花苞即将绽放' },
      { day: 3, icon: '🌻', description: '美丽的向日葵！' }
    ]
  },
  {
    id: 'rose',
    name: '玫瑰',
    type: 'flower',
    icon: '🌹',
    growthDays: 5,
    xpReward: 50,
    stages: [
      { day: 0, icon: '🌱', description: '刚种下的种子' },
      { day: 2, icon: '🌿', description: '枝叶繁茂' },
      { day: 4, icon: '🥀', description: '花苞含苞待放' },
      { day: 5, icon: '🌹', description: '浪漫的玫瑰！' }
    ]
  },
  {
    id: 'cherry-tree',
    name: '樱花树',
    type: 'tree',
    icon: '🌸',
    growthDays: 7,
    xpReward: 100,
    stages: [
      { day: 0, icon: '🌱', description: '刚种下的树苗' },
      { day: 2, icon: '🌿', description: '小树正在成长' },
      { day: 4, icon: '🌳', description: '树木茂盛' },
      { day: 7, icon: '🌸', description: '樱花盛开！' }
    ]
  },
  {
    id: 'carrot',
    name: '胡萝卜',
    type: 'vegetable',
    icon: '🥕',
    growthDays: 2,
    xpReward: 20,
    stages: [
      { day: 0, icon: '🌱', description: '刚种下的种子' },
      { day: 1, icon: '🌿', description: '绿叶冒出' },
      { day: 2, icon: '🥕', description: '胡萝卜成熟！' }
    ]
  },
  {
    id: 'tomato',
    name: '番茄',
    type: 'vegetable',
    icon: '🍅',
    growthDays: 4,
    xpReward: 40,
    stages: [
      { day: 0, icon: '🌱', description: '刚种下的种子' },
      { day: 1, icon: '🌿', description: '幼苗成长中' },
      { day: 3, icon: '🪴', description: '开出小花' },
      { day: 4, icon: '🍅', description: '番茄成熟！' }
    ]
  },
  {
    id: 'house',
    name: '小屋',
    type: 'building',
    icon: '🏠',
    growthDays: 10,
    xpReward: 200,
    stages: [
      { day: 0, icon: '🔨', description: '开始建造' },
      { day: 3, icon: '🧱', description: '地基完成' },
      { day: 6, icon: '🏗️', description: '框架搭建中' },
      { day: 10, icon: '🏠', description: '温馨小屋！' }
    ]
  },
  {
    id: 'fountain',
    name: '喷泉',
    type: 'building',
    icon: '⛲',
    growthDays: 7,
    xpReward: 150,
    stages: [
      { day: 0, icon: '🔨', description: '开始建造' },
      { day: 3, icon: '🪨', description: '石块堆砌' },
      { day: 7, icon: '⛲', description: '美丽喷泉！' }
    ]
  }
]

// 获取植物
export function getPlantById(id: string): PlantDefinition | undefined {
  return plants.find(p => p.id === id)
}

// 获取当前生长阶段
export function getCurrentStage(plant: PlantDefinition, growthProgress: number): typeof plant.stages[0] {
  const daysGrown = Math.floor((growthProgress / 100) * plant.growthDays)

  for (let i = plant.stages.length - 1; i >= 0; i--) {
    if (daysGrown >= plant.stages[i].day) {
      return plant.stages[i]
    }
  }

  return plant.stages[0]
}