package com.jtspringproject.JtSpringProject.controller;

public class Product {
    private int id;
    private String name;
    private String image;
    private int categoryId;
    private String categoryName;
    private int quantity;
    private int price;
    private int weight;
    private String description;
    private boolean onSale;
    private double discountedPrice;
    private double discount;
    private int sold;
    private int liked;

    public Product(int id, String name, String image, int categoryId, String categoryName, int quantity, int price, int weight, String description, boolean onSale, double discountedPrice, int sold) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.quantity = quantity;
        this.price = price;
        this.weight = weight;
        this.description = description;
        this.onSale = onSale;
        this.discountedPrice = discountedPrice;
        this.sold = sold;
    }
    
    public Product(int id, String name, String image, int categoryId, String categoryName, int quantity, int price, int weight, String description, boolean onSale, double discountedPrice, int sold, int liked) {
        this(id, name, image, categoryId, categoryName, quantity, price, weight, description, onSale, discountedPrice, sold);
        this.liked = liked;
    }
    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    public boolean isOnSale() {
        return onSale;
    }
    public void setOnSale(boolean onSale) {
        this.onSale = onSale;
    }
    
    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    // discountedPriceのgetterとsetter
    public double getDiscountedPrice() {
    	 return discountedPrice;
    }

    public void setDiscountedPrice(double discountedPrice) {
        this.discountedPrice = discountedPrice;
    }
    
    public int getSold() {
        return sold;
    }
    
    public void setSold(int num) {
        this.sold = this.sold + num;
    }
    
    public int getLiked() {
        return liked;
    }
    
    public void setLiked(int num) {
        this.liked = num;
    }
}
