<template>
	<div>
		<div class="home_box">
			<!-- 线路信息推荐 -->
			<div class="recomList_view">
				<div class="default_box_view">
					<div class="box1"></div>
					<div class="box2"></div>
					<div class="box3"></div>
					<div class="box4"></div>
					<div class="box5"></div>
					<div class="box6"></div>
					<div class="box7"></div>
					<div class="box8"></div>
					<div class="box9"></div>
					<div class="box10"></div>
				</div>
				<div class="recomList_title">线路信息推荐</div>
				<div class="recommend_list_one">
					<div class="recommend_item animation_box" v-for="(item,index) in xianluxinxiRecomList" :key="index" @click="detailClick('xianluxinxi',item.id)">
						<div class="recommend_img_box">
							<img class="recommend_img" v-if="isHttp(item.xianlutupian)" :src="item.xianlutupian.split(',')[0]" alt="">
							<img class="recommend_img" v-else :src="item.xianlutupian?$config.url + item.xianlutupian.split(',')[0]:''" alt="">
						</div>
						<div class="recommend_content">
							<div class="recommend_title">
								{{item.xianlumingcheng}}
							</div>
							<div class="recommend_title">
								起点：{{item.qidian}}
							</div>
							<div class="recommend_title">
								终点：{{item.zhongdian}}
							</div>
							<div class="recommend_one_bottom">
								<div class="recommend_like" v-if="item.thumbsupnum">
									<span class="iconfont icon-thumb-up-line1 like_icon"></span>
									<div class="like_num">{{item.thumbsupnum}}</div>
								</div>
								<div class="recommend_collect" v-if="item.storeupnum">
									<el-icon><StarFilled /></el-icon>
									<div class="collect_num">{{item.storeupnum}}</div>
								</div>
								<div class="recommend_clickNum" v-if="item.clicknum">
									<el-icon><View /></el-icon>
									<div class="clickNum_num">{{item.clicknum}}</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="recommend_more_view" @click="moreClick('xianluxinxi')">
					<span class="recommend_more_text">更多</span>
					<el-icon><DArrowRight /></el-icon>
				</div>
			</div>
		</div>
	</div>
</template>

<script setup>
	import {
		ref,
		getCurrentInstance
	} from 'vue';
	import {
		useRouter
	} from 'vue-router';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	//线路信息推荐
	const xianluxinxiRecomList = ref([])
	const getxianluxinxiRecomList = () => {
		let autoSortUrl = 'xianluxinxi/autoSort'
		if(context?.$toolUtil.storageGet('frontToken')){
			autoSortUrl = "xianluxinxi/autoSort2"
		}
		context?.$http({
			url: autoSortUrl,
			method: 'get',
			params: {
				page: 1,
				limit: 10
			}
		}).then(res => {
			xianluxinxiRecomList.value = res.data.data.list
		})
	}
	//判断图片链接是否带http
	const isHttp = (str) => {
        return str && str.substr(0,4)=='http';
    }
	//跳转详情
	const detailClick = (table,id) => {
		router.push(`/index/${table}Detail?id=${id}`)
	}
	const moreClick = (table) => {
		router.push(`/index/${table}List`)
	}
	const init = () => {
		//线路信息推荐
		getxianluxinxiRecomList()
	}
	init()
</script>

<style lang="scss">
	.home_box {
		padding: 30px;
		margin: 0 auto;
		display: flex;
		width: 100%;
		flex-wrap: wrap;
	}
	
	// 推荐
	.recomList_view {
		padding: 20px;
		width: 100%;
		position: relative;
		order: 3;
		// 自定义盒子
		.default_box_view {
			padding: 0;
			background: transparent;
			display: flex;
			justify-content: space-between;
			flex-wrap: wrap;
			.box1 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box2 {
				top: 80px;
				background: rgba(76, 58, 36, 1);
				width: 80%;
				position: absolute;
				right: 0;
				height: 4px;
			}
			.box3 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box4 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box5 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box6 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box7 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box8 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box9 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box10 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
		}
		.recomList_title {
			margin: 0 0 40px;
			color: rgba(76, 58, 36, 1);
			font-weight: bold;
			width: 100%;
			font-size: 36px;
			text-align: left;
		}
		// list
		.recommend_list_one {
			display: flex;
			width: 100%;
			flex-wrap: wrap;
			.recommend_item {
				border: 4px solid rgba(76, 58, 36, 1);
				margin: 0 10px 20px;
				background: transparent;
				width: calc(20% - 20px);
			}
			.recommend_img_box {
				width: 100%;
				font-size: 0;
				.recommend_img {
					object-fit: cover;
					width: 100%;
					height: 336px;
				}
			}
			.recommend_content {
				.recommend_title {
					border: 1px solid rgba(76, 58, 36, 1);
					color: #000;
					font-weight: bold;
					width: 100%;
					font-size: 18px;
					border-width: 0 0 1px;
					line-height: 2;
					text-align: center;
				}
				.recommend_price {
					color: rgba(212, 0, 0, 1);
					width: 100%;
					font-size: 14px;
					line-height: 2;
					text-align: center;
				}
				.recommend_one_bottom {
					border: 1px solid calc(100% / 3);
					padding: 0 0;
					display: flex;
					width: 100%;
					border-width: 1px 0 0;
					justify-content: space-between;
					align-items: center;
					height: 50px;
					.recommend_like {
						border: 1px solid calc(100% / 3);
						color: #999;
						display: flex;
						width: calc(100% / 3);
						font-size: 16px;
						border-width: 0 1px 0 0;
						justify-content: center;
						align-items: center;
						height: 100%;
						.like_icon {
							margin: 0 4px 0 0;
							color: inherit;
						}
						.like_num {
							color: inherit;
						}
					}
					.recommend_collect {
						border: 1px solid calc(100% / 3);
						color: #999;
						display: flex;
						width: calc(100% / 3);
						font-size: 16px;
						border-width: 0 1px 0 0;
						justify-content: center;
						align-items: center;
						height: 100%;
						.el-icon {
							margin: 0 4px 0 0;
							color: inherit;
						}
						.collect_num {
							color: inherit;
						}
					}
					.recommend_clickNum {
						color: #999;
						display: flex;
						width: calc(100% / 3);
						font-size: 16px;
						justify-content: center;
						align-items: center;
						height: 100%;
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
		// list
		// animation
		.animation_box {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			z-index: initial;
		}
		.animation_box:hover {
			transform: rotate(0deg) scale(1.1) skew(4deg, 4deg) translate3d(0px, 0px, 0px);
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
		// 更多
		.recommend_more_view {
			cursor: pointer;
			border: 1px solid rgba(76, 58, 36, 1);
			padding: 12px 0;
			margin: 20px auto;
			color: rgba(76, 58, 36, 1);
			background: transparent;
			width: 160px;
			font-size: 16px;
			text-align: center;
			.recommend_more_text {
			}
			.el-icon {
			}
		}
	}
	// 推荐
	// 新闻资讯
	.newsList_view {
		padding: 20px;
		width: 100%;
		position: relative;
		order: 1;

		.newsList_title {
			margin: 0 0 20px;
			color: rgba(76, 58, 36, 1);
			font-weight: bold;
			width: 100%;
			font-size: 32px;
			text-align: center;
		}
		// list
		.news_list_three {
			display: flex;
			align-items: center;
			.news_left {
				background: transparent;
				width: 50%;
				.news_img_box {
					width: 100%;
					font-size: 0;
					.news_img {
						object-fit: cover;
						width: 100%;
						height: 720px;
					}
				}
				.news_content {
					border: 4px solid rgba(76, 58, 36, 1);
					padding: 10px 0;
					margin: 10px 0 0;
					display: flex;
					border-width: 4px 0;
					flex-wrap: wrap;
					.news_title {
						color: rgba(76, 58, 36, 1);
						font-weight: bold;
						width: 100%;
						font-size: 18px;
						text-align: left;
						height: 30px;
					}
					.news_text {
						border: 1px solid rgba(76, 58, 36, 1);
						padding: 6px 0;
						margin: 0 0 10px;
						color: rgba(137, 127, 117, 1);
						display: -webkit-box;
						font-size: 14px;
						line-height: 1.5;
						overflow: hidden;
						width: 100%;
						border-width: 0 0 1px;
						-webkit-box-orient: vertical;
						-webkit-line-clamp: 2;
						height: 70px;
					}
					.news_time {
						padding: 0 0 0 10px;
						color: rgba(158, 158, 158, 1);
						width: 50%;
						line-height: 2;
						text-align: left;
					}
				}
			}
			.news_right {
				margin: 0 0 0 20px;
				flex-direction: column;
				display: flex;
				width: calc(50% - 20px);
				justify-content: space-between;
				flex-wrap: wrap;
				height: 900px;
				.news_right_item {
					background: transparent;
					display: flex;
					width: 100%;
					height: 160px;
					.news_img_box {
						width: 30%;
						font-size: 0;
						order: 2;
						.news_img {
							object-fit: cover;
							width: 100%;
							height: 160px;
						}
					}
					.news_content {
						border: 1px solid rgba(76, 58, 36, 1);
						padding: 10px 0 0;
						margin: 0 10px 0 0;
						display: flex;
						width: calc(70% - 10px);
						border-width: 4px 0;
						flex-wrap: wrap;
						.news_title {
							color: rgba(76, 58, 36, 1);
							font-weight: bold;
							width: 100%;
							font-size: 18px;
							text-align: left;
						}
						.news_text {
							border: 1px solid rgba(158, 158, 158, 1);
							overflow: hidden;
							color: rgba(137, 127, 117, 1);
							display: -webkit-box;
							font-size: 14px;
							border-width: 0 0 1px;
							line-height: 1.5;
							-webkit-box-orient: vertical;
							-webkit-line-clamp: 2;
						}
						.news_time {
							padding: 0 0 0 10px;
							color: rgba(137, 127, 117, 1);
							width: 50%;
							line-height: 50px;
							text-align: left;
							height: 50px;
						}
					}
				}
			}
		}
		// list
		// animation
		.animation_box {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			z-index: initial;
		}
		.animation_box:hover {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			-webkit-perspective: 1000px;
			perspective: 1000px;
			transition: 0.3s;
		}
		.animation_box img {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			z-index: initial;
		}
		.animation_box img:hover {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			-webkit-perspective: 1000px;
			perspective: 1000px;
			transition: 0.3s;
		}
		// animation
		// 更多
		.news_more_view {
			cursor: pointer;
			border-radius: 20px;
			padding: 12px 0;
			margin: 20px auto;
			color: #fff;
			top: 0;
			background: rgba(76, 58, 36, 1);
			width: 120px;
			position: absolute;
			right: 20px;
			text-align: center;
			.news_more_text {
			}
			.el-icon {
			}
		}
	}
	// 新闻资讯
	// 首页展示
	.homeList_view {
		border: 4px solid rgba(76, 58, 36, 1);
		padding: 10px 20px 20px;
		margin: 0 20px 0 0;
		display: flex;
		width: calc(60% - 20px);
		position: relative;
		flex-wrap: wrap;
		order: 5;

		// 自定义盒子
		.default_box_view {
			background: #efefef;
			display: flex;
			justify-content: space-between;
			flex-wrap: wrap;
			.box1 {
				top: 56px;
				background: rgba(76, 58, 36, 1);
				width: 80%;
				position: absolute;
				right: 0;
				height: 4px;
			}
			.box2 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box3 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box4 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box5 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box6 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box7 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box8 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box9 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
			.box10 {
				background: #fff;
				display: none;
				width: 20%;
				height: 80px;
			}
		}
		.homeList_title {
			margin: 0 0 40px;
			color: rgba(76, 58, 36, 1);
			font-weight: bold;
			width: 100%;
			font-size: 32px;
			text-align: left;
		}
		// list
		.home_list_one {
			display: flex;
			width: 100%;
			align-items: flex-start;
			.home_item1 {
				border: 4px solid rgba(76, 58, 36, 1);
				margin: 0 10px 0 0;
				width: calc(100% / 3);
				position: relative;
				.home_img_box {
					width: 100%;
					font-size: 0;
					.home_img {
						object-fit: cover;
						width: 100%;
						height: 336px;
					}
				}
				.home_content {
					color: rgba(76, 58, 36, 1);
					background: transparent;
					font-weight: bold;
					width: 100%;
					line-height: 3;
					text-align: center;
					.home_title {
						font-size: 16px;
					}
				}
			}
			.home_item2 {
				margin: 0;
				display: flex;
				width: calc(200% / 3);
				justify-content: space-between;
				align-items: center;
				.item2_top {
					border: 4px solid rgba(76, 58, 36, 1);
					margin: 0 0 00px;
					width: calc(50% - 5px);
					position: relative;
					.home_img_box {
						width: 100%;
						.home_img {
							object-fit: cover;
							width: 100%;
							height: 336px;
						}
					}
					.home_content {
						color: rgba(76, 58, 36, 1);
						background: transparent;
						font-weight: bold;
						width: 100%;
						line-height: 3;
						text-align: center;
						.home_title {
							font-size: 16px;
						}
					}
				}
				.item2_bottom {
					border: 4px solid rgba(76, 58, 36, 1);
					width: calc(50% - 5px);
					position: relative;
					.home_img_box {
						width: 100%;
						.home_img {
							object-fit: cover;
							width: 100%;
							height: 336px;
						}
					}
					.home_content {
						color: rgba(76, 58, 36, 1);
						background: transparent;
						font-weight: bold;
						width: 100%;
						line-height: 3;
						text-align: center;
						.home_title {
							font-size: 16px;
						}
					}
				}
			}
			.home_item3 {
				margin: 0 10px 0 0;
				display: none;
				width: 30%;
				position: relative;
				.home_img_box {
					width: 100%;
					font-size: 0;
					.home_img {
						object-fit: cover;
						width: 100%;
						height: 520px;
					}
				}
				.home_content {
					color: #fff;
					left: 0;
					bottom: 0;
					background: rgba(0,0,0,.3);
					width: 100%;
					line-height: 3;
					position: absolute;
					text-align: center;
					.home_title {
						font-size: 16px;
					}
				}
			}
			.home_item4 {
				margin: 0 0 0 0;
				display: none;
				width: 20%;
				.item4_top {
					margin: 0 0 20px;
					display: none;
					width: 100%;
					position: relative;
					.home_img_box {
						width: 100%;
						.home_img {
							object-fit: cover;
							width: 100%;
							height: 250px;
						}
					}
					.home_content {
						color: #fff;
						left: 0;
						bottom: 0;
						background: rgba(0,0,0,.3);
						width: 100%;
						line-height: 3;
						position: absolute;
						text-align: center;
						.home_title {
							font-size: 16px;
						}
					}
				}
				.item4_bottom {
					display: none;
					width: 100%;
					position: relative;
					.home_img_box {
						width: 100%;
						.home_img {
							object-fit: cover;
							width: 100%;
							height: 250px;
						}
					}
					.home_content {
						color: #fff;
						left: 0;
						bottom: 0;
						background: rgba(0,0,0,.3);
						width: 100%;
						line-height: 3;
						position: absolute;
						text-align: center;
						.home_title {
							font-size: 16px;
						}
					}
				}
			}
		}
		// list
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
			transform: rotate(0deg) scale(0.9) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			-webkit-perspective: 1000px;
			perspective: 1000px;
			transition: 0.3s;
		}
		// animation
		// 更多
		.homeList_more_view {
			cursor: pointer;
			border: 1px solid rgba(76, 58, 36, 1);
			padding: 12px 0;
			margin: 0 auto;
			color: rgba(76, 58, 36, 1);
			top: 6px;
			background: transparent;
			width: 140px;
			position: absolute;
			right: 10px;
			text-align: center;
			.homeList_more_text {
			}
			.el-icon {
			}
		}
	}
	// 首页展示
</style>