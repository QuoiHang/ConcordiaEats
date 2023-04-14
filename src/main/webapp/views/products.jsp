<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.FileOutputStream" %>    
<%@page import=" java.io.ObjectOutputStream" %>    
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

	<title>Products</title>
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
					<li class="nav-item active"><a class="nav-link" href="/admin">Logout</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<br>
	
	<div class="container-fluid">

		<a style="margin: 20px 0" class="btn btn-primary"
			href="/admin/products/add">Add Product</a><br>
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
				<th scope="col">Sold</th>
				<th scope="col">Delete</th>
				<th scope="col">Update</th>
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
						ResultSet rs = stmt.executeQuery("select * from products");

					while (rs.next()) {
						int id = rs.getInt("id");
						String name = rs.getString("name");
						int categoryid = rs.getInt("categoryid");
						int quantity = rs.getInt("quantity");
						int price = rs.getInt("price");
						String weight = rs.getString("weight");
						String description = rs.getString("description");
						int sold = rs.getInt("sold");
						
						ResultSet rs2 = stmt2.executeQuery("SELECT name FROM categories WHERE categoryid=" + categoryid);
						rs2.next();
						String categoryName = rs2.getString("name");						
						
					%>
					<td><%= id %></td>
					<td><%= name %></td>
					<td><%= categoryid + "-" + categoryName %></td>	
					<td><img src="https://placehold.co/100x100.png" height="100px" width="100px"></td>
					<td><%= quantity %></td>
					<td>$ <%= price %></td>
					<td><%= weight %> g</td>
					<td><%= description %></td>
					<td><%= sold %></td>
					<td>
					<form action="products/delete" method="get">
						<input type="hidden" name="id" value="<%=rs.getInt(1)%>">
						<input type="submit" value="Delete" class="btn btn-danger">
					</form>
					</td>
					<td>
					<form action="products/update" method="get">
						<input type="hidden" name="pid" value="<%=rs.getInt(1)%>">
						<input type="submit" value="Update" class="btn btn-warning">
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
		
		<!-- MOST SELLING -->
		<table class="table">		
			<h3> Most Selling </h3>	
			<tr>
				<th scope="col">Serial No.</th>
				<th scope="col">Product Name</th>
				<th scope="col">Category</th>
				<th scope="col">Quantity</th>
				<th scope="col">Price</th>
				<th scope="col">Weight</th>
				<th scope="col">Sold</th>
			</tr>
			<tbody>
				<tr>
					<%
						try {
							String url2 = "jdbc:mysql://localhost:3306/springproject";
							Class.forName("com.mysql.cj.jdbc.Driver");
							Connection con2 = DriverManager.getConnection(url2, "root", "");
							Statement stmt3 = con2.createStatement();
							Statement stmt4 = con2.createStatement();
							ResultSet rs3 = stmt3.executeQuery("select * from products order by sold DESC, categoryid ASC , name ASC");
							
						while (rs3.next()) {
							int id = rs3.getInt("id");
							String name = rs3.getString("name");
							int categoryid = rs3.getInt("categoryid");
							int quantity = rs3.getInt("quantity");
							int price = rs3.getInt("price");
							String weight = rs3.getString("weight");
							String description = rs3.getString("description");
							
							ResultSet rs4 = stmt4.executeQuery("SELECT name FROM categories WHERE categoryid=" + categoryid);
							rs4.next();
							String categoryName = rs4.getString("name");
					%>
					<td><%= id %></td>
					<td><%= name %></td>
					<td><%= categoryid + "-" + categoryName %></td>					
					<td><%= quantity %></td>
					<td>$ <%= price %></td>
					<td><%= weight %> g</td>
					<td><%= description %></td>
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
		
		<!-- LEAST SELLING -->
		<table class="table">		
			<h3> Least Selling </h3>	
			<tr>
			<th scope="col">Serial No.</th>
			<th scope="col">Product Name</th>
			<th scope="col">Category</th>
			<th scope="col">Quantity</th>
			<th scope="col">Price</th>
			<th scope="col">Weight</th>
			<th scope="col">Sold</th>
			</tr>		
			<tbody>
				<tr>
				<%
				try {
					String url3 = "jdbc:mysql://localhost:3306/springproject";
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con3 = DriverManager.getConnection(url3, "root", "");
					Statement stmt5 = con3.createStatement();
					Statement stmt6 = con3.createStatement();
					ResultSet rs5 = stmt5.executeQuery("select * from products order by sold ASC, categoryid ASC, name ASC");

					while (rs5.next()) {
						int id = rs5.getInt("id");
						String name = rs5.getString("name");
						int categoryid = rs5.getInt("categoryid");
						int quantity = rs5.getInt("quantity");
						int price = rs5.getInt("price");
						String weight = rs5.getString("weight");
						String description = rs5.getString("description");
						
						ResultSet rs6 = stmt6.executeQuery("SELECT name FROM categories WHERE categoryid=" + categoryid);
						rs6.next();
						String categoryName = rs6.getString("name");
					%>
					<td><%= id %></td>		
					<td><%= name %></td>
					<td><%= categoryid + "-" + categoryName %>	</td>
					<td><%= quantity %></td>
					<td>$ <%= price %></td>
					<td><%= weight %> g</td>
					<td><%= description %></td>			
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

	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
</body>
</html>