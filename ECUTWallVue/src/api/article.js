import request from '@/utils/request.js'
// import {useTokenStore} from '@/stores/token.js'

//文章分类列表查询
export const articleCategoryListService = () => {
    // const tokenStore = useTokenStore();
    // return request.get('/category',{
    //     headers:{
    //         'Authorization':tokenStore.token
    //     }
    // })
    return request.get('/category')
}

//添加文章分类
export const addArticleCategoryService = (categoryData) => {
    return request.post('/category', categoryData)
}

//编辑文章分类
export const updateArticleCategoryService = (categoryData) => {
    return request.put('/category', categoryData)
}

//删除文章分类
export const deleteArticleCategoryService = (categoryId) => {
    return request.delete('/category?id=' + categoryId)
}

//文章列表查询
export const articleListService = (params) => {
    return request.get('/article', { params:params })
}

//添加文章
export const addArticleService = (articleData) => {
    return request.post('/article', articleData)
}

//编辑文章
export const updateArticleService = (articleData) => {
    return request.put('/article', articleData)
}

//删除文章
export const deleteArticleService = (articleId) => {
    return request.delete('/article?id=' + articleId)
}