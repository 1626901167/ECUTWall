<script setup>
import {
    Edit,
    Delete
} from '@element-plus/icons-vue'
import { QuillEditor } from '@vueup/vue-quill'
import '@vueup/vue-quill/dist/vue-quill.snow.css'

import { ref } from 'vue'

//文章分类数据模型
const categorys = ref([
    {
        "id": 0,
        "categoryName": "",
        "categoryAlias": "",
        "createTime": "",
        "updateTime": ""
    }
])

//用户搜索时选中的分类id
const categoryId = ref('')

//用户搜索时选中的发布状态
const state = ref('')

//文章列表数据模型
const articles = ref([
    {
        "id": 0,
        "title": "",
        "content": "",
        "coverImg": "",
        "state": "草稿",
        "categoryId": 0,
        "createTime": "",
        "updateTime": ""
    }
])

//分页条数据模型
const pageNum = ref(1)//当前页
const total = ref(20)//总条数
const pageSize = ref(3)//每页条数

//当每页条数发生了变化，调用此函数
const onSizeChange = (size) => {
    pageSize.value = size
    getArticleList()
}
//当前页码发生变化，调用此函数
const onCurrentChange = (num) => {
    pageNum.value = num
    getArticleList()
}

//回显文章分类
import { articleCategoryListService,  articleListService, addArticleService, updateArticleService, deleteArticleService} from '@/api/article.js'
const getArticleCategoryList = async () => {
    let res = await articleCategoryListService();
    categorys.value = res.data;
}
getArticleCategoryList()

//获取文章列表数据
const getArticleList = async () => {
    let res = await articleListService({
        pageNum: pageNum.value,
        pageSize: pageSize.value,
        categoryId: categoryId.value ? categoryId.value : null,
        state: state.value ? state.value : null
    })
    //渲染视图
    articles.value = res.data.items;
    total.value = res.data.total;

    //处理数据，给数据模型扩展一个属性categoryName，分类名称
    articles.value.forEach(article => {
        categorys.value.forEach(category => {
            if (article.categoryId == category.id) {
                article.categoryName = category.categoryName;
            }
        })
    })

}
getArticleList()

import { Plus } from '@element-plus/icons-vue'
//控制抽屉是否显示
const visibleDrawer = ref(false)
//添加表单数据模型
const articleModel = ref({
    title: '',
    categoryId: '',
    coverImg: '',
    content: '',
    state: ''
})

//导入token
import { useTokenStore } from '@/stores/token.js'
const tokenStore = useTokenStore()

//上传成功的回调函数
const uploadSuccess = (res) => {
    articleModel.value.coverImg = res.data;
    console.log(res.data);
}

//添加文章
import {ElMessage} from 'element-plus'
const addArticle = async (clickState) => {
    //把发布状态赋值给数据模型
    articleModel.value.state = clickState;

    //调用接口
    let res = await addArticleService(articleModel.value);

    ElMessage.success(res.message? res.message : '添加成功');
    
    //关闭抽屉
    visibleDrawer.value = false;

    //刷新列表
    getArticleList();
}

//展示文章
const showArticle = async (article) => {
    visibleDrawer.value = true;
    //把文章数据赋值给表单数据模型
    articleModel.value = article;
}

//添加文章
const updateArticle = async (clickState) => {
    //把发布状态赋值给数据模型
    articleModel.value.state = clickState;

    //调用接口
    let res = await updateArticleService(articleModel.value);

    ElMessage.success(res.message? res.message : '修改成功');
    
    //关闭抽屉
    visibleDrawer.value = false;

    //刷新列表
    getArticleList();
}

//删除文章
import { ElMessageBox } from 'element-plus'
const deleteArticle = async (id) => {
//提示用户 确认框
ElMessageBox.confirm(
        '你确认删除该文章信息吗？',
        '温馨提示',
        {
            confirmButtonText: '确认',
            cancelButtonText: '取消',
            type: 'warning',
        }
    )
        .then(async () => {
            //调用接口
            await deleteArticleService(id);
            //用户点击了确认
            ElMessage({
                type: 'success',
                message: '删除成功',
            })
            //调用获取所有文章分类的函数
            getArticleList();
        })
        .catch(() => {
            //用户点击了取消
            ElMessage({
                type: 'info',
                message: '取消删除',
            })
        })
}

//清空抽屉
const clearDrawer = () => {
    articleModel.value = {
        title: '',
        categoryId: '',
        coverImg: '',
        content: ' ',
        state: ''
    }
}

//定义抽屉标题
const title = ref('')

</script>
<template>
    <el-card class="page-container">
        <template #header>
            <div class="header">
                <span>文章管理</span>
                <div class="extra">
                    <el-button type="primary" @click="clearDrawer(); SetWidowsTest; visibleDrawer = true; title = '添加文章';">添加文章</el-button>
                </div>
            </div>
        </template>
        <!-- 搜索表单 -->
        <el-form inline>
            <el-form-item label="文章分类：">
                <el-select placeholder="请选择" v-model="categoryId" style="width: 240px">
                    <el-option v-for="c in categorys" :key="c.id" :label="c.categoryName" :value="c.id">
                    </el-option>
                </el-select>
            </el-form-item>

            <el-form-item label="发布状态：">
                <el-select placeholder="请选择" v-model="state" style="width: 240px">
                    <el-option label="已发布" value="已发布"></el-option>
                    <el-option label="草稿" value="草稿"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="getArticleList">搜索</el-button>
                <el-button @click="categoryId = ''; state = ''">重置</el-button>
            </el-form-item>
        </el-form>
        <!-- 文章列表 -->
        <el-table :data="articles" style="width: 100%">
            <el-table-column label="文章标题" width="400" prop="title"></el-table-column>
            <el-table-column label="分类" prop="categoryName"></el-table-column>
            <el-table-column label="发表时间" prop="createTime"> </el-table-column>
            <el-table-column label="状态" prop="state"></el-table-column>
            <el-table-column label="操作" width="100">
                <template #default="{ row }">
                    <el-button :icon="Edit" circle plain type="primary" @click="showArticle(row); title = '修改文章'"></el-button>
                    <el-button :icon="Delete" circle plain type="danger" @click="deleteArticle(row.id)"></el-button>
                </template>
            </el-table-column>
            <template #empty>
                <el-empty description="没有数据" />
            </template>
        </el-table>
        <!-- 分页条 -->
        <el-pagination v-model:current-page="pageNum" v-model:page-size="pageSize" :page-sizes="[3, 5, 10, 15]"
            layout="jumper, total, sizes, prev, pager, next" background :total="total" @size-change="onSizeChange"
            @current-change="onCurrentChange" style="margin-top: 20px; justify-content: flex-end" />
        <!-- 抽屉 -->
        <el-drawer v-model="visibleDrawer" :title="title" direction="rtl" size="50%">
            <!-- 添加文章表单 -->
            <el-form :model="articleModel" label-width="100px">
                <el-form-item label="文章标题">
                    <el-input v-model="articleModel.title" placeholder="请输入标题"></el-input>
                </el-form-item>
                <el-form-item label="文章分类">
                    <el-select placeholder="请选择" v-model="articleModel.categoryId">
                        <el-option v-for="c in categorys" :key="c.id" :label="c.categoryName" :value="c.id">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="文章封面">
                    <!-- 
                        auto-upload:设置文字是否自动上传
                        action:设置服务器接口路径
                        name:设置上传文件字段名
                        headers:设置上传文件请求头
                        on-success:设置上传成功的回调函数
                     -->
                    <el-upload class="avatar-uploader" :auto-upload="true" :show-file-list="false" action="/api/upload"
                        name="file" :headers="{ 'Authorization': tokenStore.token }" :on-success="uploadSuccess">
                        <img v-if="articleModel.coverImg" :src="articleModel.coverImg" class="avatar" />
                        <el-icon v-else class="avatar-uploader-icon">
                            <Plus />
                        </el-icon>
                    </el-upload>
                </el-form-item>
                <el-form-item label="文章内容">
                    <div class="editor">
                        <quill-editor theme="snow" v-model:content="articleModel.content" contentType="html">
                        </quill-editor>
                    </div>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="title=='添加文章'? addArticle('已发布'): updateArticle('已发布')">发布</el-button>
                    <el-button type="info" @click="title=='添加文章'? addArticle('草稿') : updateArticle('草稿')">草稿</el-button>
                </el-form-item>
            </el-form>
        </el-drawer>
    </el-card>
</template>
<style lang="scss" scoped>
.page-container {
    min-height: 100%;
    box-sizing: border-box;

    .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
}

/* 抽屉样式 */
.avatar-uploader {
    :deep() {
        .avatar {
            width: 178px;
            height: 178px;
            display: block;
        }

        .el-upload {
            border: 1px dashed var(--el-border-color);
            border-radius: 6px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: var(--el-transition-duration-fast);
        }

        .el-upload:hover {
            border-color: var(--el-color-primary);
        }

        .el-icon.avatar-uploader-icon {
            font-size: 28px;
            color: #8c939d;
            width: 178px;
            height: 178px;
            text-align: center;
        }
    }
}

.editor {
    width: 100%;

    :deep(.ql-editor) {
        min-height: 200px;
    }
}
</style>