package com.xiaoguo.jc.op.action.ttg;

import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;

import com.xiaoguo.jc.common.dto.base.ResultMessage;
import com.xiaoguo.jc.common.model.activity.ActivityDto;
import com.xiaoguo.jc.common.model.activity.ActivityRabbitRelDto;
import com.xiaoguo.jc.common.model.rabbit.RabbitDto;
import com.xiaoguo.jc.common.service.activity.ActivityRabbitRelService;
import com.xiaoguo.jc.common.service.activity.ActivityService;
import com.xiaoguo.jc.common.service.exception.JcServiceException;
import com.xiaoguo.jc.common.service.rabbit.RabbitService;
import com.xiaoguo.jc.op.action.BaseAction;
import com.xiaoguo.yo.common.util.DateTimeUtils;
import com.xiaoguo.yo.common.util.json.JsonUtil;

import baseproj.common.mybatis.page.PageParameter;

public class ActivityAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 8003036628189138901L;

    @Autowired
    private ActivityService service;
    @Autowired
    private RabbitService rabbitService;
    @Autowired
    private ActivityRabbitRelService activityRabbitRelService;

    private RabbitDto rabbitDto;

    private ActivityDto dto;

    /**
     * 列表页
     * 
     * @return
     * @throws Exception
     */
    public String toList() throws Exception {
        if (null == dto) {
            dto = new ActivityDto();
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
        if (null == dto) {
            dto = new ActivityDto();
        }
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
            service.insert(dto);
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("新增成功");
        } catch (JcServiceException e) {
            rm.setMessage("新增失败." + e.getErroDesc());
        } catch (Exception e) {
            rm.setMessage("修改失败.");
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

    /**
     * 进入设置兔子页面 (地图页)
     * 
     * @return
     * @throws Exception
     */
    public String toSetRabbitMap() throws Exception {
        if (null == dto || null == dto.getId()) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "对象为null,操作非法！");
        }
        dto = service.select(dto);
        // ActivityRabbitRelDto param = new ActivityRabbitRelDto();
        // param.setPage(new PageParameter(1, Integer.MAX_VALUE));
        // param.setAid(dto.getId());
        // dataList = activityRabbitRelService.queryByPage(dto);
        RabbitDto param = new RabbitDto();
        param.setAid(dto.getId());
        param.setPage(new PageParameter(1, Integer.MAX_VALUE));
        dataList = rabbitService.queryByAid(param);
        return "setRabbitMap";
    }

    /**
     * pupup弹窗选择兔子
     * 
     * @return
     * @throws Exception
     */
    public String toAddRabbit() throws Exception {
        if (null == dto || null == dto.getId()) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "参数有误！");
        }
        rabbitDto = new RabbitDto();
        rabbitDto.setAid(dto.getId());
        rabbitDto.setPage(super.getPage());
        //dataList = rabbitService.queryNotInRelByPage(rabbitDto);
        dataList = rabbitService.queryNotInRelAndInRange(rabbitDto);
        return "addRabbit";
    }

    /**
     * 设置活动和兔子的关联关系
     * 
     * @return
     * @throws Exception
     */
    public void addActivityRabbitRel() throws Exception {
        super.setJsonFormat();
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        try {
            if (null == dto || null == dto.getId() || null == rabbitDto || null == rabbitDto.getId()) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "参数有误！");
            }
            ActivityRabbitRelDto arrd = new ActivityRabbitRelDto();
            arrd.setAid(dto.getId());
            arrd.setRid(rabbitDto.getId());
            arrd.setCreateTime(DateTimeUtils.getNowDatetime());
            arrd.setOid(super.getOperator(request).getOperatorno());
            activityRabbitRelService.insert(arrd);
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("设置成功");
        } catch (JcServiceException e) {
            rm.setMessage("设置失败." + e.getErroDesc());
        } catch (Exception e) {
            rm.setMessage("设置失败.");
        } finally {
            PrintWriter pw = response.getWriter();
            pw.write(JsonUtil.bean2json(rm));
        }
    }

    /**
     * 设置活动和兔子的关联关系
     * 
     * @return
     * @throws Exception
     */
    public void delActivityRabbitRel() throws Exception {
        super.setJsonFormat();
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        try {
            if (null == dto || null == dto.getId() || null == rabbitDto || null == rabbitDto.getId()) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "参数有误！");
            }
            ActivityRabbitRelDto arrd = new ActivityRabbitRelDto();
            arrd.setAid(dto.getId());
            arrd.setRid(rabbitDto.getId());
            activityRabbitRelService.delete(arrd);
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

    public ActivityDto getDto() {
        return dto;
    }

    public void setDto(ActivityDto dto) {
        this.dto = dto;
    }

    public RabbitDto getRabbitDto() {
        return rabbitDto;
    }

    public void setRabbitDto(RabbitDto rabbitDto) {
        this.rabbitDto = rabbitDto;
    }

}
