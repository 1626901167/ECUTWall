<script setup>
import {
    Edit,
    Delete
} from '@element-plus/icons-vue'
import { ref } from 'vue'
const categorys = ref([
    {
        "id": 0,
        "categoryName": "",
        "categoryAlias": "",
        "createTime": "",
        "updateTime": ""
    }
])

//声明一个异步函数
import { articleCategoryListService, addArticleCategoryService, updateArticleCategoryService, deleteArticleCategoryService } from '@/api/article.js'
const articleCategoryList = async () => {
    let res = await articleCategoryListService();
    categorys.value = res.data;
}
articleCategoryList();

//控制添加分类弹窗
const dialogVisible = ref(false)

//添加分类数据模型
const categoryModel = ref({
    categoryName: '',
    categoryAlias: ''
})
//添加分类表单校验
const rules = {
    categoryName: [
        { required: true, message: '请输入分类名称', trigger: 'blur' },
    ],
    categoryAlias: [
        { required: true, message: '请输入分类别名', trigger: 'blur' },
    ]
}

//调用接口添加表单
import { ElMessage } from 'element-plus'
const addCategory = async () => {
    //调用接口
    let res = await addArticleCategoryService(categoryModel.value);

    ElMessage.success(res.message ? res.message : '添加成功')

    //调用获取所有文章分类的函数
    articleCategoryList();

    //关闭弹窗
    dialogVisible.value = false;
}

//定义弹层标题
const title = ref('')

//展示编辑弹窗
const showDialog = (row) => {
    dialogVisible.value = true;
    title.value = '修改分类';
    //数据拷贝
    categoryModel.value.categoryName = row.categoryName;
    categoryModel.value.categoryAlias = row.categoryAlias;
    //扩展id属性，转递后台用于修改
    categoryModel.value.id = row.id;
}

//编辑分类
const updateCategory = async () => {
    //调用接口
    let res = await updateArticleCategoryService(categoryModel.value);

    ElMessage.success(res.message ? res.message : '修改成功')

    clearDialog();

    //调用获取所有文章分类的函数
    articleCategoryList();

    //关闭弹窗
    dialogVisible.value = false;
}

//删除分类
import { ElMessageBox } from 'element-plus'
const deleteCategory = async (id) => {
    //提示用户 确认框
    ElMessageBox.confirm(
        '你确认删除该分类信息吗？',
        '温馨提示',
        {
            confirmButtonText: '确认',
            cancelButtonText: '取消',
            type: 'warning',
        }
    )
        .then(async () => {
            //调用接口
            await deleteArticleCategoryService(id);
            //用户点击了确认
            ElMessage({
                type: 'success',
                message: '删除成功',
            })
            //调用获取所有文章分类的函数
            articleCategoryList();
        })
        .catch(() => {
            //用户点击了取消
            ElMessage({
                type: 'info',
                message: '取消删除',
            })
        })

}

//清空弹窗数据
const clearDialog = () => {
    categoryModel.value.categoryName = '';
    categoryModel.value.categoryAlias = '';
}

</script>
<template>
    <el-card class="page-container">
        <template #header>
            <div class="header">
                <span>文章分类</span>
                <div class="extra">
                    <el-button type="primary"
                        @click="dialogVisible = true; title = '添加分类'; clearDialog()">添加分类</el-button>
                </div>
            </div>
        </template>
        <el-table :data="categorys" style="width: 100%">
            <el-table-column label="序号" width="100" type="index"> </el-table-column>
            <el-table-column label="分类名称" prop="categoryName"></el-table-column>
            <el-table-column label="分类别名" prop="categoryAlias"></el-table-column>
            <el-table-column label="操作" width="100">
                <template #default="{ row }">
                    <el-button :icon="Edit" circle plain type="primary" @click="showDialog(row)"></el-button>
                    <el-button :icon="Delete" circle plain type="danger" @click="deleteCategory(row.id)"></el-button>
                </template>
            </el-table-column>
            <template #empty>
                <el-empty description="没有数据" />
            </template>
        </el-table>

        <!-- 添加分类弹窗 -->
        <el-dialog v-model="dialogVisible" :title="title" width="30%">
            <el-form :model="categoryModel" :rules="rules" label-width="100px" style="padding-right: 30px">
                <el-form-item label="分类名称" prop="categoryName">
                    <el-input v-model="categoryModel.categoryName" minlength="1" maxlength="10"></el-input>
                </el-form-item>
                <el-form-item label="分类别名" prop="categoryAlias">
                    <el-input v-model="categoryModel.categoryAlias" minlength="1" maxlength="15"></el-input>
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="dialogVisible = false">取消</el-button>
                    <el-button type="primary" @click="title == '添加分类' ? addCategory() : updateCategory()"> 确认
                    </el-button>
                </span>
            </template>
        </el-dialog>
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
</style>