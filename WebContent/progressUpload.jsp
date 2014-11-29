<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Progress Upload</title>
		<!-- 控制上傳進度條的兩個div區塊來做到進度條的效果 -->
		<style type="text/css">
			#progressBar {
				width: 400px;
				height: 12px;
				background: #FFFFFF;
				border: 1px solid #000000;
				padding: 1px;
			}
			#progressBarItem {
				width: 30%;
				height: 100%;
				background: #FF0000; 
			}
		</style>
	</head>
	<body>
		<iframe name=upload_iframe width=0 height=0></iframe>
		
		<form action="ProgressUploadServlet" method="post" enctype="multipart/form-data" target="upload_iframe" onsubmit="showStatus(); ">
			<input type="file" name="file1" style="width: 350px; "> <br />
			<input type="file" name="file2" style="width: 350px; "> <br />
			<input type="file" name="file3" style="width: 350px; "> <br />
			<input type="file" name="file4" style="width: 350px; ">
			<input type="submit" value=" 開始上傳 " id="btnSubmit">
		</form>
		
		<div id="status" style="display: none; ">
			上傳進度條: 
			<div id="progressBar">
				<div id="progressBarItem"></div>
			</div>
			<div id="statusInfo"></div>
		</div>
		
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		
		<script type="text/javascript">

			var _finished = true;
			
			function $(obj){
				return document.getElementById(obj);
			}
			
			// 顯示進度條
			function showStatus(){
				_finished = false;
				$('status').style.display = 'block';		// 將隱藏的進度條顯示 
				$('progressBarItem').style.width = '1%'; 	// 設定進度條的初始值為1%
				$('btnSubmit').disabled = true;				// 禁止[開始上傳]按鈕，防止重複上傳
				
				setTimeout("requestStatus()", 1000); 		// 一秒鐘後執行requestStatus()，更新上傳進度
			}
			
			// 向伺服器請求上傳進度資訊
			function requestStatus(){
			
				if(_finished)	return;
				
				var req = createRequest(); 	// 獲得AJAX請求
				
				req.open("GET", "ProgressUploadServlet");			// 設定請求路徑
				req.onreadystatechange=function(){callback(req);};	// 請求完畢就執行callback(req)
				req.send(null);		// 發送請求
				
				setTimeout("requestStatus()", 1000);	// 一秒後重新請求 
			}
			
			// 傳回AJAX請求物件
			function createRequest()
			{
				if (window.XMLHttpRequest) {	// Netscape browser
					return new XMLHttpRequest();
				} else {	// IE
					try {
				    	return new ActiveXObject("Msxml2.XMLHTTP");
					} catch (e) {
						return new ActiveXObject("Microsoft.XMLHTTP");
					}
				}
				return null;
			}
			
			// 更新進度條
			function callback(req){
			
				if (req.readyState == 4) {	// 請求結束後
					if(req.status != 200){	// 如果發生錯誤，則顯示錯誤資訊
						_debug("發生錯誤。 req.status: " + req.status + "");
						return;
					}
					
					_debug("status.jsp 返回值：" + req.responseText);		// 顯示DEBUG資訊						
						
					// 處理進度資訊，格式：百分比||已完成數(M)||文件總長度(M)||傳輸速率(K)||已用時間(s)||預估總時間(s)||預估剩餘時間(s)||正在上傳第幾個文件
					var ss = req.responseText.split("||");
					$('progressBarItem').style.width = '' + ss[0] + '%'; 
					$('statusInfo').innerHTML = '已完成百分比: ' + ss[0] + '% <br />已完成數(M): ' + ss[1] + '<br/>文件總長度(M): ' + ss[2] + '<br/>傳輸速率(K): ' + ss[3] + '<br/>已用時間(s): ' + ss[4] + '<br/>預估總時間(s): ' + ss[5] + '<br/>預估剩餘時間(s): ' + ss[6] + '<br/>正在上傳第幾個文件: ' + ss[7];
					
					if(ss[1] == ss[2]){	// 已完成數(M) = 文件總長度(M)
						_finished = true;
						$('statusInfo').innerHTML += "<br/><br/><br/>上傳已完成。"; 	
						$('btnSubmit').disabled = false;	// 開啟[開始上傳]按鈕，可以上傳其他檔案
					}
				}
			}
			
			// 顯示偵錯訊息
			function _debug(obj){
				var div = document.createElement("DIV");
				div.innerHTML = "[debug]: " + obj;
				document.body.appendChild(div); 
			}
			
		</script>
	</body>
</html>