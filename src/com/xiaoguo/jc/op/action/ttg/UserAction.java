package com.xiaoguo.jc.op.action.ttg;

import org.springframework.beans.factory.annotation.Autowired;

import com.xiaoguo.jc.common.model.user.UserDto;
import com.xiaoguo.jc.common.service.user.UserService;
import com.xiaoguo.jc.op.action.BaseAction;

public class UserAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 8003036628189138901L;

    @Autowired
    private UserService service;

    private UserDto dto;

    /**
     * 列表页
     * 
     * @return
     * @throws Exception
     */
    public String toList() throws Exception {
        if (null == dto) {
            dto = new UserDto();
        }
        dto.setPage(super.getPage());
        this.dataList = service.queryByPage(dto);
        return LIST;
    }

    /**
     * 详情页面
     * 
     * @return
     * @throws Exception
     */
    public String toDetail() throws Exception {
        if (null == dto) {
            dto = new UserDto();
        }
        return DETAIL;
    }

    public UserDto getDto() {
        return dto;
    }

    public void setDto(UserDto dto) {
        this.dto = dto;
    }

}
