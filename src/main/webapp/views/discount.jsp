<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"></script>
	<style>
        body {
            background-color: #f0f0f0;
        }      

        .navbar{
            color: #f0f0f0;
            background-color: #912338;
        }

        .navbar a,
        .nav-item a {
            color: #f0f0f0;
            font-weight: 500;
            font-size: 17px;
        }

        .nav-item a:hover {
            color: #e5a712 !important; 
            font-weight: bold;
        }

        [class*="container"] {
            max-width: 1170px !important;
        }

        .concordia-txt-grey {
            color: #f0f0f0;
        }
    </style>
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
	    
    <title>Discount</title>
</head>

<body>
	<nav class="navbar navbar-expand-md navbar-dark sticky-top">
		<div class="container-fluid">
            <div class="d-flex">
                <img th:src="@{/images/ConcordiaEats-Logo-BW.svg}" src="/images/ConcordiaEats-Logo-BW.svg" width="auto" height="40"/>
				<h4 class="my-auto">Admin Dashboard</h4>
			</div>			
			
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto"></ul>
				<ul class="navbar-nav">
					<li class="nav-item active"><a class="nav-link" href="/adminhome">Home Page</a></li>
					<li class="nav-item active"><a class="nav-link" href="/admin">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<br>
		
	<!-- Add this line to create a back button -->
	<div class="container-fluid">
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
								<button type="submit" class="btn btn-danger">Reset discount</button>
							</form>
						</td>
						<td>
							<button onclick="applyDiscount(${product.id})" class="btn btn-success">Apply Discount</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>

