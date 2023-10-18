package com.telusko.jobposting.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.telusko.jobposting.model.Post;
import com.telusko.jobposting.repository.PostRepository;
import com.telusko.jobposting.repository.SearchRepository;

import jakarta.servlet.http.HttpServletResponse;
import springfox.documentation.annotations.ApiIgnore;

@RestController
public class PostController {
	// 18Oct23 - To redirect all url to homepage
	
	@Autowired
	PostRepository repo;
	
	@Autowired
	SearchRepository srepo;
	
	@ApiIgnore
	@RequestMapping(value="/")
	public void redirect(HttpServletResponse response) throws IOException {
		response.sendRedirect("/swagger-ui.html");
	}
	@GetMapping("/posts")
	public List<Post> getAllPosts(){
		return repo.findAll();
	}
	
	//improved search {text} -> "java", "sql", "react"
	@GetMapping("/posts/{text}")
	public List<Post> searchImproved(@PathVariable String text){
		return srepo.findByText(text);
	}
	
	//for posting data
	@PostMapping("/post")
	public Post addPost(@RequestBody Post post) {
		return repo.save(post);
	}
	
	
	
}
