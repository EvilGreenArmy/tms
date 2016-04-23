package com.tms.service.impl;

import com.tms.dao.FavoritesMapper;
import com.tms.entities.FavoritesInfo;
import com.tms.pagination.Page;
import com.tms.service.FavoritesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by Evan on 2016/4/3.
 */
@Service("favoritesService")
public class FavoritesServiceImpl implements FavoritesService {
    @Autowired
    private FavoritesMapper dao;

    @Override
    public Page<FavoritesInfo> queryList(Map<String, Object> paramMap) {
        Page<FavoritesInfo> page = (Page<FavoritesInfo>) paramMap.get("page");
        List<FavoritesInfo> result = dao.favoritesQueryPage(paramMap);
        page.setResultList(result);
        return page;
    }

    @Transactional
    public void saveFavorites(FavoritesInfo favoritesInfo) {
        dao.insertFavorites(favoritesInfo);
    }

    @Transactional
    public void deleteFavorites(Integer[] ids) {
        dao.deleteFavorites(ids);
    }

    @Override
    public Integer getTotalFavorites(Integer productId) {
        return this.dao.getTotalFavorites(productId);
    }
}
