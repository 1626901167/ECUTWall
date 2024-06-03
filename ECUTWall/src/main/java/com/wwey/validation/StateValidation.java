package com.wwey.validation;

import com.wwey.anno.State;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class StateValidation implements ConstraintValidator<State,String> {

    /*
    *
    * @param value   将来要校验的数据
    * @param context /  context in which the constraint is evaluated
    *
    * @return 如果返回false，则校验不通过，如果返回true，则校验通过
    *
    * */

    @Override
    public boolean isValid(String value, ConstraintValidatorContext constraintValidatorContext) {
        //提供校验规则
        if(value ==null){
            return false;
        }
        return value.equals("已发布") || value.equals("草稿");
    }
}
