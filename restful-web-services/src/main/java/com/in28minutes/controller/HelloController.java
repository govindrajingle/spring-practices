package com.in28minutes.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import eu.bitwalker.useragentutils.UserAgent;
import jakarta.servlet.http.HttpServletRequest;

@RestController
public class HelloController {
	@GetMapping("/time")
	public String time() {
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy 'at' HH:mm:ss");
		String currentTime = formatter.format(now);
		return "Hello, Acer ! The current time is " + currentTime;
	}

	@GetMapping("/welcome")
	@ResponseBody
	public String welcome() {
		return "<html>\n" + "<header><title>Welcome</title></header>\n" + "<body>\n" + "Hello world from HTML\n"
				+ "</body>\n" + "</html>";
	}

	@GetMapping("/home")
	@ResponseBody
	public String homepage() {
		return "home";
	}

	// How to show jsp file
	@RequestMapping("/modeltest")
	public ModelAndView modeltest(HttpServletRequest request) {
	    String browserType = request.getHeader("User-Agent");
	    LocalDateTime time = LocalDateTime.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy 'at' HH:mm:ss");
		String currentTime = formatter.format(time);
	    long requestTime = request.getDateHeader("Date");
	    UserAgent userAgent = UserAgent.parseUserAgentString("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36");
        // Get the exact browser name.
        String exactBrowser = userAgent.getBrowser().getName();
        // Print the exact browser name.
	    System.out.println("Browser type: " + exactBrowser);
	    System.out.println("Time: " + time);

	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("home");
	    return mav;
	}
	
	// 05 October 2023
	@GetMapping("/clock")
	public ModelAndView getClockTime(HttpServletRequest request) {
	    ModelAndView mav = new ModelAndView();
	    LocalDateTime now = LocalDateTime.now();
	    // Format the date and time
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
	    String formattedDateTime = now.format(formatter);
	    mav.setViewName("clock");
	    mav.addObject("dateTime", formattedDateTime);
	    return mav;
	}



}
