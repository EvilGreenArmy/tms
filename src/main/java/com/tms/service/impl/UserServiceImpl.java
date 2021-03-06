package com.tms.service.impl;

import com.tms.dao.UserMapper;
import com.tms.entities.AccountDutyInfo;
import com.tms.entities.LikeInfo;
import com.tms.entities.UserInfo;
import com.tms.pagination.Page;
import com.tms.security.PwdEncoder;
import com.tms.service.UserService;
import com.tms.util.Constant;
import com.tms.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;

/**
 * Created by Evan on 2016/3/15.
 */
@Service("userService")
public class UserServiceImpl implements UserService {


    private static final String salt = "googlebaidu";
    private static final String MD5_KEY = "amsMd5";
    @Autowired
    private UserMapper userDao;
    @Autowired
    private PwdEncoder pwdEncoder;

    @Override
    public Page<UserInfo> queryList(Map<String, Object> paramMap) {
        Page<UserInfo> page = (Page<UserInfo>) paramMap.get("page");
        List<UserInfo> result = userDao.userQueryPage(paramMap);
        page.setResultList(result);
        return page;
    }

    @Transactional
    public void saveUser(UserInfo user) {
        if(StringUtil.isEmpty(user.getPassword())) {
            String password = pwdEncoder.encodePassword(Constant.DEFAULT_PASSWORD, salt);
            user.setPassword(password);
        } else {
            String password = pwdEncoder.encodePassword(user.getPassword(), salt);
            user.setPassword(password);
        }
        //删除状态默认为A 未删除
        user.setDelState(Constant.ACTIVE_STATUS);
        userDao.insertUser(user);
    }

    @Override
    public UserInfo getUserByLogin(String userName, String password) {
        UserInfo user = new UserInfo();
        user.setAcctName(userName);
        List<UserInfo> list = userDao.getUser(user);
        UserInfo loginUser = null;
        if (list != null && list.size() > 0) {
            UserInfo temp = list.get(0);
            String dbpassword = temp.getPassword();
            if (pwdEncoder.isPasswordValid(dbpassword, password, salt)) {
                // 登陆成功
                loginUser = temp;
            }
        }
        return loginUser;
    }

    @Override
    public boolean checkAcctName(UserInfo userInfo) {
        List<UserInfo> list = userDao.getUser(userInfo);
        if (list != null && list.size() > 0) {
            return true;
        }
        return false;
    }

    @Override
    public UserInfo getUserById(Integer id) {
        List<UserInfo> userList = userDao.getUserById(id);
        if (userList != null && userList.size() > 0) {
            return userList.get(0);
        }
        return new UserInfo();
    }

    @Transactional
    public void updateUser(UserInfo user) {
        userDao.updateUser(user);
    }

    @Transactional
    public void deleteUser(Integer[] ids) {
        userDao.deleteUser(ids);
    }

    @Transactional
    public void editAccountDuty(Map<String, Object> map) {
        Integer acctId = Integer.parseInt(map.get("acctId").toString());
        clearAcctDuty(acctId);
        List<AccountDutyInfo> acctDutyList = (List)map.get("acctRoles");
        if(acctDutyList != null && acctDutyList.size() > 0) {
            insertAcctDuty(acctDutyList);
        }
    }

    @Override
    public boolean isAdmin(Integer acctId) {
        Integer count = userDao.isAdminUser(acctId);
        if(count != null && count.intValue() > 0) {
            return true;
        }
        return false;
    }
    @Transactional
    public void saveUp(LikeInfo likeInfo) {
        this.userDao.insertLike(likeInfo);
    }

    @Override
    public Integer getTotalLike(Integer productId) {
        return this.userDao.getTotalLike(productId);
    }

    @Override
    public String encodePassword(String password) {
        return pwdEncoder.encodePassword(password, salt);
    }

    @Transactional
    public void modifyPassword(UserInfo user) {
        userDao.modifyPassword(user);
    }

    private void clearAcctDuty(Integer acctId) {
        userDao.clearAcctDuty(acctId);
    }
    private void insertAcctDuty(List<AccountDutyInfo> acctDutyList) {
        userDao.insertAcctDuty(acctDutyList);
    }
}
