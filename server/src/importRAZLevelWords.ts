/**
 * RAZ分级词汇导入脚本
 * 从详细版Excel导入RAZ分级词汇（AA到Z2共29个级别）
 */

import 'reflect-metadata'
import { AppDataSource } from './config/database'
import { Word } from './entities/Word'
import * as xlsx from 'xlsx'
import * as path from 'path'
import { v4 as uuidv4 } from 'uuid'

const RAZ_LEVELS = ['AA', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'Z1', 'Z2']

function parseMeanings(definition: string): Array<{ partOfSpeech: string; definition: string; translation: string }> {
  if (!definition) return [{ partOfSpeech: '', definition: '', translation: '' }]

  const meanings: Array<{ partOfSpeech: string; definition: string; translation: string }> = []
  const lines = definition.split('\n').filter(line => line.trim())

  for (const line of lines) {
    const match = line.match(/^([a-z]+\.)\s*(.+)$/i)
    if (match) {
      meanings.push({
        partOfSpeech: match[1],
        definition: match[2],
        translation: match[2]
      })
    } else if (line.trim()) {
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

async function importRAZWords() {
  console.log('🚀 开始导入RAZ分级词汇...\n')

  await AppDataSource.initialize()
  const wordRepo = AppDataSource.getRepository(Word)

  // 读取Excel文件
  const excelPath = path.join(__dirname, '../../RAZ所有级别单词_详细版.xlsx')
  console.log('📖 读取文件:', excelPath)
  const workbook = xlsx.readFile(excelPath)

  const stats: Record<string, number> = {}
  let totalImported = 0

  // 遍历所有级别
  for (const level of RAZ_LEVELS) {
    const sheetName = level
    if (!workbook.SheetNames.includes(sheetName)) {
      console.log(`⚠️  级别 ${level} 不存在，跳过`)
      continue
    }

    const worksheet = workbook.Sheets[sheetName]
    const rawData = xlsx.utils.sheet_to_json(worksheet, { header: 1 })

    let imported = 0
    for (let i = 1; i < rawData.length; i++) {
      const row = rawData[i] as any[]
      if (!row || !row[1]) continue

      const word = row[1].toString().trim()
      const phonetic = row[2]?.toString().trim() || ''
      const definition = row[3]?.toString().trim() || ''
      const isPrimary = row[5] === '√'
      const isJunior = row[6] === '√'
      const isSenior = row[7] === '√'

      let gradeLevel = ''
      if (isPrimary) gradeLevel = '小学'
      else if (isJunior) gradeLevel = '初中'
      else if (isSenior) gradeLevel = '高中'

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
      wordEntity.source = 'RAZ分级'
      wordEntity.razLevel = level.toLowerCase()
      wordEntity.difficulty = gradeLevel === '小学' ? 1 : gradeLevel === '初中' ? 2 : 3

      await wordRepo.save(wordEntity)
      imported++
      totalImported++
    }

    stats[level] = imported
    process.stdout.write(`\r✅ ${level}: ${imported} 个单词`)
  }

  console.log('\n\n📊 导入统计:')
  for (const [level, count] of Object.entries(stats)) {
    console.log(`   ${level}: ${count} 个`)
  }
  console.log(`\n   总计导入: ${totalImported} 个单词`)

  // 验证
  const total = await wordRepo.count()
  const razCount = await wordRepo.count({ where: { source: 'RAZ分级' } })
  const summaryCount = await wordRepo.count({ where: { source: '汇总' } })

  console.log('\n📊 数据库统计:')
  console.log(`   汇总词汇: ${summaryCount} 个`)
  console.log(`   RAZ分级词汇: ${razCount} 个`)
  console.log(`   总计: ${total} 个`)

  await AppDataSource.destroy()
  console.log('\n✅ 导入完成!')
}

importRAZWords().catch(console.error)