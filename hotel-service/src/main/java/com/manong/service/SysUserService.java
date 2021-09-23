package com.manong.service;

import com.manong.entity.SysUser;
import com.manong.vo.UserVo;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface SysUserService extends UserDetailsService {

    /**
     * 根据部门编号查询该部门下的员工信息
     * @param deptId
     * @return
     */
    int getUserCountByDeptId(Integer deptId);

    /**
     * 根据角色编号查询该角色下的用户数量
     * @param roleId
     * @return
     */
    int getUserCountByRoleId(Integer roleId);


    /**
     * 查询用户列表
     * @param userVo
     * @return
     */
    List<SysUser> findUserList(UserVo userVo);

    /**
     * 添加用户
     * @param sysUser
     * @return
     */
    int insert(SysUser sysUser);

    /**
     * 修改用户
     * @param sysUser
     * @return
     */
    int updateUser(SysUser sysUser);

    /**
     * 删除用户
     * @param id
     * @return
     */
    int deleteById(Integer id);

    /**
     *
     * @param id
     * @return
     */
    int resetPwd(Integer id, Integer userId);

    /**
     * 保存用户角色关系
     * @param ids
     * @param userId
     * @return
     */
    boolean saveUserRole(String ids, Integer userId);

    /**
     * 根据用户名查询用户信息
     * @param userName
     * @return
     */
    SysUser getUserByUserName(String userName);
}
