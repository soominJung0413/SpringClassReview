<%--
  Created by IntelliJ IDEA.
  User: doli0
  Date: 2020-09-09
  Time: 오후 10:06
  To change this template use File | Settings | File Templates.
--%>
<!-- Read, Create, Update 시 동일 객체를 다루게 된다. 이 때  JSP에 비슷한 내용을
중복적으로 개발하지 말고 이렇게 공통 부분을 정의하고 처리하는 형태에 따라 조정하는 스타일을 활용합시다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"
        integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
        crossorigin="anonymous"></script>

<div id="hierarchyIdDiv" class="form-group" style ="display:none">
    <label>ID</label>
    <input id="hierarchyId" name="hierarchicallyId" class="form-control" type="text"
    <c:if test="${post != null}">
           value='<c:out value="${post.hierarchicallyId}"/>'
    </c:if>
    >
</div>
<div class="form-group">
    <label>Title</label>
    <input id="title" name="boardTitle" class="form-control" type="text"
    <c:if test="${post != null}">
           value='<c:out value="${post.boardTitle}"/>'
    </c:if>
    >
</div>
<div class="form-group">
    <label>Text area</label>
    <textarea id="content" name="content" class="form-control" rows="4" cols="50">
		<c:if test="${post != null}">
            <c:out value="${post.content}" />
        </c:if>
	</textarea>
</div>
<div class="form-group">
    <label>Writer</label>
    <input class="form-control" type="text" readonly='readonly'
    <c:if test="${post != null}">
           value='<c:out value="${post.writer.name}"/>'
    </c:if>
    >
</div>

<script type="text/javascript">
    function setOperMode(mode) {
        //Default is Creatable and Updatable. So has No change!
        //$("#hierarchyIdDiv").hide();

        if ("readMode" === mode) {
            $("#title").attr("readonly",true);
            $("#content").attr("readonly",true);
        }
    }

    $(document).ready(function() {
    });
</script>
