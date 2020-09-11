<%--
  Created by IntelliJ IDEA.
  User: doli0
  Date: 2020-09-09
  Time: 오후 11:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
    request.setCharacterEncoding("UTF-8");
%>

<%@ include file="../includes/header.jsp"%>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">게시글 수정</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">게시글 수정 페이지</div>

            <!-- /.panel-heading -->
            <div class="panel-body">
                <form id="postInfoForm" role="form" action="/board/modify" method="post">
                    <%@ include file="./includes/PageInfo.jsp"%>

                    <button type="submit" id='btnModify' class="btn btn-default">글 수정</button>
                    <button type="submit" id='btnRemove' class="btn btn-warning">글 삭제</button>
                    <button type="submit" id='btnList' class="btn btn-info">글 목록</button>
                        ${cri.makeHTMLTags()}
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
        // ./includes/PostInfo.jsp에 정의된 함수입니다.
        setOperMode("updateMode");

        var searchKeywordFrom = $("#postInfoForm");

        $('#btnModify').on("click", function(e) {
            e.preventDefault();
            searchKeywordFrom.submit();
        });

        $('#btnList').on("click", function(e) {
            e.preventDefault();

            var pageNumInput = $("input:hidden[name='pageNum']").clone();
            var amountInput = $("input:hidden[name='amount']").clone();
            var searchTypeInput = $("input:hidden[name='searchType']").clone();
            var searchKeywordInput = $("input:hidden[name='searchKeyword']").clone();

            searchKeywordFrom.attr('action', "/board/list").attr("method", "get");
            searchKeywordFrom.empty();
            searchKeywordFrom.append(pageNumInput);
            searchKeywordFrom.append(amountInput);
            searchKeywordFrom.append(searchTypeInput);
            searchKeywordFrom.append(searchKeywordInput);

            searchKeywordFrom.submit();
        });

        $('#btnRemove').on("click", function(e) {
            e.preventDefault();

            searchKeywordFrom.attr('action', "/board/remove").attr("method", "post");

            searchKeywordFrom.submit();
        });

    });
</script>
