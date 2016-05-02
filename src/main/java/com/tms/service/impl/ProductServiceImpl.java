package com.tms.service.impl;

import com.tms.dao.ProductMapper;
import com.tms.entities.ProductInfo;
import com.tms.pagination.Page;
import com.tms.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Reason on 2016/3/26.
 */
@Service("productService")
public class ProductServiceImpl implements ProductService {
    @Autowired
    ProductMapper productDao;

    @Override
    public Page<ProductInfo> queryList(Map<String, Object> paramMap) {
        Page<ProductInfo> page = (Page<ProductInfo>)paramMap.get("page");
        List<ProductInfo> result = productDao.productQueryPage(paramMap);
        page.setResultList(result);
        return page;
    }

    @Override
    public void saveProduct(ProductInfo product) {
        productDao.insertProduct(product);
    }

    @Override
    public void editProduct(ProductInfo product) {
        productDao.updateProduct(product);
    }

    @Override
    public ProductInfo getProductById(Integer id) {
        return productDao.getProductById(id);
    }

    @Override
    public void updateProduct(ProductInfo product) {

    }

    @Override
    public void deleteProduct(Integer id) {

    }

    @Override
    public void updateStatus(Integer id, String status) {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("id",id);
        paramMap.put("status",status);
        productDao.updateStatus(paramMap);
    }
}
