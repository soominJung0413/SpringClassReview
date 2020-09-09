<%--
  Created by IntelliJ IDEA.
  User: doli0
  Date: 2020-09-09
  Time: 오후 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Read</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">게시글 조회 페이지</div>

            <!-- /.panel-heading -->
            <div class="panel-body">

                <%@ include file="./includes/PageInfo.jsp"%>

                <button id="btnModifyPost" class="btn btn-default" data-hierarchy_id=${post.hierarchicallyId}>수정</button>
                <button data-oper='list' class="btn btn-default">글 목록</button>
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
</div>
<!-- /.row -->

<%@ include file="../includes/footer.jsp"%>

<!-- import javascript model -->

<script type="text/javascript">

    $(document).ready(function() {
        // ./includes/PostInfo.jsp에 정의된 함수입니다.
        setOperMode("readMode");

        $("#btnModifyPost").on('click', function(e){
            self.location = "/board/modify?hierarchicallyId=" + $(this).data('hierarchy_id');
        });

        $("button[data-oper='list']").on("click", function(e) {
            self.location = "/board/list";
        });
    });
</script>
