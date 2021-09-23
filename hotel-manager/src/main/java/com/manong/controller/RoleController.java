package com.manong.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.manong.entity.Permission;
import com.manong.entity.Role;
import com.manong.service.PermissionService;
import com.manong.service.RoleService;
import com.manong.service.SysUserService;
import com.manong.utils.DataGridViewResult;
import com.manong.utils.SystemConstants;
import com.manong.utils.TreeNode;
import com.manong.vo.RoleVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/role")
public class RoleController {
    
    @Resource
    private RoleService roleService;

    @Resource
    private SysUserService userService;

    @Resource
    private PermissionService permissionService;

    @RequestMapping("/list")
    public DataGridViewResult list(RoleVo roleVo){
        //设置分页信息
        PageHelper.startPage(roleVo.getPage(),roleVo.getLimit());
        //调用查询部门列表的方法
        List<Role> roleList = roleService.findRoleList(roleVo);
        //创建分页对象
        PageInfo<Role> pageInfo = new PageInfo<Role>(roleList);
        //返回数据
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }


    /**
     * 添加角色
     * @param role
     * @return
     */
    @RequestMapping("/addRole")
    public String addRole(Role role){
        Map<String,Object> map = new HashMap<String,Object>();
        if(roleService.insert(role)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"添加成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 修改角色
     * @param role
     * @return
     */
    @RequestMapping("/updateRole")
    public String updateRole(Role role){
        Map<String,Object> map = new HashMap<String,Object>();
        if(roleService.updateRole(role)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"修改成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"修改失败");
        }
        return JSON.toJSONString(map);
    }


    /**
     * 检查角色下是否存在用户信息
     * @param roleId
     * @return
     */
    @RequestMapping("/checkRoleHasUser")
    public String checkRoleHasUser(Integer roleId){
        Map<String,Object> map = new HashMap<String,Object>();
        if(userService.getUserCountByRoleId(roleId)>0){
            map.put(SystemConstants.EXIST,true);
            map.put(SystemConstants.MESSAGE,"该角色下存在用户信息，无法删除");
        }else{
            map.put(SystemConstants.EXIST,false);
        }
        return JSON.toJSONString(map);
    }

    /**
     * 删除角色
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    public String deleteById(Integer id){
        Map<String,Object> map = new HashMap<String,Object>();
        if(roleService.deleteById(id)>0){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"删除成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"删除失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 初始化角色列表
     * @param userId
     * @return
     */
    @RequestMapping("/initRoleListByUserId")
    public DataGridViewResult initRoleListByUserId(Integer userId){
        //调用查询所有角色列表的方法
        List<Map<String, Object>> roleListByMap = roleService.findRoleListByMap();
        //调用根据用户ID查询该用户拥有的角色列表方法
        List<Integer> roleListWithUserId = roleService.findRoleListWithUserId(userId);
        //循环遍历两个集合的数据是否出现相同的值(两个集合中的角色ID是否相等，如果相等，表示该用户有这个角色，则需要将复选框选中)
        for (Map<String, Object> map : roleListByMap) {
            //定义变量，标识是否选中
            boolean flag = false;//默认不选中
            //获取角色ID
            Integer roleId = (Integer) map.get("id");//id是角色主键，以主键作为map集合中key
            //内层循环遍历拥有拥有的角色列表
            for (Integer rid : roleListWithUserId) {
                //比较两个集合中的角色ID是否相等
                if(rid == roleId){
                    //修改状态值
                    flag = true;
                    break;
                }
            }
            //将状态保存到Map集合中
            map.put("LAY_CHECKED",flag);//key必须为LAY_CHECKED
        }
        //返回数据
        return new DataGridViewResult(roleListByMap);
    }


    /**
     * 初始化用户角色菜单树
     * @param roleId
     * @return
     */
    @RequestMapping("/initMenuTree")
    public DataGridViewResult initMenuTree(Integer roleId){
        //调用查询所有菜单权限列表的方法
        List<Permission> permissionList = permissionService.findPermissionList(null);
        //调用根据角色ID查询菜单列表的方法（角色权限列表集合）
        List<Integer> currentRolePermissionIds = permissionService.findPermissionByRoleId(roleId);
        //创建集合保存菜单信息
        List<Permission> currentPermissions = new ArrayList<Permission>();
        //判断角色权限列表集合是否存在数据
        if(currentRolePermissionIds!=null && currentRolePermissionIds.size()>0){
            //如果角色权限列表集合中存在数据，则需要根据权限菜单ID查询详细信息
            currentPermissions = permissionService.findPermissionById(currentRolePermissionIds);
        }

        //创建菜单节点集合
        List<TreeNode> treeNodes = new ArrayList<TreeNode>();
        //循环遍历权限菜单列表
        for (Permission permission : permissionList) {
            //定义变量，标识是否选中
            String checkArr = "0";//0表示复选框不选中，1表示选中复选框
            //内层循环遍历当前角色拥有的权限菜单
            //循环比较的原因：比较两个集合中的数据是否有相同的，有相同的表示当前角色拥有这个权限
            for (Permission currentPermission : currentPermissions) {
                //比较两个集合中权限菜单id是否相同，相同则选择
                if(permission.getId() == currentPermission.getId()){
                    checkArr = "1";
                    break;
                }
            }
            //定义变量，标识菜单是否展开
            Boolean spread = (permission.getSpread()==null || permission.getSpread()==1) ? true : false;
            treeNodes.add(new TreeNode(permission.getId(),permission.getPid(),permission.getTitle(),spread,checkArr));
        }
        return new DataGridViewResult(treeNodes);
    }


    /**
     * 保存角色菜单关系
     * @param permissionIds
     * @param roleId
     * @return
     */
    @RequestMapping("/saveRolePermission")
    public String saveRolePermission(String permissionIds,Integer roleId){
        Map<String,Object> map = new HashMap<String,Object>();
        if(roleService.saveRolePermission(permissionIds,roleId)){
            map.put(SystemConstants.SUCCESS,true);
            map.put(SystemConstants.MESSAGE,"菜单分配成功");
        }else{
            map.put(SystemConstants.SUCCESS,false);
            map.put(SystemConstants.MESSAGE,"菜单分配失败");
        }
        return JSON.toJSONString(map);
    }

}
