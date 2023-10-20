package com.postgres;

/*import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;*/
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

/*import com.postgres.dao.StudentDao;*/

@SpringBootApplication
@ComponentScan(basePackages = "com.postgres.controller")
public class Springwithpostgres19octApplication  {
	/*
	 * public class Springwithpostgres19octApplication implements CommandLineRunner
	 * {
	 * 
	 * @Autowired private StudentDao studentDao;
	 */
	public static void main(String[] args) {
		SpringApplication.run(Springwithpostgres19octApplication.class, args);
	}
	/*
	 * @Override public void run(String... args) throws Exception {
	 * //this.studentDao.createTable(); //this.studentDao.insertData("Govind",
	 * "Noida"); }
	 */
}
