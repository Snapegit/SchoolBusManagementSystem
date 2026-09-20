<template>
	<div class="app-contain" :style='{"width":"calc(100% - 60px)","margin":"20px auto"}'>
		<div class="bread_view">
			<el-breadcrumb separator="Ξ" class="breadcrumb">
				<el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
				<el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
			</el-breadcrumb>
		</div>
		<div class="back_view" v-if="centerType">
			<el-button class="back_btn" @click="backClick" type="primary">返回</el-button>
		</div>
		<el-form :inline="true" :model="searchQuery" class="list_search">
			<div class="search_view">
				<div class="search_label">
					车辆编号：
				</div>
				<div class="search_box">
					<el-input class="search_inp" v-model="searchQuery.cheliangbianhao" placeholder="车辆编号"
						clearable>
					</el-input>
				</div>
			</div>
			<div class="search_btn_view">
				<el-button class="search_btn" type="primary" @click="searchClick">搜索</el-button>
				<el-button class="add_btn" type="success" v-if="btnAuth('cheliangxinxi','新增')" @click="addClick">新增</el-button>
			</div>
		</el-form>
		<div class="list_bottom">
			<div class="data_box">
				<div class="data_view">
					<div class="data_item animation_box" v-for="(item,index) in list" :key="index" @click.stop="detailClick(item.id)" >
						<div class="data_content">
							<div class="data_price" v-if="item.price">￥{{item.price}}</div>
						</div>
					</div>
				</div>
				<el-pagination
					background 
					:layout="layouts.join(',')"
					:total="total" 
					:page-size="listQuery.limit"
					prev-text="<"
					next-text=">"
					:hide-on-single-page="true"
					:style='{"width":"100%","padding":"0","margin":"20px 0 0","whiteSpace":"nowrap","color":"#333","fontWeight":"500"}'
					@size-change="sizeChange"
					@current-change="currentChange" 
					@prev-click="prevClick"
					@next-click="nextClick"  />
			</div>
		</div>
		<el-dialog v-model="preViewVisible" :title="'查看大图'" width="60%" destroy-on-close>
			<img :src="preViewUrl" style="width: 100%;" alt="">
		</el-dialog>
	</div>
</template>

<script setup>
	import {
		ref,
		getCurrentInstance,
		nextTick,
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	const route = useRoute()
	//基础信息
	const tableName = 'cheliangxinxi'
	const formName = '车辆信息'
	//基础信息
	const breadList = ref([{
		name: formName
	}])
	const list = ref([])
	const listQuery = ref({
		page: 1,
		limit: Number(8)
	})
	const total = ref(0)
	const listLoading = ref(false)
	//权限验证
	const btnAuth = (e,a)=>{
		if(centerType.value){
			return context?.$toolUtil.isBackAuth(e,a)
		}else{
			return context?.$toolUtil.isAuth(e,a)
		}
	}
	const addClick = () => {
		router.push('/index/cheliangxinxiAdd')
	}
	//判断是否从个人中心跳转
	const centerType = ref(false)
	//返回
	const backClick = () => {
		router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
	}
	const init = () => {
		if(route.query.centerType){
			centerType.value = true
		}
		getList()
	}
	//搜索
	const searchQuery = ref({})
	//下拉列表
	const searchClick = () => {
		listQuery.value.page = 1
		getList()
	}
	//分页
	const layouts = ref(["total","prev","pager","next","sizes","jumper"])
	const sizeChange = (size) => {
		listQuery.value.limit = size
		getList()
	}
	const currentChange = (page) => {
		listQuery.value.page = page
		getList()
	}
	const prevClick = () => {
		listQuery.value.page = listQuery.value.page - 1
		getList()
	}
	const nextClick = () => {
		listQuery.value.page = listQuery.value.page + 1
		getList()
	}
	//分页
	//列表
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		if(searchQuery.value.cheliangbianhao&&searchQuery.value.cheliangbianhao!=''){
			params.cheliangbianhao = '%' + searchQuery.value.cheliangbianhao + '%'
		}
		context?.$http({
			url: `${tableName}/${centerType.value?'page':'list'}`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = Number(res.data.data.total)
		})
	}
	const detailClick = (id) => {
		router.push('cheliangxinxiDetail?id=' + id + (centerType.value?'&&centerType=1':''))
	}
	//下载文件
	const download = (file) =>{
		if(!file){
			context?.$toolUtil.message('文件不存在','error')
		}
		const a = document.createElement('a');
		a.style.display = 'none';
		a.setAttribute('target', '_blank');
		file && a.setAttribute('download', file);
		a.href = context?.$config.url + file;
		document.body.appendChild(a);
		a.click();
		document.body.removeChild(a);
	}
	// 查看大图
	const preViewUrl = ref('')
	const preViewVisible = ref(false)
	const preViewClick = (url) =>{
		preViewUrl.value = url
		preViewVisible.value = true
	}
	init()
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
	// 分类盒子
	.category_view {
		border: 1px solid rgba(76, 58, 36, 1);
		margin: 20px 0 10px;
		display: flex;
		border-width: 4px 0;
		// 分类item
		.category {
			cursor: pointer;
			border: 1px solid rgba(76, 58, 36, 1);
			border-radius: 0;
			padding: 10px;
			margin: 0 10px 0 0;
			color: rgba(76, 58, 36, 1);
			background: #fff;
			width: 120px;
			border-width: 0 1px;
			box-sizing: border-box;
			text-align: center;
		}
		// item-悬浮
		.category:hover {
			color: #fff;
			background: rgba(76, 58, 36, 1);
		}
		// item-选中
		.categoryActive {
			color: #fff;
			background: rgba(76, 58, 36, 1);
		}
	}

	//搜索
	.list_search {
		border: 1px solid rgba(76, 58, 36, 1);
		display: flex;
		border-width: 4px 0;
		align-items: center;
		height: 60pxx;
		.search_view {
			margin: 0 10px 0 0;
			display: flex;
			align-items: center;
			height: 60px;
			.search_label {
				margin: 0 10px 0 0;
				color: #666;
				font-weight: 500;
				display: inline-block;
				font-size: 14px;
				line-height: 60px;
				height: 60px;
			}
			.search_box {
				display: flex;
				width: calc(100% - 100px);
				// 输入框
				:deep(.search_inp) {
					border: 0px solid rgba(76, 58, 36, 1);
					padding: 0 10px;
					background: transparent;
					width: 100%;
					border-width: 0 1px;
					line-height: 52px;
					box-sizing: border-box;
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
		}
		.search_btn_view {
			margin: 0;
			display: flex;
			// 搜索按钮
			.search_btn {
				border: 1px solid rgba(76, 58, 36, 1);
				cursor: pointer;
				border-radius: 0;
				padding: 0 24px;
				outline: none;
				margin: 0 10px 0 0;
				color: rgba(76, 58, 36, 1);
				background: transparent;
				width: auto;
				font-size: 16px;
				border-width: 0 1px;
				height: 52px;
			}
			// 搜索按钮-悬浮
			.search_btn:hover {
				background: rgba(76, 58, 36, 0.5);
			}
			// 新增按钮
			.add_btn {
				border: 1px solid rgba(76, 58, 36, 1);
				cursor: pointer;
				border-radius: 0;
				padding: 0 24px;
				margin: 0;
				outline: none;
				color: rgba(76, 58, 36, 1);
				background: transparent;
				width: auto;
				font-size: 16px;
				border-width: 0 1px;
				height: 52px;
			}
			// 新增按钮-悬浮
			.add_btn:hover {
				background: rgba(76, 58, 36, 0.5);
			}
		}
	}

	// 数据盒子
	.list_bottom {
		margin: 50px 0 0;
		display: flex;
		width: 100%;
		align-items: flex-start;
		//列表
		.data_box {
			flex: 4;
			width: 85%;
			.data_view {
				background: transparent;
				display: flex;
				width: 100%;
				flex-wrap: wrap;
				.data_item {
					border: 4px solid rgba(76, 58, 36, 1);
					padding: 0;
					margin: 0 10px 20px;
					background: transparent;
					width: calc(20% - 20px);
					box-sizing: border-box;
					// 图片盒子
					.data_img_box {
						margin: 0 auto 0;
						width: 100%;
						font-size: 0;
						position: relative;
						// 图片
						.data_img {
							object-fit: cover;
							width: 100%;
							height: 236px;
						}
					}
					// 内容盒子
					.data_content {
						padding: 0C;
						width: 100%;
						// 价格
						.data_price {
							border: 1px solid rgba(76, 58, 36, 1);
							color: #f00;
							width: 100%;
							font-size: 16px;
							border-width: 0 0 1px;
							line-height: 2;
							text-align: center;
						}
						// 标题
						.data_title {
							border: 1px solid rgba(76, 58, 36, 1);
							color: rgba(76, 58, 36, 1);
							font-weight: bold;
							width: 100%;
							font-size: 16px;
							border-width: 0 0 1px;
							line-height: 3;
							text-align: center;
						}
						// 底部栏
						.data_operate_box {
							padding: 0 0;
							display: flex;
							width: 100%;
							justify-content: space-between;
							align-items: center;
							box-sizing: border-box;
							// 点赞数
							.data_like {
								border: 1px solid rgba(76, 58, 36, 1);
								color: rgba(76, 58, 36, 1);
								display: flex;
								width: calc(100% / 3);
								font-size: 16px;
								border-width: 0 1px 0 0;
								justify-content: center;
								align-items: center;
								height: 40px;
								.like_icon {
									margin: 0 4px 0 0;
									color: inherit;
								}
								.like_num {
									color: inherit;
								}
							}
							// 收藏数
							.data_collect {
								border: 1px solid rgba(76, 58, 36, 1);
								color: rgba(76, 58, 36, 1);
								display: flex;
								width: calc(100% / 3);
								font-size: 16px;
								border-width: 0 1px 0 0;
								justify-content: center;
								align-items: center;
								height: 40px;
								.el-icon {
									margin: 0 4px 0 0;
									color: inherit;
								}
								.collect_num {
									color: inherit;
								}
							}
							// 点击数
							.data_clickNum {
								color: rgba(76, 58, 36, 1);
								display: flex;
								width: calc(100% / 3);
								font-size: 16px;
								justify-content: center;
								align-items: center;
								height: 40px;
								.el-icon {
									margin: 0 4px 0 0;
									color: inherit;
								}
								.clickNum_num {
									color: inherit;
								}
							}
						}
					}
				}
			}
		}
	}

	// animation
	.animation_box {
		transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
		z-index: initial;
	}
	.animation_box:hover {
		transform: rotate(0deg) scale(1.1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
		-webkit-perspective: 1000px;
		perspective: 1000px;
		transition: 0.3s;
	}
	.animation_box img {
		transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
		z-index: initial;
	}
	.animation_box img:hover {
		transform: rotate(0deg) scale(0.8) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
		-webkit-perspective: 1000px;
		perspective: 1000px;
		transition: 0.3s;
	}
	// animation

	// 分页器
	.el-pagination {
		// 总页码
		:deep(.el-pagination__total) {
			margin: 0 10px 0 0;
			color: #666;
			font-weight: 400;
			display: inline-block;
			vertical-align: top;
			font-size: 13px;
			line-height: 28px;
			height: 28px;
		}
		// 上一页
		:deep(.btn-prev) {
			border: none;
			border-radius: 2px;
			padding: 0;
			margin: 0 5px;
			color: #666;
			background: #f4f4f5;
			display: inline-block;
			vertical-align: top;
			font-size: 13px;
			line-height: 28px;
			min-width: 35px;
			height: 28px;
		}
		// 下一页
		:deep(.btn-next) {
			border: none;
			border-radius: 2px;
			padding: 0;
			margin: 0 5px;
			color: #666;
			background: #f4f4f5;
			display: inline-block;
			vertical-align: top;
			font-size: 13px;
			line-height: 28px;
			min-width: 35px;
			height: 28px;
		}
		// 上一页禁用
		:deep(.btn-prev:disabled) {
			border: none;
			cursor: not-allowed;
			border-radius: 2px;
			padding: 0;
			margin: 0 5px;
			color: #C0C4CC;
			background: #f4f4f5;
			display: inline-block;
			vertical-align: top;
			font-size: 13px;
			line-height: 28px;
			height: 28px;
		}
		// 下一页禁用
		:deep(.btn-next:disabled) {
			border: none;
			cursor: not-allowed;
			border-radius: 2px;
			padding: 0;
			margin: 0 5px;
			color: #C0C4CC;
			background: #f4f4f5;
			display: inline-block;
			vertical-align: top;
			font-size: 13px;
			line-height: 28px;
			height: 28px;
		}
		// 页码
		:deep(.el-pager) {
			padding: 0;
			margin: 0;
			display: inline-block;
			vertical-align: top;
			// 数字
			.number {
				cursor: pointer;
				padding: 0 4px;
				margin: 0 5px;
				color: #666;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: #f4f4f5;
				text-align: center;
				min-width: 30px;
				height: 28px;
			}
			// 数字悬浮
			.number:hover {
				cursor: pointer;
				padding: 0 4px;
				margin: 0 5px;
				color: #409EFF;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: rgba(76, 58, 36, 1);
				text-align: center;
				min-width: 30px;
				height: 28px;
			}
			// 选中
			.number.is-active {
				cursor: default;
				padding: 0 4px;
				margin: 0 5px;
				color: #FFF;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: rgba(76, 58, 36, 1);
				text-align: center;
				min-width: 30px;
				height: 28px;
			}
		}
		// sizes
		:deep(.el-pagination__sizes) {
			display: inline-block;
			vertical-align: top;
			font-size: 13px;
			line-height: 28px;
			height: 28px;
			.el-select {
				border: 1px solid #DCDFE6;
				cursor: pointer;
				padding: 0;
				color: #606266;
				display: inline-block;
				font-size: 13px;
				line-height: 28px;
				border-radius: 3px;
				outline: 0;
				background: #FFF;
				width: 100%;
				text-align: center;
				height: 28px;
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
		// 跳页
		:deep(.el-pagination__jump) {
			margin: 0 0 0 24px;
			color: #606266;
			display: inline-block;
			vertical-align: top;
			font-size: 13px;
			line-height: 28px;
			height: 28px;
			// 输入框
			.el-input {
				border: 1px solid #DCDFE6;
				cursor: pointer;
				padding: 0 3px;
				color: #606266;
				display: inline-block;
				font-size: 14px;
				line-height: 28px;
				border-radius: 3px;
				outline: 0;
				background: #FFF;
				width: 100%;
				text-align: center;
				height: 28px;
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
	}
	
	// 热门信息盒子
	.hot_view {
		border: 4px solid rgba(76, 58, 36, 1);
		flex: 1;
		width: 15%;
		// 标题
		.hot_title {
			border: 1px solid rgba(76, 58, 36, 1);
			color: rgba(76, 58, 36, 1);
			font-weight: bold;
			width: 100%;
			font-size: 18px;
			border-width: 0 0 4px;
			line-height: 3;
			text-align: center;
		}

		.hot_list {
			padding: 0 10px;
			width: 100%;
			// item
			.hot {
				border: 4px solid rgba(76, 58, 36, 1);
				padding: 0 0 0;
				margin: 0 0 10px;
				background: transparent;
				width: 100%;
				box-sizing: border-box;
				//图片盒子
				.hot_img_view {
					width: 100%;
					font-size: 0;
					height: 150px;
					// 图片
					.hot_img {
						object-fit: cover;
						width: 100%;
						height: 100%;
					}
				}
				// 内容盒子
				.hot_content {
					// 名称
					.hot_text {
					color: rgba(76, 58, 36, 1);
					font-weight: bold;
					font-size: 16px;
					line-height: 3;
					text-align: center;
					}
				}
			}
		}
	}
</style>