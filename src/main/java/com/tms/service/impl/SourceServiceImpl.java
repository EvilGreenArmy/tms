package com.tms.service.impl;

import com.tms.dao.SourceMapper;
import com.tms.entities.SourceInfo;
import com.tms.entities.UserInfo;
import com.tms.pagination.Page;
import com.tms.service.SourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Evan on 2016/3/27.
 */
@Service("sourceService")
public class SourceServiceImpl implements SourceService {
    @Autowired
    private SourceMapper sourceDao;

    @Override
    public List<SourceInfo> getParentSource(UserInfo user) {
        return sourceDao.getParentSource(user);
    }

    @Override
    public List<SourceInfo> getChildrenSource(UserInfo user) {
        return sourceDao.getChildrenSource(user);
    }

    @Override
    public Page<SourceInfo> queryList(Map<String, Object> paramMap) {
        Page<SourceInfo> page = (Page<SourceInfo>) paramMap.get("page");
        List<SourceInfo> result = sourceDao.sourceQueryPage(paramMap);
        page.setResultList(result);
        return page;
    }

    @Transactional
    public void saveSource(SourceInfo source) {
        sourceDao.insertSource(source);
    }

    @Override
    public SourceInfo getSourceById(Integer id) {
        List<SourceInfo> sourceList = sourceDao.getSourceById(id);
        if (sourceList != null && sourceList.size() > 0) {
            return sourceList.get(0);
        }
        return new SourceInfo();
    }

    @Transactional
    public void updateSource(SourceInfo source) {
        sourceDao.updateSource(source);
    }

    @Transactional
    public void deleteSource(Integer[] ids) {
        sourceDao.deleteSource(ids);
    }

    @Override
    public List<SourceInfo> getParentSource() {
        return sourceDao.getAllParentSource();
    }

    @Override
    public List<SourceInfo> getChildrenSource() {
        return sourceDao.getAllChildrenSource();
    }

    @Override
    public Map<Integer, Integer> getRoleSource(Integer roleId) {
        List<SourceInfo> sourceList = sourceDao.getRoleSource(roleId);
        Map<Integer, Integer> map = new HashMap<Integer, Integer>();
        if (sourceList != null && sourceList.size() > 0) {
            for (SourceInfo source : sourceList) {
                map.put(source.getId(), roleId);
            }
        }
        return map;
    }
}
