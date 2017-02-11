<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="bean.SimpleAccessUser" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 	
	要使用JSTL(JSP Standard Tag Library)，必須先將以下兩個jar放到/WEB_INF/lib之下:
	1. javax.servlet.jsp.jstl-1.2.1.jar
	2. javax.servlet.jsp.jstl-api-1.2.1.jar
	
	從tagLib_JSTLTesting.html連動過來。
 --%>
<c:set var="title" value="標準標記 - 使用JSTL" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>${title}</title>
	</head>
	<body>
		<h1>${title}</h1>
		<h3>c:out (印出變數)</h3>
		<p>
			sex參數為：<c:out value="${ param.sex }" default="如果沒有值會秀出預設參數" escapeXml="true"></c:out>
		</p>
		<hr />
		<h3>c:if (if條件判斷)</h3>
		<p>
			<c:if test="${param.sex == 'male' }">
				if: 先生您好
			</c:if>
			<c:if test="${param.sex == 'female' }">
				if: 小姐您好
			</c:if>
			<c:if test="${param.sex != 'female' && param.sex != 'male'}">
				if: 您好
			</c:if>
		</p>
		<hr />
		<h3>c:choose, c:when, c:otherwise (if-else功能)</h3>
		<p>
			<c:choose>
				<c:when test="${ param.sex == 'female' }">
					when: 小姐您好
				</c:when>
				<c:otherwise>
					otherwise: 不是小姐
				</c:otherwise>
			</c:choose>
		</p>
		<p>
			您的性別是: 
			<c:choose>
				<c:when test="${param.sex == 'male'}" >男</c:when>
				<c:when test="${param.sex == 'female'}" >女</c:when>
				<c:otherwise >中性</c:otherwise>
			</c:choose>
		</p>
		<hr />
		<h3>c:forEach (for迴圈功能)</h3>
		<p>
			喜歡的運動:
			<c:forEach var="aValue" items="${paramValues['sport']}" >
				${aValue},
			</c:forEach>
		</p>
		<p>
			<h4>forEach印出1~100間的偶數:</h4>
			<c:forEach var="num" begin="2" end="100" step="2">
				${ num }, 
			</c:forEach>
		</p>
		<%
			// 這段應該要寫在servlet裡面
			List<SimpleAccessUser> userList = new ArrayList<SimpleAccessUser>();
			SimpleAccessUser user_1 = new SimpleAccessUser();
			user_1.setName("Hawk eye");
			user_1.setDept("Avengers");
			userList.add(0, user_1);
			SimpleAccessUser user_2 = new SimpleAccessUser();
			user_2.setName("Thor");
			user_2.setDept("Avengers");
			userList.add(1, user_2);
			SimpleAccessUser user_3 = new SimpleAccessUser();
			user_3.setName("Captain America");
			user_3.setDept("Avengers");
			userList.add(1, user_2);
			
			request.setAttribute("userList", userList);
		%>
		<p>
			<h4>forEach檢查集合:</h4>
			<table>
				<tr>
					<th>名稱</th>
					<th>部門</th>
				</tr>
				<c:forEach var="user" items="${ userList }">
					<tr>
						<td>${ user.name }</td>
						<td>${ user.dept }</td>
					</tr>
				</c:forEach>
			</table>
		</p>
		<%
			Map<String, String> testMap = new HashMap<String, String>();
			testMap.put("one", "valueOne");
			testMap.put("two", "valueTwo");
			
			request.setAttribute("testMap", testMap);
		%>
		<p>
			<h4>forEach檢查Map</h4>
			<table>
				<tr>
					<th>KEY</th>
					<th>VALUE</th>
				</tr>
				<c:forEach var="item" items="${ testMap }">
					<tr>
						<td>${ item.key }</td>
						<td>${ item.value }</td>
					</tr>
				</c:forEach>
			</table>
		</p>
		<p>
			<h4>c:forEach的varStatus屬性</h4>
			<table>
				<tr>
					<th>index(第幾個物件)</th>
					<th>count(已檢查幾個物件)</th>
					<th>first(目前物件是否為第一個物件)</th>
					<th>last(是否為最後一個物件)</th>
					<th>current(傳回目前檢查的物件)</th>
					<th>begin(for的起始index)</th>
					<th>end(for的終止index)</th>
					<th>step(for的遞增或遞減值)</th>
				</tr>
				<c:forEach var="user" items="${ userList }" varStatus="userVarStatus">
					<tr>
						<td>${ userVarStatus.index }</td>
						<td>${ userVarStatus.count }</td>
						<td>${ userVarStatus.first }</td>
						<td>${ userVarStatus.last }</td>
						<td>${ userVarStatus.current.name }</td>
						<td>${ userVarStatus.begin }</td>
						<td>${ userVarStatus.end }</td>
						<td>${ userVarStatus.step }</td>
					</tr>
				</c:forEach>
			</table>
		</p>
		<hr />
		<h3>c:forTokens (String的forEach)</h3>
		<p>
			<table>
				<c:forTokens items="one, two, three, four, five" delims="," var="item" varStatus="varStatus" begin="1" end="7" step="2">
					<tr>
						<td>${ varStatus.index }</td>
						<td>${ item }</td>
					</tr>
				</c:forTokens>
			</table>
		</p>
		<hr />
		<h3>c:set 宣告或修改物件</h3>
		<p>
			<c:set var="count" value="${ count + 1 }" scope="session"></c:set>
			count變數: ${ count }
			<br />
			<%
				request.setAttribute("user_4", new SimpleAccessUser());
				request.setAttribute("map_1", new HashMap());
			%>
			<c:if test="${ user_4 != null }"><!-- c:set 使用target屬性檢查的物件不能為null，所以先使用c:if檢查(var和target屬性只能擇一) -->
				<c:set target="${ user_4 }" property="name" value="iron man"></c:set>
				user_4.name: ${ user_4.name }
			</c:if>
			<br />
			<c:set target="${ map_1 }" property="firstProperty" value="firstPropertyValue"></c:set>
			map_1.firstProperty: ${ map_1.firstProperty }
		</p>
		<hr />
		<h3>c:remove 刪除物件</h3>
		<p>
			<c:remove var="map_1" /><!-- c:remove 只有var和scope屬性，var只接受字串，不接受EL，scope可以指定page、request、session、application -->
			${ map_1 == null ? 'map_1 已經被刪除' : 'map_1 沒有被刪除' }
		</p>
		<hr />
		<h3>c:import 匯入網路資源</h3>
		<p>
			<c:import url="https://tw.yahoo.com" charEncoding="utf-8" var="yahoo" scope="request"></c:import>
			<p>
				yahoo的原始碼為: <c:out value="${ yahoo }" escapeXml="true"></c:out>
			</p>
		</p>
		<hr />
		<h3>c:url 如果user瀏覽器不支援cookie，可以使用response.encodeURL()方法對URL進行寫程式，讓他也能使用session功能，這叫做URL重新定義。</h3>
		<p>
			<c:url value="/images/errorstate.gif"></c:url>
		</p>
		<hr />
		<h3>c:redirect 重新導向</h3>
		<c:redirect url="/helloWorldJSP.html"></c:redirect>
	</body>
</html>