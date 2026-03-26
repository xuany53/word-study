/**
 * 完整测试脚本 - 测试用户注册、登录、获取单词流程
 */

const BASE_URL = 'http://localhost:3000'

async function test() {
  console.log('🧪 开始测试完整流程...\n')

  try {
    // 1. 测试健康检查
    console.log('1️⃣ 测试健康检查...')
    const healthRes = await fetch(`${BASE_URL}/health`)
    const health = await healthRes.json()
    console.log('   ✅ 服务器状态:', health.status)
    console.log()

    // 2. 注册新用户
    console.log('2️⃣ 注册新用户...')
    const timestamp = Date.now()
    const registerRes = await fetch(`${BASE_URL}/api/auth/register`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        username: `test_${timestamp}`,
        email: `test_${timestamp}@test.com`,
        password: '123456'
      })
    })
    const registerData = await registerRes.json()
    console.log('   注册结果:', registerData.success ? '✅ 成功' : '❌ 失败')
    if (!registerData.success) {
      console.log('   错误信息:', registerData.message)
      return
    }
    console.log()

    // 3. 登录
    console.log('3️⃣ 登录...')
    const loginRes = await fetch(`${BASE_URL}/api/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        email: `test_${timestamp}@test.com`,
        password: '123456'
      })
    })
    const loginData = await loginRes.json()
    console.log('   登录结果:', loginData.success ? '✅ 成功' : '❌ 失败')
    if (!loginData.success) {
      console.log('   错误信息:', loginData.message)
      return
    }
    const token = loginData.data.token
    console.log('   Token:', token.substring(0, 20) + '...')
    console.log()

    // 4. 获取单词列表
    console.log('4️⃣ 获取单词列表...')
    const wordsRes = await fetch(`${BASE_URL}/api/words`, {
      headers: { 'Authorization': `Bearer ${token}` }
    })
    const wordsData = await wordsRes.json()
    console.log('   获取结果:', wordsData.success ? '✅ 成功' : '❌ 失败')

    if (wordsData.success && wordsData.data) {
      const words = Array.isArray(wordsData.data) ? wordsData.data : []
      console.log('   单词总数:', words.length)

      if (words.length > 0) {
        console.log('\n   前5个单词:')
        words.slice(0, 5).forEach((w, i) => {
          console.log(`   ${i + 1}. word="${w.word}" phonetic="${w.phonetic}"`)
          if (w.word === '' || !w.word) {
            console.log('      ⚠️ 警告: word 字段为空!')
          }
        })
      } else {
        console.log('   ⚠️ 警告: 没有单词数据!')
      }
    }
    console.log()

    // 5. 获取今日学习单词
    console.log('5️⃣ 获取今日学习单词...')
    const todayRes = await fetch(`${BASE_URL}/api/learning/today`, {
      headers: { 'Authorization': `Bearer ${token}` }
    })
    const todayData = await todayRes.json()
    console.log('   获取结果:', todayData.success ? '✅ 成功' : '❌ 失败')

    if (todayData.success && todayData.data) {
      console.log('   待复习:', todayData.data.reviewWords)
      console.log('   新单词:', todayData.data.newWords)

      if (todayData.data.newWordList && todayData.data.newWordList.length > 0) {
        console.log('\n   前5个新单词:')
        todayData.data.newWordList.slice(0, 5).forEach((w, i) => {
          console.log(`   ${i + 1}. word="${w.word}" phonetic="${w.phonetic}"`)
          if (w.word === '' || !w.word) {
            console.log('      ⚠️ 警告: word 字段为空!')
          }
        })
      }
    }
    console.log()

    console.log('✅ 测试完成!')
  } catch (error) {
    console.error('❌ 测试出错:', error)
  }
}

test()