<script setup>
import { ref } from 'vue'
import {useRouter} from 'vue-router'

const router = useRouter()

const userPassword = ref({
    old_pwd: '',
    new_pwd: '',
    re_pwd: ''
})

//校验密码
const checkRePassword = (rule, value, callback)=>{
    if (value === '') {
        callback(new Error('请再次确认密码'))
    }
    if (value !== userPassword.value.new_pwd) {
        callback(new Error('两次输入的密码不一致'))
    }
    else {
        callback()
    }
}

const rules = {
    old_pwd: [
        { required: true, message: '请输入原密码', trigger: 'blur' },
        { min: 5, max: 16, message: '密码长度在5到16位非空字符', trigger: 'blur' }
    ],
    new_pwd: [
        { required: true, message: '请输入新密码', trigger: 'blur' },
        { min: 5, max: 16, message: '密码长度在5到16位非空字符', trigger: 'blur' }
    ],
    re_pwd: [
        { required: true,validator: checkRePassword, trigger: 'blur' }
    ]
}



//修改密码
import {userUpdatePwdService} from '@/api/user.js'
import { ElMessage, ElMessageBox} from 'element-plus'
const updateUserPassword = async() => {
    //调用接口
    let res = await userUpdatePwdService(userPassword.value)
    ElMessage.success(res.message ? res.message : '修改成功,请重新登录')
    router.push('/login')
}
</script>
<template>
    <el-card class="page-container">
        <template #header>
            <div class="header">
                <span>修改密码</span>
            </div>
        </template>
        <el-row>
            <el-col :span="12">
                <el-form :model="userPassword" :rules="rules" label-width="100px" size="large">
                    <el-form-item label="原密码" prop="old_pwd">
                        <el-input :prefix-icon="Lock" v-model="userPassword.old_pwd"></el-input>
                    </el-form-item>
                    <el-form-item label="新密码" prop="new_pwd">
                        <el-input :prefix-icon="Lock" type="password" v-model="userPassword.new_pwd"></el-input>
                    </el-form-item>
                    <el-form-item label="确认密码" prop="re_pwd">
                        <el-input :prefix-icon="Lock" type="password" v-model="userPassword.re_pwd"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="updateUserPassword">提交修改</el-button>
                    </el-form-item>
                </el-form>
            </el-col>
        </el-row>
    </el-card>
</template>