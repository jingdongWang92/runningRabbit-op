package com.xiaoguo.jc.op.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.common.collect.Maps;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;
import com.xiaoguo.jc.common.enums.BaseLogEnum;
import com.xiaoguo.jc.common.model.BaseDto;
import com.xiaoguo.jc.common.model.system.operatelog.OperateLogDto;
import com.xiaoguo.jc.common.model.system.operator.OperatorDto;
import com.xiaoguo.jc.common.service.system.operatelog.OperateLogService;
import com.xiaoguo.jc.common.utils.CommonUtils;
import com.xiaoguo.jc.common.utils.GetWebConfig;
import com.xiaoguo.yo.common.util.json.JsonUtil;
import com.xiaoguo.yo.common.util.session.SessionUtil;

import baseproj.common.constants.BaseEnum;
import baseproj.common.mybatis.page.PageParameter;
import baseproj.common.util.DateTimeUtils;

/**
 * The Class BaseAction.
 */
public class BaseAction extends ActionSupport implements ServletRequestAware, ServletResponseAware, Preparable {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** The Constant log. */
	protected static final Logger log = LoggerFactory.getLogger(BaseAction.class);

	/** The request. */
	protected HttpServletRequest request;

	/** The response. */
	protected HttpServletResponse response;

	/** The page. */
	protected PageParameter page;

	/** The data list. */
	protected List<? extends BaseDto> dataList;

	/** 图片上传路径 */
	protected String imageStorePath;
	protected String imgUploadUrl;

	/** 图片外网映射地址 */
	protected String imgHttpUrl;

	/** The operate log service. */
	@Autowired
	protected OperateLogService operateLogService;

	protected static final String LIST = "list";
	protected static final String ADD = "add";
	protected static final String EDIT = "edit";
	protected static final String DETAIL = "detail";

	/**
	 * 从session里获取操作员对象.
	 * 
	 * @param request
	 *            the request
	 * @return the operator
	 * @return
	 */
	protected OperatorDto getOperator(HttpServletRequest request) {
		OperatorDto operator = null;
		try {
			HttpSession session = SessionUtil.getSession(request);
			operator = (OperatorDto) session.getAttribute("Operator");
		} catch (Exception e) {
			log.error("get Operator's info error", e);
		}
		return operator;
	}

	/**
	 * 记录操作日志.
	 * 
	 * @param enums
	 *            the enums
	 * @param des
	 *            the des
	 * @version
	 */
	protected void createOperatorLog(Enum<? extends BaseLogEnum> enums, String[] des) {
		/* 1、根据特定的条件request来组装日志对象 */
		OperateLogDto operateLog = null;
		try {
			if (enums instanceof BaseLogEnum) {
				BaseLogEnum baseLogEnum = (BaseLogEnum) enums;

				OperatorDto operator = this.getOperator(request);

				// 用户登录错误时，不需要记录操作日志
				if (operator == null) {
					return;
				}

				if (StringUtils.isBlank(des[0])) {
					des[0] = operator.getAccount();
				}
				String ip = CommonUtils.getIpAddr(request);

				operateLog = new OperateLogDto();
				operateLog.setIpaddress(ip);
				operateLog.setAccount(operator.getAccount());
				operateLog.setOperatetype(baseLogEnum.getCode());
				operateLog.setOperatetime(DateTimeUtils.getCurrentDateString());

				String logDes = baseLogEnum.getLogMsg();
				if (StringUtils.isBlank(logDes)) {
					log.error("can not find " + logDes + "log code type!");
					throw new RuntimeException();
				}
				operateLog.setDescription(CommonUtils.format(logDes, des));

				// 操作日志入日志文件
				operateLogService.addOperateLog(operateLog);
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}

	/**
	 * Save operate log.
	 * 
	 * @param enums
	 *            the enums
	 * @param des
	 *            the des
	 * @param operator
	 *            the operator
	 * @version
	 */
	protected void createOperatorLog(Enum<? extends BaseLogEnum> enums, String[] des, OperatorDto operator) {
		/* 1、根据特定的条件request来组装日志对象 */
		OperateLogDto operateLog = null;
		try {
			if (enums instanceof BaseLogEnum) {
				BaseLogEnum baseLogEnum = (BaseLogEnum) enums;

				des[0] = operator.getAccount();
				String ip = operator.getIpAddress();

				operateLog = new OperateLogDto();
				operateLog.setIpaddress(ip);
				operateLog.setAccount(operator.getAccount());
				operateLog.setOperatetype(baseLogEnum.getCode());

				String logDes = baseLogEnum.getLogMsg();
				if (StringUtils.isBlank(logDes)) {
					log.error("can not find " + logDes + "log code type!");
					throw new RuntimeException();
				}
				operateLog.setDescription(CommonUtils.format(logDes, des));
				operateLog.setOperatetime(DateTimeUtils.getCurrentDateString());
				// 操作日志入日志文件
				operateLogService.addOperateLog(operateLog);
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}

	/**
	 * 清除浏览器缓存.
	 * 
	 * @version
	 */
	public void clearBrowserCache() {
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
	}

	/**
	 * 设置json编码格式.
	 * 
	 * @version
	 */
	protected void setJsonFormat() {
		response.setContentType("text/json; charset=utf-8");
		response.setCharacterEncoding("utf-8");
	}

	/**
	 * 设置纯文本编码格式
	 * 
	 * @version
	 */
	protected void setTextFormat() {
		response.setContentType("text/plain; charset=utf-8");
		response.setCharacterEncoding("utf-8");
	}

	/**
	 * 设置网页格式
	 */
	protected void setHtmlFormat() {
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
	}

	/**
	 * 将json输出到页面
	 * 
	 * @param content
	 */
	protected void printJson(String content) {
		this.print(content, OutPutType.JSON);
	}

	/**
	 * 将text输出到页面
	 * 
	 * @param content
	 */
	protected void printText(String content) {
		this.print(content, OutPutType.TEXT);
	}

	/**
	 * 将html输出到页面
	 * 
	 * @param content
	 */
	protected void printHtml(String content) {
		this.print(content, OutPutType.HTML);
	}

	/**
	 * 将内容输出到页面
	 * 
	 * @param content
	 * @param outPutType
	 */
	protected void print(String content, OutPutType outPutType) {
		if (outPutType == OutPutType.JSON) {
			this.setJsonFormat();
		} else if (outPutType == OutPutType.TEXT) {
			this.setTextFormat();
		} else if (outPutType == OutPutType.HTML) {
			this.setHtmlFormat();
		}
		this.print(content);
	}

	/**
	 * 将内容输入到页面
	 * 
	 * @param content
	 */
	protected void print(String content) {
		PrintWriter out = null;
		try {
			out = this.response.getWriter();
			out.print(content);
		} catch (Exception e) {
		} finally {
			if (null != out) {
				out.flush();
				out.close();
			}
		}
	}

	/**
	 * 设置Excel编码格式
	 * 
	 */
	protected void setExcelFormat() {
		/** MIME类型 */
		response.setContentType("application/vnd.ms-excel");
		response.setCharacterEncoding("utf-8");
	}

	/**
	 * 
	 * 
	 * 
	 * @return WebRoot目录的绝对路径
	 */

	public static String getWebRootAbsolutePath() {
		String path = null;
		String folderPath = BaseAction.class.getProtectionDomain().getCodeSource().getLocation().getPath();
		if (folderPath.indexOf("WEB-INF") > 0) {
			path = folderPath.substring(0, folderPath.indexOf("WEB-INF/classes"));
		}
		return path;

	}

	/**
	 * Sets the servlet request.
	 * 
	 * @param request
	 *            the new servlet request
	 */
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	/**
	 * Sets the servlet response.
	 * 
	 * @param response
	 *            the new servlet response
	 */
	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	/**
	 * Gets the page.
	 * 
	 * @return the page
	 */
	public PageParameter getPage() {
		if (null == page) {
			page = new PageParameter();
		}
		return page;
	}

	/**
	 * Sets the page.
	 * 
	 * @param page
	 *            the new page
	 */
	public void setPage(PageParameter page) {
		this.page = page;
	}

	/**
	 * Gets the data list.
	 * 
	 * @return the dataList
	 * @version
	 */
	public List<? extends BaseDto> getDataList() {
		if (dataList != null) {

			// Des.encryptDES(String.valueOf(i), "MZdP^dq7");
			// aaa = URLEncoder.encode(val, "UTF-8");

			for (BaseDto base : dataList) {

				/*
				 * try { PropertyDescriptor pd =
				 * PropertyUtils.getPropertyDescriptor(base, "id"); Method m =
				 * PropertyUtils.getReadMethod(pd); m.invoke(base, ) } catch
				 * (Exception e) { e.printStackTrace(); }
				 */
			}
		}
		return dataList;
	}

	/**
	 * @return the imgHttpUrl
	 */
	public String getFileHttpUrl() {
		return GetWebConfig.getValue("qiniu.api.domain") + "/";
	}

	/**
	 * 上传响应json
	 * 
	 * @param msg
	 */
	protected void uploadResponse(String msg) {
		try {
			this.setJsonFormat();
			PrintWriter pw = response.getWriter();
			Map<String, Object> result = Maps.newHashMap();
			result.put("error", msg);
			pw.print(JsonUtil.map2json(result));
		} catch (IOException e) {
		}
	}

	/**
	 * 上传响应json
	 * 
	 * @param msg
	 */
	protected void uploadResponse(String msg, Integer id, String imageName) {
		try {
			this.setJsonFormat();
			PrintWriter pw = response.getWriter();
			Map<String, Object> result = Maps.newHashMap();
			result.put("error", msg);
			result.put("id", id);
			result.put("imageName", imageName);
			pw.print(JsonUtil.map2json(result));
		} catch (IOException e) {
		}
	}

	/**
	 * @return the imgUploadUrl
	 */
	public String getImgUploadUrl() {
		return GetWebConfig.getValue("trip.img.upload.url");
	}

	/**
	 * @return the imgHttpUrl
	 */
	public String getImgHttpUrl() {
		return GetWebConfig.getValue("trip.img.http.url");
	}

	/**
	 * 获取随机验证码
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	protected String getKaptchaExpectedCode(HttpServletRequest request) throws Exception {
		String kaptchaExpected = null;
		try {
			HttpSession session = SessionUtil.getSession(request);
			kaptchaExpected = (String) session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		} catch (Exception e) {
			LOG.error("Get Kaptcha Expected Code fail", e);
		}
		return kaptchaExpected;
	}

	@Override
	public void prepare() throws Exception {

	}

	/**
	 * 输入格式
	 * 
	 * @author hjzeng-2015
	 * 
	 */
	public enum OutPutType implements BaseEnum {
		JSON("1001", "Json"),

		TEXT("1002", "Text"),

		HTML("1003", "Html");

		public String code;

		public String name;

		OutPutType(String code, String name) {
			this.code = code;
			this.name = name;
		}

		/**
		 * Gets the code.
		 * 
		 * @return the code
		 */
		@Override
		public String getCode() {
			return code;
		}

		/**
		 * Gets the name.
		 * 
		 * @return the name
		 */
		@Override
		public String getName() {
			return name;
		}
	}
}