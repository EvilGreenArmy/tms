<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<script type="text/javascript">
    /*$(document).ready(function(){
        $(".click").click(function(){
            $(".tip").fadeIn(200);
        });

        $(".tiptop a").click(function(){
            $(".tip").fadeOut(200);
        });

        $(".sure").click(function(){
            $(".tip").fadeOut(100);
        });

        $(".cancel").click(function(){
            $(".tip").fadeOut(100);
        });

    });*/
    function delRole(){
        layer.confirm('确定要删除数据吗？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            trimForm('roleList');
            $("#roleList").attr("action","${basePath}/role/delete.do")
            layer.closeAll();
            postDataByFormName('roleList','workspace');
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
            postDataByURL('${basePath}/role/delete.do',{id:id},'workspace');
            layer.closeAll();
        }, function(){
        });
    }
    function assign() {
        if(isSelectData('id')){
            if(isMultiSelectData('id')){
                pageEditData('${basePath}/role/assign.do?t_='+ Math.random(),'id','id','workspace');
            }
        }
    }
    function queryRole(){
        postDataByFormName('roleList','workspace');
    }
</script>
<form action="${basePath}/role/list.do" method="post" id="roleList" name="roleList">
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">系统管理</a></li>
        <li><a href="#">角色管理</a></li>
    </ul>
</div>

<div class="rightinfo">
    <div class="seach_box">

        <fieldset>
            <legend>消息查询</legend>
            <table>
                <tbody>
                <tr>
                    <td class="tabel_title">角色名称</td>
                    <td class="table_cont">
                        <input type="text" name="name" placeholder="角色名称" value="${paramMap.name}" class="search_input"/>
                    </td>
                    <td  class="tabel_title">描述</td>
                    <td  class="table_cont">
                        <input type="text" name="description" placeholder="描述" value="${paramMap.description}" class="search_input"/>
                    </td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <td colspan="3"></td>
                    <td>
                        <button type="button" class="search_btn" onclick="queryRole();">查询</button>
                    </td>
                </tr>
                </tfoot>
            </table>
        </fieldset>


    </div>
    <div class="tools">

        <ul class="toolbar">
            <li class="click" onclick="getData('${basePath}/role/add.do','','workspace');"><span><img src="${basePath}/img/admin/login/t01.png" /></span>添加</li>
            <%--<li class="click"><span><img src="${basePath}/img/admin/login/t02.png" /></span>激活</li>--%>
            <li onclick="delRole();"><span><img src="${basePath}/img/admin/login/t03.png" /></span>删除</li>
            <li onclick="assign();"><span><img src="${basePath}/img/admin/login/t05.png" /></span>分派菜单</li>
        </ul>


        <ul class="toolbar1">
            <%--<li><span><img src="${basePath}/img/admin/login/t05.png" /></span>设置</li>--%>
        </ul>

    </div>


    <table class="tablelist">
        <thead>
        <tr>
            <th><input id="chk_all" type="checkbox" value="" /></th>
            <th>角色名称</th>
            <th>描述</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="obj" items="${page.resultList}">
            <tr>
                <td><input name="id" type="checkbox" value="${obj.id}" /></td>
                <td>${obj.name}</td>
                <td>${obj.description}</td>
                <td>
                    <a href="javascript:;" class="tablelink" onclick="getData('${basePath}/role/edit.do?id=${obj.id}','','workspace');">修改</a> |
                    <a href="javascript:;" onclick="singleDelete(${obj.id})" class="tablelink"> 删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <jsp:include page="../pagination/ajaxPager.jsp" flush="true" >
        <jsp:param name="formName" value="roleList" />
    </jsp:include>
    </div>
    </form>

<script type="text/javascript">
    $('.tablelist tbody tr:odd').addClass('odd');
</script>
