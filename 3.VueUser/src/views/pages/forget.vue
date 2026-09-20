<template>
	<div>
		<div class="forget_view">
			<div class="outTitle_view">
				<el-image class="outTitle_img" src="http://clfile.zggen.cn/20230928/4c610f871a994351938a0be4b6faf9d5.png" fit="cover"></el-image>
				<div class="outTilte">{{projectName}}注册</div>
			</div>
			<el-form :model="forgetForm" class="forget_box">
				<div class="tab_view">
					<div class="tab" :class="pageType==1?'tab_active':''">找回密码</div>
					<div class="tab" :class="pageType==2?'tab_active tab_active1':''">输入密保</div>
					<div class="tab" :class="pageType==3?'tab_active tab_active1 tab_active2':''">重置密码</div>
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
	const pageType = ref(1)
	const forgetForm = ref({})
	const userForm = ref({})
	//返回登录
	const close = () => {
		context?.$router.push({
			path: "/login"
		});
	}
</script>

<style lang="scss" scoped>
	.forget_view {
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
			padding: 29px 0;
			margin: 0 0 0 60px;
			display: flex;
			width: 43%;
			border-width: 0 0 4px;
			justify-content: space-around;
			align-items: center;
			position: fixed;
			// 标题图片
			.outTitle_img {
				width: 200px;
				height: 40px;
			}
			.outTilte {
				color: #4C3A24;
				letter-spacing: 5px;
				font-size: 46px;
			}
		}
		// 表单盒子
		.forget_box {
			border: 4px solid #948E86;
			border-radius: 0;
			padding: 200px 20px;
			margin: 1px 0 8px 60px;
			display: flex;
			width: 43%;
			border-width: 4px 0 4px 4px;
			justify-content: center;
			position: relative;
			flex-wrap: wrap;
			height: 99vh;
			// tab
			// 盒子
			.tab_view {
				padding: 0 0 0px;
				display: flex;
				width: 80%;
				align-items: center;
				// 默认样式
				.tab {
					border: 1px solid #4C3A24;
					padding: 0;
					margin: 0 1px;
					font-weight: bold;
					width: calc(100% / 3);
					font-size: 18px;
					line-height: 40px;
					box-sizing: border-box;
					text-align: center;
					height: 40px;
				}
				// 选中样式一
				.tab_active {
					color: #fff;
					background: #4C3A24;
				}
				// 选中样式二
				.tab_active1 {
					color: #fff;
					background: #4C3A24;
				}
				// 选中样式三
				.tab_active2 {
					color: #fff;
					background: #4C3A24;
				}
			}
			// item
			.list_item {
				margin: 0;
				display: flex;
				width: 80%;
				justify-content: flex-start;
				align-items: center;
				// label
				.item_label {
					width: 90px;
					font-size: 14px;
					box-sizing: border-box;
					text-align: center;
				}
				// 输入框
				:deep(.list_inp) {
					border: 1px solid #4C3A24;
					padding: 0 10px;
					background: transparent;
					width: calc(100% - 120px);
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
				//下拉框样式
				:deep(.list_sel) {
					border: 1px solid #4C3A24;
					border-radius: 0;
					padding: 0 10px;
					background: transparent;
					width: calc(100% - 120px);
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
			}
			// 按钮盒子
			.list_btn {
				margin: 20px 0 0;
				display: flex;
				width: 100%;
				justify-content: center;
				align-items: center;
				flex-wrap: wrap;
				// 获取密保
				:deep(.el-button--success) {
					border: 0;
					cursor: pointer;
					border-radius: 0;
					padding: 0 24px;
					margin: 0 10px 0 0;
					outline: none;
					color: #fff;
					background: #4C3A24;
					width: 65%;
					font-size: 16px;
					height: 40px;
				}
				// 获取密保悬浮
				:deep(.el-button--success:hover) {
					background: rgba(76, 58, 36, 0.5);
					width: 70%;
					font-size: 18px;
				}
				// 确认密保
				:deep(.el-button--primary) {
					border: 0;
					cursor: pointer;
					border-radius: 0;
					padding: 0 24px;
					margin: 0 10px 0 0;
					outline: none;
					color: #fff;
					background: #4C3A24;
					width: 65%;
					font-size: 16px;
					height: 40px;
				}
				// 确认密保悬浮
				:deep(.el-button--primary:hover) {
					background: rgba(76, 58, 36, 0.5);
					width: 70%;
					font-size: 18px;
				}
				// 重置密码
				:deep(.el-button--warning) {
					border: 0;
					cursor: pointer;
					border-radius: 0;
					padding: 0 24px;
					margin: 0 10px 0 0;
					outline: none;
					color: #fff;
					background: rgba(76, 58, 36, 1);
					width: 65%;
					font-size: 16px;
					height: 40px;
				}
				// 重置密码悬浮
				:deep(.el-button--warning:hover) {
					background: rgba(76, 58, 36, 0.5);
					width: 70%;
					font-size: 18px;
				}
				.r-login {
					cursor: pointer;
					border: 4px solid rgba(148, 142, 134, 1);
					padding: 0;
					color: rgba(76, 58, 36, 1);
					bottom: 0;
					font-weight: bold;
					font-size: 18px;
					line-height: 110px;
					left: 0;
					width: 100%;
					border-width: 4px 0 0;
					position: absolute;
					text-align: center;
					height: 110px;
				}
			}
		}
	}
</style>
