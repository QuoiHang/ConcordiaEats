<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
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
                        <a class="nav-link active" th:href="@{/Search}" href="#">Search</a>
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
				<div class="input-group my-3">
			<form method="get">
				<input type="text" class="form-control" id="searchInput" name="keyword" placeholder="Enter a product name to search">
				<div class="input-group-append">
					<button class="btn btn-primary" type="submit">Search</button>
				</div>
			</form>
		</div>

		<table id="resultTable" class="table">
			<thead>
				<tr>
					<th>Serial No.</th>
					<th>Product Name</th>
					<th>Category</th>
					<th>Preview</th>
					<th>Quantity</th>
					<th>Price</th>
					<th>Weight</th>
					<th>Description</th>
					<th>Buy</th>	
				</tr>
			</thead>
			<tbody>
				<%
					if(request.getParameter("keyword")!=null) {
						String keyword=request.getParameter("keyword");
						String url = "jdbc:mysql://localhost:3306/springproject";
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection(url, "root", "");
						Statement stmt = con.createStatement();
						Statement stmt2 = con.createStatement();
						ResultSet rs = stmt.executeQuery("SELECT * FROM products WHERE name LIKE '%" + keyword + "%'");
						while (rs.next()) {
							String name = rs.getString("name");
							int categoryid = rs.getInt("categoryid");
							int quantity = rs.getInt("quantity");
							int price = rs.getInt("price");
							String weight = rs.getString("weight");
							int id = rs.getInt("id");
							ResultSet rs2 = stmt2.executeQuery("SELECT name FROM categories WHERE categoryid=" + categoryid);
							rs2.next();
							String categoryName = rs2.getString("name");
				%>
							<tr>
								<td><%= id %></td>
								<td><%= name %></td>
								<td><%= categoryName %></td>
								<td><img src='https://placehold.co/100x100.png' height='100px' width='100px'></td>
								<td><%= quantity %></td>
								<td><%= price %></td>
								<td><%= weight %></td>
								<td><%= "" %></td>
								<td>
									<form action="/buy" method="get">
										<input type="hidden" name="id" value="<%=id%>">
										<input type="submit" value="Buy" class="btn btn-info btn-lg">
									</form>
								</td>
								<td><%= "" %></td>
							</tr>
						<%
							}
						}
					%>
			</tbody>
		</table>
    </div>
    <!-- SEARCH BAR -->

	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>
