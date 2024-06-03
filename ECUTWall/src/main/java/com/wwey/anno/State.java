package com.wwey.anno;


import com.wwey.validation.StateValidation;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Documented//元注解
@Constraint(
        validatedBy = {StateValidation.class} //指定提供的校验规则
)
@Target({ElementType.FIELD})//元注解
@Retention(RetentionPolicy.RUNTIME)//元注解

public @interface State {

    //提供校验失败后的提示信息
    String message() default "state参数只能是草稿或者已发布";

    //指定分组
    Class<?>[] groups() default {};

    //负载 获取到State注解的附加信息
    Class<? extends Payload>[] payload() default {};

}

