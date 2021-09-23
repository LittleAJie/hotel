package com.manong.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.manong.entity.Room;
import com.manong.service.RoomService;
import com.manong.utils.DataGridViewResult;
import com.manong.utils.SystemConstants;
import com.manong.utils.UUIDUtils;
import com.manong.vo.RoomVo;
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
@RequestMapping("/admin/room")
public class RoomController {


    @Resource
    private RoomService roomService;

    /**
     * 查询房屋列表
     * @param roomVo
     * @return
     */
    @RequestMapping("/list")
    public DataGridViewResult list(RoomVo roomVo){
        //设置分页信息
        PageHelper.startPage(roomVo.getPage(),roomVo.getLimit());
        //调用查询的方法
        List<Room> roomList = roomService.findRoomList(roomVo);
        //创建分页对象
        PageInfo<Room> pageInfo = new PageInfo<Room>(roomList);
        //返回数据
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    /**
     * 文件上传
     * @param attach
     * @return
     */
    @RequestMapping("/uploadFile")
    public String uploadFile(MultipartFile attach){
        //创建Map集合保存数据(响应到前台页面的数据)
        Map<String,Object> map = new HashMap<String,Object>();
        //判断是否有选中文件
        if(!attach.isEmpty()){
            //获取文件上传地址
            String path = "F:/project/ssm_hotel/upload/room-pic/main/";
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
                dataMap.put("src","/hotel/show/room-pic/main/"+finalName);//文件上传成功的回显地址
                map.put("data",dataMap);
                map.put("imagePath",finalName);//图片名称，目的是给photo隐藏域赋值
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return JSON.toJSONString(map);
    }


    /**
     * 添加房间
     * @param room
     * @return
     */
    @RequestMapping("/addRoom")
    public String addRoom(Room room){
        Map<String,Object> map = new HashMap<String,Object>();
        if(roomService.addRoom(room)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"添加成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/detailUpload")
    public String detailUpload(MultipartFile file){
        //创建Map集合保存返回的JSON数据
        Map<String,Object> map = new HashMap<String,Object>();
        //判断是否有选中文件
        if(!file.isEmpty()){
            //文件上传提交地址
            String path = "F:/project/ssm_hotel/upload/room-pic/detail/";
            //获取源文件的名称
            String oldFileName = file.getOriginalFilename();
            //获取文件的后缀名
            String extension = FilenameUtils.getExtension(oldFileName);
            //重命名旧文件
            String newFileName = UUIDUtils.randomUUID()+"."+extension;
            //为了解决同一个文件夹下文件过多的问题，使用日期作为文件夹管理
            String datePath = new SimpleDateFormat("yyyyMMdd").format(new Date());
            //组装最终的文件名
            String finalName = datePath + "/" + newFileName;
            //创建文件对象
            //参数1：文件上传的地址  参数2：文件名称
            File dest = new File(path,finalName);
            //判断该文件夹是否存在，不存在则创建文件夹
            if(!dest.getParentFile().exists()){
                dest.getParentFile().mkdirs();//创建文件夹
            }

            try {
                //进行文件上传
                file.transferTo(dest);
                map.put("code",0);//状态码
                map.put("msg","上传成功");//执行消息
                Map<String,Object> dataMap = new HashMap<String,Object>();
                dataMap.put("src","/hotel/show/room-pic/detail/"+finalName);
                map.put("data",dataMap);//文件数据
                map.put("imagePath",finalName);//隐藏域的值，只保留日期文件夹+重命名后的文件名

            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        return JSON.toJSONString(map);
    }

    /**
     * 修改房间
     * @param room
     * @return
     */
    @RequestMapping("/updateRoom")
    public String updateRoom(Room room){
        Map<String,Object> map = new HashMap<String,Object>();
        if(roomService.updateRoom(room)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"修改成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"修改失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 删除房间
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    public String deleteById(Integer id){
        Map<String,Object> map = new HashMap<String,Object>();
        if(roomService.deleteById(id)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"删除成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"删除失败");
        }
        return JSON.toJSONString(map);
    }

}
