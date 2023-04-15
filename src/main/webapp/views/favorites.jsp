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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
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
    <title>Favorites</title>
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
                        <a class="nav-link" th:href="@{/search}" href="/search">Search</a>
                    </li>                         
                    <li class="nav-item">
                        <a class="nav-link active" th:href="@{/favorites}" href="#">Favorites</a>
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

	<div class="container-fluid">
		<table class="table">
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
			<tbody>
				<tr>
					<%
					try {
						String url = "jdbc:mysql://localhost:3306/springproject";
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection(url, "root", "");
						Statement stmt = con.createStatement();
						Statement stmt2 = con.createStatement();
						Statement stmt3 = con.createStatement();
						// Get userid from model
						String userid = (String) request.getAttribute("userid");							
						
						ResultSet rs = stmt.executeQuery("select product_id from favorites where user_id = " + userid);
						
					while (rs.next()) {
						int id = rs.getInt("product_id");
						
						ResultSet rs2 = stmt2.executeQuery("SELECT * FROM products WHERE id = " + id);
						
						rs2.next();
						
						String name = rs2.getString("name");
						int categoryid = rs2.getInt("categoryid");
						String image = rs2.getString("image");
						int quantity = rs2.getInt("quantity");
						int price = rs2.getInt("price");
						String weight = rs2.getString("weight");
						String description = rs2.getString("description");
						
						ResultSet rs3 = stmt3.executeQuery("SELECT name FROM categories WHERE categoryid=" + categoryid);
						rs3.next();
						String categoryName = rs3.getString("name");
					%>
					<td><%= id %></td>
					<td><%= name %></td>
					<td>
						<%= categoryName %>
					</td>
					<td><img src="<%= image %>" height="100px" width="100px"></td>
					<td><%= quantity %></td>
					<td>$ <%= price %>
					</td>
					<td><%= weight %> g</td>
					<td><%= description %></td>
					<td>
						<i class="fas fa-heart" style="color: #912338"></i>
					</td>
					<td>
						<form action="/add" method="post">
							<input type="hidden" name="id" value="<%= id %>">
							<input type="submit" value="Add to Cart" class="btn btn-info btn-lg">
						</form>
					</td>						
					
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		} catch (Exception ex) {
			out.println("Exception Occurred:: " + ex.getMessage());
		}
		%>
	</div>

	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>
