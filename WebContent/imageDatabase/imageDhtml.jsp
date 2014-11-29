<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>圖片檔案夾(互動性秀圖(DHTML))</title>
		<script type="text/javascript">
		<!--
			var i = 1;
			var cntWeight = 2;	// 放大、縮小圖形的倍數
			var origWidth = 0;
			var origHeight = 0;
			var strPath = "../images/";
			
			function displayImg() {
				imgShown.src = strPath + formImg.imgName.value;
				if (i == 1) {	// 保留圖形的原始寬度高度
					origWidth = imgShown.width;
					origHeight = imgShown.height;
				} else {	// 還原圖形的原始寬度高度
					imgShown.width = origWidth;
					imgShown.height = origHeight;
					i = 1;	// reset i，再保留圖形原始寬度高度
					origWidth = imgShown.width;
					origHeight = imgShown.height;
				}
			}
			
			function zoomOut() {
				if (i == 1) {
					imgShown.src = strPath + formImg.imgName.value;
					origWidth = imgShown.width;	// 保留圖形的原始寬度高度
					origHeight = imgShown.height;
				}
				imgShown.width = imgShown.width * cntWeight;
				imgShown.height = imgShown.height * cntWeight;
				i++;
			}
			
			function zoomIn() {
				if (i == 1) {
					imgShown.src = strPath + formImg.imgName.value;
					origWidth = imgShown.width;
					origHeight = imgShown.height;
				}
				imgShown.width = imgShown.width / cntWeight;
				imgShown.height = imgShown.height / cntWeight;
				i++;
			}
		-->
		</script>
	</head>
	<body>
		<h2>圖片檔案夾(互動性秀圖(DHTML))</h2>
		<form name="formImg" method="post">
			<p>
				圖檔名稱: <input type="text" name="imgName" size=30 value="Adventure Time challenge.png">
				<input type="hidden" name="hidName" value="Adventure Time challenge.png">
				<input type="button" value="秀 圖" onclick="displayImg()">
				<input type="button" value="放 大" onclick="zoomOut()">
				<input type="button" value="縮 小" onclick="zoomIn()">
			</p>
		</form>
		<hr />
		<img id="imgShown" name="imgShown" src="../images/Adventure Time challenge.png">
		<hr />
	</body>
</html>