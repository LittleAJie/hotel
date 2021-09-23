package com.manong.controller;


import com.manong.entity.Floor;
import com.manong.entity.Room;
import com.manong.service.FloorService;
import com.manong.service.RoomService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class IndexController {

    @Resource
    private FloorService floorService;

    @Resource
    private RoomService roomService;


    @RequestMapping("/index")
    public String index(Model model){
        //调用查询所有楼层列表的方法
        List<Floor> floorList = floorService.findFloorList(null);
        //调用查询房间列表的方法
        List<Room> roomList = roomService.findRoomList(null);
        //将数据添加到模型中
        model.addAttribute("floorList",floorList);
        model.addAttribute("roomList",roomList);
        //返回逻辑视图名
        return "forward:/index.jsp";
    }

}
