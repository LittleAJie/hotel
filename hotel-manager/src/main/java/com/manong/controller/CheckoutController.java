package com.manong.controller;

import com.alibaba.fastjson.JSON;
import com.manong.entity.Checkout;
import com.manong.entity.SysUser;
import com.manong.service.CheckoutService;
import com.manong.service.SysUserService;
import com.manong.utils.SystemConstants;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/admin/checkout")
public class CheckoutController {

    @Resource
    private CheckoutService checkoutService;

    @Resource
    private SysUserService sysUserService;

    /**
     * 添加退房记录
     * @param checkout
     * @param principal
     * @return
     */
    @RequestMapping("/addCheckout")
    public String addCheckout(Checkout checkout, Principal principal){
        Map<String,Object> map = new HashMap<String,Object>();
        //获取当前登录用户
        SysUser sysUser = sysUserService.getUserByUserName(principal.getName());
        //设置创建人
        checkout.setCreatedBy(sysUser.getId());
        //调用添加退房记录的方法
        if(checkoutService.addCheckout(checkout)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"退房成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"退房失败");
        }
        return JSON.toJSONString(map);
    }

}
