package com.tms.service;

import com.tms.entities.CommentInfo;
import com.tms.pagination.Page;

import java.util.Map;

/**
 * Created by Evan on 2016/4/3.
 */
public interface CommentService {
    public Page<CommentInfo> queryList(Map<String, Object> paramMap);

    public void saveComment(CommentInfo commentInfo);

    public void deleteComment(Integer[] ids);
}
