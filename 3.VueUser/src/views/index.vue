<template>
	<div class="home">
		<div class="index_top">
			<div class="index_top_title">校车管理信息系统</div>
			<div class="index_top_right">
				<template v-if="Token">
					<div v-if="date&&weather.city" class="weather_time_view">
						<div class="weather">
							<div class="city">{{weather.city}}</div>
							<div class="wea">
								{{weather.wea}} | {{weather.tem}}℃
							</div>
						</div>
						<div class="time">
							<div class="date">{{date}}</div>
							<div class="timer">{{timer}}</div>
						</div>
					</div>
				</template>
				<el-button v-if="!Token" type="success" icon="User" circle @click="loginClick" />
				<el-button v-if="Token" type="danger" icon="SwitchButton" circle @click="loginOut" />
			</div>
		</div>
		<el-scrollbar class="contain_view">
			<el-scrollbar wrap-class="scrollbar-wrapper" class="menu_scrollbar">
				<el-menu :default-openeds="[]" :unique-opened="true" :default-active="menuIndex" class="menu_view"
					:collapse="collapse" @select="menuChange">
					<el-menu-item class="first_item" index="0" @click="menuHandler('/')">
						<i class="iconfont icon-zhuye2"></i>
						<template #title>
							<span>首页</span>
						</template>
					</el-menu-item>
					<template v-for="(menu,index) in menuList" :key="menu.menu">
						<el-sub-menu v-if="menu.child.length>1" :index="index+2+''" class="first_item">
							<template #title>
								<i class="iconfont" :class="menu.icon"></i>
								<span>{{ menu.name }}</span>
							</template>
							<el-menu-item class="menu_item_view" v-for=" (child,sort) in menu.child" :key="sort"
								:index="(index+2)+'-'+sort" @click="menuHandler(child.url)">{{ child.name }}
							</el-menu-item>
						</el-sub-menu>
						<el-menu-item v-else :index="index+2+''" class="first_item" @click="menuHandler(menu.child[0].url)">
							<i class="iconfont" :class="menu.icon"></i>
							<template #title>
								<span>{{menu.child[0].name}}</span>
							</template>
						</el-menu-item>
					</template>
					<el-menu-item v-if="Token" class="first_item" @click="menuHandler('center')">
						<i class="iconfont icon-user2"></i>
						<template #title>
							<span>个人中心</span>
						</template>
					</el-menu-item>
				</el-menu>
			</el-scrollbar>
			<div class="rotation_view">
				<mySwiper :type="3" :data="rotationList" :autoHeight="true" :autoplay="true"
					:loop="false" :navigation="true" :pagination="false" 
					:paginationType="2" :scrollbar="false" :slidesPerView="1" 
					:spaceBetween="20" :centeredSlides="false"
					:freeMode="false" :effectType="1"
					:direction="horizontal">
					<template #default="scope">
						<img :style='{"width":"100%"}' :src="scope.row.value?$config.url + scope.row.value:''">
					</template>
				</mySwiper>
			</div>
			<router-view />
			<el-backtop :right="100" :bottom="100" />
			<div class="bottom_view">
				<img class="bottom_img" src="http://chy2.gdnxeco.com/20230912/0d5ae5e141c14b06a52a7c4c2f8ea4cf.jpg" alt="">
				<div class="bottom_company"></div>
				<div class="bottom_record">京ICP证030173号</div>
				<div class="bottom_desc">电话：138238****8 | 邮箱：138238****8@164.com</div>
			</div>
		</el-scrollbar>
	</div>
</template>
<script setup>
	import menu from '@/utils/menu'
	import axios from 'axios'
	import {
		ref,
		onBeforeUnmount,
		getCurrentInstance,
		nextTick,
		computed,
		watch,
	} from 'vue';
	import {
		useRouter
	} from 'vue-router';
	import {
		useStore
	} from 'vuex';
	const router = useRouter()
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const Token = ref('')
	const weather = ref({})
	const date = ref('')
	const timer = ref('')
	const interval = ref(null)
	const getWeather = () => {
		axios({
			method: 'get',
			url: 'http://v0.yiketianqi.com/free/day?appid=69475998&appsecret=rldbX1Zl&city=北京'
		}).then(res => {
			weather.value = res.data
		})
	}
	watch(() => router.currentRoute.value,() => {
		Token.value = context?.$toolUtil.storageGet('frontToken')
		// 获取默认菜单index
		menuIndex.value = context?.$toolUtil.storageGet('menuIndex')?context?.$toolUtil.storageGet('menuIndex'): '0'
	})
	onBeforeUnmount(() => {
		clearInterval(interval.value)
	})
	// 默认菜单index
	const menuIndex = ref('0')
	const init = () => {
		// 获取默认菜单index
		menuIndex.value = context?.$toolUtil.storageGet('menuIndex')?context?.$toolUtil.storageGet('menuIndex'): '0'
		// 获取菜单
		getMenu()
		// 赋值token
		Token.value = context?.$toolUtil.storageGet('frontToken')
		// 时间
		interval.value = setInterval(() => {
			date.value = context?.$toolUtil.getCurDate()
			timer.value = context?.$toolUtil.getCurDateTime().split(' ')[1]
		}, 1000)
		// 天气
		getWeather()
		// 轮播图
		getRotationList()
		if(Token.value){
			getSession()
		}
	}
	// 切换菜单保存index
	const menuChange = (e)=>{
		context?.$toolUtil.storageSet('menuIndex',e)
	}
	// 轮播图
	const rotationList = ref([])
	const baseUrl = context?.$config.url
	const getRotationList = () => {
		context?.$http({
			url: 'config/list',
			method: 'get',
			params: {
				page: 1,
				limit: 3
			}
		}).then(res => {
			rotationList.value = res.data.data.list
		})
	}
	const menuList = ref([])
	const role = ref('')
	const getMenu = () => {
		let params = {
			page: 1,
			limit: 1,
			sort: 'id',
		}
		context?.$http({
			url: "menu/list",
			method: "get",
			params: params
		}).then(res => {
			context?.$toolUtil.storageSet("menus", res.data.data.list[0].menujson);
		})
		menuList.value = context?.$config.menuList
	}
	const loginClick = () => {
		context?.$toolUtil.storageSet('toPath',window.history.state.current)
		router.push('/login')
	}
	const loginOut = () => {
		context?.$toolUtil.message('退出成功', 'success')
		context?.$toolUtil.storageClear()
		router.replace('/index/home')
		context?.$toolUtil.storageSet('menuIndex','0')
		Token.value = ''
	}
	//菜单跳转
	const menuHandler = (name) => {
		if (name == 'center') {
			name = `${context?.$toolUtil.storageGet('frontSessionTable')}Center`
		}
		router.push(name)
	}
	// 获取用户信息
	const getSession = () =>{
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method:'get'
		}).then(res=>{
			context?.$toolUtil.storageSet('userid',res.data.data.id)
			if(context?.$toolUtil.storageGet('frontSessionTable') == 'xuesheng'){
				context?.$toolUtil.storageSet('headportrait',res.data.data.touxiang)
			}
			if(context?.$toolUtil.storageGet('frontSessionTable') == 'xuesheng'){
				context?.$toolUtil.storageSet("frontName", res.data.data.xueshengzhanghao)
			}
			if(context?.$toolUtil.storageGet('frontSessionTable') == 'jiaozhigong'){
				context?.$toolUtil.storageSet("frontName", res.data.data.jiaoshigonghao)
			}
			if(context?.$toolUtil.storageGet('frontSessionTable') == 'jiaozhigong'){
				context?.$toolUtil.storageSet('headportrait',res.data.data.touxiang)
			}
			if(context?.$toolUtil.storageGet('frontSessionTable') == 'jiashiyuan'){
				context?.$toolUtil.storageSet("frontName", res.data.data.jiashiyuanzhanghao)
			}
		})
	}
	init()
</script>
<style lang="scss" scoped>
	/* 头部 */
	.index_top {
		border: 4px solid rgba(76, 58, 36, 1);
		padding: 0 30px;
		z-index: 1002;
		background: rgba(241, 236, 230, 1);
		display: flex;
		width: 100%;
		border-width: 4px 0;
		justify-content: flex-end;
		align-items: center;
		position: relative;
		box-sizing: border-box;
		height: 64px;
		.index_top_title {
			color: rgba(76, 58, 36, 1);
			left: 25%;
			font-weight: bold;
			width: 50%;
			font-size: 30px;
			position: absolute;
			text-align: center;
		}
		.index_top_right {
			display: flex;
			align-items: center;
			// 天气时间盒子
			.weather_time_view {
				padding: 0 60px 0 0;
				color: rgba(76, 58, 36, 1);
				display: flex;
				// 天气城市盒子
				.weather {
					border: 1px solid rgba(76, 58, 36, 1);
					padding: 0 20px;
					flex-direction: column;
					display: flex;
					font-size: 14px;
					border-width: 0 1px 0 0;
					line-height: 1;
					justify-content: center;
					align-items: center;
					// 城市
					.city {
						padding: 0 0 6px;
					}
					// 天气
					.wea {
					}
				}
				// 时间盒子
				.time {
					padding: 0 20px;
					flex-direction: column;
					display: flex;
					font-size: 14px;
					line-height: 1;
					justify-content: center;
					align-items: center;
					// 日期
					.date {
						padding: 0 0 6px;
					}
					// 时间
					.timer {
					}
				}
			}
		}
		// 登录按钮
		:deep(.el-button--success) {
			color: #fff;
			background: rgba(76, 58, 36, 1);
			border-color: rgba(76, 58, 36, 1);
		}
		:deep(.el-button--success:hover) {
			background: rgba(76, 58, 36, 0.5);
			border-color: rgba(76, 58, 36, 0.5);
		}
		// 登出按钮
		:deep(.el-button--danger) {
			color: #fff;
			background: rgba(76, 58, 36, 1);
			border-color: rgba(76, 58, 36, 1);
		}
		:deep(.el-button--danger:hover) {
			background: rgba(76, 58, 36, 0.5);
			border-color: rgba(76, 58, 36, 0.5);
		}
	}
	// 轮播盒子
	.rotation_view {
		margin: 0 auto;
		width: 100%;
	}
	// 底部
	.bottom_view {
		padding: 20px 0;
		flex-direction: column;
		background: #000;
		display: flex;
		width: 100%;
		justify-content: center;
		align-items: center;
		// 图片
		.bottom_img {
			border-radius: 100%;
			object-fit: cover;
			display: none;
			width: 44px;
			height: 44px;
		}
		// 公司
		.bottom_company {
			margin: 10px 0 0;
			color: #333;
			display: none;
			font-size: 14px;
			line-height: 28px;
		}
		// 备案号
		.bottom_record {
			margin: 10px 0 0;
			color: #fff;
			font-size: 14px;
			line-height: 28px;
		}
		// 联系方式
		.bottom_desc {
			margin: 10px 0 0;
			color: #fff;
			font-size: 14px;
			line-height: 28px;
		}
	}
	
	
	

	.contain_view {
		padding: 0;
		margin: 0 0 0 210px;
		background: rgba(241, 236, 230, 1);
	}
	.el-aside {
		transition: width 0.15s;
		-webkit-transition: width 0.15s;
		-moz-transition: width 0.15s;
		-webkit-transition: width 0.15s;
		-o-transition: width 0.15s;
	}
	// 总盒子
	:deep(.menu_scrollbar) {
		border: 4px solid rgba(76, 58, 36, 1);
		padding: 64px 0 0;
		overflow: hidden;
		top: 0;
		left: 0;
		background: rgba(241, 236, 230, 1);
		width: 210px;
		border-width: 0 4px 0 0;
		position: fixed;
		height: 100%;
		// 菜单盒子
		.menu_view {
			padding: 0 0;
			color: #fff;
			background: transparent;
			height: 100%;

			// 无二级菜单
			.el-menu-item {
				padding: 0 10px;
				color: #666;
				background: transparent;
				line-height: 50px;
				text-align: center;
				height: 50px;
				.iconfont {
					margin: 0 5px 0 0;
					color: inherit;
					width: 34px;
					vertical-align: middle;
					font-size: 20px;
					text-align: center;
				}
			}

			// 无二级悬浮
			.el-menu-item:hover {
				padding: 0 10px;
				color: #fff;
				background: #4C3A24;
				line-height: 50px;
				height: 50px;
			}

			// 无二级选中
			.el-menu-item.is-active {
				padding: 0;
				color: #fff;
				background: #4C3A24;
				line-height: 50px;
				height: 50px;
			}

			// 有二级盒子
			.el-sub-menu {
				cursor: pointer;
				border: 4px solid #4C3A24;
				padding: 0 0;
				color: #333;
				white-space: nowrap;
				background: transparent;
				border-width: 0 0 4px;
				position: relative;

				// 有二级item
				.el-sub-menu__title {
					padding: 0 10px;
					color: #666;
					background: transparent;
					line-height: 50px;
					text-align: center;
					height: 50px;
					.iconfont {
						margin: 0 5px 0 0;
						color: inherit;
						width: 34px;
						vertical-align: middle;
						font-size: 20px;
						text-align: center;
					}
					.el-sub-menu__icon-arrow{
						margin: -3px 0 0 8px;
						color: inherit;
						vertical-align: middle;
						font-size: 12px;
						position: static;
					}
				}

				// 有二级item悬浮
				.el-sub-menu__title:hover {
					padding: 0 10px;
					color: #fff;
					background: #4C3A24;
					line-height: 50px;
					height: 50px;
				}
			}
			//二级选中
			.is-active {
				.el-sub-menu__title {
					padding: 0;
					color: #fff;
					background: #4C3A24;
					line-height: 50px;
					height: 50px;
				}
			}
			// 二级盒子
			.el-menu--inline {
				border: none;
				padding: 0;
				background: #897F75;
				// 二级菜单
				.menu_item_view {
					border: 1px solid rgba(255,255,255,0.5);
					padding: 0 40px;
					color: #fff !important;
					background: transparent;
					border-width: 0 0 2px;
					line-height: 50px;
					text-align: center;
					height: 50px;
				}
				// 二级悬浮
				.menu_item_view:hover {
					padding: 0 40px;
					color: #fff !important;
					background: #4C3A24;
					line-height: 50px;
					height: 50px;
				}
				// 二级选中
				.is-active.menu_item_view {
					padding: 0 40px;
					color: #fff !important;
					background: #4C3A24;
					line-height: 50px;
					height: 50px;
				}
			}
		}
	}
</style>
<style lang="scss">
	.el-popper{
		.el-menu--popup-container {
			.el-menu--popup{
				border: none;
				padding: 0;
				background: #897F75;
				// 二级菜单
				.menu_item_view {
					border: 1px solid rgba(255,255,255,0.5);
					padding: 0 40px;
					color: #fff !important;
					background: transparent;
					border-width: 0 0 2px;
					line-height: 50px;
					text-align: center;
					height: 50px;
				}
				// 二级悬浮
				.menu_item_view:hover {
					padding: 0 40px;
					color: #fff !important;
					background: #4C3A24;
					line-height: 50px;
					height: 50px;
				}
				// 二级选中
				.is-active.menu_item_view {
					padding: 0 40px;
					color: #fff !important;
					background: #4C3A24;
					line-height: 50px;
					height: 50px;
				}
			}
		}
	}
</style>