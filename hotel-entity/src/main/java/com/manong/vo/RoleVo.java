package com.manong.vo;

import com.manong.entity.Role;
import lombok.Data;

@Data
public class RoleVo extends Role {

    private Integer page;//当前页码
    private Integer limit;//每页显示数量

}
