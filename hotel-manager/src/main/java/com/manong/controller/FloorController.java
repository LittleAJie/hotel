package com.manong.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.manong.entity.Floor;
import com.manong.service.FloorService;
import com.manong.utils.DataGridViewResult;
import com.manong.utils.SystemConstants;
import com.manong.vo.FloorVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/floor")
public class FloorController {

    @Resource
    private FloorService floorService;


    /**
     * 查询楼层列表
     * @param floorVo
     * @return
     */
    @RequestMapping("/list")
    public DataGridViewResult list(FloorVo floorVo){
        //设置分页信息
        PageHelper.startPage(floorVo.getPage(),floorVo.getLimit());
        //调用查询楼层列表方法
        List<Floor> floorList = floorService.findFloorList(floorVo);
        //创建分页对象
        PageInfo<Floor> pageInfo = new PageInfo<Floor>(floorList);
        //返回数据
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }


    /**
     * 添加楼层
     * @param floor
     * @return
     */
    @RequestMapping("/addFloor")
    public String addFloor(Floor floor){
        Map<String,Object> map = new HashMap<String,Object>();
        if(floorService.insert(floor)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"添加成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 修改楼层
     * @param floor
     * @return
     */
    @RequestMapping("/updateFloor")
    public String updateFloor(Floor floor){
        Map<String,Object> map = new HashMap<String,Object>();
        if(floorService.updateFloor(floor)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"修改成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"修改失败");
        }
        return JSON.toJSONString(map);
    }


    /**
     * 查询楼层列表数据
     * @return
     */
    @RequestMapping("/floorList")
    public String floorList(){
        return floorService.getFloorListByRedis();
    }

}
