package com.tms.dao;

import com.tms.entities.CommentInfo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Evan on 2016/4/3.
 */
@Repository
public interface CommentMapper {

    List<CommentInfo> commentQueryPage(Map map);

    void insertComment(CommentInfo commentInfo);

    void deleteComment(Integer[] ids);
}
