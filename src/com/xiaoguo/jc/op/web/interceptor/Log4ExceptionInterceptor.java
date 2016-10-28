package com.xiaoguo.jc.op.web.interceptor;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.StrutsStatics;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

import baseproj.common.exception.BaseServiceException;

/**
 * @desc struts2拦截器 ———— log记录异常
 */
public class Log4ExceptionInterceptor extends AbstractInterceptor {

    /** */
    private static final long serialVersionUID = 5525407325186621028L;
    private static final Logger logger = LoggerFactory.getLogger(Log4ExceptionInterceptor.class);

    /**
     * Intercept.
     * 
     * @param ai
     *            the ai
     * @return the string
     * @throws Exception
     *             the exception
     * @version
     */
    @Override
    public String intercept(ActionInvocation ai) throws Exception {
        try {
            return ai.invoke();
        } catch (Throwable e) {
            logger.error("Action Invocation Exception:", e);
            int code = 500;
            String msg = null;
            if (e instanceof BaseServiceException) {
            	BaseServiceException excetipn = (BaseServiceException)e;
            	code = excetipn.getErroCode();
            	msg = excetipn.getErroDesc();
			}else{
				msg = e.getMessage();
			}
            ActionContext actionContext = ai.getInvocationContext();   
            HttpServletRequest request= (HttpServletRequest) actionContext.get(StrutsStatics.HTTP_REQUEST);   
            request.setAttribute("code", code);
            request.setAttribute("msg", msg);
            return "error";
        }
    }

}
