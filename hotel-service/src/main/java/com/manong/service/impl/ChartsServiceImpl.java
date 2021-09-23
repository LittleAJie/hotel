package com.manong.service.impl;

import com.manong.dao.ChartsMapper;
import com.manong.service.ChartsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Service
@Transactional
public class ChartsServiceImpl implements ChartsService {

    @Resource
    private ChartsMapper chartsMapper;

    public List<Map> getTotalPriceByYear() {
        return chartsMapper.getTotalPriceByYear();
    }

    public List<Double> getMonthTotalPriceByYear(String year) {
        return chartsMapper.getMonthTotalPriceByYear(year);
    }
}
