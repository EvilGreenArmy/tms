package com.tms.service;

import com.tms.entities.FavoritesInfo;
import com.tms.pagination.Page;

import java.util.Map;

/**
 * Created by Evan on 2016/4/3.
 */
public interface FavoritesService {

    public Page<FavoritesInfo> queryList(Map<String, Object> paramMap);

    public void saveFavorites(FavoritesInfo favoritesInfo);

    public void deleteFavorites(Integer[] ids);

    public Integer getTotalFavorites(Integer productId);
}
