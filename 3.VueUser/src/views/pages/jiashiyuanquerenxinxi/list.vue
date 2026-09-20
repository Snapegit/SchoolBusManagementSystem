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
					路线名称：
				</div>
				<div class="search_box">
					<el-input class="search_inp" v-model="searchQuery.luxianmingcheng" placeholder="路线名称"
						clearable>
					</el-input>
				</div>
			</div>
			<div class="search_btn_view">
				<el-button class="search_btn" type="primary" @click="searchClick">搜索</el-button>
				<el-button class="add_btn" type="success" v-if="btnAuth('jiashiyuanquerenxinxi','新增')" @click="addClick">新增</el-button>
			</div>
		</el-form>
		<div class="list_bottom">
			<div class="data_box">
				<div class="data_view">
					<el-table v-loading="listLoading" class="data_table" :data="list" border :row-style="{'cursor':'pointer'}"
						@row-click="tableDetailClick" :stripe='true'>
						<el-table-column :resizable='true' align="left" header-align="left" type="selection" width="55" />
						<el-table-column label="序号" width="120" :resizable='true' align="left" header-align="left">
							<template #default="scope">{{ scope.$index + 1}}</template>
						</el-table-column>
						<el-table-column label="路线名称" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.luxianmingcheng}}
							</template>
						</el-table-column>
						<el-table-column label="起点" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.qidian}}
							</template>
						</el-table-column>
						<el-table-column label="停靠站点" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.tingkaozhandian}}
							</template>
						</el-table-column>
						<el-table-column label="终点" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.zhongdian}}
							</template>
						</el-table-column>
						<el-table-column label="学生账号" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.xueshengzhanghao}}
							</template>
						</el-table-column>
						<el-table-column label="学生姓名" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.xueshengxingming}}
							</template>
						</el-table-column>
						<el-table-column label="车辆编号" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.cheliangbianhao}}
							</template>
						</el-table-column>
						<el-table-column label="车牌号" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.chepaihao}}
							</template>
						</el-table-column>
						<el-table-column label="驾驶员账号" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.jiashiyuanzhanghao}}
							</template>
						</el-table-column>
						<el-table-column label="驾驶员姓名" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.jiashiyuanxingming}}
							</template>
						</el-table-column>
						<el-table-column label="确认时间" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.querenshijian}}
							</template>
						</el-table-column>
					</el-table>
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
	const tableName = 'jiashiyuanquerenxinxi'
	const formName = '驾驶员确认信息'
	//基础信息
	const breadList = ref([{
		name: formName
	}])
	const list = ref([])
	const listQuery = ref({
		page: 1,
		limit: 20,
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
		router.push('/index/jiashiyuanquerenxinxiAdd')
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
		if(searchQuery.value.luxianmingcheng&&searchQuery.value.luxianmingcheng!=''){
			params.luxianmingcheng = '%' + searchQuery.value.luxianmingcheng + '%'
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
	const tableDetailClick = (row) => {
		router.push('jiashiyuanquerenxinxiDetail?id=' + row.id + (centerType.value?'&&centerType=1':''))
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
				// 表格样式
				.el-table {
					padding: 0;
					background: transparent;
					width: 100%;
					border-color: rgba(76, 58, 36, 1);
					border-width: 4px 0 0 4px;
					border-style: solid;
					:deep(.el-table__header-wrapper) {
						thead {
							color: #999;
							font-weight: 500;
							width: 100%;
							tr {
								background: rgba(241, 236, 230, 1);
								th {
									padding: 12px 0;
									border-color: rgba(76, 58, 36, 1);
									border-width: 0 0px 4px 0;
									border-style: solid;
									text-align: left;
									.cell {
										padding: 0 10px;
										word-wrap: normal;
										word-break: break-all;
										white-space: normal;
										font-weight: bold;
										display: inline-block;
										vertical-align: middle;
										width: 100%;
										line-height: 24px;
										position: relative;
										text-overflow: ellipsis;
										//未选中样式
										.el-checkbox {
											//复选框
											.el-checkbox__inner {
												background: #fff;
												border-color: #999;
											}
										}
										//选中样式
										.is-checked {
											//复选框
											.el-checkbox__inner {
												background: #55ffff;
												border-color: #55ffff;
											}
										}
									}
								}
							}
						}
					}
					:deep(.el-table__body-wrapper) {
						tbody {
							width: 100%;
							tr {
								background: #fff;
								td {
									padding: 12px 0;
									color: #999;
									background: #fff;
									border-color: rgba(76, 58, 36, 1);
									border-width: 0 0px 0px 0;
									border-style: solid;
									text-align: left;
									.cell {
										padding: 0 10px;
										overflow: hidden;
										word-break: break-all;
										white-space: normal;
										line-height: 24px;
										text-overflow: ellipsis;
										//未选中样式
										.el-checkbox {
											//复选框
											.el-checkbox__inner {
												background: #fff;
												border-color: #999;
											}
										}
										//选中样式
										.is-checked {
											//复选框
											.el-checkbox__inner {
												background: #55ffff;
												border-color: #55ffff;
											}
										}
									}
								}
							}
							tr.el-table__row--striped {
								td {
									background: rgba(241, 236, 230, 1) !important;
								}
							}
							tr:hover {
								td {
									padding: 12px 0;
									color: #fff;
									background: rgba(76, 58, 36, 0.3);
									border-color: #eee;
									border-width: 0 1px 1px 0;
									border-style: solid;
									text-align: left;
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