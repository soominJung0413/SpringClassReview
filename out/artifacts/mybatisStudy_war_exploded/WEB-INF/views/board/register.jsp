<%--
  Created by IntelliJ IDEA.
  User: doli0
  Date: 2020-09-09
  Time: 오후 9:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    request.setCharacterEncoding("UTF-8");
%>

<%@ include file="../includes/header.jsp"%>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Tables</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">게시글 등록 페이지</div>

            <!-- /.panel-heading -->
            <div class="panel-body">
                <form id = "postForm" role="form" action="/board/register" method="post">
                    <%@ include file="includes/PageInfo.jsp"%><%--페이지 모듈화는 상세히한다. 나눌 수 있는 것은 모두 나눈다.--%>
                            <%--폼의 기본구조는 동일하니, 폼에 상황에 따라 dom을 바꾸는 함수를 작성하도록 한다.--%>
                    <button id = "btnInsertPost" type="submit" class="btn btn-default">Submit Button</button>
                    <button type="reset" class="btn btn-default">Reset Button</button>

                    <input type="hidden" name='pageNum' value='${cri.pageNum}'>
                    <input type="hidden" name='amount' value='${cri.amount}'>

                    <input type="hidden" name="boardType.boardTypeId" value="-1"><%--게시판 종류--%>
                    <input type="hidden" name="writer.id" value="-100"><%--세션유저아이디--%>
                </form>

            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
</div>

<%@ include file="../includes/footer.jsp"%>

<script type="text/javascript">
    $(document).ready(function() {
        setOperMode("createMode");

        var postForm = $("#postForm");

        $("#btnInsertPost").on("click", function(e) {
            e.preventDefault();
            postForm.submit();
        });
    });
</script>