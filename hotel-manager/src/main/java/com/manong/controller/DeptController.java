package com.manong.controller;


import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.manong.entity.Dept;
import com.manong.service.DeptService;
import com.manong.service.SysUserService;
import com.manong.utils.DataGridViewResult;
import com.manong.utils.SystemConstants;
import com.manong.vo.DeptVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/dept")
public class DeptController {

    @Resource
    private DeptService deptService;

    @Resource
    private SysUserService userService;

    /**
     * 查询部门列表
     * @param deptVo
     * @return
     */
    @RequestMapping("/list")
    public DataGridViewResult list(DeptVo deptVo){
        //设置分页信息
        PageHelper.startPage(deptVo.getPage(),deptVo.getLimit());
        //调用查询部门列表的方法
        List<Dept> deptList = deptService.findDeptList(deptVo);
        //创建分页对象
        PageInfo<Dept> pageInfo = new PageInfo<Dept>(deptList);
        //返回数据
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    /**
     * 添加部门
     * @param dept
     * @return
     */
    @RequestMapping("/addDept")
    public String addDept(Dept dept){
        Map<String,Object> map = new HashMap<String,Object>();
        if(deptService.insert(dept)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"添加成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }


    /**
     * 修改部门
     * @param dept
     * @return
     */
    @RequestMapping("/updateDept")
    public String updateDept(Dept dept){
        Map<String,Object> map = new HashMap<String,Object>();
        if(deptService.updateDept(dept)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"修改成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"修改失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 检查部门是否存在用户
     * @param deptId
     * @return
     */
    @RequestMapping("/checkDeptHasUser")
    public String checkDeptHasUser(Integer deptId){
        Map<String,Object> map = new HashMap<String,Object>();
        if(userService.getUserCountByDeptId(deptId)>0){
            map.put(SystemConstants.EXIST,true);
            map.put(SystemConstants.MESSAGE,"该部门下存在用户信息，无法删除");
        }else{
            map.put(SystemConstants.EXIST,false);
        }
        return JSON.toJSONString(map);
    }

    /**
     * 删除部门
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    public String deleteById(Integer id){
        Map<String,Object> map = new HashMap<String,Object>();
        if(deptService.deleteById(id)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"删除成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"删除失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 查询部门列表
     * @return
     */
    @RequestMapping("/findDeptList")
    public String findDeptList(){
        return deptService.findDeptList();
    }

}
