package com.xiaoguo.jc.op.action.login;

import com.opensymphony.xwork2.interceptor.annotations.InputConfig;
import com.xiaoguo.jc.common.enums.OperateLogEnum;
import com.xiaoguo.jc.common.model.system.operator.OperatorDto;
import com.xiaoguo.jc.common.service.system.login.OpLoginService;
import com.xiaoguo.jc.common.service.system.login.impl.OpLoginServiceException;
import com.xiaoguo.jc.common.utils.CommonUtils;
import com.xiaoguo.jc.common.utils.GetWebConfig;
import com.xiaoguo.jc.op.action.BaseAction;
import com.xiaoguo.yo.common.util.session.SessionUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * The Class LoginAction.
 * 
 * @author
 */
public class LoginAction extends BaseAction {

    /** The Constant serialVersionUID. */
    private static final long serialVersionUID = 5550998471573943593L;

    /** The login service. */
    @Autowired
    private OpLoginService loginService;

    /** The operator. */
    private OperatorDto operator;

    /**
     * Execute.
     * 
     * @return the string
     * @throws Exception
     *             the exception
     * @version
     */
    @Override
    public String execute() throws Exception {
        return LOGIN;
    }

    /**
     * Login.
     * 
     * @return the string
     * @throws Exception
     *             the exception
     * @version
     */
    @InputConfig(resultName = "login")
    public String login() throws Exception {
        String[] des = new String[2];
        try {
            operator = operator == null ? new OperatorDto() : operator;
            des[0] = operator.getAccount();
            // 校验随机验证码是否正确
            this.validateLoginCode();
            // 获取验证登录并获取操作员信息
            operator = loginService.checkLogin(operator);
            // 设置IP地址
            operator.setIpAddress(CommonUtils.getIpAddr(request));

            SessionUtil.createSession(request, "Operator", operator);
            // 设置操作员权限和菜单
            loginService.addOperatorPrivs(request, operator);
            des[1] = getText("common.log.success");
        } catch (OpLoginServiceException e) {
            des[1] = getText("common.log.fail");
            int erroCode = e.getErroCode();
            if (erroCode == OpLoginServiceException.ACCOUNT_OR_PASSWORD_ERROR
                    || erroCode == OpLoginServiceException.USER_STOP_LOGOUT) {
                this.request.setAttribute("accountError", e.getErroDesc());
                return LOGIN;
            } else if (erroCode == OpLoginServiceException.VALIDTE_CODE_ERROR) {
                this.request.setAttribute("validcodeError", e.getErroDesc());
                return LOGIN;
            } else {
                this.request.setAttribute("message", e.getErroDesc());
                throw e;
            }
        } finally {
            super.createOperatorLog(OperateLogEnum.System.SYS_LOGIN, des);
        }

        return SUCCESS;
    }

    /**
     * 校验登录参数
     * 
     * @throws Exception
     */
    public void validateLogin() throws Exception {
        operator = operator == null ? new OperatorDto() : operator;
        String account = operator.getAccount();
        if (StringUtils.isBlank(account)) {
            this.request.setAttribute("accountError",
                    this.getText("login.input.username") + this.getText("common.input.required"));
            return;
        }
        String password = operator.getPassword();
        if (StringUtils.isBlank(password)) {
            this.request.setAttribute("passwordError",
                    this.getText("login.input.password") + this.getText("common.input.required"));
            return;
        }
        String validateCode = operator.getValidcode();
        if (StringUtils.isBlank(validateCode)) {
            this.request.setAttribute("validcodeError",
                    this.getText("login.input.validcode") + this.getText("common.input.required"));
            return;
        }
    }

    /**
     * 校验验证码不正确的方法.
     * 
     * @throws Exception
     *             the exception
     * @return
     */
    private void validateLoginCode() throws Exception {
        String sesValidCode = getKaptchaExpectedCode(request);
        if (StringUtils.isBlank(operator.getValidcode()) || !operator.getValidcode().equalsIgnoreCase(sesValidCode)) {
            throw new OpLoginServiceException(OpLoginServiceException.VALIDTE_CODE_ERROR);
        }
    }

    /**
     * 注销OP门户.
     * 
     * @return the string
     * @return
     */
    public void logout() throws Exception {
        // SSO方式登录时，usercode存在，反之，不存在
        String usercode = (String) SessionUtil.getSession(request).getAttribute("SSO_APP_USER_NAME");
        SessionUtil.getSession(request).invalidate();
        // 登出后跳转路径
        String redirectUrl = "/login.action";
        if (StringUtils.isBlank(usercode)) {
            // 非SSO登录
            StringBuilder urlBuilder = new StringBuilder(request.getContextPath()).append(redirectUrl);
            if (operator != null && StringUtils.isNotBlank(operator.getAccount())) {
                urlBuilder.append("?").append("operator.account=").append(operator.getAccount());
            }
            redirectUrl = urlBuilder.toString();
        } else {
            redirectUrl = GetWebConfig.getValue("web.sso.logout.url");
        }

        response.sendRedirect(redirectUrl);
    }

    /**
     * Gets the operator.
     * 
     * @return the operator
     */
    public OperatorDto getOperator() {
        return operator;
    }

    /**
     * Sets the operator.
     * 
     * @param operator
     *            the operator to set
     */
    public void setOperator(OperatorDto operator) {
        this.operator = operator;
    }
}
