
<template>
	<div class="app-contain" :style='{"width":"98%","padding":"0","margin":"10px auto","position":"relative","background":"TRANSPARENT"}'>
		<div class="bread_view">
			<el-breadcrumb separator="Ξ" class="breadcrumb">
				<el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
				<el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
			</el-breadcrumb>
		</div>
		<el-form ref="formRef" :model="form" class="add_form" label-width="120px" :rules="rules">
			<el-row>
				<el-col :span="24">
					<el-form-item label="线路名称" prop="xianlumingcheng">
						<el-input class="list_inp" v-model="form.xianlumingcheng" placeholder="线路名称"
							 type="text" 							:readonly="!isAdd||disabledForm.xianlumingcheng?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="线路图片" prop="xianlutupian">
						<uploads
							:disabled="!isAdd||disabledForm.xianlutupian?true:false"
							action="file/upload" 
							tip="请上传线路图片" 
							:limit="3" 
							style="width: 100%;text-align: left;"
							:fileUrls="form.xianlutupian?form.xianlutupian:''" 
							@change="xianlutupianUploadSuccess">
						</uploads>
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item label="起点" prop="qidian">
						<el-input class="list_inp" v-model="form.qidian" placeholder="起点"
							 type="text" 							:readonly="!isAdd||disabledForm.qidian?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="停靠站点" prop="tingkaozhandian">
						<el-input class="list_inp" v-model="form.tingkaozhandian" placeholder="停靠站点"
							 type="text" 							:readonly="!isAdd||disabledForm.tingkaozhandian?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="终点" prop="zhongdian">
						<el-input class="list_inp" v-model="form.zhongdian" placeholder="终点"
							 type="text" 							:readonly="!isAdd||disabledForm.zhongdian?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="路线详情" prop="luxianxiangqing">
						<editor class="list_editor" :value="form.luxianxiangqing" placeholder="请输入路线详情" :readonly="!isAdd||disabledForm.luxianxiangqing?true:false"
							@change="(e)=>editorChange(e,'luxianxiangqing')"></editor>
					</el-form-item>
				</el-col>
			</el-row>
			<div class="formModel_btn_box">
				<el-button class="formModel_cancel" @click="backClick">取消</el-button>
				<el-button class="formModel_confirm" @click="save"
					type="success"
					>
					保存
				</el-button>
			</div>
		</el-form>
	</div>
</template>
<script setup>
	import {
		ref,
		getCurrentInstance,
		watch,
		onUnmounted,
		onMounted,
		nextTick,
		computed
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const route = useRoute()
	const router = useRouter()
	//基础信息
	const tableName = 'xianluxinxi'
	const formName = '线路信息'
	//基础信息
	const breadList = ref([{
		name: formName
	}])
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//form表单
	const form = ref({
		xianlumingcheng: '',
		xianlutupian: '',
		qidian: '',
		tingkaozhandian: '',
		zhongdian: '',
		luxianxiangqing: '',
		storeupnum: '0',
		clicktime: '',
	})
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	const disabledForm = ref({
		xianlumingcheng : false,
		xianlutupian : false,
		qidian : false,
		tingkaozhandian : false,
		zhongdian : false,
		luxianxiangqing : false,
		storeupnum : false,
		clicktime : false,
	})
	const isAdd = ref(false)
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
		xianlumingcheng: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		xianlutupian: [
		],
		qidian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		tingkaozhandian: [
		],
		zhongdian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		luxianxiangqing: [
		],
		storeupnum: [
			{ validator: validateIntNumber, trigger: 'blur' },
		],
		clicktime: [
		],
	})
	//线路图片上传回调
	const xianlutupianUploadSuccess=(e)=>{
		form.value.xianlutupian = e
	}
	//methods

	//methods
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			res.data.data.luxianxiangqing = res.data.data.luxianxiangqing.replace(reg,'../../../cl39466158/file');
			form.value = res.data.data
		})
	}
	const crossRow = ref('')
	const crossTable = ref('')
	const crossTips = ref('')
	const crossColumnName = ref('')
	const crossColumnValue = ref('')
	//初始化
	const init = (formId=null,formType='add',formNames='',row=null,table=null,statusColumnName=null,tips=null,statusColumnValue=null) => {
		if(formId){
			id.value = formId
			type.value = formType
		}
		if(formType == 'add'){
			isAdd.value = true
		}else if(formType == 'info'){
			isAdd.value = false
			getInfo()
		}else if(formType == 'edit'){
			isAdd.value = true
			getInfo()
		}
		else if(formType == 'cross'){
			isAdd.value = true
			// getInfo()
			for(let x in row){
				if(x=='xianlumingcheng'){
					form.value.xianlumingcheng = row[x];
					disabledForm.value.xianlumingcheng = true;
					continue;
				}
				if(x=='xianlutupian'){
					form.value.xianlutupian = row[x];
					disabledForm.value.xianlutupian = true;
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
				if(x=='luxianxiangqing'){
					form.value.luxianxiangqing = row[x];
					disabledForm.value.luxianxiangqing = true;
					continue;
				}
				if(x=='storeupnum'){
					form.value.storeupnum = row[x];
					disabledForm.value.storeupnum = true;
					continue;
				}
				if(x=='clicktime'){
					form.value.clicktime = row[x];
					disabledForm.value.clicktime = true;
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
			form.value.storeupnum='0'
		}
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
		})
	}
	//初始化
	//取消
	const backClick = () => {
		history.back()
	}
	//富文本数据回调
	const editorChange = (e,name) =>{
		form.value[name] = e
	}
	//提交
	const save=()=>{
		if(form.value.xianlutupian!=null) {
			form.value.xianlutupian = form.value.xianlutupian.replace(new RegExp(context?.$config.url,"g"),"");
		}
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
									history.back()
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
							history.back()
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
	onMounted(()=>{
		type.value = route.query.type?route.query.type:'add'
		let row = null
		let table = null
		let statusColumnName = null
		let tips = null
		let statusColumnValue = null
		if(type.value == 'cross'){
			row = context?.$toolUtil.storageGet('crossObj')?JSON.parse(context?.$toolUtil.storageGet('crossObj')):{}
			table = context?.$toolUtil.storageGet('crossTable')
			statusColumnName = context?.$toolUtil.storageGet('crossStatusColumnName')
			tips = context?.$toolUtil.storageGet('crossTips')
			statusColumnValue = context?.$toolUtil.storageGet('crossStatusColumnValue')
		}
		init(route.query.id?route.query.id:null, type.value,'', row, table, statusColumnName, tips, statusColumnValue)
	})
	
</script>
<style lang="scss" scoped>
	// 面包屑盒子
	.bread_view {
		border: 0 solid #4C3A24;
		border-radius: 0;
		padding: 0;
		margin: 10px auto;
		background: transparent;
		width: 100%;
		border-width: 0 0 4px;
		:deep(.breadcrumb) {
			font-size: 14px;
			line-height: 1;
			height: 40px;
			.el-breadcrumb__separator {
				margin: 0 9px;
				color: #ccc;
				font-weight: 500;
				display: none;
			}
			.first_breadcrumb {
				.el-breadcrumb__inner {
					margin: 0 20px 0 0;
					color: #fff;
					background: #4C3A24;
					display: inline-block;
					width: 120px;
					line-height: 40px;
					text-align: center;
					height: 40px;
				}
			}
			.second_breadcrumb {
				.el-breadcrumb__inner {
					border: 1px solid #4C3A24;
					color: #4C3A24;
					display: inline-block;
					width: 120px;
					border-width: 2px 2px 0;
					line-height: 40px;
					text-align: center;
					height: 40px;
				}
			}
		}
	}
	// 表单
	.add_form{
		border: 4px solid rgba(76, 58, 36, 1);
		padding: 30px;
		// form item
		:deep(.el-form-item) {
			margin: 0 0 20px 0;
			display: flex;
			//label
			.el-form-item__label {
			 color: #999;
			 display: block;
			 width: 90px;
			 text-align: center;
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
					border: 1px solid rgba(76, 58, 36, 1);
					padding: 0 10px;
					background: transparent;
					width: 40%;
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
				// 富文本
				.list_editor {
					background-color: #fff;
					border-radius: 0;
					padding: 0;
					margin: 0;
					width: 100%;
					border-color: rgba(76, 58, 36, 1);
					border-width: 1px;
					border-style: solid;
					height: auto;
				}
				//图片上传样式
				.el-upload-list  {
					//提示语
					.el-upload__tip {
						margin: 7px 0 0;
						color: #999;
						display: none;
						font-size: 12px;
						justify-content: flex-start;
						align-items: center;
					}
					//外部盒子
					.el-upload--picture-card {
						border: 1px dashed rgba(76, 58, 36, 1);
						cursor: pointer;
						background-color: transparent;
						border-radius: 0;
						width: 100px;
						line-height: 110px;
						text-align: center;
						height: 100px;
						//图标
						.el-icon{
							color: rgba(76, 58, 36, 1);
							font-size: 32px;
						}
					}
					.el-upload-list__item {
						border: 1px dashed rgba(76, 58, 36, 1);
						cursor: pointer;
						background-color: transparent;
						border-radius: 0;
						width: 100px;
						line-height: 110px;
						text-align: center;
						height: 100px;
					}
				}
			}
		}
	}
	// 按钮盒子
	.formModel_btn_box {
		margin: 0 0 0 90px;
		display: flex;
		width: 100%;
		align-items: center;
		.formModel_cancel {
			border: 1px solid rgba(76, 58, 36, 1);
			cursor: pointer;
			border-radius: 0;
			padding: 0 24px;
			margin: 0 10px 0 0;
			outline: none;
			color: rgba(76, 58, 36, 1);
			background: transparent;
			width: auto;
			font-size: 14px;
			height: 40px;
		}
		.formModel_cancel:hover {
			color: #fff;
			background: rgba(76, 58, 36, .5);
		}
		
		.formModel_confirm {
			border: 1px solid rgba(76, 58, 36, 1);
			cursor: pointer;
			border-radius: 0;
			padding: 0 24px;
			margin: 0 10px 0 0;
			outline: none;
			color: rgba(76, 58, 36, 1);
			background: transparent;
			width: auto;
			font-size: 14px;
			height: 40px;
		}
		.formModel_confirm:hover {
			color: #fff;
			background: rgba(76, 58, 36, .5);
		}
	}
</style>