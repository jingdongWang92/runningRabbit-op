package com.xiaoguo.jc.op.action.ttg;

import java.io.File;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.common.collect.Lists;
import com.xiaoguo.jc.common.dto.base.ResultMessage;
import com.xiaoguo.jc.common.model.activity.ActivityDto;
import com.xiaoguo.jc.common.model.coupon.CouponInfoDto;
import com.xiaoguo.jc.common.model.system.operator.OperatorDto;
import com.xiaoguo.jc.common.service.activity.ActivityService;
import com.xiaoguo.jc.common.service.coupon.CouponInfoService;
import com.xiaoguo.jc.common.service.exception.JcServiceException;
import com.xiaoguo.jc.common.service.qncloud.impl.QiniuCloudApiServiceException;
import com.xiaoguo.jc.op.action.BaseAction;
import com.xiaoguo.yo.common.util.json.JsonUtil;

public class CouponAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 8003036628189138901L;

    @Autowired
    private CouponInfoService service;
    @Autowired
    private ActivityService activityService;

    private CouponInfoDto dto;
    private List<ActivityDto> actList;
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
        if (dto == null) {
            dto = new CouponInfoDto();
        }
        OperatorDto operator = super.getOperator(request);
        if (!operator.getOperatorno().equals(1)) {
            dto.setOperatorno(operator.getOperatorno());
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
        actList = activityService.queryValidActivityList();
        dto = new CouponInfoDto();
        OperatorDto opera = super.getOperator(request);
        dto.setOperatorName(opera.getOperatorname());
        dto.setOperatorno(opera.getOperatorno());
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
            dto.setOperatorno(super.getOperator(request).getOperatorno());
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
        actList = activityService.queryValidActivityList();
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
            if (null == dto.getTotal()) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "库存为必填项！");
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
     * 上传图片页面
     * 
     * @return
     * @throws Exception
     */
    public String toUpload() throws Exception {
        if (null == dto || null == dto.getId()) {
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
                dto = new CouponInfoDto();
            }
            CouponInfoDto drivingSchoolDto = service.select(dto);
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

    public CouponInfoDto getDto() {
        return dto;
    }

    public void setDto(CouponInfoDto dto) {
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

    public List<ActivityDto> getActList() {
        return actList;
    }

    public void setActList(List<ActivityDto> actList) {
        this.actList = actList;
    }

}
