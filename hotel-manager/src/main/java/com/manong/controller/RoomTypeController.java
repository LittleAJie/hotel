package com.manong.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.manong.entity.RoomType;
import com.manong.service.RoomTypeService;
import com.manong.utils.DataGridViewResult;
import com.manong.utils.SystemConstants;
import com.manong.utils.UUIDUtils;
import com.manong.vo.RoomTypeVo;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/roomType")
public class RoomTypeController {

    @Resource
    private RoomTypeService roomTypeService;


    @RequestMapping("/list")
    public DataGridViewResult list(RoomTypeVo roomTypeVo){
        PageHelper.startPage(roomTypeVo.getPage(),roomTypeVo.getLimit());
        List<RoomType> roomTypeList = roomTypeService.findRoomTypeList(roomTypeVo);
        PageInfo<RoomType> pageInfo = new PageInfo<RoomType>(roomTypeList);
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }


    @RequestMapping("/uploadFile")
    public String uploadFile(MultipartFile attach){
        //创建Map集合保存数据(响应到前台页面的数据)
        Map<String,Object> map = new HashMap<String,Object>();
        //判断是否有选中文件
        if(!attach.isEmpty()){
            //获取文件上传地址
            String path = "F:/project/ssm_hotel/upload/";
            //获取源文件名称
            String oldName = attach.getOriginalFilename();
            //获取文件后缀名
            String extension = FilenameUtils.getExtension(oldName);
            //重命名文件名称
            String newFileName = UUIDUtils.randomUUID()+"."+extension;
            //为了解决同一个文件夹下文件过多的问题，使用日期作为文件夹管理
            String datePath = new SimpleDateFormat("yyyyMMdd").format(new Date());
            //组装最终的文件名
            String finalName = datePath + "/" + newFileName;
            //创建文件对象
            File destFile = new File(path,finalName);
            //判断文件夹是否存在，文件夹不存在则创建该文件夹
            if(!destFile.getParentFile().exists()){
                destFile.getParentFile().mkdirs();
            }
            try {
                //将文件保存到硬盘
                attach.transferTo(destFile);
                //保存响应的数据
                map.put("code",0);
                map.put("msg","");
                Map<String,Object> dataMap = new HashMap<String,Object>();
                dataMap.put("src","/hotel/show/"+finalName);//文件上传成功的回显地址
                map.put("data",dataMap);
                map.put("imagePath",finalName);//图片名称，目的是给photo隐藏域赋值
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return JSON.toJSONString(map);
    }

    /**
     * 添加房型
     * @param roomType
     * @return
     */
    @RequestMapping("/addRoomType")
    public String addRoomType(RoomType roomType){
        Map<String,Object> map = new HashMap<String,Object>();
        if(roomTypeService.insert(roomType)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"添加成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 修改房型
     * @param roomType
     * @return
     */
    @RequestMapping("/updateRoomType")
    public String updateRoomType(RoomType roomType){
        Map<String,Object> map = new HashMap<String,Object>();
        if(roomTypeService.updateRoomType(roomType)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"修改成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"修改失败");
        }
        return JSON.toJSONString(map);
    }


    /**
     * 检查该房型下是否存在房间
     * @param roomTypeId
     * @return
     */
    @RequestMapping("/checkRoomTypeHasRoom")
    public String checkRoomTypeHasRoom(Integer roomTypeId){
        Map<String,Object> map = new HashMap<String,Object>();
        if(roomTypeService.getRoomCountByRoomTypeId(roomTypeId)>0){
            map.put(SystemConstants.EXIST,true);
            map.put(SystemConstants.MESSAGE,"该房型下存在房间信息，无法删除");
        }else{
            map.put(SystemConstants.EXIST,false);
        }
        return JSON.toJSONString(map);
    }

    /**
     * 删除房型
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    public String deleteById(Integer id){
        Map<String,Object> map = new HashMap<String,Object>();
        if(roomTypeService.deleteById(id)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"删除成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"删除失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 查询房型列表
     * @return
     */
    @RequestMapping("/roomTypeList")
    public String roomTypeList(){
        return roomTypeService.getRoomTypeListByRedis();
    }

}
