package com.telusko.jobposting.repository;

import java.util.List;

import com.telusko.jobposting.model.Post;

public interface SearchRepository {
	List<Post>findByText(String text);
}
