package com.jtspringproject.JtSpringProject.controller;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.mysql.cj.protocol.Resultset;

@Controller
public class AdminController {
	int adminlogcheck = 0;
	String usernameforclass = "";
	int userid;

	@RequestMapping(value = { "/", "/logout" }) // REQUEST: /, /logout
	public String returnIndex() {
		adminlogcheck = 0;
		usernameforclass = "";
		return "userLogin";
	}

	@GetMapping("/index")
	public String index(Model model, HttpSession session) {
		if (usernameforclass.equalsIgnoreCase(""))
			return "userLogin";
		else {
			session.setAttribute("username", usernameforclass);
	        session.setAttribute("userid", userid);
			model.addAttribute("username", usernameforclass);
			model.addAttribute("userid", userid);
			return "index";
		}
	}

	@GetMapping("/userloginvalidate")
	public String userlog(Model model) {
		return "userLogin";
	}

	@PostMapping(value = "userloginvalidate")
	public String userlogin(@RequestParam("username") String username, @RequestParam("password") String pass,
			Model model) {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery(
					"select * from users where username = '" + username + "' and password = '" + pass + "' ;");
			if (rst.next()) {
				usernameforclass = rst.getString(2);
				// Add user id into model
				userid = rst.getInt(1);
				return "redirect:/index";
			} else {
				model.addAttribute("message", "Invalid Username or Password");
				return "userLogin";
			}

		} catch (Exception e) {
			System.out.println("Exception:" + e);
		}
		return "userLogin";
	}

	@GetMapping("/admin")
	public String adminlogin(Model model) {
		return "adminlogin";
	}

	@GetMapping("/adminhome")
	public String adminHome(Model model) {
		if (adminlogcheck != 0)
			return "adminHome";
		else
			return "redirect:/admin";
	}

	@GetMapping("/loginvalidate")
	public String adminlog(Model model) {
		return "adminlogin";
	}

	@PostMapping(value = "loginvalidate")
	public String adminlogin(@RequestParam("username") String username, @RequestParam("password") String pass,
			Model model) {

		if (username.equalsIgnoreCase("admin") && pass.equalsIgnoreCase("123")) {
			adminlogcheck = 1;
			return "redirect:/adminhome";
		} else {
			model.addAttribute("message", "Invalid Username or Password");
			return "adminlogin";
		}
	}

	@GetMapping("/admin/categories")
	public String getcategory() {
		return "categories";
	}

	@GetMapping(value = "admin/sendcategory")
	public String addcategorytodb(@RequestParam("categoryname") String catname) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			Statement stmt = con.createStatement();

			PreparedStatement pst = con.prepareStatement("insert into categories(name) values(?);");
			pst.setString(1, catname);
			int i = pst.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception:" + e);
		}
		return "redirect:/admin/categories";
	}

	@GetMapping("/admin/categories/delete")
	public String removeCategoryDb(@RequestParam("id") int id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			Statement stmt = con.createStatement();

			PreparedStatement pst = con.prepareStatement("delete from categories where categoryid = ? ;");
			pst.setInt(1, id);
			int i = pst.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception:" + e);
		}
		return "redirect:/admin/categories";
	}

	@GetMapping("/admin/categories/update")
	public String updateCategoryDb(@RequestParam("categoryid") int id,
			@RequestParam("categoryname") String categoryname) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			Statement stmt = con.createStatement();

			PreparedStatement pst = con.prepareStatement("update categories set name = ? where categoryid = ?");
			pst.setString(1, categoryname);
			pst.setInt(2, id);
			int i = pst.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception:" + e);
		}
		return "redirect:/admin/categories";
	}

	@GetMapping("/admin/products")
	public String getproduct(Model model) {
		return "products";
	}

	@GetMapping("/admin/products/add")
	public String addproduct(Model model) {
		return "productsAdd";
	}

	@GetMapping("/admin/products/update")
	public String updateproduct(@RequestParam("pid") int id, Model model) {
		String pname, pdescription, pimage;
		int pid, pprice, pweight, pquantity, pcategory;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from products where id = " + id + ";");

			if (rst.next()) {
				pid = rst.getInt(1);
				pname = rst.getString(2);
				pimage = rst.getString(3);
				pcategory = rst.getInt(4);
				pquantity = rst.getInt(5);
				pprice = rst.getInt(6);
				pweight = rst.getInt(7);
				pdescription = rst.getString(8);
				model.addAttribute("pid", pid);
				model.addAttribute("pname", pname);
				model.addAttribute("pimage", pimage);
				ResultSet rst2 = stmt2.executeQuery("select * from categories where categoryid = " + pcategory + ";");
				if (rst2.next()) {
					model.addAttribute("pcategory", rst2.getString(2));
				}
				model.addAttribute("pquantity", pquantity);
				model.addAttribute("pprice", pprice);
				model.addAttribute("pweight", pweight);
				model.addAttribute("pdescription", pdescription);
			}
		} catch (Exception e) {
			System.out.println("Exception:" + e);
		}
		return "productsUpdate";
	}

	@PostMapping(value = "admin/products/updateData")
	public String updateproducttodb(@RequestParam("id") int id, @RequestParam("name") String name,
			@RequestParam("price") int price, @RequestParam("weight") int weight,
			@RequestParam("quantity") int quantity, @RequestParam("description") String description,
			@RequestParam("productImage") String picture)

	{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");

			PreparedStatement pst = con.prepareStatement(
					"update products set name= ?,image = ?,quantity = ?, price = ?, weight = ?,description = ? where id = ?;");
			pst.setString(1, name);
			pst.setString(2, picture);
			pst.setInt(3, quantity);
			pst.setInt(4, price);
			pst.setInt(5, weight);
			pst.setString(6, description);
			pst.setInt(7, id);
			int i = pst.executeUpdate();
		} catch (Exception e) {
			System.out.println("Exception:" + e);
		}
		return "redirect:/admin/products";
	}

	@GetMapping("/admin/products/delete")
	public String removeProductDb(@RequestParam("id") int id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");

			PreparedStatement pst = con.prepareStatement("delete from products where id = ? ;");
			pst.setInt(1, id);
			int i = pst.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception:" + e);
		}
		return "redirect:/admin/products";
	}

	@PostMapping("/admin/products")
	public String postproduct() {
		return "redirect:/admin/categories";
	}

	@PostMapping(value = "admin/products/sendData")
	public String addproducttodb(@RequestParam("name") String name, @RequestParam("categoryid") String catid,
			@RequestParam("price") int price, @RequestParam("weight") int weight,
			@RequestParam("quantity") int quantity, @RequestParam("description") String description,
			@RequestParam("productImage") String picture) {

		try {
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from categories where name = '" + catid + "';");
			if (rs.next()) {
				int categoryid = rs.getInt(1);

				PreparedStatement pst = con.prepareStatement(
						"insert into products(name,image,categoryid,quantity,price,weight,description) values(?,?,?,?,?,?,?);");
				pst.setString(1, name);
				pst.setString(2, picture);
				pst.setInt(3, categoryid);
				pst.setInt(4, quantity);
				pst.setInt(5, price);
				pst.setInt(6, weight);
				pst.setString(7, description);
				int i = pst.executeUpdate();
			}
		} catch (Exception e) {
			System.out.println("Exception:" + e);
		}
		return "redirect:/admin/products";
	}

	@GetMapping("/admin/customers")
	public String getCustomerDetail() {
		return "displayCustomers";
	}

	@GetMapping("profileDisplay")
	public String profileDisplay(Model model) {
		String displayusername, displaypassword, displayemail;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from users where username = '" + usernameforclass + "';");

			if (rst.next()) {
				int userid = rst.getInt(1);
				displayusername = rst.getString(2);
				displaypassword = rst.getString(3);
				displayemail = rst.getString(6);
				model.addAttribute("userid", userid);
				model.addAttribute("username", displayusername);
				model.addAttribute("email", displayemail);
				model.addAttribute("password", displaypassword);
			}
		} catch (Exception e) {
			System.out.println("Exception:" + e);
		}
		System.out.println("Hello");
		return "updateProfile";
	}

	@PostMapping(value = "updateuser")
	public String updateUserProfile(@RequestParam("userid") int userid, @RequestParam("username") String username,
			@RequestParam("email") String email, @RequestParam("password") String password
			/*, @RequestParam("address") String address */)

	{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");

			PreparedStatement pst = con
					.prepareStatement("update users set username= ?,email = ?,password= ? where uid = ?;");
			pst.setString(1, username);
			pst.setString(2, email);
			pst.setString(3, password);
			pst.setInt(4, userid);
			int i = pst.executeUpdate();
			usernameforclass = username;
		} catch (Exception e) {
			System.out.println("Exception:" + e);
		}
		return "redirect:/index";
	}

	@GetMapping("/admin/discount")
	public String getAllProducts(Model model) {
		try {
			List<Product> productList = getAllProducts();
			model.addAttribute("productList", productList);
			return "discount";
		} catch (Exception e) {
			System.out.println("Exception: " + e);
			return "error";
		}
	}


	private List<Product> getAllProducts() throws Exception {
		List<Product> productList = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		String query = "select * from products;";
		ResultSet rs = stmt.executeQuery(query);

		while (rs.next()) {
			int id = rs.getInt("id");
			String name = rs.getString("name");
			String image = rs.getString("image");
			
			int categoryId = rs.getInt("categoryid");
			ResultSet rs2 = stmt2.executeQuery("SELECT name FROM categories WHERE categoryid=" + categoryId);
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

	@PostMapping("/admin/applyDiscount")
	public void applyDiscount(@RequestParam("productId") int productId,
			@RequestParam("discountRate") double discountRate, @RequestParam("discountedPrice") double discountedPrice,
			HttpServletResponse response) {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			PreparedStatement pst = con
					.prepareStatement("UPDATE products SET onSale = 1, discountedPrice = ? WHERE id = ?;");
			pst.setDouble(1, discountedPrice);
			pst.setInt(2, productId);
			int i = pst.executeUpdate();
			if (i > 0) {
				response.setStatus(HttpServletResponse.SC_OK);
			} else {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			}
		} catch (Exception e) {
			System.out.println("Exception: " + e);
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/admin/resetDiscount")
	public String resetDiscount(@RequestParam("productId") int productId, HttpServletResponse response) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject", "root", "");
			PreparedStatement pst = con
					.prepareStatement("UPDATE products SET onSale = 0, discountedPrice = price WHERE id = ?;");
			pst.setInt(1, productId);
			int i = pst.executeUpdate();
			if (i > 0) {
				response.setStatus(HttpServletResponse.SC_OK);
				return "redirect:/admin/discount"; 
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

}
