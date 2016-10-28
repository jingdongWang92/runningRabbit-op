package com.xiaoguo.jc.op.action.index;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONObject;
import com.xiaoguo.jc.common.model.user.UserDto;
import com.xiaoguo.jc.common.service.user.UserService;
import com.xiaoguo.jc.op.action.BaseAction;

/**
 * 首页信息加载处理
 * 
 * @author hjzeng-2015
 * 
 */
public class IndexAction extends BaseAction {
	private static final long serialVersionUID = -8186334535750003162L;

	@Autowired
	private UserService userService;

	public void queryUserCount() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<UserDto> list = userService.queryAllUserList();
			if (null == list) {
				list = new ArrayList<>();
			}
			result.put("count", list.size());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		String content = JSONObject.toJSONString(result);
		super.printJson(content);
	}

}
