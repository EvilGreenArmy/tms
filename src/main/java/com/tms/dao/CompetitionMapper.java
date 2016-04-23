package com.tms.dao;

import com.tms.entities.CompetitionInfo;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * Created by Evan on 2016/4/3.
 */
@Repository
public interface CompetitionMapper {
    List<CompetitionInfo> competitionQueryPage(Map map);

    void insertCompetition(CompetitionInfo competitionInfo);

    Integer getCompetitionAmount(Integer productId);

    BigDecimal getMaxValue(Integer producId);

    List<CompetitionInfo> getAllCompetition(Integer productId);
    void insertReply(CompetitionInfo competitionInfo);
}
