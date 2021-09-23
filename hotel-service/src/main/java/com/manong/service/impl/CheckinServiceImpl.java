package com.manong.service.impl;

import com.manong.dao.CheckinMapper;
import com.manong.dao.OrdersMapper;
import com.manong.dao.RoomMapper;
import com.manong.dao.RoomTypeMapper;
import com.manong.entity.Checkin;
import com.manong.entity.Orders;
import com.manong.entity.Room;
import com.manong.entity.RoomType;
import com.manong.service.CheckinService;
import com.manong.vo.CheckinVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class CheckinServiceImpl implements CheckinService {

    @Resource
    private CheckinMapper checkinMapper;

    @Resource
    private OrdersMapper ordersMapper;

    @Resource
    private RoomTypeMapper roomTypeMapper;
    @Resource
    private RoomMapper roomMapper;

    public List<Checkin> findCheckinList(CheckinVo checkinVo) {
        return checkinMapper.findCheckinList(checkinVo);
    }

    @Transactional(rollbackFor = RuntimeException.class)
    public int insert(Checkin checkin) {
        //设置状态
        checkin.setStatus(1);//入住中
        checkin.setCreateDate(new Date());//创建时间
        //调用添加入住信息的方法
        int count = checkinMapper.insert(checkin);
        //如果添加成功
        if(count>0){
            //修改预订订单信息(从已确认的状态2改成入住中3)
            Orders orders = new Orders();
            orders.setId(checkin.getOrdersId());
            orders.setStatus(3);//入住中
            //调用修改订单信息的方法
            ordersMapper.update(orders);

            //修改房型信息(在原有的已入住数量的基础上+1)
            RoomType roomType = roomTypeMapper.findById(checkin.getRoomTypeId());
            roomType.setLivedNum(roomType.getLivedNum()+1);
            //调用修改房型的方法
            roomTypeMapper.updateRoomType(roomType);

            //修改房间状态（由已预订2改成入住中3）
            Room room = new Room();
            room.setStatus(3);
            room.setId(orders.getRoomId());
            //调用修改的方法
            roomMapper.updateRoom(room);
        }
        return count;
    }
}
