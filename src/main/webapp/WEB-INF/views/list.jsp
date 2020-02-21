<%--
  Created by IntelliJ IDEA.
  User: Satan
  Date: 2020/2/20
  Time: 23:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
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
                    新增</button>
                <button class="btn btn-danger">
                    <span class="glyphicon glyphicon-minus"></span>
                    删除
                </button>
            </div>
        </div>
        <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>员工编号</th>
                        <th>员工姓名</th>
                        <th>员工性别</th>
                        <th>邮箱</th>
                        <th>部门名</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <td>${emp.empId}</td>
                            <td>${emp.empName}</td>
                            <td>${emp.gender=="0"? '男':'女'}</td>
                            <td>${emp.email}</td>
                            <td>${emp.department.deptName}</td>
                            <td>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil"></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash"></span>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>


                </table>
            </div>
        </div>
        <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6">
                当前:${pageInfo.pageNum}页,共${pageInfo.pages}页,总记录数:${pageInfo.total}
            </div>
            <%--分页条信息--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${pageContext.request.contextPath}/emps?pageNum=1">首页</a></li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${pageContext.request.contextPath}/emps?pageNum=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num==pageInfo.pageNum}">
                                <li class="active"><a href="${pageContext.request.contextPath}/emps?pageNum=${page_Num}">${page_Num}</a></li>
                            </c:if>
                            <c:if test="${page_Num !=pageInfo.pageNum}">
                                <li><a href="${pageContext.request.contextPath}/emps?pageNum=${page_Num}">${page_Num}</a></li>
                            </c:if>
                            <%--<li><a href="emps/${pageNum}">2</a></li>
                            <li><a href="emps/${pageNum}">3</a></li>
                            <li><a href="emps/${pageNum}">4</a></li>
                            <li><a href="emps/${pageNum}">5</a></li>--%>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${pageContext.request.contextPath}/emps?pageNum=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        </c:if>
                        <li>
                            <a href="${pageContext.request.contextPath}/emps?pageNum=${pageInfo.pages}">末页</a>
                        </li>
                    </ul>
                </nav>
            </div>
            <%----%>
        </div>
    </div>
</body>
</html>
