package com.manong.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Dept {
    private Integer id;

    private String deptName;

    private String address;

    private Date createDate;

    private String remark;
}
