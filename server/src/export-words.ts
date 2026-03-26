/**
 * 导出数据库中所有单词为SQL文件
 */
import { AppDataSource } from './config/database'
import { Word } from './entities/Word'

async function exportWords() {
  try {
    await AppDataSource.initialize()
    console.log('✅ Database connected')

    const wordRepository = AppDataSource.getRepository(Word)
    const words = await wordRepository.find()

    console.log(`📊 Found ${words.length} words`)

    // 生成SQL
    const sqlLines: string[] = [
      '-- 趣背词完整单词库',
      '-- 导出时间: ' + new Date().toISOString(),
      '-- 总单词数: ' + words.length,
      '',
      'SET NAMES utf8mb4;',
      'USE word_study;',
      '',
      '-- 清空现有单词数据',
      'DELETE FROM words;',
      '',
      '-- 插入单词数据',
      'INSERT INTO words (id, word, phonetic, pronunciation, meanings, examples, image, category, difficulty, createdAt) VALUES'
    ]

    const values = words.map((w, i) => {
      const meanings = JSON.stringify(w.meanings).replace(/'/g, "''")
      const examples = JSON.stringify(w.examples).replace(/'/g, "''")
      const pronunciation = w.pronunciation ? `'${w.pronunciation}'` : 'NULL'
      const image = w.image ? `'${w.image}'` : 'NULL'
      const category = w.category ? `'${w.category}'` : 'NULL'

      return `('${w.id}', '${w.word}', '${w.phonetic}', ${pronunciation}, '${meanings}', '${examples}', ${image}, ${category}, ${w.difficulty}, '${w.createdAt.toISOString().slice(0, 19).replace('T', ' ')}')`
    })

    // 分批写入，每100个一组
    for (let i = 0; i < values.length; i++) {
      if (i === 0) {
        sqlLines.push(values[i])
      } else {
        sqlLines.push(',' + values[i])
      }
    }

    sqlLines.push(';')
    sqlLines.push('')
    sqlLines.push(`-- 导出完成，共 ${words.length} 个单词`)
    sqlLines.push('SELECT COUNT(*) as total_words FROM words;')

    const fs = await import('fs')
    const sql = sqlLines.join('\n')
    fs.writeFileSync('database/words.sql', sql, 'utf-8')

    console.log('✅ Exported to database/words.sql')

    // 统计各级别数量
    const stats: Record<string, number> = {}
    words.forEach(w => {
      const cat = w.category || 'uncategorized'
      stats[cat] = (stats[cat] || 0) + 1
    })

    console.log('\n📊 各级别单词统计:')
    Object.entries(stats).sort().forEach(([cat, count]) => {
      console.log(`   ${cat}: ${count}`)
    })

    await AppDataSource.destroy()
  } catch (error) {
    console.error('❌ Export error:', error)
    process.exit(1)
  }
}

exportWords()