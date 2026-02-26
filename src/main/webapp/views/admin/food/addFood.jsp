

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form action="${pageContext.request.contextPath}/addFood"
      method="post"
      enctype="multipart/form-data">

    Tên: <input type="text" name="name" required/>

    Giá: <input type="number" name="price" required/>

    Ảnh: <input type="file" name="imageFile" accept="image/*" required/>

    <button type="submit">Lưu</button>
</form>