<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="coreyouTag" uri="http://tw.coreyouCorp.com/coreyouTagLib" %>
<h3>JSP組態 - 設定在Web.xml中</h3>
<ul>
	<li>設定 &lt;el-ignored&gt; 為 true, 讓 ${el}元素失效</li>
	<li>設定 &lt;scripting-invalid&gt; 為 true, 讓&lt;% scripting-invalid&gt; 元素失效(但還是可以使用&lt;%@ %&gt;和&lt;%-- --&gt;)</li>
	<li>設定 &lt;include-prelude&gt; 加入標頭檔</li>
	<li>設定&lt;include-coda&gt; 加入標尾檔</li>
</ul>