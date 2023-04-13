<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Discount</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
function applyDiscount(productId) {
    /* (same as before) */
}

function resetDiscountRate(productId) {
    /* (same as before) */
}
</script>

<style>
body {
	background-color: #f8f9fa;
}

.container {
	margin-top: 30px;
}
</style>

</head>
<body>
	<div class="container">
		<h1>Discount</h1>
		<a href="/adminhome" class="btn btn-secondary mb-3">Back to Admin
			Home</a>

		<table class="table table-striped table-bordered">
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
						<td><input type="number" class="form-control"
							id="discountRate-${product.id}" min="0" max="100" step="1"
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
							<button class="btn btn-primary"
								onclick="apply
Discount(${product.id})">Apply Discount</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</body>
</html>