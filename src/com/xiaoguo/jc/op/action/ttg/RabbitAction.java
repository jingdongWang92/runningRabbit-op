package com.xiaoguo.jc.op.action.ttg;

import java.io.PrintWriter;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.xiaoguo.jc.common.dto.base.ResultMessage;
import com.xiaoguo.jc.common.model.rabbit.RabbitDto;
import com.xiaoguo.jc.common.service.exception.JcServiceException;
import com.xiaoguo.jc.common.service.rabbit.RabbitService;
import com.xiaoguo.jc.op.action.BaseAction;
import com.xiaoguo.yo.common.util.json.JsonUtil;

public class RabbitAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 8003036628189138901L;

    @Autowired
    private RabbitService service;

    private RabbitDto dto;

    /**
     * 列表页
     * 
     * @return
     * @throws Exception
     */
    public String toList() throws Exception {
        if (dto == null) {
            dto = new RabbitDto();
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
        if (null == dto || null == dto.getId()) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "对象为null,操作非法！");
        }
        dto = service.select(dto);
        return DETAIL;
    }

    /**
     * 新增页面
     * 
     * @return
     * @throws Exception
     */
    public String toAdd() throws Exception {
        return ADD;
    }

    /**
     * 执行新增操作
     * 
     * @throws Exception
     */
    public void add() throws Exception {
        super.setJsonFormat();
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        try {
            if (null == dto) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "对象为null,操作非法！");
            }
            if (StringUtils.isNotBlank(dto.getUuid()) && !dto.getUuid().matches(
                    "([a-f0-9A-F]){8,8}-([a-fA-F0-9]){4,4}-([a-fA-F0-9]){4,4}-([a-fA-F0-9]){4,4}-([a-fA-F0-9]){12,12}")) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "uuid 格式有误！");
            }

            if (null == dto.getMajor() || !dto.getMajor().matches("[0-9]{0,5}")) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "major 格式有误！");
            }
            int major = Integer.valueOf(dto.getMajor());
            if (major < 0 || major > 65535) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "major 范围有误！");
            }

            if (null == dto.getMinor() || !dto.getMinor().matches("[0-9]{0,5}")) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "minor 格式有误！");
            }
            int minor = Integer.valueOf(dto.getMinor());
            if (minor < 0 || minor > 65535) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "minor 范围有误！");
            }
            service.insert(dto);
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("新增成功");
        } catch (JcServiceException e) {
            rm.setMessage("新增失败." + e.getErroDesc());
        } catch (Exception e) {
            rm.setMessage("添加失败.");
        } finally {
            PrintWriter pw = response.getWriter();
            pw.write(JsonUtil.bean2json(rm));
        }
    }

    /**
     * 修改页面
     * 
     * @return
     * @throws Exception
     */
    public String toEdit() throws Exception {
        if (null == dto || null == dto.getId()) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "对象为null,操作非法！");
        }
        dto = service.select(dto);
        return EDIT;
    }

    /**
     * 执行修改参数操作
     * 
     * @throws Exception
     */
    public void edit() throws Exception {
        super.setJsonFormat();
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        try {
            if (null == dto || null == dto.getId()) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "对象为null,操作非法！");
            }
            if (StringUtils.isNotBlank(dto.getUuid()) && !dto.getUuid().matches(
                    "([a-f0-9A-F]){8,8}-([a-fA-F0-9]){4,4}-([a-fA-F0-9]){4,4}-([a-fA-F0-9]){4,4}-([a-fA-F0-9]){12,12}")) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "uuid 格式有误！");
            }

            if (null == dto.getMajor() || !dto.getMajor().matches("[0-9]{0,5}")) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "major 格式有误！");
            }
            int major = Integer.valueOf(dto.getMajor());
            if (major < 0 || major > 65535) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "major 范围有误！");
            }

            if (null == dto.getMinor() || !dto.getMinor().matches("[0-9]{0,5}")) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "minor 格式有误！");
            }
            int minor = Integer.valueOf(dto.getMinor());
            if (minor < 0 || minor > 65535) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "minor 范围有误！");
            }
            service.update(dto);
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("修改成功");
        } catch (JcServiceException e) {
            rm.setMessage("修改失败." + e.getErroDesc());
        } catch (Exception e) {
            rm.setMessage("修改失败.");
        } finally {
            PrintWriter pw = response.getWriter();
            pw.write(JsonUtil.bean2json(rm));
        }
    }

    /**
     * 执行修改参数操作
     * 
     * @throws Exception
     */
    public void del() throws Exception {
        super.setJsonFormat();
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        try {
            if (null == dto || null == dto.getId()) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "对象为null,操作非法！");
            }
            service.delete(dto);
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("删除成功");
        } catch (JcServiceException e) {
            rm.setMessage("删除失败." + e.getErroDesc());
        } catch (Exception e) {
            rm.setMessage("删除失败.");
        } finally {
            PrintWriter pw = response.getWriter();
            pw.write(JsonUtil.bean2json(rm));
        }
    }

    public RabbitDto getDto() {
        return dto;
    }

    public void setDto(RabbitDto dto) {
        this.dto = dto;
    }

}
