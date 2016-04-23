package com.tms.service.impl;

import com.tms.dao.CompetitionMapper;
import com.tms.entities.CompetitionInfo;
import com.tms.pagination.Page;
import com.tms.service.CompetitionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * Created by Evan on 2016/4/3.
 */
@Service("competitionService")
public class CompetitionServiceImpl implements CompetitionService {


    @Autowired
    private CompetitionMapper dao;
    @Override
    public List<CompetitionInfo> getAllCompetition(Integer productId) {
        return dao.getAllCompetition(productId);
    }
    @Override
    public Page<CompetitionInfo> queryList(Map<String, Object> paramMap) {
        Page<CompetitionInfo> page = (Page<CompetitionInfo>) paramMap.get("page");
        List<CompetitionInfo> result = dao.competitionQueryPage(paramMap);
        page.setResultList(result);
        return page;
    }

    @Transactional
    public void saveCompetition(CompetitionInfo competition) {
        dao.insertCompetition(competition);
    }

    @Override
    public Integer getTotalAmount(Integer productId) {
        return dao.getCompetitionAmount(productId);
    }

    @Override
    public BigDecimal getMaxValue(Integer productId) {
        return dao.getMaxValue(productId);
    }
    @Transactional
    public void saveReplyCompetition(CompetitionInfo competition) {
        dao.insertReply(competition);
    }

}
