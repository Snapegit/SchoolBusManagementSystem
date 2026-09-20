<template>
	<div>
		<div class="login_view">
			<div class="outTitle_view">
				<el-image class="outTitle_img" src="http://clfile.zggen.cn/20230926/8fa3f48d53694f27b4bcc57e99ae5a99.png" fit="cover"></el-image>
				<div class="outTilte">校车管理信息系统登录</div>
			</div>
			<el-form :model="loginForm" class="login_form">
				<div class="tabView" v-if="userList.length>1">
					<div class="tab" :style="{'width':`calc(100% / ${userList.length})`}"
						:class="loginForm.role==item.roleName?'tabActive':''" v-for="(item,index) in userList"
						:key="index" @click="tabClick(item.roleName)">{{item.roleName}}</div>
				</div>
				<div class="list_item" v-if="loginType==1">
					<div class="list_label">
						账号：
					</div>
					<input class="list_inp" v-model="loginForm.username" placeholder="请输入账号" />
				</div>
				<div class="list_item" v-if="loginType==1">
					<div class="list_label">
						密码：
					</div>
					<input class="list_inp" v-model="loginForm.password" type="password" placeholder="请输入密码" @keydown.enter.native="handleLogin" />
				</div>
				<div class="btn_view">
					<el-button class="login" v-if="loginType==1" type="success" @click="handleLogin">登录</el-button>
					<el-button class="register" type="primary" @click="handleRegister('xuesheng')">注册学生</el-button>
				</div>
			</el-form>
		</div>
	</div>
</template>
<script setup>
	import {
		ref,
		getCurrentInstance,
		nextTick,
		onMounted,
	} from "vue";
	import menu from '@/utils/menu'
	const userList = ref([])
	const menus = ref([])
	const loginForm = ref({
		role: '',
		username: '',
		password: ''
	})
	const tableName = ref('')
	const loginType = ref(1)
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//注册
    const handleRegister = (tableName) => {
    	context?.$router.push(`/${tableName}Register`)
    	
    }
	//登录用户tab切换
	const tabClick = (role) => {
		loginForm.value.role = role
	}
	const handleLogin = () => {
		if (!loginForm.value.username) {
			context?.$toolUtil.message('请输入用户名', 'error')
			
			return;
		}
		if (!loginForm.value.password) {
			context?.$toolUtil.message('请输入密码', 'error')
			
			return;
		}
		if (userList.value.length > 1) {
			if (!loginForm.value.role) {
				context?.$toolUtil.message('请选择角色', 'error')
				verifySlider.reset()
				return;
			}
			for (let i = 0; i < menus.value.length; i++) {
				if (menus.value[i].roleName == loginForm.value.role) {
					tableName.value = menus.value[i].tableName;
				}
			}
		} else {
			tableName.value = userList.value[0].tableName;
			loginForm.value.role = userList.value[0].roleName;
		}
		login()
	}
	const login = () => {
		context?.$http({
			url: `${tableName.value}/login?username=${loginForm.value.username}&password=${loginForm.value.password}`,
			method: 'post'
		}).then(res => {
			context?.$toolUtil.storageSet("frontToken", res.data.token);
			context?.$toolUtil.storageSet("frontRole", loginForm.value.role);
			context?.$toolUtil.storageSet("frontSessionTable", tableName.value);
			let path = context?.$toolUtil.storageGet('toPath')
			if (path) {
				context?.$router.push(path)
				context?.$toolUtil.storageRemove('toPath')
				return
			}
			context?.$router.push(`/index/${tableName.value}Center`)
		},err=>{
		})
	}
	//获取菜单
	const getMenu= async ()=> {
		let arr = menu.list()
		if(!arr){
			let res = await context?.$http.get("menu/list")
			context?.$toolUtil.storageSet("menus", res.data.data.list[0].menujson);
			arr = JSON.parse(res.data.data.list[0].menujson)
		}
		menus.value = arr
		for (let i = 0; i < menus.value.length; i++) {
			if (menus.value[i].hasFrontLogin=='是') {
				userList.value.push(menus.value[i])
			}
		}
    }
	//初始化
	const init = async () => {
		await getMenu();
		loginForm.value.role = userList.value[0].roleName
	}
	onMounted(()=>{
		init()
	})
</script>

<style lang="scss" scoped>
	.login_view {
		background-repeat: no-repeat;
		flex-direction: column;
		background-size: cover !important;
		background: url(http://clfile.zggen.cn/20230926/47efc20649f24902b92ea0dcdaf73d10.png);
		display: flex;
		width: 100%;
		min-height: 100vh;
		justify-content: flex-start;
		align-items: flex-start;
		position: relative;
		background-position: center center;
		// 标题盒子
		.outTitle_view {
			border: 4px solid #948E86;
			padding: 26px 0 32px 5%;
			margin: 0 0 0 64px;
			top: 5px;
			display: flex;
			width: 80%;
			border-width: 0 0 4px;
			justify-content: flex-start;
			align-items: center;
			position: fixed;
			// 标题图片
			.outTitle_img {
				width: 200px;
				height: 40px;
			}
			.outTilte {
				margin: 0 0 0 20px;
				color: #4C3A24;
				letter-spacing: 5px;
				width: 80%;
				font-size: 36px;
			}
		}
		// 表单盒子
		.login_form {
			border: 4px solid #948E86;
			padding: 200px 20px;
			margin: 1px 0 8px 60px;
			display: flex;
			width: 43%;
			border-width: 4px 0 4px 4px;
			justify-content: center;
			position: relative;
			flex-wrap: wrap;
			height: 99vh;
		}
		// item盒子
		.list_item {
			margin: 10px 0;
			display: flex;
			width: 70%;
			justify-content: center;
			align-items: center;
			// label
			.list_label {
				color: #4C3A24;
				width: 90px;
				font-size: 14px;
				text-align: center;
			}
			// 输入框
			.list_inp {
				border: 1px solid #4C3A24;
				padding: 0 10px;
				background: transparent;
				width: calc(100% - 90px);
				outline-offset: 4px;
				line-height: 36px;
				height: 36px;
			}
		}
		// 用户类型样式
		.tabView{
			display: flex;
			width: 70%;
			font-size: 18px;
			justify-content: space-between;
			align-items: center;
			// 默认样式
			.tab{
				cursor: pointer;
				border: 1px solid #4C3A24;
				border-radius: 0;
				margin: 0 1px;
				color: #4C3A24;
				background: transparent;
				font-weight: bold;
				border-width: 1px;
				line-height: 40px;
				box-sizing: border-box;
				text-align: center;
				height: 40px;
			}
			// 选中样式
			.tabActive{
				cursor: pointer;
				border-radius: 0;
				margin: 0 1px;
				color: #fff;
				background: #4C3A24;
				font-weight: bold;
				line-height: 40px;
				text-align: center;
				height: 40px;
			}
		}
		// 按钮盒子
		.btn_view {
			padding: 20px 0 0;
			display: flex;
			width: 70%;
			justify-content: center;
			align-items: center;
			flex-wrap: wrap;
			// 登录
			.login {
				border: 0;
				cursor: pointer;
				border-radius: 0;
				padding: 0 24px;
				margin: 0 0 10px;
				outline: none;
				color: #fff;
				background: #4C3A24;
				width: 100%;
				font-size: 18px;
				height: 44px;
			}
			// 注册
			.register {
				border: 0;
				cursor: pointer;
				border-radius: 0;
				padding: 0 24px;
				margin: 0 0 10px;
				outline: none;
				color: #fff;
				background: #897F75;
				width: 100%;
				font-size: 18px;
				height: 44px;
			}
		}
	}

</style>