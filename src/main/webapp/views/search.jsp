<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"></script>
	<style>
        body {
            background-color: #f0f0f0;
        }      

        .btn {
            background-color: #912338;
            color: #f0f0f0;
            border: none;
        }

        .btn:hover,
        .btn:focus,
        .btn:active {
            background-color: #da3a16;
            color: #f0f0f0;
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
    <title>Categories</title>
</head>

<body>
    <!-- NAV -->
    <nav class="navbar navbar-expand-md navbar-dark sticky-top">
        <div class="container-fluid">
            <div class="d-flex">
                <img th:src="@{/images/ConcordiaEats-Logo-BW.svg}" src="/images/ConcordiaEats-Logo-BW.svg" width="auto" height="40"/>
				<h4 class="my-auto">Let's Go Dining</h4>
			</div>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" th:href="@{/}" href="/index">Home</a>
                    <li class="nav-item">
                        <a class="nav-link" th:href="@{/uproduct}" href="/user/products">Categories</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" th:href="@{/search}" href="#">Search</a>
                    </li>                         
                    <li class="nav-item">
                        <a class="nav-link" th:href="@{/favorites}" href="/favorites">Favorites</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" th:href="@{/cart}" href="/cart">Cart</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="profileDisplay">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" sec:authorize="isAuthenticated()" href="logout">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- NAV -->
    
    <!-- SEARCH BAR -->
    <div class="container">
		<div class="input-group my-3 d-flex align-items-center">
			<form method="post" class="d-flex flex-grow-1" action="/searchKeyword">
		    	<div class="flex-grow-1 mr-2">
		      		<input type="text" class="form-control" id="searchInput" name="keyword" placeholder="Enter a product name to search">
		    	</div>
		    	<div class="input-group-append">
		      		<button class="btn btn-primary" type="submit">Search</button>
		    	</div>
		  	</form>
		</div>

		<table id="resultTable" class="table">
			<thead>
				<tr>
					<th scope="col">Serial No.</th>
					<th scope="col">Product Name</th>
					<th scope="col">Category</th>
					<th scope="col">Preview</th>
					<th scope="col">Quantity</th>
					<th scope="col">Price</th>
					<th scope="col">Weight</th>
					<th scope="col">Description</th>
					<!-- Like -->
					<th scope="col"></th>
					<!-- Add to cart -->
					<th scope="col"></th>		
				</tr>
			</thead>	
			<tbody>
				<tbody>
				<c:forEach items="${productList}" var="product">
					<tr>
						<td>${product.id}</td>
						<td>${product.name}</td>
						<td>${product.categoryName}</td>
						<td><img src="${product.image}" height="100px" width="100px"></td>
						<td>${product.quantity}</td>
						<td>$ ${product.onSale ? product.discountedPrice : product.price}</td>
						<td>${product.weight} g</td>
						<td>${product.description}</td>
						
						<td>
							<form class="like-form" method="post" action="/like">
							    <input type="hidden" name="productId" value="${product.id}" />
							    <button type="submit" class="like-button btn" style="color: #912338; background: none; border: none;">
							        <i class="${product.liked > 0 ? 'fas' : 'far'} fa-heart fa-lg"></i>
							    </button>
							</form>			    						
						</td>
						
						<td>
							<form action="/add" method="post">
								<input type="hidden" name="id" value="${product.id}">
								<input type="submit" value="Add to Cart" class="btn btn-info btn-lg">
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>	
    </div>
    <!-- SEARCH BAR -->

	<script>
		$(document).ready(function() {
		    $(".like-form").submit(function(event) {
		        event.preventDefault(); // prevent the form from submitting normally
		        var formData = $(this).serialize(); // get the form data
		        var $likeButton = $(this).find(".like-button"); // get the like button that was clicked
		        $.ajax({
		            url: "/like",
		            type: "POST",
		            data: formData,
		            dataType: "json",
		            success: function(response) {
		                // Update the like button based on the response
		                if (response.liked) {
		                    $likeButton.find("i").removeClass("far").addClass("fas"); // select the i element inside the like button that was clicked
		                } else {
		                    $likeButton.find("i").removeClass("fas").addClass("far"); // select the i element inside the like button that was clicked
		                }
		            },
		            error: function(xhr, status, error) {
		                console.error("Error:", error);
		            }
		        });
		    });
		});
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"></script>
</body>

</html>
