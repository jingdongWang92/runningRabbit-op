package com.xiaoguo.jc.op.util.struts2.validator;

import com.opensymphony.xwork2.validator.ValidationException;
import com.opensymphony.xwork2.validator.validators.FieldValidatorSupport;

/**
 * 验证字符串是否为半角
 * 
 * @author Administrator
 * 
 */
public class CheckHalfWidthDigit extends FieldValidatorSupport {

    @Override
    public void validate(Object arg0) throws ValidationException {
        String fieldName = this.getFieldName();
        // 得到用户输入字符串
        String fieldValue = (String) this.getFieldValue(fieldName, arg0);

        char[] chars = fieldValue.toCharArray();
        // 循环验证用户输入的字符串是否为半角
        for (int i = 0; i < chars.length; i++) {
            if (chars[i] > '\uFF00' && chars[i] < '\uFF5F') {
                this.addFieldError(fieldName, arg0);
                return;
            }
        }
    }

}
