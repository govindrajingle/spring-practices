package com.telusko.jobposting.repository;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.swing.text.Document;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.convert.MongoConverter;
import org.springframework.stereotype.Component;

import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.telusko.jobposting.model.Post;

@Component
public class SearchRepositoryImpl implements SearchRepository {

	@Autowired
	MongoClient client;

	@Autowired
	MongoConverter converter; //to convert doc to java

	@Override
	public List<Post> findByText(String text) {
		final List<Post> posts = new ArrayList<>();
		// logic to find the searched text -> import it from Internet (MongoDB) and match the version of dependencies, import statements and rest
		//copy paste but math the import statements 
		 MongoDatabase database = client.getDatabase("gnine");
	     MongoCollection<org.bson.Document> collection = database.getCollection("JobPost");
	     AggregateIterable<org.bson.Document> result = collection.aggregate(Arrays.asList(new org.bson.Document("$search",
                 new org.bson.Document("text",
                 new org.bson.Document("query", text)
                 .append("path", Arrays.asList("techs", "desc", "profile")))),
                 new org.bson.Document("$sort",
                 new org.bson.Document("exp", 1L)),
                 new org.bson.Document("$limit", 5L)));
	     //saving data from result to posts
	     
	    result.forEach(doc -> posts.add(converter.read(Post.class,doc)));
	    System.out.println("*****Result - > "+result.toString());
	    System.out.println(posts.toString());
		return posts;
	}
}
