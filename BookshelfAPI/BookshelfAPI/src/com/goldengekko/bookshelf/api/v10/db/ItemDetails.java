package com.goldengekko.bookshelf.api.v10.db;

/**
 * @class ItemDetails
 * @author Svetlin Ralchev
 * @discssion Represents a ListItem's details
 */
public class ItemDetails {
	int id;
	String title;
	String author;
	String image;
	double price;
	
	/**
	 * Constructors a ItemDetails
	 */
	public ItemDetails() {
		
	}
	
	/**
	 * Constructors a ItemDetails
	 * @param id The item's id
	 * @param title The item's title
	 * @param author The item's author
	 * @param image The item's image link
	 * @param price The item's price
	 */
	public ItemDetails(int id, String title, String author, String image, double price) {
		this.id = id;
		this.title = title;
		this.author = author;
		this.image = image;
		this.price = price;
	}
	
	/**
	 * Gets the item's id
	 * @return Returns the item's id
	 */
	public int getId() {
		return this.id;
	}
	
	/**
	 * Sets the item's id
	 * @param id the item's id
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * Gets the itam's title
	 * @return Returns the item's title
	 */
	public String getTitle() {
		return this.title;
		
	}
	
	/**
	 * Sets the item's title
	 * @param title the item's title
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	
	/**
	 * Gets the itam's author
	 * @return Returns the item's author
	 */
	public String getAuthor() {
		return this.author;
		
	}
	
	/**
	 * Sets the item's author
	 * @param title the item's author
	 */
	public void setAuthor(String author) {
		this.author = author;
	}
	
	/**
	 * Gets the itam's image
	 * @return Returns the item's image
	 */
	public String getImage() {
		return this.image;
		
	}
	
	/**
	 * Sets the item's image
	 * @param title the item's image
	 */
	public void setImage(String image) {
		this.author = image;
	}
	
	/**
	 * Gets the itam's price
	 * @return Returns the item's price
	 */
	public double getPrice() {
		return this.price;
		
	}
	
	/**
	 * Sets the item's price
	 * @param title the item's price
	 */
	public void setPrice(double price) {
		this.price = price;
	}
}
