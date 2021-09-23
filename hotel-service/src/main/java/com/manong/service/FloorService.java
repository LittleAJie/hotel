package com.manong.service;

import com.manong.entity.Floor;
import com.manong.vo.FloorVo;

import java.util.List;

public interface FloorService {

    /**
     * 查询楼层列表
     * @param floorVo
     * @return
     */
    List<Floor> findFloorList(FloorVo floorVo);

    /**
     * 添加楼层
     * @param floor
     * @return
     */
    int insert(Floor floor);

    /**
     * 修改楼层
     * @param floor
     * @return
     */
    int updateFloor(Floor floor);

    /**
     * 加载楼层列表
     * @return
     */
    String getFloorListByRedis();

}
