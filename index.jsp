<%@page import="dao.PhanTrangDAO"%>
<%@page import="dao.SanPhamDAO"%>
<%@page import="model.SanPham"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Demo phân trang</title>

 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
.phantrang {
	margin-top: 0px;
	float: right;
}

.khungsanpham {
	padding-top: 20px;
	padding-left: 30px;
	float: left;
}

.boder {
	border: solid;
	width: 200px;
	height: 300px;
}

.img {
	margin-left: 3px;
	margin-top: 3px;
	width: 190px;
	height: 180px;
}

.gia {
	text-align: center;
	color: red;
	margin-top: 10px;
	margin-bottom: 10px;
}

.mua {
	color: red;
}
</style>

</head>
<body>
	<div class="container">
		<h3>Các sản phẩm hiện có</h3>
		<%
			ArrayList<SanPham> dsSanPham = new SanPhamDAO().khoiTaoGiatri();
			/*
			Muốn hiển thị 20 sản phẩm đầu là trang 1,20 sản phẩm tiếp theo là trang 2,tương tự cứ tiếp tục cho các trang tiếp theo
			Tổng số trang hiển thị được tính bằng công thức: dsSanPham.size() / 20 ;
			*/
			int sizeDisplay = 20;
			int tongSoTrang = new PhanTrangDAO(sizeDisplay,dsSanPham.size()).totalPage();
			String className = "";
			for (int i = 1; i <= tongSoTrang; i++) {
				if (i == 1) {
					className = "show";
				} else {
					className = "hidden";
				}
		%>
		<!-- Thẻ div phía dưới này có tác dụng bao bọc các sản phẩm của từng trang,bao gồm id=page* để liên kết với javascript,
		class=show hoặc class=hidden để quyết định là hiển thị hay không.Ở đây ta mặc định trang 1 luôn hiển thị,còn lại các trang khác
		sẻ bị ẩn.Khi gọi javascript thì tên class thay đổi thành show mới xuất hiện -->
		<div  class="<%=className%>" id="page<%=i%>">
		<!-- Dòng for bên dưới dùng để hiển thị các sản phẩm ở từng trang.
		sizeDisplay =20;
			Đầu tiên ta gán giá trị j=sizeDisplay*(i-1) có nghĩa là j=0 (lúc này i=1)
			Điều kiện dừng for : j<sizeDisplay*i nghĩa là j<20 (để hiển thị không vượt quá 20 sản phẩm ) 
				và j< dsSanPham.size() ( điều kiện này phòng hờ trường hợp biến j vượt quá chiều dài mãng sản phẩm)
			-Khi đã hiển thị được 20 sản phẩm đầu tiên thì for(j) dừng, biến i++ dẫn đến j=sizeDisplay*(i-1) (j=20)
			như vậy j =20 bắt đầu với các sản phẩm tiếp theo của danh sách từ 21 đến 40 rồi lại kiểm tra điều kiện
			cứ thế chạy đến khi hết sản phẩm trong danh sách;
		 -->
			<%
				for (int j = sizeDisplay*(i-1); j < sizeDisplay * i && j <dsSanPham.size(); j++) {
			%>
			<div class="khungsanpham">
				<div class="boder">
					<div class="img">
						<img src="" width="192px" height="180px">
					</div>
					<div class="gia">
						<%=dsSanPham.get(j).getTen()%>
					</div>
					<div class="gia">
						<%=dsSanPham.get(j).getGia()%>
					</div>
					<div class="mua">
						<center>
							<a href=""><button class="btn btn-success">Mua ngay</button></a>
						</center>
					</div>
				</div>
			</div>
		<%}%>
			</div>
			<%	}	%>
		</div>


<!-- thẻ div bên dưới có tác dụng tạo ra thanh phân trang.Đồng thời gán cho mỗi thẻ a có một javascript.
	javascript này được gọi bằng sự kiện onclick() và tên phương thức tương ứng với từng thẻ a,cú pháp tên là: changeClass*
 -->
	<div class="container">
		<div class="phantrang">
			<ul class="pagination pagination-sm">
				<label style="float: left; margin-top: 3px">Chọn trang hiển
					thị:</label>
				<%
					for (int i = 1; i <= tongSoTrang; i++) {
				%>
				<li><a href="#page<%=i%>" onclick="changeClass<%=i%>()">
						<%
							out.print(i);
						%>
				</a></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>


<!-- Bên dưới là nội dung của script.Cụ thể cho từng phương thức ở trang nào thì trang đó sẽ có className = show còn lại
là hidden. -->
	<script type="text/javascript">
	<%for (int i = 1; i <= tongSoTrang; i++) {%>
		function changeClass<%=i%>(){	
    			document.getElementById("page<%=i%>").className = "show";
				<%for (int j = 1; j <= tongSoTrang; j++) {
					if (j != i) {%>
 			   document.getElementById("page<%=j%>").className = "hidden";
		<%}
				}%>
		}
		<%}%>
</script>
</body>
</html>