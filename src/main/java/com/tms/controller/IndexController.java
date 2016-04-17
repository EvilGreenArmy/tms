package com.tms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Evan on 2016/4/17.
 */
@Controller
public class IndexController extends BaseController {

    @RequestMapping(value = "/index")
    public String list(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
        return "login/login";
    }

}
