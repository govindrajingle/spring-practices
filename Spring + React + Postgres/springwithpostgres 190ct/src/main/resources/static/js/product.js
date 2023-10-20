function saveProduct() {
	alert("Save button pressed");
    var product = {
        name: document.getElementById("name").value,
        price: parseFloat(document.getElementById("price").value)
    };

    // Make an AJAX POST request to save the product
    $.ajax({
        type: "POST",
        url: "/saveProduct",
        contentType: "application/json",
        data: JSON.stringify(product),
        success: function(response) {
            // Display the response message
            $("#responseMessage").html(response);
            // Clear the form
            document.getElementById("name").value = "";
            document.getElementById("price").value = "";
        },
        error: function(error) {
            console.error("Error: " + JSON.stringify(error));
        }
    });
}
