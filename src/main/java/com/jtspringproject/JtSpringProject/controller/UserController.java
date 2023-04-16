package com.jtspringproject.JtSpringProject.controller;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Collections;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.http.ResponseEntity;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;

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

	private List<Product> getUserProducts(String userid, String mode) throws Exception {
		List<Product> productList = new ArrayList<>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
		
		PreparedStatement stmt;
		if (mode == "all") {
			stmt = con.prepareStatement("SELECT *, (SELECT COUNT(*) FROM favorites WHERE favorites.product_id = products.id AND favorites.user_id = ?) AS liked FROM products;");
		} else {
			stmt = con.prepareStatement("SELECT *, 1 AS liked FROM products WHERE products.id IN (SELECT favorites.product_id FROM favorites WHERE favorites.user_id = ?);");
		}
		
		stmt.setString(1, userid);
		ResultSet rs = stmt.executeQuery();
		
		Statement stmt2 = con.createStatement();

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
			int liked = rs.getInt("liked");
			
			Product product = new Product(id, name, image, categoryId, categoryName, quantity, price, weight, description, onSale,
					discountedPrice, sold, liked);
			productList.add(product);
		}

		// System.out.println("Product list size: " + productList.size());
		return productList;
	}
	
	@GetMapping("/user/products")
	public String getproduct(Model model, HttpSession session) throws Exception {
	    String username = (String) session.getAttribute("username");
	    Integer useridObj = (Integer) session.getAttribute("userid");
	    String userid = useridObj.toString();
	    model.addAttribute("username", username);
	    model.addAttribute("userid", userid);
	    
	    List<Product> productList = getUserProducts(userid, "all");
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
	public String favorites(Model model, HttpSession session) throws Exception {
	    String username = (String) session.getAttribute("username");
	    Integer useridObj = (Integer) session.getAttribute("userid");
	    String userid = useridObj.toString();
	    model.addAttribute("username", username);
	    model.addAttribute("userid", userid);	
	    
	    List<Product> productList = getUserProducts(userid, "favorites");
		model.addAttribute("productList", productList);
	    
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
	@ResponseBody
	public Map<String, Object> likeProduct(@RequestParam("productId") int productId, HttpSession session) {
	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
	        PreparedStatement pst;
	        int liked = 0;

	        // Check if the user has already liked the product
	        pst = con.prepareStatement("SELECT * FROM favorites WHERE user_id = ? AND product_id = ?");
	        pst.setInt(1, (int) session.getAttribute("userid"));
	        pst.setInt(2, productId);
	        ResultSet rs = pst.executeQuery();
	        if (rs.next()) {
	            // The user has already liked the product, so unlike it
	            pst = con.prepareStatement("DELETE FROM favorites WHERE user_id = ? AND product_id = ?");
	            pst.setInt(1, (int) session.getAttribute("userid"));
	            pst.setInt(2, productId);
	            pst.executeUpdate();
	        } else {
	            // The user has not liked the product, so like it
	            pst = con.prepareStatement("INSERT INTO favorites (user_id, product_id) VALUES (?, ?)");
	            pst.setInt(1, (int) session.getAttribute("userid"));
	            pst.setInt(2, productId);
	            pst.executeUpdate();
	            liked = 1;
	        }

	        return Collections.singletonMap("liked", liked);
	    } catch (Exception e) {
	        System.out.println("Exception: " + e);
	        return Collections.singletonMap("liked", 0);
	    }
	}
	
	@PostMapping("/add")
	public String add(@RequestParam("productId") int id, Model model) {
	    return "add";
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
    
    @PostMapping("/addToCart")
    public ResponseEntity<Map<String, Integer>> addToCart(@RequestParam("productId") int productId, 
                                 @RequestParam("quantity") int quantity, 
                                 HttpSession session) {
    
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
            PreparedStatement pst;
            int added = 0;

            // Check if the user has already added the product to the cart
            pst = con.prepareStatement("SELECT * FROM cart WHERE user_id = ? AND product_id = ?");
            pst.setInt(1, (int) session.getAttribute("userid"));
            pst.setInt(2, productId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                // The user has already added the product to the cart, so update the quantity
                pst = con.prepareStatement("UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?");
                pst.setInt(1, quantity + rs.getInt("quantity"));
                pst.setInt(2, (int) session.getAttribute("userid"));
                pst.setInt(3, productId);
                pst.executeUpdate();
            } else {
                // The user has not added the product to the cart, so add it
                pst = con.prepareStatement("INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)");
                pst.setInt(1, (int) session.getAttribute("userid"));
                pst.setInt(2, productId);
                pst.setInt(3, quantity);
                pst.executeUpdate();
                added = 1;
            }

            return ResponseEntity.ok(Collections.singletonMap("added", added));
        } catch (Exception e) {
            System.out.println("Exception: " + e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("added", 0));
        }
    }



}
