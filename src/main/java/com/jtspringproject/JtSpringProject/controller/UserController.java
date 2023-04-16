package com.jtspringproject.JtSpringProject.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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

	// direct to '/user/products' -> user product -> uproduct
	@GetMapping("/user/products")
	public String getproduct(Model model) {
		return "uproduct";
	}
	
	// direct to '/buy'
	@GetMapping("/search")
	public String search() {
		return "search";
	}

	// direct to '/buy'
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
	public String favorites() {
		return "favorites";
	}
	
	@GetMapping("/cart")
	public String cart() {
		return "cart";
	}
	
	 @PostMapping("/updateCartItem")
	    public ResponseEntity<?> updateCartItem(@RequestParam("userId") int userId,
	                                            @RequestParam("productId") int productId,
	                                            @RequestParam("quantity") int quantity) {
	        try {
	            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
	            PreparedStatement pst = con.prepareStatement("UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?;");
	            pst.setInt(1, quantity);
	            pst.setInt(2, userId);
	            pst.setInt(3, productId);

	            int i = pst.executeUpdate();
	            System.out.println("Cart item updated: " + i);

	            return ResponseEntity.ok().build();
	        } catch (Exception e) {
	            System.out.println("Exception: " + e);
	            return ResponseEntity.badRequest().build();
	        }
	    }

	    @PostMapping("/deleteCartItem")
	    public ResponseEntity<?> deleteCartItem(@RequestParam("userId") int userId,
	                                            @RequestParam("productId") int productId) {
	        try {
	            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
	            PreparedStatement pst = con.prepareStatement("DELETE FROM cart WHERE user_id = ? AND product_id = ?;");
	            pst.setInt(1, userId);
	            pst.setInt(2, productId);

	            int i = pst.executeUpdate();
	            System.out.println("Cart item deleted: " + i);

	            return ResponseEntity.ok().build();
	        } catch (Exception e) {
	            System.out.println("Exception: " + e);
	            return ResponseEntity.badRequest().build();
	        }
	    }
}
