<template>
	<div class="app-contain" :style='{"width":"100%","padding":"30px","margin":"10px auto","position":"relative"}'>
		<div class="bread_view">
			<el-breadcrumb separator="Ξ" class="breadcrumb">
				<el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
				<el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
			</el-breadcrumb>
		</div>
		<div class="back_view">
			<el-button class="back_btn" @click="backClick" type="primary">返回</el-button>
		</div>
		<div class="detail_view">
			<div class="swiper_view">
				<mySwiper :data="bannerList" :type="3"
				:loop="false"
				:navigation="false"
				:pagination="false"
				:paginationType="3"
				:scrollbar="false"
				:slidesPerView="1"
				:spaceBetween="20"
				:autoHeight="false"
				:centeredSlides="false"
				:freeMode="false"
				:effectType="3"
				:direction="horizontal"
				:autoplay="true"
				:slidesPerColumn="1">
				<template #default="scope">
					<img :style='{"objectFit":"cover","width":"100%","height":"350px"}' :src="scope.row?$config.url + scope.row:''">
				</template>
			</mySwiper>
			</div>
			
			<div class="info_view">
				<div class="title_view">
					<div class="detail_title">
						{{detail.luxianmingcheng}}
					</div>
				</div>
				<div class="info_item">
					<div class="info_label">起点</div>
					<div  class="info_text" >{{detail.qidian}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">停靠站点</div>
					<div  class="info_text" >{{detail.tingkaozhandian}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">终点</div>
					<div  class="info_text" >{{detail.zhongdian}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">学生账号</div>
					<div  class="info_text" >{{detail.xueshengzhanghao}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">学生姓名</div>
					<div  class="info_text" >{{detail.xueshengxingming}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">车辆编号</div>
					<div  class="info_text" >{{detail.cheliangbianhao}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">车牌号</div>
					<div  class="info_text" >{{detail.chepaihao}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">驾驶员账号</div>
					<div  class="info_text" >{{detail.jiashiyuanzhanghao}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">驾驶员姓名</div>
					<div  class="info_text" >{{detail.jiashiyuanxingming}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">驾驶员确认状态</div>
					<div  class="info_text" >{{detail.jiashiyuanquerenzhuangtai}}</div>
				</div>
				<div class="btn_view">
					<el-button class="cross_btn" v-if="btnFrontAuth(tableName,'确认')" @click="jiashiyuanquerenxinxionAcross('确认','jiashiyuanquerenxinxi','','jiashiyuanquerenzhuangtai','已确认','已确认,未确认'.split(',')[0])" type="warning">确认</el-button>
					<el-button v-if="centerType&&(detail.ispay=='未支付'||!detail.ispay)&&btnFrontAuth('yuyuejieguo','支付')" class="approval_btn" @click="payClick">支付</el-button>
					<el-button class="edit_btn" v-if="centerType&&btnAuth('yuyuejieguo','修改')" type="primary" @click="editClick">修改</el-button>
					<el-button class="del_btn" v-if="centerType&&btnAuth('yuyuejieguo','删除')" type="danger" @click="delClick">删除</el-button>
				</div>
			</div>
		</div>
		<el-tabs type="border-card" v-model="activeName" class="tabs_view">
		</el-tabs>
	</div>
</template>
<script setup>
	import axios from 'axios'
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
		ElMessageBox
	} from 'element-plus'
	import {
		useRoute,
		useRouter
	} from 'vue-router';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const route = useRoute()
	const router = useRouter()
	//基础信息
	const tableName = 'yuyuejieguo'
	const formName = '预约结果'
	//基础信息
	const breadList = ref([{
		name: formName
	}])
	//权限验证
	const btnAuth = (e,a)=>{
		if(centerType.value){
			return context?.$toolUtil.isBackAuth(e,a)
		}else{
			return context?.$toolUtil.isAuth(e,a)
		}
	}
	//查看权限验证
	const btnFrontAuth = (e,a)=>{
		if(centerType.value){
			return context?.$toolUtil.isBackAuth(e,a)
		}else{
			return context?.$toolUtil.isFrontAuth(e,a)
		}
	}
	// 返回
	const backClick = () =>{
		history.back()
	}
	// 轮播图
	const bannerList = ref([])
	// 详情
	const title = ref('')
	const detail = ref({})
    const activeName = ref('first')
	const getDetail = () => {
		context?.$http({
			url: `${tableName}/detail/${route.query.id}`,
			method: 'get'
		}).then(res => {
			title.value = res.data.data.luxianmingcheng
			detail.value = res.data.data
		})
	}
	// 下载文件
	const downClick = (file) => {
		if(!file){
			context?.$toolUtil.message('文件不存在','error')
		}
		let arr = file.replace(new RegExp('file/', "g"), "")
		axios.get((location.href.split(context?.$config.name).length>1 ? location.href.split(context?.$config.name)[0] :'') + context?.$config.name + '/file/download?fileName=' + arr, {
			headers: {
				token: context?.$toolUtil.storageGet('frontToken')
			},
			responseType: "blob"
		}).then(({
			data
		}) => {
			const binaryData = [];
			binaryData.push(data);
			const objectUrl = window.URL.createObjectURL(new Blob(binaryData, {
				type: 'application/pdf;chartset=UTF-8'
			}))
			const a = document.createElement('a')
			a.href = objectUrl
			a.download = arr
			// a.click()
			// 下面这个写法兼容火狐
			a.dispatchEvent(new MouseEvent('click', {
				bubbles: true,
				cancelable: true,
				view: window
			}))
			window.URL.revokeObjectURL(data)
		})
	}
	// 判断是否从个人中心跳转
	const centerType = ref(false)
	const init = () => {
		if(route.query.centerType){
			centerType.value = true
		}
		getDetail()
	}
	//修改
	const editClick = () => {
		router.push(`/index/${tableName}Add?id=${detail.value.id}&&type=edit`)
	}
	//删除
	const delClick = () => {
		ElMessageBox.confirm(`是否删除此${formName}？`, '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(()=>{
			context?.$http({
				url: `${tableName}/delete`,
				method: 'post',
				data: [detail.value.id]
			}).then(res=>{
				context?.$toolUtil.message('删除成功','success',()=>{
					history.back()
				})
			})
			
		})
	}
	const jiashiyuanquerenxinxionAcross = (btnType,table,crossOptAudit,statusColumnName,tips,statusColumnValue) => {
		if(!context?.$toolUtil.storageGet('frontToken')){
			context?.$toolUtil.message('请登录后再操作！','error')
			return false
		}
		if(!btnAuth(tableName,btnType)){
			context?.$toolUtil.message('暂无权限操作！','error')
			return false
		}
		context?.$toolUtil.storageSet('crossObj',JSON.stringify(detail.value))
		context?.$toolUtil.storageSet('crossTable',tableName)
		context?.$toolUtil.storageSet('crossStatusColumnName',statusColumnName)
		context?.$toolUtil.storageSet('crossTips',tips)
		context?.$toolUtil.storageSet('crossStatusColumnValue',statusColumnValue)
		if(statusColumnName!=''&&!statusColumnName.startsWith("[")) {
			var obj = detail.value
			for (var o in obj){
				if(o==statusColumnName && obj[o]==statusColumnValue){
					context?.$toolUtil.message(tips,'error')
					return;
				}
			}
		}
		nextTick(()=>{
			router.push(`/index/${table}Add?type=cross&&id=${detail.value.id}`)
		})
	}
	onMounted(()=>{
		init()
	})
</script>
<style lang="scss" scoped>
	// 返回盒子
	.back_view {
		border-radius: 27px;
		padding: 20px;
		margin: 10px auto;
		background: transparent;
		width: 1200px;
		// 返回按钮
		.back_btn {
			border: 0;
			cursor: pointer;
			border-radius: 0px;
			padding: 0 24px;
			outline: none;
			color: #fff;
			background: #4C3A24;
			width: auto;
			font-size: 14px;
			height: 40px;
		}
		// 返回按钮-悬浮
		.back_btn:hover {
			background: rgba(76, 58, 36, 0.5);
			font-size: 16px;
		}
	}
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
	
	.detail_view{
		border: 4px solid rgba(76, 58, 36, 1);
		display: flex;
		position: relative;
		flex-wrap: wrap;
		// 轮播图
		.swiper_view {
			width: 30%;
		}
		
		// 文字区
		.info_view {
			padding: 20px;
			margin: 0 0 20px;
			background: transparent;
			width: 70%;
			box-sizing: border-box;
		
			.title_view {
				border: 1px solid rgba(76, 58, 36, 1);
				padding: 0 6px;
				display: flex;
				width: 100%;
				border-width: 4px 0;
				justify-content: space-between;
				align-items: center;
		
				.detail_title {
					color: #000;
					font-weight: bold;
					font-size: 20px;
				}
				.follow {
					border: 1px solid rgba(76, 58, 36, 1);
					cursor: pointer;
					border-radius: 0;
					padding: 10px 20px;
					color: rgba(76, 58, 36, 1);
					display: flex;
					width: 120px;
					border-width: 0 1px;
					line-height: 1;
					justify-content: space-around;
					align-items: center;
					.iconfont {
						color: rgba(76, 58, 36, 1);
					}
					.iconfontActive {
						color: #f00;
					}
					span {
						color: rgba(76, 58, 36, 1);
					}
					.textActive {
						color: #ff0;
					}
				}
				.follow:hover {
				}
				.follow:active {
					transform: scale(0.8);
				}
			}
		
			.info_item {
					border: 1px solid rgba(76, 58, 36, 1);
					padding: 16px 0;
					margin: 10px 0;
					display: flex;
					border-width: 1px 0;
					align-items: center;
		
				.info_label {
					color: #999;
					width: 90px;
					text-align: center;
				}
				.info_text {
					color: rgba(76, 58, 36, 1);
				}
			}
			.btn_view {
				padding: 0 0;
				margin: 0 0 00px;
				display: flex;
				flex-wrap: wrap;
				// 跨表-按钮
				.cross_btn {
					border: 1px solid ;
					border-radius: 0;
					margin: 0 6px 6px;
					color: rgba(76, 58, 36, 1);
					background: transparent;
				}
				// 悬浮
				.cross_btn:hover {
					border: none;
					color: #333;
					background: rgba(170, 0, 0, 0.5);
				}
				// 修改-按钮
				.edit_btn {
					border: 1px solid rgba(76, 58, 36, 1);
					border-radius: 0;
					margin: 0 6px 6px;
					color: rgba(76, 58, 36, 1);
					background: transparent;
				}
				// 悬浮
				.edit_btn:hover {
					color: #fff;
					background: rgba(76, 58, 36, .5);
				}
				// 删除-按钮
				.del_btn {
					border: 1px solid rgba(76, 58, 36, 1);
					border-radius: 0;
					margin: 0 6px 6px;
					color: rgba(76, 58, 36, 1);
					background: transparent;
				}
				// 悬浮
				.del_btn:hover {
					border: none;
					color: #333;
					background: rgba(255, 255, 127, 0.5);
				}
			}
		}
	}
	

	//底部盒子
	.tabs_view {
		border: 0px solid #DCDFE6;
		box-shadow: none;
		background: transparent;
		:deep(.el-tabs__header) {
			background: transparent;
			border: none;
		}
		// 头部
		:deep(.el-tabs__nav-scroll) {
			margin: 0;
			background: rgba(241, 236, 230, 1);
			border-color: rgba(76, 58, 36, 1);
			border-width: 2px 0;
			border-style: solid;
			.el-tabs__nav {
				background: rgba(241, 236, 230, 1);
				.el-tabs__item {
					border: 1px solid rgba(76, 58, 36, 1);
					padding: 0 20px;
					margin: 0 10px 0 0;
					color: #999;
					font-weight: 500;
					display: inline-block;
					font-size: 14px;
					line-height: 40px;
					background: transparent;
					border-width: 0 1px;
					position: relative;
					list-style: none;
					height: 40px;
				}
				.el-tabs__item:hover {
					color: #fff;
					background: rgba(76, 58, 36, 1);
				}
				.is-active {
					margin: 0 10px 0 0;
					color: #fff;
					background: rgba(76, 58, 36, 1);
				}
			}
		}
		// 内容区
		:deep(.el-tabs__content) {
			padding: 15px;
		}
	}
	


</style>