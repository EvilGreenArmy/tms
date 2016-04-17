<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<script type="text/javascript">
    function delFavorites(){
        layer.confirm('确定要删除数据吗？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            trimForm('favoritesList');
            $("#favoritesList").attr("action","${basePath}/favorites/delete.do")
            layer.closeAll();
            postDataByFormName('favoritesList','workspace');
        }, function(){
        });
    }

    function checkSelect(){
        var ids = $("input:checked");
        if(ids.size()>0){
            return true;
        }
        return false;
    }

    $(function(){
        $("#chk_all").click(function(){
            $("input[name='id']").prop("checked",$(this).prop("checked"));
        });
    })
    function singleDelete(id) {
        layer.confirm('确定要删除数据吗？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            postDataByURL('${basePath}/favorites/delete.do',{id:id},'workspace');
            layer.closeAll();
        }, function(){
        });
    }
</script>
<form action="${basePath}/favorites/list.do" method="post" id="favoritesList" name="favoritesList">
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">业务管理</a></li>
        <li><a href="#">我的收藏</a></li>
    </ul>
</div>

<div class="rightinfo">

    <div class="tools">

        <ul class="toolbar">
            <%--<li class="click" onclick="getData('${basePath}/user/add.do','','workspace');"><span><img src="${basePath}/img/admin/login/t01.png" /></span>添加</li>--%>
            <%--<li class="click"><span><img src="${basePath}/img/admin/login/t02.png" /></span>激活</li>--%>
            <li onclick="delFavorites();"><span><img src="${basePath}/img/admin/login/t03.png" /></span>删除</li>
        </ul>


        <%--<ul class="toolbar">
            <li class="click" onclick="assign();"><span><img src="${basePath}/img/admin/login/t05.png" /></span>分派角色</li>
        </ul>--%>

    </div>


    <table class="tablelist">
        <thead>
        <tr>
            <th><input id="chk_all" type="checkbox" value="" /></th>
            <c:if test="${isAdmin eq '1'}">
                <th>收藏人</th>
            </c:if>
            <th>名称</th>
            <th>类型</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="obj" items="${page.resultList}">
            <tr>
                <td><input name="id" type="checkbox" value="${obj.id}" /></td>
                <c:if test="${isAdmin eq '1'}">
                    <td>${obj.userInfo.userName}</td>
                </c:if>
                <td>${obj.productInfo.name}</td>
                <c:if test="${obj.productInfo.type eq '1'}">
                    <td>成果</td>
                </c:if>
                <c:if test="${obj.productInfo.type eq '2'}">
                    <td>专利</td>
                </c:if>
                <td>
                    <a href="javascript:;" onclick="singleDelete(${obj.id})" class="tablelink"> 删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <jsp:include page="../pagination/ajaxPager.jsp" flush="true" >
        <jsp:param name="formName" value="favoritesList" />
    </jsp:include>
    </div>
    </form>

<script type="text/javascript">
    $('.tablelist tbody tr:odd').addClass('odd');
</script>
