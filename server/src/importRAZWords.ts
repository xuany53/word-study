/**
 * RAZ单词库导入脚本
 * 从Excel导入单词，按小学/初中/高中分类
 */

import 'reflect-metadata'
import { AppDataSource } from './config/database'
import { Word } from './entities/Word'
import * as xlsx from 'xlsx'
import * as path from 'path'
import { v4 as uuidv4 } from 'uuid'

interface ExcelWord {
  序号: number
  单词: string
  音标: string
  词典释义: string
  课本释义: string
  小学词汇: string
  初中词汇: string
  高中词汇: string
}

function parseMeanings(definition: string): Array<{ partOfSpeech: string; definition: string; translation: string }> {
  if (!definition) return [{ partOfSpeech: '', definition: '', translation: definition || '' }]

  const meanings: Array<{ partOfSpeech: string; definition: string; translation: string }> = []
  const lines = definition.split('\n').filter(line => line.trim())

  for (const line of lines) {
    // 尝试匹配词性模式，如 "n. 小船" 或 "vi. 划船"
    const match = line.match(/^([a-z]+\.)\s*(.+)$/i)
    if (match) {
      meanings.push({
        partOfSpeech: match[1],
        definition: match[2],
        translation: match[2]
      })
    } else if (line.trim()) {
      // 没有词性标记，直接作为翻译
      if (meanings.length > 0) {
        meanings[meanings.length - 1].translation += ' ' + line
      } else {
        meanings.push({
          partOfSpeech: '',
          definition: line,
          translation: line
        })
      }
    }
  }

  return meanings.length > 0 ? meanings : [{ partOfSpeech: '', definition: '', translation: definition }]
}

async function importWords() {
  console.log('开始导入RAZ单词库...\n')

  // 初始化数据库连接
  await AppDataSource.initialize()
  const wordRepo = AppDataSource.getRepository(Word)

  // 清空现有数据
  console.log('清空现有单词数据...')
  await wordRepo.clear()
  console.log('✅ 已清空\n')

  // 读取Excel文件
  const excelPath = path.join(__dirname, '../../RAZ所有级别单词词频表.xlsx')
  console.log('读取Excel文件:', excelPath)

  const workbook = xlsx.readFile(excelPath)
  const sheetName = workbook.SheetNames[0]
  const worksheet = workbook.Sheets[sheetName]

  // 转换为JSON
  const rawData = xlsx.utils.sheet_to_json(worksheet, { header: 1 })

  // 跳过标题行，处理数据
  const words: Word[] = []
  const stats = { 小学: 0, 初中: 0, 高中: 0, 其他: 0 }

  for (let i = 1; i < rawData.length; i++) {
    const row = rawData[i] as any[]
    if (!row || !row[1]) continue

    const word = row[1].toString().trim()
    const phonetic = row[2]?.toString().trim() || ''
    const definition = row[3]?.toString().trim() || ''
    const isPrimary = row[5] === '√'
    const isJunior = row[6] === '√'
    const isSenior = row[7] === '√'

    // 确定年级级别
    let gradeLevel = ''
    if (isPrimary) {
      gradeLevel = '小学'
      stats.小学++
    } else if (isJunior) {
      gradeLevel = '初中'
      stats.初中++
    } else if (isSenior) {
      gradeLevel = '高中'
      stats.高中++
    } else {
      gradeLevel = '其他'
      stats.其他++
    }

    const wordEntity = new Word()
    wordEntity.id = uuidv4()
    wordEntity.word = word
    wordEntity.phonetic = phonetic
    wordEntity.pronunciation = null
    wordEntity.meanings = parseMeanings(definition)
    wordEntity.examples = []
    wordEntity.image = null
    wordEntity.category = null
    wordEntity.gradeLevel = gradeLevel
    wordEntity.difficulty = gradeLevel === '小学' ? 1 : gradeLevel === '初中' ? 2 : 3

    words.push(wordEntity)
  }

  console.log(`\n📊 统计信息:`)
  console.log(`   小学词汇: ${stats.小学} 个`)
  console.log(`   初中词汇: ${stats.初中} 个`)
  console.log(`   高中词汇: ${stats.高中} 个`)
  console.log(`   其他词汇: ${stats.其他} 个`)
  console.log(`   总计: ${words.length} 个\n`)

  // 批量插入
  console.log('开始批量插入...')
  const batchSize = 500
  for (let i = 0; i < words.length; i += batchSize) {
    const batch = words.slice(i, i + batchSize)
    await wordRepo.save(batch)
    process.stdout.write(`\r已导入: ${Math.min(i + batchSize, words.length)} / ${words.length}`)
  }

  console.log('\n\n✅ 导入完成!')

  // 验证
  const count = await wordRepo.count()
  console.log(`数据库中共有 ${count} 个单词`)

  await AppDataSource.destroy()
}

importWords().catch(console.error)