package com.tms.service;

import com.tms.entities.CategoryInfo;
import com.tms.pagination.Page;

import java.util.List;
import java.util.Map;

/**
 * Created by Reason on 2016/3/27.
 */
public interface CategoryService {
    Page<CategoryInfo> queryList(Map<String, Object> paramMap);
    public void saveCategory(CategoryInfo category);
    public boolean checkCategoryName(String categoryName, Integer parentId);
    public List<CategoryInfo> querySubCategorys(Integer parentId);
    public CategoryInfo getCategoryById(Integer id);
    public void editCategory(CategoryInfo category);
    public void deletes(Integer[] ids);
}
