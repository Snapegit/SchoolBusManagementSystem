
<template>
	<div>
		<div class="app-contain">
			<el-form class="userinfo_form" ref="userinfoFormRef" :model="form" label-width="$template2.back.add.form.base.labelWidth">
				<el-row>
					<el-col :span="24">
						<el-form-item label="驾驶员账号" prop="jiashiyuanzhanghao">
							<el-input class="list_inp" v-model="user.jiashiyuanzhanghao" readonly placeholder="驾驶员账号" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="驾驶员密码" prop="jiashiyuanmima">
							<el-input class="list_inp" v-model="user.jiashiyuanmima" readonly placeholder="驾驶员密码" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="驾驶员姓名" prop="jiashiyuanxingming">
							<el-input class="list_inp" v-model="user.jiashiyuanxingming"  placeholder="驾驶员姓名" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="性别" prop="xingbie">
							<el-select 
								class="list_sel" 
								v-model="user.xingbie" 
								placeholder="请选择性别"
								>
								<el-option v-for="item in jiashiyuanxingbieLists" :label="item" :value="item"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="联系电话" prop="lianxidianhua">
							<el-input class="list_inp" v-model="user.lianxidianhua"  placeholder="联系电话" clearable />
						</el-form-item>
					</el-col>
					<span class="userinfo_form_btn_box">
						<el-button class='userinfo_confirm' type="primary" @click="onSubmit">保存</el-button>
					</span>
				</el-row>
			</el-form>
		</div>
	</div>
</template>

<script setup>
	import { isNumber,isIntNumer,isEmail,isMobile,isPhone,isURL,checkIdCard } from "@/utils/toolUtil";
	import {
		reactive,
		ref,
		getCurrentInstance
	} from 'vue'
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const tableName = ref('jiashiyuan')
	const user = ref({})
	const jiashiyuanxingbieLists = ref([])
	const init = () => {
		jiashiyuanxingbieLists.value = "男,女".split(',')
	}
	const onSubmit = () => {
		if((!user.value.jiashiyuanzhanghao)){
			context?.$toolUtil.message(`驾驶员账号不能为空`,'error')
			return false
		}
		if((!user.value.jiashiyuanmima)){
			context?.$toolUtil.message(`驾驶员密码不能为空`,'error')
			return false
		}
		if((!user.value.jiashiyuanxingming)){
			context?.$toolUtil.message(`驾驶员姓名不能为空`,'error')
			return false
		}
		if((user.value.lianxidianhua)&&(!context?.$toolUtil.isMobile(user.value.lianxidianhua))){
			context?.$toolUtil.message(`联系电话应输入手机格式`,'error')
			return false
		}
		context?.$http({
			url: `${tableName.value}/update`,
			method: 'post',
			data: user.value
		}).then(res => {
			context?.$toolUtil.message('修改成功','success')
		})

	}
	const getInfo = () => {
		context?.$http({
			url: `${tableName.value}/session`,
			method: 'get'
		}).then(res => {
			user.value = res.data.data
			init()
		})
	}
	getInfo()
</script>

<style lang="scss" scoped>
	// 表单
	.userinfo_form {
		border: 1px solid rgba(254, 182, 203, 0.5);
		border-radius: 0px;
		padding: 40px 30px;
		margin: 0;
		background: #fff;
		// form item
		:deep(.el-form-item) {
			margin: 0 150px 20px 0;
			background: none;
			display: flex;
			// 内容盒子
			.el-form-item__content{
				display: flex;
				width: calc(100% - 120px);
				justify-content: flex-start;
				align-items: center;
				flex-wrap: wrap;
			}
			// 输入框
			.list_inp {
				border: 0px solid rgba(255, 255, 255, 0.25);
				border-radius: 0px;
				padding: 0 10px;
				color: #666;
				background: rgba(0, 0, 0, 0.1);
				width: auto;
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
			.list_sel {
				border: 1px solid rgba(255, 255, 255, 0.25);
				border-radius: 0px;
				padding: 0 10px;
				color: #666;
				background: rgba(0, 0, 0, 0.1);
				width: auto;
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
						}
						.is-focus {
							box-shadow: none !important;
						}
					}
				}
			}

		}
		// 按钮盒子
		.userinfo_form_btn_box {
			display: flex;
			width: 100%;
			justify-content: center;
			align-items: center;
			// 确定按钮
			.userinfo_confirm {
				border: 1px solid #357ebd;
				cursor: pointer;
				border-radius: 3px;
				padding: 0 24px;
				margin: 0 20px 0 0;
				outline: none;
				color: #fff;
				background: rgba(66, 139, 202, 0.55);
				width: auto;
				font-size: 14px;
				min-width: 100px;
				height: 36px;
			}
			// 确定按钮-悬浮
			.userinfo_confirm:hover {
			}
		}
	}
</style>
