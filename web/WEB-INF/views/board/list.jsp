<%--
  Created by IntelliJ IDEA.
  User: doli0
  Date: 2020-09-09
  Time: 오후 9:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
    <p class="mb-4">
        DataTables is a third party plugin that is used to generate the demo
        table below. For more information about DataTables, please visit the <a
            target="_blank" href="https://datatables.net">official DataTables
        documentation</a>.
    </p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">게시글 목록 페이지</h6>
            <button class='btn btn-xs btn-outline-dark' id="btnInsertPostPage" type='button'>글 쓰기</button>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%"
                       cellspacing="0">
                    <thead>
                    <tr>
                        <th>제목</th>
                        <th>작성자</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="post">
                        <tr>
                            <td><a href="/board/readOnePost?hierarchicallyId=${post.hierarchicallyId}">${post.boardTitle}</a></td>
                            <td>${post.writer.name}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>
<!-- /.container-fluid -->

<!-- 처리 완료 확인용 모달창 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">처리가 완료되었습니다.</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div> <!-- /.modal-content -->
    </div> <!-- /.modal-dialog -->
</div><!-- /.modal 처리 완료 확인용 모달끝 -->




<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
    $(document).ready(function() {
        var result = '<c:out value="${result}"/>';

        checkModal(result);

        // 상태(모달 창 띄울 필요 없음 상태) 하나 생성
        history.replaceState({}, null, null);

        function checkModal(result) {
            if (result === '' || history.state) {
                return;
            }
            $(".modal-body").html( result );

            $("#myModal").modal("show");
        }

        $("#btnInsertPostPage").on('click', function(e){
            self.location = "/board/register";
        });

    });
</script>
