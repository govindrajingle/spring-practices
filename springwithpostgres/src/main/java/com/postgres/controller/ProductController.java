package com.postgres.controller;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.postgres.entity.Product;
import com.postgres.repository.ProductRepository;

@Controller
@CrossOrigin(origins = "http://localhost:3000")
public class ProductController {
	@Autowired
	private ProductRepository productRepository;

//	@GetMapping("/home")
//	@ResponseBody
//	public String getClockTime(HttpServletRequest request) {
//		return "home";
//	}

	/*
	 * @RequestMapping("/modeltest") public ModelAndView showHome() { ModelAndView
	 * mav = new ModelAndView(); mav.setViewName("home"); return mav; }
	 */

	@RequestMapping("/addProduct")
	public String showModel() {
		return "addProduct";
	}

	// 22 OCT 23 -> Successfully working in this method the data from client is not in the format of JSON, it's of UTF-8
//	@PostMapping("/saveProduct")
//	public String saveProduct(@ModelAttribute Product product, BindingResult bindingResult, Model model) {
//		if (bindingResult.hasErrors()) {
//			return "Error: Invalid data";
//		}
//		productRepository.save(product);
//		model.addAttribute("flashMessage", "Product added successfully");
//		return "redirect:/addProduct";
//	}
	
	 @PostMapping("/saveProduct")
	    public String saveProduct(@RequestParam("jsonData") String jsonData) {
	        // jsonData contains the JSON data as a string
	        // You can parse it into a Product object using a JSON library
	        Product product = parseJsonToProduct(jsonData);
	        // Save the product
	        System.out.println("-----> jsonData -> "+jsonData);
	        productRepository.save(product);
	        return "redirect:/addProduct";
	    }
    private Product parseJsonToProduct(String jsonData) {
        // Use a JSON parser or library to parse the JSON string and create a Product object
        // For example, you can use Jackson or Gson for JSON parsing
        // Here's an example using Jackson ObjectMapper:
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.readValue(jsonData, Product.class);
        } catch (IOException e) {
            // Handle JSON parsing error
            e.printStackTrace();
            return null;
        }
    }


	@DeleteMapping("/deleteProduct/{id}")
	public ResponseEntity<String> deleteProductById(@PathVariable Long id) {
		productRepository.deleteById(id);
		return ResponseEntity.ok("Product with ID " + id + " has been deleted.");
	}

	@GetMapping("/products")
	public List<Product> getAllProducts() {
		return productRepository.findAll();
	}

	@PutMapping("/updateProduct/{id}")
	public String updateProduct(@PathVariable Long id, @RequestBody Product updatedProduct) {
		// Find the existing product by ID
		Product existingProduct = productRepository.findById(id).orElse(null);

		if (existingProduct != null) {
			// Update the name and/or price
			if (updatedProduct.getName() != null) {
				existingProduct.setName(updatedProduct.getName());
			}
			if (updatedProduct.getPrice() > 0) {
				existingProduct.setPrice(updatedProduct.getPrice());
			}

			// Save the updated product
			productRepository.save(existingProduct);
			return "Product updated successfully";
		} else {
			return "Product not found or could not be updated";
		}
	}

	@GetMapping("/getProduct/{id}")
	public ResponseEntity<Product> getProductById(@PathVariable Long id) {
		// Find the product by ID
		Optional<Product> product = productRepository.findById(id);

		if (product.isPresent()) {
			return ResponseEntity.ok(product.get());
		} else {
			return ResponseEntity.notFound().build();
		}
	}

}
