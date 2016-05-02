package com.tms.service;

import com.tms.entities.ProductInfo;
import com.tms.pagination.Page;

import java.util.Map;

/**
 * Created by Reason on 2016/3/26.
 */
public interface ProductService {

    public Page<ProductInfo> queryList(Map<String, Object> paramMap);

    public void saveProduct(ProductInfo product);

    public void editProduct(ProductInfo product);

    public ProductInfo getProductById(Integer id);

    public void updateProduct(ProductInfo product);

    public void deleteProduct(Integer id);

    public void updateStatus(Integer id, String status);
}
