import { createRouter, createWebHashHistory } from 'vue-router'
import index from '../views'
import home from '../views/pages/home.vue'
import login from '../views/pages/login.vue'
import xueshengList from '@/views/pages/xuesheng/list'
import xueshengDetail from '@/views/pages/xuesheng/formModel'
import xueshengAdd from '@/views/pages/xuesheng/formAdd'
import xueshengRegister from '@/views/pages/xuesheng/register'
import xueshengCenter from '@/views/pages/xuesheng/center'
import jiaozhigongList from '@/views/pages/jiaozhigong/list'
import jiaozhigongDetail from '@/views/pages/jiaozhigong/formModel'
import jiaozhigongAdd from '@/views/pages/jiaozhigong/formAdd'
import jiashiyuanList from '@/views/pages/jiashiyuan/list'
import jiashiyuanDetail from '@/views/pages/jiashiyuan/formModel'
import jiashiyuanAdd from '@/views/pages/jiashiyuan/formAdd'
import xianluxinxiList from '@/views/pages/xianluxinxi/list'
import xianluxinxiDetail from '@/views/pages/xianluxinxi/formModel'
import xianluxinxiAdd from '@/views/pages/xianluxinxi/formAdd'
import storeupList from '@/views/pages/storeup/list'
import xianluyuyueList from '@/views/pages/xianluyuyue/list'
import xianluyuyueDetail from '@/views/pages/xianluyuyue/formModel'
import xianluyuyueAdd from '@/views/pages/xianluyuyue/formAdd'
import yuyuejieguoList from '@/views/pages/yuyuejieguo/list'
import yuyuejieguoDetail from '@/views/pages/yuyuejieguo/formModel'
import yuyuejieguoAdd from '@/views/pages/yuyuejieguo/formAdd'
import cheliangxinxiList from '@/views/pages/cheliangxinxi/list'
import cheliangxinxiDetail from '@/views/pages/cheliangxinxi/formModel'
import cheliangxinxiAdd from '@/views/pages/cheliangxinxi/formAdd'
import jiashiyuanquerenxinxiList from '@/views/pages/jiashiyuanquerenxinxi/list'
import jiashiyuanquerenxinxiDetail from '@/views/pages/jiashiyuanquerenxinxi/formModel'
import jiashiyuanquerenxinxiAdd from '@/views/pages/jiashiyuanquerenxinxi/formAdd'

const routes = [{
		path: '/',
		redirect: '/index/home'
	},
	{
		path: '/index',
		component: index,
		children: [{
			path: 'home',
			component: home
		}
		, {
			path: 'xueshengList',
			component: xueshengList
		}, {
			path: 'xueshengDetail',
			component: xueshengDetail
		}, {
			path: 'xueshengAdd',
			component: xueshengAdd
		}
		, {
			path: 'xueshengCenter',
			component: xueshengCenter
		}
		, {
			path: 'jiaozhigongList',
			component: jiaozhigongList
		}, {
			path: 'jiaozhigongDetail',
			component: jiaozhigongDetail
		}, {
			path: 'jiaozhigongAdd',
			component: jiaozhigongAdd
		}
		, {
			path: 'jiashiyuanList',
			component: jiashiyuanList
		}, {
			path: 'jiashiyuanDetail',
			component: jiashiyuanDetail
		}, {
			path: 'jiashiyuanAdd',
			component: jiashiyuanAdd
		}
		, {
			path: 'xianluxinxiList',
			component: xianluxinxiList
		}, {
			path: 'xianluxinxiDetail',
			component: xianluxinxiDetail
		}, {
			path: 'xianluxinxiAdd',
			component: xianluxinxiAdd
		}
		, {
			path: 'storeupList',
			component: storeupList
		}
		, {
			path: 'xianluyuyueList',
			component: xianluyuyueList
		}, {
			path: 'xianluyuyueDetail',
			component: xianluyuyueDetail
		}, {
			path: 'xianluyuyueAdd',
			component: xianluyuyueAdd
		}
		, {
			path: 'yuyuejieguoList',
			component: yuyuejieguoList
		}, {
			path: 'yuyuejieguoDetail',
			component: yuyuejieguoDetail
		}, {
			path: 'yuyuejieguoAdd',
			component: yuyuejieguoAdd
		}
		, {
			path: 'cheliangxinxiList',
			component: cheliangxinxiList
		}, {
			path: 'cheliangxinxiDetail',
			component: cheliangxinxiDetail
		}, {
			path: 'cheliangxinxiAdd',
			component: cheliangxinxiAdd
		}
		, {
			path: 'jiashiyuanquerenxinxiList',
			component: jiashiyuanquerenxinxiList
		}, {
			path: 'jiashiyuanquerenxinxiDetail',
			component: jiashiyuanquerenxinxiDetail
		}, {
			path: 'jiashiyuanquerenxinxiAdd',
			component: jiashiyuanquerenxinxiAdd
		}
		]
	},
	{
		path: '/login',
		component: login
	}
	,{
		path: '/xueshengRegister',
		component: xueshengRegister
	}
]

const router = createRouter({
  history: createWebHashHistory(process.env.BASE_URL),
  routes
})

export default router
