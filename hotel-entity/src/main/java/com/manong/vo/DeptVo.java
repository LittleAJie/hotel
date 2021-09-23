package com.manong.vo;

import com.manong.entity.Dept;
import lombok.Data;

@Data
public class DeptVo extends Dept {

    private Integer page;//当前页码
    private Integer limit;//每页显示数量

}
