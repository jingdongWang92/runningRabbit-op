package com.xiaoguo.jc.op.action.ttg;

import java.io.File;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.common.collect.Lists;
import com.xiaoguo.jc.common.dto.base.ResultMessage;
import com.xiaoguo.jc.common.model.leaflet.LeafletDto;
import com.xiaoguo.jc.common.service.exception.JcServiceException;
import com.xiaoguo.jc.common.service.leaflet.LeafletService;
import com.xiaoguo.jc.common.service.qncloud.impl.QiniuCloudApiServiceException;
import com.xiaoguo.jc.op.action.BaseAction;
import com.xiaoguo.yo.common.util.json.JsonUtil;

/**
 * 
 * 广告Action
 */
public class LeafletAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 8003036628189138901L;

    @Autowired
    private LeafletService service;

    private LeafletDto dto;
    // 上传图片文件
    private File file_data;
    private String file_dataFileName;

    private String time;

    /**
     * 列表页
     * 
     * @return
     * @throws Exception
     */
    public String toList() throws Exception {
        if (dto == null) {
            dto = new LeafletDto();
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
        if (null != dto) {
            if (null != dto.getStartDate() && !"".equals(dto.getStartDate()) && null != dto.getEndDate()
                    && !"".equals(dto.getEndDate())) {
                time = dto.getStartDate() + "至" + dto.getEndDate();
            }
        }
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
        if (null != dto) {
            if (null != dto.getStartDate() && !"".equals(dto.getStartDate()) && null != dto.getEndDate()
                    && !"".equals(dto.getEndDate())) {
                time = dto.getStartDate() + "至" + dto.getEndDate();
            }
        }
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
                dto = new LeafletDto();
            }
            LeafletDto drivingSchoolDto = service.select(dto);
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
     * 执行处理保存广告位图片操作
     * 
     * @throws Exception
     */
    public void uploadLeaflet() throws Exception {
        String msg = "";
        String newImageName = "";
        try {
            if (dto == null) {
                throw new Exception("系统异常!");
            }
            if (null != time && !"".equals(time)) {
                try {
                    String start = null;
                    String end = null;
                    String[] arr = time.split("至");
                    if (!StringUtils.isBlank(time)) {
                        start = arr[0];
                        end = arr[1];
                    }

                    // 查询条件验证
                    if (null != start && null != end) {
                        dto.setStartDate(start);
                        dto.setEndDate(end);
                    }
                } catch (Exception e) {
                    throw new Exception("日期格式有误");
                }
            }
            dto.setFile(file_data);
            dto.setFilename(file_dataFileName);
            check(dto);
            newImageName = service.uploadLeaflet(dto);
        } catch (JcServiceException e) {
            msg = e.getErroDesc();
        } catch (Exception e) {
            msg = e.getMessage();
        } finally {
            super.uploadResponse(msg, dto.getId(), newImageName);
        }
    }

    public void check(LeafletDto dto) {
        if (null == dto) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "参数有误！");
        }
        if (null == dto.getName() || "".equals(dto.getName())) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "广告名称为必填项！");
        }
        if (null == dto.getStartDate() || "".equals(dto.getStartDate()) || null == dto.getEndDate()
                || "".equals(dto.getEndDate())) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "有效期为必填项！");
        }
        if (null == dto.getSkipUrl() || "".equals(dto.getSkipUrl())) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "链接为必填项！");
        }
    }

    public LeafletDto getDto() {
        return dto;
    }

    public void setDto(LeafletDto dto) {
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

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

}
