package com.tms.dao;

import com.tms.entities.CompetitionInfo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Evan on 2016/4/3.
 */
@Repository
public interface CompetitionMapper {
    List<CompetitionInfo> competitionQueryPage(Map map);

    void insertCompetition(CompetitionInfo competitionInfo);

}
