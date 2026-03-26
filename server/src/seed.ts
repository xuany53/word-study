import { AppDataSource } from './config/database'
import { Word } from './entities/Word'

// 基础单词库
const basicWords = [
  { word: 'hello', phonetic: '/həˈləʊ/', meanings: [{ partOfSpeech: 'interj.', definition: 'used as a greeting', translation: '你好' }], examples: [{ sentence: 'Hello, how are you?', translation: '你好，你好吗？' }], difficulty: 1 },
  { word: 'world', phonetic: '/wɜːld/', meanings: [{ partOfSpeech: 'n.', definition: 'the earth and all the people', translation: '世界' }], examples: [{ sentence: 'The world is beautiful.', translation: '世界是美丽的。' }], difficulty: 1 },
  { word: 'apple', phonetic: '/ˈæpl/', meanings: [{ partOfSpeech: 'n.', definition: 'a round fruit', translation: '苹果' }], examples: [{ sentence: 'I eat an apple every day.', translation: '我每天吃一个苹果。' }], difficulty: 1 },
  { word: 'book', phonetic: '/bʊk/', meanings: [{ partOfSpeech: 'n.', definition: 'a written work', translation: '书' }], examples: [{ sentence: 'I love reading books.', translation: '我喜欢读书。' }], difficulty: 1 },
  { word: 'computer', phonetic: '/kəmˈpjuːtə/', meanings: [{ partOfSpeech: 'n.', definition: 'an electronic device', translation: '电脑' }], examples: [{ sentence: 'I use a computer for work.', translation: '我用电脑工作。' }], difficulty: 2 },
  { word: 'water', phonetic: '/ˈwɔːtə/', meanings: [{ partOfSpeech: 'n.', definition: 'a clear liquid', translation: '水' }], examples: [{ sentence: 'I drink water every day.', translation: '我每天喝水。' }], difficulty: 1 },
  { word: 'happy', phonetic: '/ˈhæpi/', meanings: [{ partOfSpeech: 'adj.', definition: 'feeling pleasure', translation: '快乐' }], examples: [{ sentence: 'I am very happy today.', translation: '今天我很快乐。' }], difficulty: 1 },
  { word: 'study', phonetic: '/ˈstʌdi/', meanings: [{ partOfSpeech: 'v.', definition: 'to learn', translation: '学习' }], examples: [{ sentence: 'I study English every day.', translation: '我每天学习英语。' }], difficulty: 2 },
  { word: 'beautiful', phonetic: '/ˈbjuːtɪfl/', meanings: [{ partOfSpeech: 'adj.', definition: 'pleasing to look at', translation: '美丽' }], examples: [{ sentence: 'The flower is beautiful.', translation: '这朵花很美丽。' }], difficulty: 2 },
  { word: 'important', phonetic: '/ɪmˈpɔːtənt/', meanings: [{ partOfSpeech: 'adj.', definition: 'of great significance', translation: '重要' }], examples: [{ sentence: 'English is very important.', translation: '英语很重要。' }], difficulty: 3 },

  // RAZ aa 级别 - 动物
  { word: 'cat', phonetic: '/kæt/', meanings: [{ partOfSpeech: 'n.', definition: 'a small furry pet', translation: '猫' }], examples: [{ sentence: 'The cat is sleeping.', translation: '猫在睡觉。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'dog', phonetic: '/dɒɡ/', meanings: [{ partOfSpeech: 'n.', definition: 'a loyal pet animal', translation: '狗' }], examples: [{ sentence: 'I have a dog.', translation: '我有一只狗。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'bird', phonetic: '/bɜːd/', meanings: [{ partOfSpeech: 'n.', definition: 'an animal with wings', translation: '鸟' }], examples: [{ sentence: 'The bird can fly.', translation: '鸟会飞。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'fish', phonetic: '/fɪʃ/', meanings: [{ partOfSpeech: 'n.', definition: 'an animal that lives in water', translation: '鱼' }], examples: [{ sentence: 'The fish swims.', translation: '鱼在游泳。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'pig', phonetic: '/pɪɡ/', meanings: [{ partOfSpeech: 'n.', definition: 'a farm animal', translation: '猪' }], examples: [{ sentence: 'The pig is pink.', translation: '猪是粉红色的。' }], category: 'raz-aa', difficulty: 1 },

  // RAZ aa 级别 - 颜色
  { word: 'red', phonetic: '/red/', meanings: [{ partOfSpeech: 'adj.', definition: 'the color of fire', translation: '红色的' }], examples: [{ sentence: 'The apple is red.', translation: '苹果是红色的。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'blue', phonetic: '/bluː/', meanings: [{ partOfSpeech: 'adj.', definition: 'the color of sky', translation: '蓝色的' }], examples: [{ sentence: 'The sky is blue.', translation: '天空是蓝色的。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'green', phonetic: '/ɡriːn/', meanings: [{ partOfSpeech: 'adj.', definition: 'the color of grass', translation: '绿色的' }], examples: [{ sentence: 'The grass is green.', translation: '草是绿色的。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'yellow', phonetic: '/ˈjeləʊ/', meanings: [{ partOfSpeech: 'adj.', definition: 'the color of sun', translation: '黄色的' }], examples: [{ sentence: 'The banana is yellow.', translation: '香蕉是黄色的。' }], category: 'raz-aa', difficulty: 1 },

  // RAZ aa 级别 - 家庭
  { word: 'mom', phonetic: '/mɒm/', meanings: [{ partOfSpeech: 'n.', definition: 'mother', translation: '妈妈' }], examples: [{ sentence: 'I love my mom.', translation: '我爱我的妈妈。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'dad', phonetic: '/dæd/', meanings: [{ partOfSpeech: 'n.', definition: 'father', translation: '爸爸' }], examples: [{ sentence: 'My dad is tall.', translation: '我爸爸很高。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'baby', phonetic: '/ˈbeɪbi/', meanings: [{ partOfSpeech: 'n.', definition: 'a very young child', translation: '宝宝' }], examples: [{ sentence: 'The baby is cute.', translation: '宝宝很可爱。' }], category: 'raz-aa', difficulty: 1 },

  // RAZ aa 级别 - 基础名词
  { word: 'ball', phonetic: '/bɔːl/', meanings: [{ partOfSpeech: 'n.', definition: 'a round object for playing', translation: '球' }], examples: [{ sentence: 'Throw the ball.', translation: '扔球。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'bed', phonetic: '/bed/', meanings: [{ partOfSpeech: 'n.', definition: 'furniture for sleeping', translation: '床' }], examples: [{ sentence: 'I sleep in my bed.', translation: '我在床上睡觉。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'car', phonetic: '/kɑː/', meanings: [{ partOfSpeech: 'n.', definition: 'a vehicle', translation: '汽车' }], examples: [{ sentence: 'I go by car.', translation: '我坐汽车去。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'tree', phonetic: '/triː/', meanings: [{ partOfSpeech: 'n.', definition: 'a tall plant', translation: '树' }], examples: [{ sentence: 'The tree is big.', translation: '这棵树很大。' }], category: 'raz-aa', difficulty: 1 },
  { word: 'flower', phonetic: '/ˈflaʊə/', meanings: [{ partOfSpeech: 'n.', definition: 'the colorful part of a plant', translation: '花' }], examples: [{ sentence: 'The flower is red.', translation: '花是红色的。' }], category: 'raz-aa', difficulty: 1 },

  // RAZ A 级别
  { word: 'eat', phonetic: '/iːt/', meanings: [{ partOfSpeech: 'v.', definition: 'to consume food', translation: '吃' }], examples: [{ sentence: 'I eat breakfast.', translation: '我吃早餐。' }], category: 'raz-a', difficulty: 1 },
  { word: 'run', phonetic: '/rʌn/', meanings: [{ partOfSpeech: 'v.', definition: 'to move fast', translation: '跑' }], examples: [{ sentence: 'I can run fast.', translation: '我可以跑得很快。' }], category: 'raz-a', difficulty: 1 },
  { word: 'jump', phonetic: '/dʒʌmp/', meanings: [{ partOfSpeech: 'v.', definition: 'to push yourself up', translation: '跳' }], examples: [{ sentence: 'I can jump high.', translation: '我可以跳得很高。' }], category: 'raz-a', difficulty: 1 },
  { word: 'walk', phonetic: '/wɔːk/', meanings: [{ partOfSpeech: 'v.', definition: 'to move on foot', translation: '走' }], examples: [{ sentence: 'I walk to school.', translation: '我走路去学校。' }], category: 'raz-a', difficulty: 1 },
  { word: 'play', phonetic: '/pleɪ/', meanings: [{ partOfSpeech: 'v.', definition: 'to have fun', translation: '玩' }], examples: [{ sentence: 'I play with friends.', translation: '我和朋友一起玩。' }], category: 'raz-a', difficulty: 1 },

  // 更多常用词
  { word: 'good', phonetic: '/ɡʊd/', meanings: [{ partOfSpeech: 'adj.', definition: 'positive quality', translation: '好的' }], examples: [{ sentence: 'This is good.', translation: '这个很好。' }], difficulty: 1 },
  { word: 'bad', phonetic: '/bæd/', meanings: [{ partOfSpeech: 'adj.', definition: 'negative quality', translation: '坏的' }], examples: [{ sentence: 'That is bad.', translation: '那个不好。' }], difficulty: 1 },
  { word: 'big', phonetic: '/bɪɡ/', meanings: [{ partOfSpeech: 'adj.', definition: 'large in size', translation: '大的' }], examples: [{ sentence: 'The elephant is big.', translation: '大象很大。' }], difficulty: 1 },
  { word: 'small', phonetic: '/smɔːl/', meanings: [{ partOfSpeech: 'adj.', definition: 'little in size', translation: '小的' }], examples: [{ sentence: 'The mouse is small.', translation: '老鼠很小。' }], difficulty: 1 },
  { word: 'hot', phonetic: '/hɒt/', meanings: [{ partOfSpeech: 'adj.', definition: 'high temperature', translation: '热的' }], examples: [{ sentence: 'The soup is hot.', translation: '汤很热。' }], difficulty: 1 },
  { word: 'cold', phonetic: '/kəʊld/', meanings: [{ partOfSpeech: 'adj.', definition: 'low temperature', translation: '冷的' }], examples: [{ sentence: 'Ice is cold.', translation: '冰是冷的。' }], difficulty: 1 },
]

async function seed() {
  console.log('🌱 Starting database seed...')

  try {
    await AppDataSource.initialize()
    console.log('✅ Database connected')

    const wordRepository = AppDataSource.getRepository(Word)

    // 检查是否已有数据
    const count = await wordRepository.count()
    if (count > 0) {
      console.log(`📊 Database already has ${count} words, skipping seed`)
      return
    }

    // 插入数据
    for (const wordData of basicWords) {
      const word = wordRepository.create({
        word: wordData.word,
        phonetic: wordData.phonetic,
        pronunciation: null,
        meanings: wordData.meanings,
        examples: wordData.examples,
        category: wordData.category || null,
        difficulty: wordData.difficulty
      })
      await wordRepository.save(word)
    }

    console.log(`✅ Successfully seeded ${basicWords.length} words`)
  } catch (error) {
    console.error('❌ Seed error:', error)
  } finally {
    await AppDataSource.destroy()
  }
}

seed()