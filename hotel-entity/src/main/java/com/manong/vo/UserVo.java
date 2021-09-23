package com.manong.vo;

import com.manong.entity.SysUser;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class UserVo extends SysUser {

    private Integer page;//当前页码
    private Integer limit;//每页显示数量

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

}
