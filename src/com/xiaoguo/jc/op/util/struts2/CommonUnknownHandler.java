package com.xiaoguo.jc.op.util.struts2;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.Result;
import com.opensymphony.xwork2.UnknownHandler;
import com.opensymphony.xwork2.XWorkException;
import com.opensymphony.xwork2.config.entities.ActionConfig;
import com.opensymphony.xwork2.config.entities.ResultConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;

/**
 * The Class RDUnknownHandler.
 * 
 * @author
 */
public class CommonUnknownHandler implements UnknownHandler {

    /** The Constant logger. */
    private static final Logger logger = LoggerFactory.getLogger(CommonUnknownHandler.class);

    /**
     * Handle unknown action.
     * 
     * @param namespace
     *            the namespace
     * @param actionName
     *            the action name
     * @return the action config
     * @throws XWorkException
     *             the x work exception
     * @version
     */
    @Override
    public ActionConfig handleUnknownAction(String namespace, String actionName) throws XWorkException {
        logger.warn("struts2 namespace = {} and actionName = {} is unknown!", new Object[] {namespace, actionName});
        return new CommonActionConfig();
    }

    /**
     * Handle unknown result.
     * 
     * @param actionContext
     *            the action context
     * @param actionName
     *            the action name
     * @param actionConfig
     *            the action config
     * @param resultCode
     *            the result code
     * @return the result
     * @throws XWorkException
     *             the x work exception
     * @version
     */
    @Override
    public Result handleUnknownResult(ActionContext actionContext, String actionName, ActionConfig actionConfig,
                                      String resultCode) throws XWorkException {
        logger.warn("struts2 actionName = {} and resultCode = {} is unknown!", new Object[] {actionName, resultCode});
        return null;
    }

    /**
     * Handle unknown action method.
     * 
     * @param action
     *            the action
     * @param methodName
     *            the method name
     * @return the object
     * @throws NoSuchMethodException
     *             the no such method exception
     * @version
     */
    @Override
    public Object handleUnknownActionMethod(Object action, String methodName) throws NoSuchMethodException {
        logger.warn("struts2 action = {} and methodName = {} is unknown!", new Object[] {action, methodName});
        return "page404";
    }

    private static class CommonActionConfig extends ActionConfig {

        /** The Constant serialVersionUID. */
        private static final long serialVersionUID = -393935372633769831L;

        /**
         * Instantiates a new m2 m action config.
         */
        public CommonActionConfig() {
            super("default", CommonUnknownHandler.class.getName(), "com.xiaoguo.jc.op.util.struts2");
            ResultConfig conf = new CommonResultConfig("page400",
                    "org.apache.struts2.dispatcher.ServletDispatcherResult");
            this.getResults().put("page404", conf);
        }

        /**
         * Gets the results.
         * 
         * @return the results
         */
        @Override
        public Map<String, ResultConfig> getResults() {
            return super.getResults();
        }
    }

    /**
     * The Class RDResultConfig.
     */
    private static class CommonResultConfig extends ResultConfig {

        /** The Constant serialVersionUID. */
        private static final long serialVersionUID = 620034000146938795L;

        /**
         * Instantiates a new m2 m result config.
         * 
         * @param name
         *            the name
         * @param className
         *            the class name
         */
        public CommonResultConfig(String name, String className) {
            super(name, className);
            this.getParams().put("location", "/syserror.jsp");
        }
    }

}
