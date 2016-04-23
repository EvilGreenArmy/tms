package com.tms.service;

import com.tms.entities.CompetitionInfo;
import com.tms.pagination.Page;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * Created by Evan on 2016/4/3.
 */
public interface CompetitionService {

    public Page<CompetitionInfo> queryList(Map<String, Object> paramMap);

    public void saveCompetition(CompetitionInfo competition);

    public Integer getTotalAmount(Integer productId);

    public BigDecimal getMaxValue(Integer productId);

    public List<CompetitionInfo> getAllCompetition(Integer productId);

    public void saveReplyCompetition(CompetitionInfo competition);
}
