<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">

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

	<title>Admin Home</title>
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
					<li class="nav-item active"><a class="nav-link" href="#">Home Page</a></li>
					<li class="nav-item active"><a class="nav-link" href="/admin">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<br>
	
	<div class="jumbotron text-center">
		<h1 class="display-5">Welcome Back:P, Admin</h1>
		<hr>
		<p>Manage your data from this Admin Panel</p>
	</div>
	
	<div class="container-fluid">
		<div class="row justify-content-center">
			<div class="col-sm-3 pt-4">
				<div class="card" style="background-color: white;">

					<div class="card-body text-center">
						<h4 class="card-title">Categories</h4>
						<p>---------------------------------------------</p>
						<p class="card-text">Manage the categories section here.</p>
						<a href="/admin/categories" class="card-link btn btn-primary">Manage</a>
					</div>
				</div>
			</div>
			
			<div class="col-sm-3 pt-4">
				<div class="card" style="background-color: white;">
					<div class="card-body text-center">
						<h4 class="card-title">Products</h4>
						<p>---------------------------------------------</p>
						<p class="card-text">Manage all the products here.</p>
						<a href="/admin/products" class="card-link btn btn-primary">Manage</a>
					</div>
				</div>
			</div>
			
			<div class="col-sm-3 pt-4">
				<div class="card" style="background-color: white;">
					<div class="card-body text-center">
						<h4 class="card-title">Customers</h4>
						<p>---------------------------------------------</p>
						<p class="card-text">Manage all the customer here.</p>
						<a href="/admin/customers" class="card-link btn btn-primary">Manage</a>

					</div>
				</div>
			</div>
			
			<div class="col-sm-3 pt-4">
				<div class="card" style="background-color: white;">
					<div class="card-body text-center">
						<h4 class="card-title">discount</h4>
						<p>---------------------------------------------</p>
						<p class="card-text">manage discounts for products :)</p>
						<a href="/admin/discount" class="card-link btn btn-primary">Manage :P</a>
					</div>
				</div>
			</div>

			<div class="col-sm-3 pt-4">
				<div class="card" style="background-color: white;">
					<div class="card-body text-center">
						<h4 class="card-title">mostSelling & leastSelling</h4>
						<p>---------------------------------------------</p>
						<p class="card-text">View the most selling and least selling items here.</p>
						<a href="/admin/products" class="card-link btn btn-primary">View</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>