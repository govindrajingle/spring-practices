package com.postgres.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.postgres.entity.Product;
import com.postgres.repository.ProductRepository;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@CrossOrigin(origins = "http://localhost:3000")
public class ProductController {
	@Autowired
	private ProductRepository productRepository;

	/*
	 * @GetMapping("/clock") public ModelAndView getClockTime(HttpServletRequest
	 * request) { ModelAndView mav = new ModelAndView(); LocalDateTime now =
	 * LocalDateTime.now(); // Format the date and time DateTimeFormatter formatter
	 * = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"); String
	 * formattedDateTime = now.format(formatter); mav.setViewName("clock");
	 * mav.addObject("dateTime", formattedDateTime); return mav; }
	 */

	@GetMapping("/addProduct")
	public ModelAndView showProductForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("addProduct");
		// Add any necessary model attributes here
		return mav;
	}

	/*
	 * @GetMapping("/addProduct") public String showProductForm() { return
	 * "addProduct"; }
	 */

	@GetMapping("/clock")
	public ModelAndView getClockTime(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		LocalDateTime now = LocalDateTime.now();
		// Format the date and time
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
		String formattedDateTime = now.format(formatter);
		System.out.println(formattedDateTime);
		mav.setViewName("clock");
		mav.addObject("dateTime", formattedDateTime);
		return mav;
	}

	@PostMapping("/saveProduct")
	public String saveProduct(@RequestBody Product product) {
		// Ensure that you have getters and setters for name and price in the Product
		// class.
		productRepository.save(product);
		return "redirect:/addProduct";
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
}
