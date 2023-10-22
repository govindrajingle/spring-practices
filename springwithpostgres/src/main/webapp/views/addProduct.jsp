<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function submitProduct() {
		var name = document.getElementById("name").value;
		var price = document.getElementById("price").value;
		var productData = {
			name : name,
			price : price
		};
		var jsonData = JSON.stringify(productData);
		document.getElementById("jsonData").value = jsonData;
	}
</script>
<title>Shopping</title>
</head>
<body
	style="background-color: #f4f4f4; font-family: Arial, sans-serif; text-align: center;">

	<h1>Add Product</h1>

	<form action="${pageContext.request.contextPath}/saveProduct"
		method="post"
		style="background-color: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); max-width: 400px; margin: 0 auto;">
		<label for="name"
			style="display: block; margin: 10px 0; color: #333; font-weight: bold;">Product
			Name:</label> <input type="text" id="name" name="name" required
			style="width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ccc; border-radius: 5px;">

		<label for="price"
			style="display: block; margin: 10px 0; color: #333; font-weight: bold;">Price:</label>
		<input type="text" id="price" name="price" required
			style="width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ccc; border-radius: 5px;">

		<input type="submit" value="Add Product" onclick="submitProduct()"
			style="background-color: #007AFF; color: #fff; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; transition: background-color 0.3s;">

		<input type="hidden" name="jsonData" id="jsonData" />

		<div id="message" style="display: none;"></div>

	</form>
</body>
</html>


<!-- <script>
	function showSuccessMessage(message) {
		var messageDiv = document.getElementById("message");
		messageDiv.style.display = "block"; // Show the message div
		messageDiv.innerText = message; // Set the message text
		var okButton = document.createElement("button");
		okButton.innerText = "OK";
		okButton.addEventListener("click", function() {
			messageDiv.style.display = "none"; // Hide the message when OK is clicked
		});
		messageDiv.appendChild(okButton);
	}
	function submitProduct() {
		var productData = {
			name: document.getElementById("name").value,
			price: document.getElementById("price").value
		};
		setTimeout(function() {
			showSuccessMessage("Product added successfully");
		}, 2000); // Simulated 2-second delay
	}
</script>
<style>
#message {
	display: none;
	background-color: #4CAF50;
	color: white;
	padding: 10px;
	border-radius: 5px;
	margin: 10px 0;
	text-align: center;
	animation: fadeIn 0.5s;
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}
}
</style> -->

