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
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
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
    <title>Cart</title>
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
                        <a class="nav-link" th:href="@{/Search}" href="/search">Search</a>
                    </li>                         
                    <li class="nav-item">
                        <a class="nav-link" th:href="@{/favorites}" href="/favorites">Favorites</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" th:href="@{/cart}" href="#">Cart</a>
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
        <table class="table" id="cartTable">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <%
                int userId = 1; // Replace this with the actual user ID of the logged-in user
                try {
                    String url = "jdbc:mysql://localhost:3306/springproject";
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(url, "root", "");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT p.id as product_id, p.name as product_name, p.price as product_price, c.quantity as quantity FROM products p JOIN cart c ON p.id = c.product_id WHERE c.user_id = " + userId);

                    while (rs.next()) {
                        int productId = rs.getInt("product_id");
                        String productName = rs.getString("product_name");
                        int productPrice = rs.getInt("product_price");
                        int quantity = rs.getInt("quantity");
                %>
                <tr>
                    <td><%= productName %></td>
                    <td>$<%= productPrice %>.00</td>
                    <td>
                        <button class="btn btn-outline-secondary" onclick="decreaseQuantity()">-</button>
                        <span class="mx-2" id="quantity"><%= quantity %></span>
                        <button class="btn btn-outline-secondary" onclick="increaseQuantity()">+</button>
                    </td>
                    <td>$<%= productPrice * quantity %>.00</td>
                    <td>
                        <button class="btn btn-danger" onclick="removeFromCart()" title="Remove">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </td>
                </tr>
                <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
        <div class="text-right">
            <h5>Total: <span id="cartTotal">$0.00</span></h5>
        </div>
        <div class="text-right">
            <button class="btn btn-primary" id="checkoutBtn">Checkout</button>
        </div>
    </div>	
		</table>
		</div>

	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script>
	  // Add item quantity in the cart
	  function increaseQuantity() {
	    const quantityElement = document.getElementById('quantity');
	    let currentQuantity = parseInt(quantityElement.textContent);
	    currentQuantity += 1;
	    quantityElement.textContent = currentQuantity;
	    updateTotal();
	  }
	
	  // Decrease item quantity in the cart
	  function decreaseQuantity() {
	    const quantityElement = document.getElementById('quantity');
	    let currentQuantity = parseInt(quantityElement.textContent);
	    if (currentQuantity > 1) {
	      currentQuantity -= 1;
	      quantityElement.textContent = currentQuantity;
	    }
	    updateTotal();
	  }
	
	  // Update cart total based on item quantity
	  function updateTotal() {
	    const quantity = parseInt(document.getElementById('quantity').textContent);
	    const price = 10; // Replace this with the actual price of the product
	    const total = price * quantity;
	    document.getElementById('cartTotal').textContent = '$' + total.toFixed(2);
	  }
	
	  // Remove an item from the cart
	  function removeFromCart() {
	    const rowToRemove = document.querySelector('#cartTable tbody tr');
	    rowToRemove.remove();
	    updateTotal();
	  }
	
	  // Redirect to the payment page
	  function redirectToPayment() {
	    window.location.href = "http://localhost:8080/buy?";
	  }
	
	  // Update the total when the page loads
	  document.addEventListener('DOMContentLoaded', updateTotal);
	
	  // Add click event listener to the checkout button
	  const checkoutButton = document.getElementById('checkoutBtn');
	  checkoutButton.addEventListener('click', redirectToPayment);
	</script>

</body>

</html>
