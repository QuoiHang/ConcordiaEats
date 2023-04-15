package com.jtspringproject.JtSpringProject.controller;

import java.sql.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

	// direct to '/register'
	@GetMapping("/register")
	public String registerUser() {
		return "register";
	}

	// POST Registration
	@PostMapping(value = "newuserregister")
	public String newUseRegister(
			@RequestParam("username") String username,
			@RequestParam("password") String password,
			@RequestParam("email") String email) {
		try {
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			PreparedStatement pst = con.prepareStatement("insert into users(username,password,email) values(?,?,?);");
			pst.setString(1, username);
			pst.setString(2, password);
			pst.setString(3, email);

			// pst.setString(4, address);
			int i = pst.executeUpdate();
			System.out.println("data base updated" + i);

		} catch (Exception e) {
			System.out.println("Exception:" + e);
		}

		return "redirect:/";
	}

	@GetMapping("/user/products")
	public String getproduct(Model model, HttpSession session) {
	    String username = (String) session.getAttribute("username");
	    Integer useridObj = (Integer) session.getAttribute("userid");
	    String userid = useridObj.toString();
	    model.addAttribute("username", username);
	    model.addAttribute("userid", userid);
	    
	    return "uproduct";
	}

	
	@GetMapping("/search")
	public String search() {
		return "search";
	}

	@PostMapping("/like")
	public String like(@RequestParam("pid") int id, Model model) {
		return "like";
	}
	
	@PostMapping("/unlike")
	public String unlike(@RequestParam("pid") int id, Model model) {
		return "unlike";
	}
	
	@PostMapping("/add")
	public String add(@RequestParam("pid") int id, Model model) {
		return "add";
	}
	
	@GetMapping("/buy")
	public String buy() {
		return "buy";
	}

	// direct to 'contact'
	@GetMapping("/contact")
	public String contact() {
		return "contact";
	}
	
	@GetMapping("/favorites")
	public String favorites(Model model, HttpSession session) {
	    String username = (String) session.getAttribute("username");
	    Integer useridObj = (Integer) session.getAttribute("userid");
	    String userid = useridObj.toString();
	    model.addAttribute("username", username);
	    model.addAttribute("userid", userid);		
	    
		return "favorites";
	}
	
	@GetMapping("/cart")
	public String cart() {
		return "cart";
	}
}
