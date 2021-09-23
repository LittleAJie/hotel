package com.manong.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.manong.entity.SysUser;
import com.manong.service.SysUserService;
import com.manong.utils.DataGridViewResult;
import com.manong.utils.SystemConstants;
import com.manong.vo.UserVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/user")
public class UserController {

    @Resource
    private SysUserService userService;


    /**
     * 注销
     * @param session
     * @return
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();//清空session数据
        return "redirect:/";
    }


    /**
     * 查询用户列表
     * @param userVo
     * @return
     */
    @ResponseBody
    @RequestMapping("/list")
    public DataGridViewResult list(UserVo userVo,Principal principal){

        //查询当前登录用户
        SysUser loginUser = userService.getUserByUserName(principal.getName());
        //如果当前登录用户是普通用户，则只能查询userType为2的用户信息
        if(loginUser!=null && loginUser.getUserType()==2){
            userVo.setUserType(2);
        }

        //设置分页信息
        PageHelper.startPage(userVo.getPage(),userVo.getLimit());
        //调用查询的方法
        List<SysUser> userList = userService.findUserList(userVo);
        //创建分页对象
        PageInfo<SysUser> pageInfo = new PageInfo<SysUser>(userList);
        //返回对象
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    /**
     * 添加用户
     * @param sysUser
     * @return
     */
    @ResponseBody
    @RequestMapping("/addUser")
    public String addUser(SysUser sysUser, Principal principal){
        Map<String,Object> map = new HashMap<String,Object>();
        //获取当前登录用户信息
        SysUser loginUser = userService.getUserByUserName(principal.getName());
        //创建人
        sysUser.setCreatedBy(loginUser.getId());
        if(userService.insert(sysUser)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"添加成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 修改用户
     * @param sysUser
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateUser")
    public String updateUser(SysUser sysUser, Principal principal){
        //获取当前登录用户信息
        SysUser loginUser = userService.getUserByUserName(principal.getName());
        //修改人
        sysUser.setModifyBy(loginUser.getId());

        Map<String,Object> map = new HashMap<String,Object>();

        if(userService.updateUser(sysUser)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"修改成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"修改失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 删除用户
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/deleteById")
    public String deleteById(Integer id){
        Map<String,Object> map = new HashMap<String,Object>();
        if(userService.deleteById(id)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"删除成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"删除失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 重置密码
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/resetPwd")
    public String resetPwd(Integer id,Principal principal){
        SysUser loginUser = userService.getUserByUserName(principal.getName());

        Map<String,Object> map = new HashMap<String,Object>();
        if(userService.resetPwd(id,loginUser.getId())>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"密码重置成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"密码重置失败");
        }
        return JSON.toJSONString(map);
    }


    /**
     * 分配角色
     * @param ids
     * @param userId
     * @return
     */
    @ResponseBody
    @RequestMapping("/grantRole")
    public String  grantRole(String ids,Integer userId){
        Map<String,Object> map = new HashMap<String,Object>();
        if(userService.saveUserRole(ids,userId)){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"角色分配成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"角色分配失败");
        }
        return JSON.toJSONString(map);
    }

}
