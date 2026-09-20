const config = {
    get() {
        return {
            url : process.env.VUE_APP_BASE_API_URL + process.env.VUE_APP_BASE_API + '/',
            name: process.env.VUE_APP_BASE_API,
			menuList:[
				{
					name: '线路信息管理',
					icon: '${frontMenu.fontClass}',
					child:[
						{
							name:'线路信息',
							url:'/index/xianluxinxiList'
						},
					]
				},
			]
        }
    },
    getProjectName(){
        return {
            projectName: "校车管理信息系统"
        } 
    }
}
export default config
