<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Discount</title>
    <script>
        function applyDiscount(productId) {
            var discountRate = document.getElementById("discountRate-" + productId).value;
            if (discountRate >= 0 && discountRate <= 100) {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        location.reload();
                    }
                };
                xhttp.open("POST", "admin/applyDiscount", true);
                xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhttp.send("productId=" + productId + "&discountRate=" + discountRate);
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
    <h1>Discount</h1>
    <table>
        <tr>
            <th>Product Name</th>
            <th>Original Price</th>
            <th>Discount</th>
            <th>Discounted Price</th>
            <th>Discount Rate</th>
            <th>Reset Discount</th>
            <th>Apply Discount</th>
        </tr>
        <c:forEach items="${productList}" var="product">
            <tr>
                <td>${product.name}</td>
                <td>${product.price}</td>
                <td>${product.onSale ? product.discountedPrice / product.price * 100 : 0}%</td>
                <td>${product.discountedPrice}</td>
                <td>
                    <input type="number" id="discountRate-${product.id}" min="0" max="100" step="1" value="${product.onSale ? product.discountedPrice / product.price * 100 : 0}">
                </td>
                <td>
                    <button onclick="resetDiscountRate(${product.id})">Reset</button>
                </td>
                <td>
                    <button onclick="applyDiscount(${product.id})">Apply Discount</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
