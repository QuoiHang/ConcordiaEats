package com.jtspringproject.JtSpringProject.controller;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
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

	private List<Product> getAllProducts() throws Exception {
		List<Product> productList = new ArrayList<>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		String query = "select * from products ORDER BY categoryid ASC, name ASC, sold ASC;";
		ResultSet rs = stmt.executeQuery(query);

		while (rs.next()) {
			int id = rs.getInt("id");
			String name = rs.getString("name");
			String image = rs.getString("image");
			
			int categoryId = rs.getInt("categoryid");
			ResultSet rs2 = stmt2.executeQuery("SELECT name FROM categories WHERE categoryid = " + categoryId);
			rs2.next();
			String categoryName = rs2.getString("name");
			
			int quantity = rs.getInt("quantity");
			int price = rs.getInt("price");
			int weight = rs.getInt("weight");
			String description = rs.getString("description");
			boolean onSale = rs.getBoolean("onSale");
			double discountedPrice = rs.getDouble("discountedPrice");
			int sold = rs.getInt("sold");
			
			Product product = new Product(id, name, image, categoryId, categoryName, quantity, price, weight, description, onSale,
					discountedPrice, sold);
			productList.add(product);
		}

		return productList;
	}
	
	@GetMapping("/user/products")
	public String getproduct(Model model, HttpSession session) throws Exception {
	    String username = (String) session.getAttribute("username");
	    Integer useridObj = (Integer) session.getAttribute("userid");
	    String userid = useridObj.toString();
	    model.addAttribute("username", username);
	    model.addAttribute("userid", userid);
	    
	    List<Product> productList = getAllProducts();
		model.addAttribute("productList", productList);
	    
	    return "uproduct";
	}

	
	@GetMapping("/search")
	public String search(Model model, HttpSession session) {
	    String username = (String) session.getAttribute("username");
	    Integer useridObj = (Integer) session.getAttribute("userid");
	    String userid = useridObj.toString();
	    model.addAttribute("username", username);
	    model.addAttribute("userid", userid);
	    
		return "search";
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
	public String cart(Model model, HttpSession session) {
	    String username = (String) session.getAttribute("username");
	    Integer useridObj = (Integer) session.getAttribute("userid");
	    String userid = useridObj.toString();
	    model.addAttribute("username", username);
	    model.addAttribute("userid", userid);	
	    
		return "cart";
	}
	
	@PostMapping("/like")
	public String like(@RequestParam("productId") int productId, HttpServletResponse response, HttpSession session) {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			PreparedStatement pst = con
					.prepareStatement("INSERT INTO favorites (user_id, product_id) VALUES (?, ?)");
			pst.setInt(1, (int) session.getAttribute("userid"));
			pst.setInt(2, productId);
			int i = pst.executeUpdate();
			
			if (i > 0) {
				response.setStatus(HttpServletResponse.SC_OK);
				return "redirect:/user/products"; 
			} else {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				return null;
			}
		} catch (Exception e) {
			System.out.println("Exception: " + e);
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			return null;
		}
	}

	@PostMapping("/unlike")
	public String unlike(@RequestParam("productId") int productId, HttpServletResponse response, Model model) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			PreparedStatement pst = con
					.prepareStatement("UPDATE products SET onSale = 0, discountedPrice = price WHERE id = ?;");
			pst.setInt(1, productId);
			int i = pst.executeUpdate();
			if (i > 0) {
				response.setStatus(HttpServletResponse.SC_OK);
				return "redirect:/favorites"; 
			} else {;
				return null;
			}
		} catch (Exception e) {
			System.out.println("Exception: " + e);
			return null; 
		}
	}
	
	@PostMapping("/add")
	public String add(@RequestParam("pid") int id, Model model) {
		return "add";
	}
}
