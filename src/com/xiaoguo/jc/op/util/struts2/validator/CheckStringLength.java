package com.xiaoguo.jc.op.util.struts2.validator;

import com.opensymphony.xwork2.validator.ValidationException;
import com.opensymphony.xwork2.validator.validators.FieldValidatorSupport;

import java.io.UnsupportedEncodingException;

/**
 * 
 * @author :
 * @version : 1.00 Create Time : 2011-3-16-下午12:56:32 Description :
 *          Struts2自定义验证--根据编码格式验证字符串长度 History： Editor version Time Operation
 *          Description*
 * 
 * 
 */

public class CheckStringLength extends FieldValidatorSupport {

    private boolean trim; // 是否去首位空格
    private int minLength; // 最大长度
    private int maxLength; // 最小长度
    private static final String ENCODING = "UTF-8"; // 编码格式(默认utf-8)

    /*
     * 构造方法初始化默认数据
     */
    public CheckStringLength() {
        this.trim = true;
        this.minLength = -1;
        this.maxLength = -1;
    }

    public boolean isTrim() {
        return trim;
    }

    public void setTrim(boolean trim) {
        this.trim = trim;
    }

    public int getMinLength() {
        return minLength;
    }

    public void setMinLength(int minLength) {
        this.minLength = minLength;
    }

    public int getMaxLength() {
        return maxLength;
    }

    public void setMaxLength(int maxLength) {
        this.maxLength = maxLength;
    }

    @Override
    public void validate(Object arg0) throws ValidationException {
        String fieldName = this.getFieldName();

        String val = (String) this.getFieldValue(fieldName, arg0);

        // 如果值为空则直接不通过
        if (val == null || val.length() <= 0) {
            return;
        }

        if (trim) {
            val = val.trim();
            // //如果值为空则直接不通过
            if (val == null || val.length() <= 0) {
                return;
            }
        }

        int length = 0;
        try {
            // 根据编码格式获得字符长度
            length = val.getBytes(ENCODING).length;
        } catch (UnsupportedEncodingException e) {
            length = val.getBytes().length;
        }

        /*
         * 判断字符长度范围
         */
        if (minLength > -1 && length < minLength) {
            this.addFieldError(fieldName, arg0);
        }
        if (maxLength > -1 && maxLength > maxLength) {
            this.addFieldError(fieldName, arg0);
        }
    }

}
