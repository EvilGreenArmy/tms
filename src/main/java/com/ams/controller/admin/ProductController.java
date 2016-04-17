package com.ams.controller.admin;

import com.ams.entities.admin.ProductInfo;
import com.ams.entities.admin.UserInfo;
import com.ams.pagination.Page;
import com.ams.service.admin.ProductService;
import com.ams.util.Constant;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 产品控制类
 * Created by Reason on 2016/3/26.
 */
@Controller
@RequestMapping(value = "/product")
public class ProductController extends BaseController {

    @Autowired
    private ProductService productService;

    private static Logger logger = Logger.getLogger(ProductController.class);

    @RequestMapping(value = "list")
    public String list(HttpServletRequest request, HttpServletResponse response, ModelMap model, Page<ProductInfo> page,
            @RequestParam(value="type", required = false) String type,@RequestParam(value="name", required = false) String name) {

        logger.debug("Page info : " + page);
        Map<String, Object> paramMap = new HashMap<String, Object>();
        if(null != type){
            paramMap.put("type", type);
        }
        if(null != name){
            paramMap.put("name", name);
        }
        paramMap.put("page", page);
        page = productService.queryList(paramMap);
        model.addAttribute("paramMap", paramMap);
        model.addAttribute("page", page);
        return "product/list";

    }

    @RequestMapping(value = "frontList")
    public String frontList(HttpServletRequest request, HttpServletResponse response, ModelMap model, Page<ProductInfo> page,
        @RequestParam(value="flag", required = false) String flag,@RequestParam(value="type", required = false) String type,
        @RequestParam(value="name", required = false) String name) {
        UserInfo currentUser = (UserInfo)getSession(request).getAttribute(Constant.SESSION_LOGIN_USER);
        logger.debug("Page info : " + page);
        Map<String, Object> paramMap = new HashMap<String, Object>();
        if("my".equals(flag)){
            paramMap.put("addUserId", currentUser.getId());
        }else{
            paramMap.put("status", Constant.ACTIVE_STATUS);
        }
        if(null != type){
            paramMap.put("type", type);
        }
        if(null != name){
            paramMap.put("name", name);
        }
        paramMap.put("page", page);
        page = productService.queryList(paramMap);
        model.addAttribute("page", page);
        model.addAttribute("paramMap", paramMap);
        if("my".equals(flag)){
            return "product/frontList";
        }else{
            return "product/frontQueryList";
        }

    }

    @RequestMapping(value = "approveList")
    public String approveList(HttpServletRequest request, HttpServletResponse response, ModelMap model, Page<ProductInfo> page,
                       @RequestParam(value="type", required = false) String type,@RequestParam(value="name", required = false) String name) {

        logger.debug("Page info : " + page);
        Map<String, Object> paramMap = new HashMap<String, Object>();
        if(null != type){
            paramMap.put("type", type);
        }
        if(null != name){
            paramMap.put("name", name);
        }
        paramMap.put("status", Constant.NO_STATUS);
        paramMap.put("page", page);
        page = productService.queryList(paramMap);
        model.addAttribute("paramMap", paramMap);
        model.addAttribute("page", page);
        return "product/approveList";

    }


    @RequestMapping(value = "add", method = RequestMethod.GET)
    public String initAdd(HttpServletRequest request, HttpServletResponse response, ModelMap model, String type) {
        logger.debug("initEdit type:" + type);
        if("1".equals(type))
            model.addAttribute("typeName", "成果");
        else
            model.addAttribute("typeName", "专利");
        model.addAttribute("type", type);
        return "product/add";
    }

    @RequestMapping(value = "add", method = RequestMethod.POST)
    public String add(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                       @ModelAttribute ProductInfo product) {
        logger.debug("product info :"+product.toString());
        UserInfo currentUser = (UserInfo)getSession(request).getAttribute(Constant.SESSION_LOGIN_USER);
        product.setAddDate(new Date());
        product.setAddUser(currentUser);
        product.setEditDate(new Date());
        product.setEditUser(currentUser);
        product.setStatus(Constant.NO_STATUS);
        this.productService.saveProduct(product);
        return "redirect:/product/frontList.do?flag=my";
    }

    @RequestMapping(value = "edit", method = RequestMethod.GET)
    public String initEdit(HttpServletRequest request, HttpServletResponse response, ModelMap model, Integer id) {
        logger.debug("initEdit id:"+id);
        ProductInfo product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        return "product/edit";
    }

    @RequestMapping(value = "frontEdit", method = RequestMethod.GET)
    public String frontEdit(HttpServletRequest request, HttpServletResponse response, ModelMap model, Integer id) {
        logger.debug("initEdit id:"+id);
        ProductInfo product = this.productService.getProductById(id);
        logger.debug("edit product: " + product);
        model.addAttribute("product", product);
        return "product/frontEdit";
    }

    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public String edit(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                       @ModelAttribute ProductInfo product, @RequestParam(value="flag", required = false)String flag) {
        UserInfo currentUser = (UserInfo)getSession(request).getAttribute(Constant.SESSION_LOGIN_USER);
        product.setEditDate(new Date());
        product.setEditUser(currentUser);
        this.productService.editProduct(product);
        if("front".equals(flag)){
            return "redirect:/product/frontList.do?flag=my";
        }
        return "redirect:/product/list.do";
    }


    @RequestMapping(value = "approve", method = RequestMethod.GET)
    public String approve(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                          @RequestParam("id")Integer id, @RequestParam("status")Integer status) {

        if(status==1){
            productService.approve(id, Constant.ACTIVE_STATUS);
        }else{
            productService.approve(id, Constant.NO_STATUS);
        }
        return "redirect:/product/approveList.do";
    }

    @RequestMapping(value = "detail", method = RequestMethod.GET)
    public String detail(HttpServletRequest request, HttpServletResponse response, ModelMap model, Integer id) {
        ProductInfo product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        return "product/detail";
    }
}
