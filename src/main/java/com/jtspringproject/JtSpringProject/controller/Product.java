package com.jtspringproject.JtSpringProject.controller;

public class Product {
    private int id;
    private String name;
    private String image;
    private int categoryId;
    private int quantity;
    private int price;
    private int weight;
    private String description;
    private double discount;


    public Product(int id, String name, String image, int categoryId, int quantity, int price, int weight, String description) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.categoryId = categoryId;
        this.quantity = quantity;
        this.price = price;
        this.weight = weight;
        this.description = description;
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
    // getter and setter
    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    // 割引後の価格を計算
    public double getDiscountedPrice() {
        return price * (1 - discount);
    }
}
