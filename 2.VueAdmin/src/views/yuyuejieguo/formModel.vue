<template>
	<div>
		<el-dialog v-model="formVisible" :title="formTitle" width="80%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" label-width="$template2.back.add.form.base.labelWidth" :rules="rules">
				<el-row>
					<el-col :span="24">
						<el-form-item label="路线名称" prop="luxianmingcheng">
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.luxianmingcheng?true:false"
								v-model="form.luxianmingcheng" 
								placeholder="请选择路线名称"
								@change="luxianmingchengChange">
								<el-option v-for="(item,index) in luxianmingchengLists" :label="item" :value="item">
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="起点" prop="qidian">
							<el-input class="list_inp" v-model="form.qidian" placeholder="起点"
								 type="text" 								:readonly="!isAdd||disabledForm.qidian?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="24">
						<el-form-item label="停靠站点" prop="tingkaozhandian">
							<el-input class="list_inp" v-model="form.tingkaozhandian" placeholder="停靠站点"
								 type="text" 								:readonly="!isAdd||disabledForm.tingkaozhandian?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="24">
						<el-form-item label="终点" prop="zhongdian">
							<el-input class="list_inp" v-model="form.zhongdian" placeholder="终点"
								 type="text" 								:readonly="!isAdd||disabledForm.zhongdian?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="24">
						<el-form-item label="学生账号" prop="xueshengzhanghao">
							<el-input class="list_inp" v-model="form.xueshengzhanghao" placeholder="学生账号"
								 type="text" 								:readonly="!isAdd||disabledForm.xueshengzhanghao?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="24">
						<el-form-item label="学生姓名" prop="xueshengxingming">
							<el-input class="list_inp" v-model="form.xueshengxingming" placeholder="学生姓名"
								 type="text" 								:readonly="!isAdd||disabledForm.xueshengxingming?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="24">
						<el-form-item label="车辆编号" prop="cheliangbianhao">
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.cheliangbianhao?true:false"
								v-model="form.cheliangbianhao" 
								placeholder="请选择车辆编号"
								@change="cheliangbianhaoChange">
								<el-option v-for="(item,index) in cheliangbianhaoLists" :label="item" :value="item">
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="车牌号" prop="chepaihao">
							<el-input class="list_inp" v-model="form.chepaihao" placeholder="车牌号"
								 type="text" 								:readonly="!isAdd||disabledForm.chepaihao?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="24">
						<el-form-item label="驾驶员账号" prop="jiashiyuanzhanghao">
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.jiashiyuanzhanghao?true:false"
								v-model="form.jiashiyuanzhanghao" 
								placeholder="请选择驾驶员账号"
								@change="jiashiyuanzhanghaoChange">
								<el-option v-for="(item,index) in jiashiyuanzhanghaoLists" :label="item" :value="item">
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="驾驶员姓名" prop="jiashiyuanxingming">
							<el-input class="list_inp" v-model="form.jiashiyuanxingming" placeholder="驾驶员姓名"
								 type="text" 								:readonly="!isAdd||disabledForm.jiashiyuanxingming?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="24">
						<el-form-item label="驾驶员确认状态" prop="jiashiyuanquerenzhuangtai">
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.jiashiyuanquerenzhuangtai?true:false"
								v-model="form.jiashiyuanquerenzhuangtai" 
								placeholder="请选择驾驶员确认状态"
								>
								<el-option v-for="(item,index) in jiashiyuanquerenzhuangtaiLists" :label="item"
									:value="item"
									>
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
				</el-row>
			</el-form>
			<template #footer v-if="isAdd||type=='logistics'||type=='reply'">
				<span class="formModel_btn_box">
					<el-button class="formModel_cancel" @click="closeClick">取消</el-button>
					<el-button class="formModel_confirm" type="primary" @click="save"
						>
						提交
					</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>
<script setup>
	import {
		reactive,
		ref,
		getCurrentInstance,
		nextTick,
		computed,
		defineEmits
	} from 'vue'
	const context = getCurrentInstance()?.appContext.config.globalProperties;	
	const emit = defineEmits(['formModelChange'])
	//基础信息
	const tableName = 'yuyuejieguo'
	const formName = '预约结果'
	//基础信息
	//form表单
	const form = ref({})
	const disabledForm = ref({
		luxianmingcheng : false,
		qidian : false,
		tingkaozhandian : false,
		zhongdian : false,
		xueshengzhanghao : false,
		xueshengxingming : false,
		cheliangbianhao : false,
		chepaihao : false,
		jiashiyuanzhanghao : false,
		jiashiyuanxingming : false,
		jiashiyuanquerenzhuangtai : false,
	})
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
	//表单验证
	//匹配整数
	const validateIntNumber = (rule, value, callback) => {
		if (!value) {
			callback();
		} else if (!context?.$toolUtil.isIntNumer(value)) {
			callback(new Error("请输入整数"));
		} else {
			callback();
		}
	}
	//匹配数字
	const validateNumber = (rule, value, callback) => {
		if(!value){
			callback();
		} else if (!context?.$toolUtil.isNumber(value)) {
			callback(new Error("请输入数字"));
		} else {
			callback();
		}
	}
	//匹配手机号码
	const validateMobile = (rule, value, callback) => {
		if(!value){
			callback();
		} else if (!context?.$toolUtil.isMobile(value)) {
			callback(new Error("请输入正确的手机号码"));
		} else {
			callback();
		}
	}
	//匹配电话号码
	const validatePhone = (rule, value, callback) => {
		if(!value){
			callback();
		} else if (!context?.$toolUtil.isPhone(value)) {
			callback(new Error("请输入正确的电话号码"));
		} else {
			callback();
		}
	}
	//匹配邮箱
	const validateEmail = (rule, value, callback) => {
		if(!value){
			callback();
		} else if (!context?.$toolUtil.isEmail(value)) {
			callback(new Error("请输入正确的邮箱地址"));
		} else {
			callback();
		}
	}
	//匹配身份证
	const validateIdCard = (rule, value, callback) => {
		if(!value){
			callback();
		} else if (!context?.$toolUtil.checkIdCard(value)) {
			callback(new Error("请输入正确的身份证号码"));
		} else {
			callback();
		}
	}
	//匹配网站地址
	const validateUrl = (rule, value, callback) => {
		if(!value){
			callback();
		} else if (!context?.$toolUtil.isURL(value)) {
			callback(new Error("请输入正确的URL地址"));
		} else {
			callback();
		}
	}
	const rules = ref({
		luxianmingcheng: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		qidian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		tingkaozhandian: [
		],
		zhongdian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		xueshengzhanghao: [
		],
		xueshengxingming: [
		],
		cheliangbianhao: [
		],
		chepaihao: [
		],
		jiashiyuanzhanghao: [
		],
		jiashiyuanxingming: [
		],
		jiashiyuanquerenzhuangtai: [
		],
	})
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//路线名称列表
	const luxianmingchengLists = ref([])
	//车辆编号列表
	const cheliangbianhaoLists = ref([])
	//驾驶员账号列表
	const jiashiyuanzhanghaoLists = ref([])
	//驾驶员确认状态列表
	const jiashiyuanquerenzhuangtaiLists = ref([])
	//methods

	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
			luxianmingcheng: '',
			qidian: '',
			tingkaozhandian: '',
			zhongdian: '',
			xueshengzhanghao: '',
			xueshengxingming: '',
			cheliangbianhao: '',
			chepaihao: '',
			jiashiyuanzhanghao: '',
			jiashiyuanxingming: '',
			jiashiyuanquerenzhuangtai: '未确认',
		}
	}
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			form.value = res.data.data
			formVisible.value = true
		})
	}
	const crossRow = ref('')
	const crossTable = ref('')
	const crossTips = ref('')
	const crossColumnName = ref('')
	const crossColumnValue = ref('')
	//初始化
	const init=(formId=null,formType='add',formNames='',row=null,table=null,statusColumnName=null,tips=null,statusColumnValue=null)=>{
		resetForm()
		if(formId){
			id.value = formId
			type.value = formType
		}
		if(formType == 'add'){
			isAdd.value = true
			formTitle.value = '新增' + formName
			formVisible.value = true
		}else if(formType == 'info'){
			isAdd.value = false
			formTitle.value = '查看' + formName
			getInfo()
		}else if(formType == 'edit'){
			isAdd.value = true
			formTitle.value = '修改' + formName
			getInfo()
		}
		else if(formType == 'cross'){
			isAdd.value = true
			formTitle.value = formNames
			// getInfo()
			for(let x in row){
				if(x=='luxianmingcheng'){
					form.value.luxianmingcheng = row[x];
					disabledForm.value.luxianmingcheng = true;
					continue;
				}
				if(x=='qidian'){
					form.value.qidian = row[x];
					disabledForm.value.qidian = true;
					continue;
				}
				if(x=='tingkaozhandian'){
					form.value.tingkaozhandian = row[x];
					disabledForm.value.tingkaozhandian = true;
					continue;
				}
				if(x=='zhongdian'){
					form.value.zhongdian = row[x];
					disabledForm.value.zhongdian = true;
					continue;
				}
				if(x=='xueshengzhanghao'){
					form.value.xueshengzhanghao = row[x];
					disabledForm.value.xueshengzhanghao = true;
					continue;
				}
				if(x=='xueshengxingming'){
					form.value.xueshengxingming = row[x];
					disabledForm.value.xueshengxingming = true;
					continue;
				}
				if(x=='cheliangbianhao'){
					form.value.cheliangbianhao = row[x];
					disabledForm.value.cheliangbianhao = true;
					continue;
				}
				if(x=='chepaihao'){
					form.value.chepaihao = row[x];
					disabledForm.value.chepaihao = true;
					continue;
				}
				if(x=='jiashiyuanzhanghao'){
					form.value.jiashiyuanzhanghao = row[x];
					disabledForm.value.jiashiyuanzhanghao = true;
					continue;
				}
				if(x=='jiashiyuanxingming'){
					form.value.jiashiyuanxingming = row[x];
					disabledForm.value.jiashiyuanxingming = true;
					continue;
				}
				if(x=='jiashiyuanquerenzhuangtai'){
					form.value.jiashiyuanquerenzhuangtai = row[x];
					disabledForm.value.jiashiyuanquerenzhuangtai = true;
					continue;
				}
			}
			if(row){
				crossRow.value = row
			}
			if(table){
				crossTable.value = table
			}
			if(tips){
				crossTips.value = tips
			}
			if(statusColumnName){
				crossColumnName.value = statusColumnName
			}
			if(statusColumnValue){
				crossColumnValue.value = statusColumnValue
			}
			form.value.jiashiyuanquerenzhuangtai='未确认'
			formVisible.value = true
		}

		context?.$http({
			url: `${context?.$toolUtil.storageGet('sessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
			if(json.hasOwnProperty('xueshengzhanghao')&& context?.$toolUtil.storageGet("role")!="管理员"){
				form.value.xueshengzhanghao = json.xueshengzhanghao
				disabledForm.value.xueshengzhanghao = true;
			}
			if(json.hasOwnProperty('xueshengxingming')&& context?.$toolUtil.storageGet("role")!="管理员"){
				form.value.xueshengxingming = json.xueshengxingming
				disabledForm.value.xueshengxingming = true;
			}
		})
		context?.$http({
			url: `option/xianluxinxi/xianlumingcheng`,
			method: 'get'
		}).then(res=>{
			luxianmingchengLists.value = res.data.data
		})
		context?.$http({
			url: `option/cheliangxinxi/cheliangbianhao`,
			method: 'get'
		}).then(res=>{
			cheliangbianhaoLists.value = res.data.data
		})
		//由上级字段带出不可改
		disabledForm.value.chepaihao = true;
		context?.$http({
			url: `option/jiashiyuan/jiashiyuanzhanghao`,
			method: 'get'
		}).then(res=>{
			jiashiyuanzhanghaoLists.value = res.data.data
		})
		//由上级字段带出不可改
		disabledForm.value.jiashiyuanxingming = true;
		jiashiyuanquerenzhuangtaiLists.value = "已确认,未确认".split(',')
	}
	//初始化
	//声明父级调用
	defineExpose({
		init
	})
	//关闭
	const closeClick = () => {
		formVisible.value = false
	}
	const luxianmingchengChange=()=>{
		context?.$http({
			url: `follow/xianluxinxi/xianlumingcheng?columnValue=` + form.value.luxianmingcheng,
			method: 'get'
		}).then(res=>{
			if(res.data.data.chepaihao){
				form.value.chepaihao = res.data.data.chepaihao
			}
			if(res.data.data.jiashiyuanxingming){
				form.value.jiashiyuanxingming = res.data.data.jiashiyuanxingming
			}
		})
	}
	const cheliangbianhaoChange=()=>{
		context?.$http({
			url: `follow/cheliangxinxi/cheliangbianhao?columnValue=` + form.value.cheliangbianhao,
			method: 'get'
		}).then(res=>{
			if(res.data.data.chepaihao){
				form.value.chepaihao = res.data.data.chepaihao
			}
			if(res.data.data.jiashiyuanxingming){
				form.value.jiashiyuanxingming = res.data.data.jiashiyuanxingming
			}
		})
	}
	const jiashiyuanzhanghaoChange=()=>{
		context?.$http({
			url: `follow/jiashiyuan/jiashiyuanzhanghao?columnValue=` + form.value.jiashiyuanzhanghao,
			method: 'get'
		}).then(res=>{
			if(res.data.data.chepaihao){
				form.value.chepaihao = res.data.data.chepaihao
			}
			if(res.data.data.jiashiyuanxingming){
				form.value.jiashiyuanxingming = res.data.data.jiashiyuanxingming
			}
		})
	}
	//富文本
	const editorChange = (e,name) =>{
		form.value[name] = e
	}
	//提交
	const save=()=>{
		var table = crossTable.value
		var objcross = JSON.parse(JSON.stringify(crossRow.value))
		let crossUserId = ''
		let crossRefId = ''
		let crossOptNum = ''
		if(type.value == 'cross'){
			if(crossColumnName.value!=''){
				if(!crossColumnName.value.startsWith('[')){
					for(let o in objcross){
						if(o == crossColumnName.value){
							objcross[o] = crossColumnValue.value
						}
					}
					//修改跨表数据
					changeCrossData(objcross)
				}else{
					crossUserId = context?.$toolUtil.storageGet('userid')
					crossRefId = objcross['id']
					crossOptNum = crossColumnName.value.replace(/\[/,"").replace(/\]/,"")
				}
			}
		}
		formRef.value.validate((valid)=>{
			if(valid){
				if(crossUserId&&crossRefId){
					form.value.crossuserid = crossUserId
					form.value.crossrefid = crossRefId
					let params = {
						page: 1,
						limit: 1000, 
						crossuserid:form.value.crossuserid,
						crossrefid:form.value.crossrefid,
					}
					context?.$http({
						url: `${tableName}/page`,
						method: 'get', 
						params: params 
					}).then(res=>{
						if(res.data.data.total>=crossOptNum){
							context?.$toolUtil.message(`${crossTips.value}`,'error')
							return false
						}else{
							context?.$http({
								url: `${tableName}/${!form.value.id ? "save" : "update"}`,
								method: 'post', 
								data: form.value 
							}).then(res=>{
								context?.$toolUtil.message(`操作成功`,'success',()=>{
									formVisible.value = false
									emit('formModelChange')
								})
							})
						}
					})
				}else{
					context?.$http({
						url: `${tableName}/${!form.value.id ? "save" : "update"}`,
						method: 'post', 
						data: form.value 
					}).then(res=>{
						context?.$toolUtil.message(`操作成功`,'success',()=>{
							formVisible.value = false
							emit('formModelChange')
						})
					})
				}
			}
		})
	}
	//修改跨表数据
	const changeCrossData=(row)=>{
		context?.$http({
			url: `${crossTable.value}/update`,
			method: 'post',
			data: row
		}).then(res=>{})
	}
</script>
<style lang="scss" scoped>
	// 表单
	.formModel_form{
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
			//label
			.el-form-item__label {
			 color: #666;
			 background: none;
			 font-weight: 500;
			 display: block;
			 width: 150px;
			 text-align: right;
			 min-width: 150px;
			}
			// 内容盒子
			.el-form-item__content {
				display: flex;
				width: calc(100% - 120px);
				justify-content: flex-start;
				align-items: center;
				flex-wrap: wrap;
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
				// 下拉框
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
								padding: 0;
							}
							.is-focus {
								box-shadow: none !important;
							}
						}
					}
				}
			}
		}
	}
	// 按钮盒子
	.formModel_btn_box {
		display: flex;
		width: 100%;
		justify-content: center;
		align-items: center;
		.formModel_cancel {
			border: 1px solid #d43f3a;
			cursor: pointer;
			border-radius: 3px;
			padding: 0 24px;
			margin: 0 20px 0 0;
			outline: none;
			color: #fff;
			background: rgba(217, 83, 79, 0.45);
			width: auto;
			font-size: 14px;
			min-width: 100px;
			height: 36px;
		}
		.formModel_cancel:hover {
		}
		
		.formModel_confirm {
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
		.formModel_confirm:hover {
		}
	}
</style>