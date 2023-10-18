package com.telusko.jobposting.repository;


import org.springframework.data.mongodb.repository.MongoRepository;

import com.telusko.jobposting.model.Post;

public interface PostRepository extends MongoRepository<Post, String> {

}
