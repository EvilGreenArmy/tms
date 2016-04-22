package com.tms.controller;

import com.tms.entities.ProductInfo;
import com.tms.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Evan on 2016/4/21.
 */
@Controller
public class ProductController extends BaseController {
    @Autowired
    private ProductService productService;
    @RequestMapping(value = "/product/detail")
    public String list(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                       @RequestParam("id") final Integer id) {
        ProductInfo product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        return "main/detail";
    }
}
