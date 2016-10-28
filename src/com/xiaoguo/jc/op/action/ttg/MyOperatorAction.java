package com.xiaoguo.jc.op.action.ttg;

import java.io.File;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.common.collect.Lists;
import com.xiaoguo.jc.common.dto.base.ResultMessage;
import com.xiaoguo.jc.common.model.system.operator.OperatorDto;
import com.xiaoguo.jc.common.service.exception.JcServiceException;
import com.xiaoguo.jc.common.service.qncloud.impl.QiniuCloudApiServiceException;
import com.xiaoguo.jc.common.service.system.operator.OperatorService;
import com.xiaoguo.jc.op.action.BaseAction;
import com.xiaoguo.yo.common.util.json.JsonUtil;

public class MyOperatorAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 8003036628189138901L;

    @Autowired
    private OperatorService service;

    private OperatorDto dto;

    // 上传图片文件
    private File file_data;
    private String file_dataFileName;

    /**
     * 列表页
     * 
     * @return
     * @throws Exception
     */
    public String toList() throws Exception {
        dto = new OperatorDto();
        dto.setOperatorno(this.getOperator(request).getOperatorno());
        dto = service.select(dto);
        return LIST;
    }

    /**
     * 上传图片页面
     * 
     * @return
     * @throws Exception
     */
    public String toUpload() throws Exception {
        if (null == dto || null == dto.getOperatorno()) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "对象为null,操作非法！");
        }
        dto = service.select(dto);
        String pic = dto.getPic();
        if (StringUtils.isNotBlank(pic)) {
            List<String> styleList = Lists.newArrayList();
            styleList.addAll(Arrays.asList(pic.split(",")));
            dto.setStyleList(styleList);
        }
        return "upLoad";
    }

    /**
     * 执行处理保存奖券风采图片操作
     * 
     * @throws Exception
     */
    public void uploadStyle() throws Exception {
        String msg = "";
        String[] des = new String[3];
        try {
            dto.setFilename(file_dataFileName);
            dto.setFile(file_data);

            service.uploadStyle(dto);
            des[1] = dto.getPic();
            des[2] = getText("common.log.success");
        } catch (QiniuCloudApiServiceException e) {
            msg = e.getMessage();
            des[2] = getText("common.log.fail");
        } catch (Exception e) {
            msg = "上传奖券style图片失败";
            des[2] = getText("common.log.fail");
        } finally {
            // super.createOperatorLog(OperateLogEnum.Base.DRIVINGSCHOOL_STYLE_UPLOAD,
            // des);
            super.uploadResponse(msg);
        }
    }

    /**
     * 执行删除奖券图片操作
     * 
     * @throws Exception
     */
    public void delImage() throws Exception {
        String[] des = new String[3];
        PrintWriter pw = response.getWriter();
        ResultMessage rm = new ResultMessage();
        try {
            if (dto == null) {
                dto = new OperatorDto();
            }
            OperatorDto drivingSchoolDto = service.select(dto);
            if (drivingSchoolDto != null) {
                des[1] = dto.getFilename();
                dto.setPic(drivingSchoolDto.getPic());
                service.deleteStyle(dto);
            } else {
                throw new Exception("奖券信息为空");
            }
            des[2] = getText("common.log.success");

            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("删除奖券图片成功.");
        } catch (Exception e) {
            des[2] = getText("common.log.fail");

            rm.setStatus(ResultMessage.FAIL);
            rm.setMessage("删除奖券图片失败.");
        } finally {
            // super.createOperatorLog(OperateLogEnum.Base.DRIVINGSCHOOL_STYLE_DEL,
            // des);
            pw.write(JsonUtil.bean2json(rm));
        }
    }

    /**
     * 跳转到重置密码
     * 
     * @return
     * @throws Exception
     */
    public String toResetPwd() throws Exception {
        if (dto == null) {
            dto = new OperatorDto();
        }
        dto.setCreateno(this.getOperator(request).getOperatorno());
        dto = service.select(dto);
        dto.setPassword("");

        return "resetpwd";
    }

    /**
     * 重置密码
     * 
     * @throws Exception
     */
    public void resetPwd() throws Exception {
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        try {
            dto = null == dto ? new OperatorDto() : dto;
            // 设置创建者,记录业务日志用到
            dto.setAccount(this.getOperator(request).getAccount());
            // 查询操作员，记录操作日志
            OperatorDto oper = service.select(dto);
            // 修改密码
            oper.setPassword(dto.getPassword());
            if (!super.getOperator(request).getOperatorno().equals(1)) {
                if (!super.getOperator(request).getOperatorno().equals(dto.getOperatorno())) {
                    throw new Exception("操作非法！");
                }
            }
            service.update(oper);
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("修改密码成功");
        } catch (Exception e) {
            // 跳转到公共错误页面
            rm.setMessage("修改密码失败");
        } finally {
            printJson(JsonUtil.bean2json(rm));
        }
    }

    public String toEdit() throws Exception {
        dto = service.select(dto);
        return EDIT;
    }

    public void edit() throws Exception {
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        try {
            if (null == dto || null == dto.getOperatorno()) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "参数有误！");
            }
            OperatorDto param = new OperatorDto();
            param.setOperatorno(dto.getOperatorno());
            param.setOperatorname(dto.getOperatorname());
            param.setAddress(dto.getAddress());
            param.setMobile(dto.getMobile());
            service.update(param);
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("修改成功");
        } catch (JcServiceException e) {
            rm.setMessage(e.getErroDesc());
        } catch (Exception e) {
            // 跳转到公共错误页面
            rm.setMessage("修改失败");
        } finally {
            printJson(JsonUtil.bean2json(rm));
        }
    }

    public OperatorDto getDto() {
        return dto;
    }

    public void setDto(OperatorDto dto) {
        this.dto = dto;
    }

    public File getFile_data() {
        return file_data;
    }

    public void setFile_data(File file_data) {
        this.file_data = file_data;
    }

    public String getFile_dataFileName() {
        return file_dataFileName;
    }

    public void setFile_dataFileName(String file_dataFileName) {
        this.file_dataFileName = file_dataFileName;
    }

}
