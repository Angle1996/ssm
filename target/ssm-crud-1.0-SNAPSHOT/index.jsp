<%--
  Created by IntelliJ IDEA.
  User: Satan
  Date: 2020/2/20
  Time: 12:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<jsp:forward page="/emps"></jsp:forward>--%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <title>Title</title>
    <%--引入jauery--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webjars/jquery/3.1.1/jquery.min.js"></script>
    <%--引入样式--%>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <%--<div class="col-md-9">123234234234234</div>--%>
        <div class="col-md-2 col-md-offset-9">
            <button class="btn btn-primary">
                <span class="glyphicon glyphicon-plus"></span>
                新增
            </button>
            <button class="btn btn-danger">
                <span class="glyphicon glyphicon-minus"></span>
                删除
            </button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>员工编号</th>
                        <th>员工姓名</th>
                        <th>员工性别</th>
                        <th>邮箱</th>
                        <th>部门名</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
        <%----%>
    </div>
</div>
<script type="text/javascript">
    var totalRecord,currentPage;
    //1、页面加载完成以后，直接去发送ajax请求,要到分页数据
    $(function(){
        //去首页
        to_page(1);
    });

    function to_page(pageNum){
        $.ajax({
            url:"${pageContext.request.contextPath}/emps",
            data:"pageNum="+pageNum,
            type:"GET",
            success:function(result){
                //console.log(result);
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条数据
                build_page_nav(result);
            }
        });
    }
    //显示员工信息
    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='0'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var emps = result.extend.pageInfo.list;
            //编辑按钮
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //删除按钮
            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //操作按钮
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前:"+result.extend.pageInfo.pageNum+"页,共"+result.extend.pageInfo.pages+"页,总记录数:"+result.extend.pageInfo.total);
    }
    //解析显示分页条
    function build_page_nav(result){
        $("#page_nav_area").empty();
        var nav=$("<nav aria-label=\"Page navigation\"></nav>")
        var ul=$("<ul></ul>").addClass("pagination");
        //构建元素li
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("<span aria-hidden=\"true\">&laquo;</span>"));

        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加点击翻页的事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum -1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("<span aria-hidden=\"true\">&raquo;</span>"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum +1);
            });
            lastPageLi.click(function(){
                to_page(result.extend.pageInfo.pages);
            });
        }
        ul.append(firstPageLi);
        //添加首页和前一页 的提示
        if (result.extend.pageInfo.hasPreviousPage==true){

        ul.append(prePageLi);
        }
        //1,2，3遍历给ul中添加页码提示
        var navigatepageNums=result.extend.pageInfo.navigatepageNums;
        $.each(navigatepageNums,function(index,item){

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function(){
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页 的提示
        if (result.extend.pageInfo.hasNextPage==true){
            ul.append(nextPageLi)
        }
        ul.append(lastPageLi);
        //把ul加入到nav
        var navEle =nav.append(ul);
        navEle.appendTo("#page_nav_area");
    }

</script>
</body>
</html>
