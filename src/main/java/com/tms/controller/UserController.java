package com.tms.controller;

import com.tms.entities.CompetitionInfo;
import com.tms.entities.FavoritesInfo;
import com.tms.entities.UserInfo;
import com.tms.pagination.Page;
import com.tms.service.CompetitionService;
import com.tms.service.FavoritesService;
import com.tms.service.UserService;
import com.tms.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Evan on 2016/4/20.
 */
@Controller
public class UserController extends BaseController {
    @Autowired
    private UserService userService;
    @Autowired
    private FavoritesService favoritesService;
    @Autowired
    private CompetitionService competitionService;
    @RequestMapping(value = "/central")
     public String list(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
        model.addAttribute("indx", 1);
        return "usercenter/userinfo";
    }
    @RequestMapping(value = "/user/modify", method = RequestMethod.GET)
    public String initModify(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
        return "usercenter/modify";
    }
    @RequestMapping(value = "/user/modify", method = RequestMethod.POST)
    public @ResponseBody String modify(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                       @ModelAttribute UserInfo user) {
        try {
            user.setStatus(Constant.ACTIVE_STATUS);
            this.userService.updateUser(user);
            return  "{\"state\":\"1\", \"errMsg\":\"\"}";
        } catch (Exception e) {
            return  "{\"state\":\"0\", \"errMsg\":\"保存失败\"}";
        }

    }
    @RequestMapping(value = "/user/password")
    public String initPassword(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
        return "usercenter/password";
    }
    @RequestMapping(value = "/user/modifyPassword", method = RequestMethod.POST)
    public @ResponseBody String modifyPassword(HttpServletRequest request, HttpServletResponse response,
                                               Model model, @RequestParam("oldPassword") String oldPassword,
                                               @RequestParam("newPassword") String newPassword,
                                               @RequestParam("newPasswordReply") String newPasswordReply) {

        UserInfo user = (UserInfo)getSession(request).getAttribute(Constant.SESSION_LOGIN_USER);
        if(!this.userService.encodePassword(oldPassword).equals(user.getPassword())) {
            return "{\"state\":\"0\", \"errMsg\":\"原密码不正确!\"}";
        }
        if(!newPassword.equals(newPasswordReply)) {
            return "{\"state\":\"0\", \"errMsg\":\"两次密码不一致!\"}";
        }
        newPassword = this.userService.encodePassword(newPassword);
        user.setPassword(newPassword);
        this.userService.modifyPassword(user);
        getSession(request).setAttribute(Constant.SESSION_LOGIN_USER, user);
        return "{\"state\":\"1\", \"errMsg\":\"\"}";
    }
    @RequestMapping(value = "/favourite")
    public String favourite(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
        model.addAttribute("indx", 2);
        return "usercenter/favourite";
    }
    @RequestMapping(value = "/favourite/list")
    public String favouriteList(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                                @RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                                @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        Page<FavoritesInfo> page = new Page<FavoritesInfo>();
        page.setCurrentPage(currentPage);
        page.setShowCount(pageSize);
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("page", page);
        UserInfo userInfo = (UserInfo) getSession(request).getAttribute(Constant.SESSION_LOGIN_USER);
        int isAdmin = 1;
        if (!userService.isAdmin(userInfo.getId())) {
            paramMap.put("acctId", userInfo.getId());
            isAdmin = 0;
        }
        page = this.favoritesService.queryList(paramMap);
        model.addAttribute("page", page);
        return "usercenter/favourite_list";
    }
    @RequestMapping(value = "/competition")
    public String competition(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
        model.addAttribute("indx", 3);
        return "usercenter/competition";
    }
    @RequestMapping(value = "/competition/list")
    public String competitionList(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                                @RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                                @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        Page<CompetitionInfo> page = new Page<CompetitionInfo>();
        page.setCurrentPage(currentPage);
        page.setShowCount(pageSize);
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("page", page);
        UserInfo userInfo = (UserInfo) getSession(request).getAttribute(Constant.SESSION_LOGIN_USER);
        int isAdmin = 1;
        if (!userService.isAdmin(userInfo.getId())) {
            paramMap.put("acctId", userInfo.getId());
            isAdmin = 0;
        }
        page = this.competitionService.queryList(paramMap);
        model.addAttribute("page", page);
        return "usercenter/competition_list";
    }
}
