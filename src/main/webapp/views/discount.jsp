<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Discount</title>
    <script>
        function applyDiscount() {
            var discountRate = document.getElementById("discountRate").value;
            if (discountRate >= 0 && discountRate <= 100) {
                var originalPrice = parseFloat(document.getElementById("originalPrice").innerText);
                var discountedPrice = originalPrice * (1 - discountRate / 100);
                document.getElementById("discountValue").innerText = discountRate + "%";
                document.getElementById("discountedPrice").innerText = discountedPrice.toFixed(2);
            } else {
                alert("Please enter a valid discount rate between 0 and 100.");
            }
        }
    </script>
</head>
<body>
    <h1>Discount</h1>
    <div>
        <img src="${discountProduct.image}" alt="Product Image">
        <h2>${discountProduct.name}</h2>
        <p>Original Price: <span id="originalPrice">${discountProduct.price}</span></p>
        <p>Discount: <span id="discountValue">${discountProduct.discount * 100}%</span></p>
        <p>Discounted Price: <span id="discountedPrice">${discountProduct.discountedPrice}</span></p>
        <p>Quantity: <span>${discountProduct.quantity}</span></p>
        <p>Weight: <span>${discountProduct.weight}</span></p>
        <p>Description: <span>${discountProduct.description}</span></p>
    </div>
    <div>
        <label for="discountRate">Discount Rate:</label>
        <input type="number" id="discountRate" min="0" max="100" step="1" value="${discountProduct.discount * 100}">
        <button onclick="applyDiscount()">Apply Discount</button>
    </div>
</body>
</html>