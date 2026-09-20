	import {
		createRouter,
		createWebHashHistory
	} from 'vue-router'
	import xianluxinxi from '@/views/xianluxinxi/list'
	import yuyuejieguo from '@/views/yuyuejieguo/list'
	import xuesheng from '@/views/xuesheng/list'
	import jiaozhigong from '@/views/jiaozhigong/list'
	import jiashiyuanquerenxinxi from '@/views/jiashiyuanquerenxinxi/list'
	import jiashiyuan from '@/views/jiashiyuan/list'
	import xianluyuyue from '@/views/xianluyuyue/list'
	import cheliangxinxi from '@/views/cheliangxinxi/list'
	import storeup from '@/views/storeup/list'
	import config from '@/views/config/list'
	import users from '@/views/users/list'
	import jiaozhigongRegister from '@/views/jiaozhigong/register'
	import jiaozhigongCenter from '@/views/jiaozhigong/center'
	import jiashiyuanCenter from '@/views/jiashiyuan/center'

export const routes = [{
		path: '/login',
		name: 'login',
		component: () => import('../views/login.vue')
	},{
		path: '/',
		name: '首页',
		component: () => import('../views/index'),
		children: [{
			path: '/',
			name: '首页Home',
			component: () => import('../views/HomeView.vue'),
			meta: {
				affix: true
			}
		}, {
			path: '/updatepassword',
			name: '修改密码',
			component: () => import('../views/updatepassword.vue')
		}
		
		,{
			path: '/jiaozhigongCenter',
			name: '教职工个人中心',
			component: jiaozhigongCenter
		}
		,{
			path: '/jiashiyuanCenter',
			name: '驾驶员个人中心',
			component: jiashiyuanCenter
		}
		,{
			path: '/xianluxinxi',
			name: '线路信息',
			component: xianluxinxi
		}
		,{
			path: '/yuyuejieguo',
			name: '预约结果',
			component: yuyuejieguo
		}
		,{
			path: '/xuesheng',
			name: '学生',
			component: xuesheng
		}
		,{
			path: '/jiaozhigong',
			name: '教职工',
			component: jiaozhigong
		}
		,{
			path: '/jiashiyuanquerenxinxi',
			name: '驾驶员确认信息',
			component: jiashiyuanquerenxinxi
		}
		,{
			path: '/jiashiyuan',
			name: '驾驶员',
			component: jiashiyuan
		}
		,{
			path: '/xianluyuyue',
			name: '线路预约',
			component: xianluyuyue
		}
		,{
			path: '/cheliangxinxi',
			name: '车辆信息',
			component: cheliangxinxi
		}
		,{
			path: '/storeup',
			name: '我的收藏',
			component: storeup
		}
		,{
			path: '/config',
			name: '轮播图',
			component: config
		}
		,{
			path: '/users',
			name: '管理员',
			component: users
		}
		]
	},
	{
		path: '/jiaozhigongRegister',
		name: '教职工注册',
		component: jiaozhigongRegister
	},
]

const router = createRouter({
	history: createWebHashHistory(process.env.BASE_URL),
	routes
})

export default router
