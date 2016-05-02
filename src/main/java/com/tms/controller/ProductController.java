package com.tms.controller;

import com.tms.entities.*;
import com.tms.service.CompetitionService;
import com.tms.service.FavoritesService;
import com.tms.service.ProductService;
import com.tms.service.UserService;
import com.tms.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Evan on 2016/4/21.
 */
@Controller
public class ProductController extends BaseController {
    @Autowired
    private ProductService productService;
    @Autowired
    private UserService userService;
    @Autowired
    private FavoritesService favoritesService;
    @Autowired
    private CompetitionService competitionService;

    /**
     * 将cookie封装到Map里面
     *
     * @param request
     * @return
     */
    private static Map<String, Cookie> readCookieMap(HttpServletRequest request) {
        Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
        Cookie[] cookies = request.getCookies();
        if (null != cookies) {
            for (Cookie cookie : cookies) {
                cookieMap.put(cookie.getName(), cookie);
            }
        }
        return cookieMap;
    }

    @RequestMapping(value = "/product/detail")
    public String list(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                       @RequestParam("id") final Integer id) {
        ProductInfo product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        Integer totalCount = this.userService.getTotalLike(id);
        model.addAttribute("praiseCount", totalCount);
        Map<String, Cookie> praiseMap = this.readCookieMap(request);
        if (praiseMap.containsKey("post_" + id)) {
            model.addAttribute("praiseFlag", "1");
        }
        Integer favCount = this.favoritesService.getTotalFavorites(id);
        model.addAttribute("favCount", favCount);
        if (praiseMap.containsKey("fav_" + id)) {
            model.addAttribute("favFlag", "1");
        }
        //最高价
        BigDecimal maxValue = this.competitionService.getMaxValue(id);
        model.addAttribute("maxValue", maxValue);
        //出价人数
        Integer amount = this.competitionService.getTotalAmount(id);
        model.addAttribute("comAmount", amount);
        //评价信息
        List<CompetitionInfo> comList = this.competitionService.getAllCompetition(id);
        model.addAttribute("comList", comList);
        return "main/detail";
    }

    @RequestMapping(value = "/product/up")
    public void up(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                   @RequestParam("id") final Integer productId) throws IOException {
        LikeInfo like = new LikeInfo();
        like.setProductId(productId);
        like.setCreateTime(new Date());
        this.userService.saveUp(like);
        Integer totalCount = this.userService.getTotalLike(productId);
        response.getWriter().println(totalCount);
    }

    @RequestMapping(value = "/product/fav")
    public void fav(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                    @RequestParam("id") final Integer productId) throws IOException {
        FavoritesInfo favoritesInfo = new FavoritesInfo();
        ProductInfo productInfo = new ProductInfo();
        productInfo.setId(productId);
        favoritesInfo.setProductInfo(productInfo);
        UserInfo userInfo = (UserInfo) getSession(request).getAttribute(Constant.SESSION_LOGIN_USER);
        favoritesInfo.setUserInfo(userInfo);
        favoritesInfo.setCreateTime(new Date());
        this.favoritesService.saveFavorites(favoritesInfo);
        Integer totalCount = this.favoritesService.getTotalFavorites(productId);
        response.getWriter().println(totalCount);
    }

    @RequestMapping(value = "/product/competition", method = RequestMethod.POST)
    public
    @ResponseBody
    String competition(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                       @RequestParam("id") final Integer productId,
                       @RequestParam(value = "content", required = false, defaultValue = "") final String content,
                       @RequestParam(value = "money", required = false, defaultValue = "0") final BigDecimal money) throws IOException {
        CompetitionInfo competition = new CompetitionInfo();
        ProductInfo p = new ProductInfo();
        p.setId(productId);
        competition.setProductInfo(p);
        UserInfo userInfo = (UserInfo) getSession(request).getAttribute(Constant.SESSION_LOGIN_USER);
        competition.setUserInfo(userInfo);
        competition.setComValue(money == null ? new BigDecimal(0) : money);
        competition.setContent(content);
        competition.setStatus(Constant.ACTIVE_STATUS);
        competition.setCreateTime(new Date());
        competitionService.saveCompetition(competition);
        if(money != null){
            productService.updateStatus(productId,"3");
        }
        //最高价
        BigDecimal maxValue = this.competitionService.getMaxValue(productId);
        //出价人数
        Integer amount = this.competitionService.getTotalAmount(productId);
        StringBuffer sb = new StringBuffer("{\"state\":\"1\", \"maxValue\":").append("\"").append(maxValue).append("\",");
        sb.append("\"maxAmount\":").append("\"").append(amount).append("\"}");
        return sb.toString();
    }
    @RequestMapping(value = "/product/reply", method = RequestMethod.POST)
    public
    @ResponseBody
    String reply(HttpServletRequest request, HttpServletResponse response, ModelMap model,
                       @RequestParam("id") final Integer productId,
                       @RequestParam(value = "content", required = false, defaultValue = "") final String content,
                       @RequestParam(value = "money", required = false, defaultValue = "0") final BigDecimal money,
                       @RequestParam("userId") final Integer userId) throws IOException {
        CompetitionInfo competition = new CompetitionInfo();
        ProductInfo p = new ProductInfo();
        p.setId(productId);
        competition.setProductInfo(p);
        UserInfo userInfo = (UserInfo) getSession(request).getAttribute(Constant.SESSION_LOGIN_USER);
        competition.setUserInfo(userInfo);
        competition.setComValue(money);
        competition.setContent(content);
        competition.setStatus(Constant.ACTIVE_STATUS);
        competition.setCreateTime(new Date());
        UserInfo reply = new UserInfo();
        reply.setId(userId);
        competition.setReplyUser(reply);
        competitionService.saveReplyCompetition(competition);

        return "{\"state\":\"1\"}";
    }
}
