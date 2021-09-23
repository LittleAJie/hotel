package com.manong.service.impl;

import com.manong.dao.SysUserMapper;
import com.manong.entity.Role;
import com.manong.entity.SysUser;
import com.manong.service.SysUserService;
import com.manong.utils.PasswordUtil;
import com.manong.utils.SystemConstants;
import com.manong.vo.UserVo;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class SysUserServiceImpl implements SysUserService {

    @Resource
    private SysUserMapper userMapper;

    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //创建角色列表集合
        List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
        //调用根据用户姓名查询用户信息的方法
        SysUser sysUser = userMapper.findUserByUserName(username);
        //循环遍历用户角色列表
        for (Role role : sysUser.getRoleList()) {
            //将角色编码添加到角色列表集合中
            authorities.add(new SimpleGrantedAuthority(role.getRoleCode()));
        }
        //创建User对象
        User user = new User(sysUser.getUserName(),
                sysUser.getPassword(),
                sysUser.getStatus()==1,
                true,
                true,
                true,
                authorities);
        return user;
    }

    public int getUserCountByDeptId(Integer deptId) {
        return userMapper.getUserCountByDeptId(deptId);
    }

    public int getUserCountByRoleId(Integer roleId) {
        return userMapper.getUserCountByRoleId(roleId);
    }

    public List<SysUser> findUserList(UserVo userVo) {
        return userMapper.findUserList(userVo);
    }

    public int insert(SysUser sysUser) {
        sysUser.setCreateDate(new Date());//创建时间
        //使用默认密码并进行加密处理
        sysUser.setPassword(PasswordUtil.encode(SystemConstants.DEFAULT_PASSWORD));
        //默认为普通用户
        sysUser.setUserType(2);
        return userMapper.insert(sysUser);
    }

    public int updateUser(SysUser sysUser) {
        sysUser.setModifyDate(new Date());
        return userMapper.updateUser(sysUser);
    }

    public int deleteById(Integer id) {
        //删除用户角色关系表的数据
        userMapper.deleteUserRoleByUserId(id);
        //删除用户数据
        return userMapper.deleteById(id);
    }

    public int resetPwd(Integer id, Integer userId) {
        //创建用户对象
        SysUser sysUser = new SysUser();
        sysUser.setId(id);//用户ID
        sysUser.setModifyBy(userId);//修改人
        sysUser.setPassword(PasswordUtil.encode(SystemConstants.DEFAULT_PASSWORD));
        sysUser.setModifyDate(new Date());
        return userMapper.updateUser(sysUser);
    }

    public boolean saveUserRole(String ids, Integer userId) {

        try {
            //保存用户角色关系前，先将原有的关系清空
            userMapper.deleteUserRoleByUserId(userId);
            //将字符串ID拆分成数组
            String[] split = ids.split(",");
            for (int i = 0; i < split.length; i++) {
                //调用保存用户角色关系的方法
                userMapper.saveUserRole(Integer.valueOf(split[i]),userId);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }


        return false;
    }

    public SysUser getUserByUserName(String userName) {
        return userMapper.getUserByUserName(userName);
    }
}
