<template>
	<div>
		<div class="register_view">
			<div class="outTitle_view">
				<el-image class="outTitle_img" src="http://clfile.zggen.cn/20230928/b6e1ed1c5cfc4104863fc6a7f410d361.png" fit="cover"></el-image>
				<div class="outTilte">{{projectName}}注册</div>
			</div>
			<el-form :model="registerForm" class="register_form">
				<div class="list_item">
					<div class="list_label">驾驶员账号：</div>
					<input class="list_inp"
					 v-model="registerForm.jiashiyuanzhanghao" 
					 placeholder="请输入驾驶员账号"
					 type="text"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">驾驶员密码：</div>
					<input class="list_inp"
					 v-model="registerForm.jiashiyuanmima" 
					 placeholder="请输入驾驶员密码"
					 type="password"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">确认驾驶员密码：</div>
					<input class="list_inp" v-model="registerForm.jiashiyuanmima2" type="password" placeholder="请输入确认驾驶员密码" />
				</div>
				<div class="list_item">
					<div class="list_label">驾驶员姓名：</div>
					<input class="list_inp"
					 v-model="registerForm.jiashiyuanxingming" 
					 placeholder="请输入驾驶员姓名"
					 type="text"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">性别：</div>
					<el-select 
						class="list_sel" 
						v-model="registerForm.xingbie" 
						placeholder="请选择性别"
						>
						<el-option v-for="item in jiashiyuanxingbieLists" :label="item" :value="item"></el-option>
					</el-select>
				</div>
				<div class="list_item">
					<div class="list_label">联系电话：</div>
					<input class="list_inp"
					 v-model="registerForm.lianxidianhua" 
					 placeholder="请输入联系电话"
					 type="text"
					 />
				</div>
				<div class="list_btn">
					<el-button class="register" type="success" @click="handleRegister">注册</el-button>
					<div class="r-login" @click="close">已有账号，直接登录</div>
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
	} from 'vue';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const projectName = context?.$project.projectName
	//获取注册类型
	import { useRoute } from 'vue-router';
	const route = useRoute()
	const tableName = ref('jiashiyuan')
	
	//公共方法
	const getUUID=()=> {
		return new Date().getTime();
	}
	
	const registerForm = ref({
        xingbie: '',
	})
	const jiashiyuanxingbieLists = ref([])
	const init=()=>{
		jiashiyuanxingbieLists.value = "男,女".split(',')
	}
	// 多级联动参数
	//注册按钮
	const handleRegister = () => {
		let url = tableName.value +"/register";
		if((!registerForm.value.jiashiyuanzhanghao)){
			context?.$toolUtil.message(`驾驶员账号不能为空`,'error')
			return false
		}
		if((!registerForm.value.jiashiyuanmima)){
			context?.$toolUtil.message(`驾驶员密码不能为空`,'error')
			return false
		}
		if(registerForm.value.jiashiyuanmima!=registerForm.value.jiashiyuanmima2){
			context?.$toolUtil.message('两次密码输入不一致','error')
			return false
		}
		if((!registerForm.value.jiashiyuanxingming)){
			context?.$toolUtil.message(`驾驶员姓名不能为空`,'error')
			return false
		}
		if(registerForm.value.lianxidianhua&&(!context?.$toolUtil.isMobile(registerForm.value.lianxidianhua))){
			context?.$toolUtil.message(`联系电话应输入手机格式`,'error')
			return false
		}
		
		context?.$http({
			url:url,
			method:'post',
			data:registerForm.value
		}).then(res=>{
			context?.$toolUtil.message('注册成功','success', obj=>{
				context?.$router.push({
					path: "/login"
				});
			})
		})
	}
	//返回登录
	const close = () => {
		context?.$router.push({
			path: "/login"
		});
	}
	init()
</script>
<style lang="scss" scoped>
	.register_view {
		background-repeat: no-repeat;
		flex-direction: column;
		background-size: cover;
		background: url(http://clfile.zggen.cn/20230928/c5da997a7e69442f99d5628bbde79cef.png);
		display: flex;
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
			z-index: 999;
			top: 5px;
			background: rgba(241,236,230,1);
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
		.register_form {
			border: 4px solid #948E86;
			border-radius: 0;
			padding: 150px 20px;
			margin: 1px 0 8px 60px;
			display: flex;
			width: 43%;
			border-width: 4px 0 4px 4px;
			overflow-y: scroll;
			justify-content: center;
			position: relative;
			flex-wrap: wrap;
			height: 99vh;
		}
		// item盒子
		.list_item {
			margin: 10px 0;
			display: flex;
			width: 90%;
			justify-content: flex-start;
			align-items: flex-start;
			// label
			.list_label {
				color: #4C3A24;
				width: 90px;
				font-size: 14px;
				box-sizing: border-box;
				text-align: right;
			}
			// 输入框
			:deep(.list_inp) {
				border: 1px solid #4C3A24;
				padding: 0 10px;
				background: transparent;
				width: calc(100% - 150px);
				line-height: 36px;
				box-sizing: border-box;
				height: 36px;
				//去掉默认样式
				.el-input__wrapper{
					border: none;
					box-shadow: none;
					background: none;
					border-radius: 0;
					height: 100%;
					padding: 0;
				}
				.is-focus {
					box-shadow: none !important;
				}
			}
		}
		//下拉框样式
		:deep(.list_sel) {
			border: 1px solid #4C3A24;
			border-radius: 0;
			padding: 0 10px;
			width: calc(100% - 150px);
			line-height: 36px;
			box-sizing: border-box;
			//去掉默认样式
			.select-trigger{
				height: 100%;
				.el-input{
					height: 100%;
					.el-input__wrapper{
						border: none;
						box-shadow: none;
						background: none;
						border-radius: 0;
						height: 100%;
						padding: 0;
					}
					.is-focus {
						box-shadow: none !important;
					}
				}
			}
		}
		//按钮盒子
		.list_btn {
			margin: 20px 0 0;
			display: flex;
			width: 100%;
			justify-content: center;
			align-items: center;
			flex-wrap: wrap;
			//注册按钮
			.register {
					border: none;
					border-radius: 0;
					color: #fff;
					background: #4C3A24;
					width: 70%;
					font-size: 18px;
					height: 40px;
			}
			//注册按钮悬浮样式
			.register:hover {
				border: none;
				border-radius: 0;
				background: rgba(76, 58, 36, 0.5);
				width: 80%;
				font-size: 20px;
				height: 40px;
			}
			//已有账号
			.r-login {
				cursor: pointer;
				border: 0px solid #948E86;
				padding: 0;
				color: #4C3A24;
				font-weight: bold;
				width: 100%;
				font-size: 16px;
				border-width: 4px 0 0;
				line-height: 80px;
				text-align: center;
				height: 80px;
			}
		}
	}
</style>