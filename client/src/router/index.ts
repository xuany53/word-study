import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('@/views/Home.vue'),
    meta: { title: '首页' }
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login.vue'),
    meta: { title: '登录' }
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/Register.vue'),
    meta: { title: '注册' }
  },
  {
    path: '/learning',
    name: 'Learning',
    component: () => import('@/views/Learning.vue'),
    meta: { title: '学习', requiresAuth: true }
  },
  {
    path: '/stats',
    name: 'Stats',
    component: () => import('@/views/Stats.vue'),
    meta: { title: '统计', requiresAuth: true }
  },
  {
    path: '/challenge',
    name: 'Challenge',
    component: () => import('@/views/Challenge.vue'),
    meta: { title: '闯关', requiresAuth: true }
  },
  {
    path: '/challenge/:id',
    name: 'ChallengePlay',
    component: () => import('@/views/ChallengePlay.vue'),
    meta: { title: '闯关进行中', requiresAuth: true }
  },
  {
    path: '/badges',
    name: 'Badges',
    component: () => import('@/views/Badges.vue'),
    meta: { title: '徽章', requiresAuth: true }
  },
  {
    path: '/settings',
    name: 'Settings',
    component: () => import('@/views/Settings.vue'),
    meta: { title: '设置', requiresAuth: true }
  },
  {
    path: '/games',
    name: 'MiniGames',
    component: () => import('@/views/MiniGames.vue'),
    meta: { title: '小游戏', requiresAuth: true }
  },
  {
    path: '/adventure',
    name: 'Adventure',
    component: () => import('@/views/Adventure.vue'),
    meta: { title: '单词大冒险', requiresAuth: true }
  },
  {
    path: '/farm',
    name: 'Farm',
    component: () => import('@/views/Farm.vue'),
    meta: { title: '单词农场', requiresAuth: true }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 路由守卫
router.beforeEach((to, _from, next) => {
  const token = localStorage.getItem('token')

  if (to.meta.requiresAuth && !token) {
    next({ name: 'Login', query: { redirect: to.fullPath } })
  } else {
    next()
  }

  // 设置页面标题
  document.title = `${to.meta.title || '趣背词'} - 让背单词不再枯燥`
})

export default router