package com.tms.pagination;

import java.util.List;

/**
 * Created by Evan on 2016/3/15.
 */
public class Page<E> {
    private static final long serialVersionUID = 587754556498974978L;

    private int showCount = 10;
    private int totalPage;
    private int totalResult;
    private int currentPage = 1;
    private int currentResult;

    private String sortField;
    private String orderBy;

    private List<E> resultList;
    public int getShowCount() {
        return showCount;
    }

    public void setShowCount(int showCount) {
        this.showCount = showCount;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getTotalResult() {
        return totalResult;
    }

    public void setTotalResult(int totalResult) {
        this.totalResult = totalResult;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getCurrentResult() {
        return showCount*(currentPage-1);
    }

    public void setCurrentResult(int currentResult) {
        this.currentResult = currentResult;
    }

    public String getSortField() {
        return sortField;
    }

    public void setSortField(String sortField) {
        this.sortField = sortField;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public List<E> getResultList() {
        return resultList;
    }

    public void setResultList(List<E> resultList) {
        this.resultList = resultList;
    }


    @Override
    public String toString() {
        return "Page{" +
                "orderBy='" + orderBy + '\'' +
                ", showCount=" + showCount +
                ", totalPage=" + totalPage +
                ", totalResult=" + totalResult +
                ", currentPage=" + currentPage +
                ", currentResult=" + currentResult +
                ", sortField='" + sortField + '\'' +
                '}';
    }
}
