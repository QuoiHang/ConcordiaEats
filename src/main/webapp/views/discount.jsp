<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Discount</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
function applyDiscount(productId) {
    var discountRate = document.getElementById("discountRate-" + productId).value;
    var price = parseFloat(document.getElementById("price-" + productId).innerText);

    if (discountRate >= 0 && discountRate <= 100) {
        var discountedPrice = price * (1 - (discountRate / 100)); 
        
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                location.reload();
            }
        };
        xhttp.open("POST", "/admin/applyDiscount", true);
        xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhttp.send("productId=" + productId + "&discountRate=" + discountRate + "&discountedPrice=" + discountedPrice);
    } else {
        alert("Please enter a valid discount rate between 0 and 100.");
    }
}

        function resetDiscountRate(productId) {
            document.getElementById("discountRate-" + productId).value = 0;
        }
    </script>
</head>
<body>
	<div class="container">
		<h1>Discount</h1>
		<a href="/adminhome" class="btn btn-primary">Back to Admin Home</a>
		<!-- Add this line to create a back button -->
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Product Name</th>
					<th>Original Price</th>
					<th>Discount</th>
					<th>Discounted Price</th>
					<th>Discount Rate</th>
					<th>On Sale</th>
					<th>Reset Discount</th>
					<th>Apply Discount</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${productList}" var="product">
					<tr>
						<td>${product.name}</td>
						<td id="price-${product.id}">${product.price}</td>
						<td>${product.onSale ? (1 - (product.discountedPrice / product.price)) * 100 : 0}%</td>
						<td>${product.discountedPrice}</td>
						<td><input type="number" id="discountRate-${product.id}"
							min="0" max="100" step="1"
							value="${product.onSale ? (1 - (product.discountedPrice / product.price)) * 100 : 0}">
						</td>
						<td>${product.onSale ? 'Yes' : 'No'}</td>
						<td>
							<form action="/admin/resetDiscount" method="post">

								<input type="hidden" name="productId" value="${product.id}" />
								<button type="submit" class="btn btn-danger">Reset
									discount</button>
							</form>
						</td>
						<td>
							<button onclick="applyDiscount(${product.id})"
								class="btn btn-success">Apply Discount</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</body>
</html>
</div>

