package com.tms.controller;

import com.alibaba.fastjson.JSONObject;
import com.tms.entities.*;
import com.tms.service.CompetitionService;
import com.tms.service.FavoritesService;
import com.tms.service.ProductService;
import com.tms.service.UserService;
import com.tms.util.Constant;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Evan on 2016/4/21.
 */
@Controller
public class ProductController extends BaseController {


    private static Logger logger = Logger.getLogger(ProductController.class);

    @Value("${wlgj.url}")
    String httpToWLURL;

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
        ProductInfo p = productService.getProductById(productId);
        competition.setProductInfo(p);
        UserInfo userInfo = (UserInfo) getSession(request).getAttribute(Constant.SESSION_LOGIN_USER);
        competition.setUserInfo(userInfo);
        competition.setComValue(money == null ? new BigDecimal(0) : money);
        competition.setContent(content);
        competition.setStatus(Constant.ACTIVE_STATUS);
        competition.setCreateTime(new Date());
        competitionService.saveCompetition(competition);
        if(money != null & "1".equals(p.getStatus())){
            doPost(p);
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

    public void doPost(ProductInfo product){
        try {
            DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
            Map<String, String> param = new HashMap<String, String>();
            param.put("distinguish","jych");
            param.put("name",product.getName());
            param.put("chineseName",product.getChineseName());
            param.put("province",product.getProvince());
            param.put("organsAttribute",product.getOrgansAttribute());
            param.put("organization",product.getOrganization());
            param.put("startDate",fmt.format(product.getStartDate()));
            param.put("endDate",fmt.format(product.getEndDate()));
            param.put("type",product.getType());
            param.put("area",product.getArea());
            param.put("addr",product.getAddr());
            param.put("linkman",product.getLinkman());
            param.put("content",product.getContent());
            param.put("telephone",product.getTelephone());
            param.put("zipCode",product.getZipCode());
            param.put("taskSource",product.getTaskSource());
            param.put("isSecret",product.getIsSecret());
            param.put("secretLevel",product.getSecretLevel());
            param.put("technologyDirectory",product.getTechnologyDirectory());
            post(httpToWLURL,param);
        }catch (Exception e){
            logger.error("Post to weilai fail.",e);
        }

    }


    /**
     * 发送HttpPost请求
     *
     * @param strURL
     *            服务地址
     * @param body
     *            json字符串,例如: "{ \"id\":\"12345\" }" ;其中属性名必须带双引号<br/>
     * @return 成功:返回json字符串<br/>
     */
    public static String post(String strURL, Object body) {
        try {
            URL url = new URL(strURL);// 创建连接
            HttpURLConnection connection = (HttpURLConnection) url
                    .openConnection();
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setUseCaches(false);
            connection.setInstanceFollowRedirects(true);
            connection.setRequestMethod("POST"); // 设置请求方式
            connection.setRequestProperty("Accept", "application/json"); // 设置接收数据的格式
            connection.setRequestProperty("Content-Type", "application/json"); // 设置发送数据的格式
            connection.connect();
            OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8"); // utf-8编码
            out.append(JSONObject.toJSON(body).toString());	//fastjson
            out.flush();
            out.close();

            BufferedReader reader = new BufferedReader(new InputStreamReader(
                    connection.getInputStream()));
            String lines;
            StringBuffer sb = new StringBuffer("");
            while ((lines = reader.readLine()) != null) {
                lines = new String(lines.getBytes(), "utf-8");
                sb.append(lines);
            }
            reader.close();
            connection.disconnect();
            return sb.toString();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "error"; // 自定义错误信息
    }
}
