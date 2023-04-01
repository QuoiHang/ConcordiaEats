<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Best Deal</title>
    </head>

    <body>
        <h1>BestDeal</h1>
        <div>
            <img src="${bestDealProduct.image}" alt="Product Image">
            <h2>${bestDealProduct.name}</h2>
            <p>Original Price: <span>${bestDealProduct.price}</span></p>
            <p>Discount: <span>${bestDealProduct.discount * 100}%</span></p>
            <p>Discounted Price: <span>${bestDealProduct.discountedPrice}</span></p>
            <p>Quantity: <span>${bestDealProduct.quantity}</span></p>
            <p>Weight: <span>${bestDealProduct.weight}</span></p>
            <p>Description: <span>${bestDealProduct.description}</span></p>
        </div>
    </body>

    </html>