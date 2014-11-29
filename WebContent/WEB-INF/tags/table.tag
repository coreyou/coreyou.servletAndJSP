<%@ tag body-content="scriptless" %>
<%@ attribute name="border" %>
<%@ attribute name="color" %>
<%@ attribute name="title" %>
<%@ attribute name="bgcolor" %>
<table border="${border}" bgcolor="${color}">
	<tr>
		<td><b>${title}</b></td>
	</tr>
	<tr>
		<td bgcolor="${bgcolor}"><jsp:doBody></jsp:doBody></td>
	</tr>
</table>