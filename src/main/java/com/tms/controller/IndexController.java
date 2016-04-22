package com.tms.controller;

import com.tms.entities.ProductInfo;
import com.tms.entities.UserInfo;
import com.tms.pagination.Page;
import com.tms.service.ProductService;
import com.tms.service.UserService;
import com.tms.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Evan on 2016/4/17.
 */
@Controller
public class IndexController extends BaseController {
    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @RequestMapping(value = "/index")
    public String list(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
        HttpSession session = getSession(request);
        StringBuffer basePath = new StringBuffer();
        basePath.append(request.getScheme()).append("://");
        basePath.append(request.getServerName()).append(":");
        basePath.append(request.getServerPort()).append(request.getContextPath());
        session.setAttribute(Constant.BASE_PATH, basePath.toString());
        return "login/login";
    }

    @RequestMapping(value = "register", method = RequestMethod.GET)
    public String initRegister(HttpServletRequest request, HttpServletResponse response,
                               Model model) {
        HttpSession session = getSession(request);
        StringBuffer basePath = new StringBuffer();
        basePath.append(request.getScheme()).append("://");
        basePath.append(request.getServerName()).append(":");
        basePath.append(request.getServerPort()).append(request.getContextPath());
        session.setAttribute(Constant.BASE_PATH, basePath.toString());
        return "login/register";
    }

    @RequestMapping(value = "register", method = RequestMethod.POST)
    public String register(HttpServletRequest request, HttpServletResponse response,
                           Model model, UserInfo userInfo) {
        userInfo.setStatus(Constant.ACTIVE_STATUS);
        this.userService.saveUser(userInfo);
        return "login/login";
    }

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String doLogin(String userName, String password, HttpServletRequest request, HttpServletResponse response,
                          Model model) {
        UserInfo user = this.userService.getUserByLogin(userName, password);
        if (user != null) {
            if (Constant.ACTIVE_STATUS.equalsIgnoreCase(user.getStatus())) {
                HttpSession session = getSession(request);
                session.setAttribute(Constant.SESSION_LOGIN_USER, user);
                StringBuffer basePath = new StringBuffer();
                basePath.append(request.getScheme()).append("://");
                basePath.append(request.getServerName()).append(":");
                basePath.append(request.getServerPort()).append(request.getContextPath());
                session.setAttribute(Constant.BASE_PATH, basePath.toString());
                return "redirect:/main.htm";
            } else {
                model.addAttribute("errMsg", "当前用户已被禁止登录");
                return "login/login";
            }
        } else {
            model.addAttribute("errMsg", "用户名或密码错误");
            return "login/login";
        }

    }

    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response,
                         Model model) {
        HttpSession session = getSession(request);
        session.removeAttribute(Constant.SESSION_LOGIN_USER);
        return "login/login";
    }

    @RequestMapping(value = "/main")
    public String main(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                       @RequestParam(value = "type", required = false) String type,
                       @RequestParam(value = "name", required = false) String name) {
        //查询成果专利
        Page<ProductInfo> page = new Page<ProductInfo>();
        Map<String, Object> paramMap = new HashMap<String, Object>();
        if (null != type) {
            paramMap.put("type", type);
        }
        if (null != name) {
            paramMap.put("name", name);
        }
        paramMap.put("page", page);
        page = productService.queryList(paramMap);
        model.addAttribute("paramMap", paramMap);
        model.addAttribute("page", page);
        return "main/main";
    }
}
