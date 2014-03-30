package com.goldengekko.bookshelf.api.v10.db;

/**
 * @author Svetlin Ralchev
 * @class ListItem
 * @discussion Represent a list item
 */
public class ListItem {
	int id;
	String title;
	String link;
	
	/**
	 * The constructor of ListItem
	 */
	public ListItem() {
	
	}
	
	/**
	 * The constructor of ListItem
	 * @param id the primary key of ListItem
	 * @param title the title of ListItem
	 * @param link the link of ListItem
	 */
	public ListItem(int id, String title, String link) {
		this.id = id;
		this.title = title;
		this.link = link;
	}
	
	/**
	 * Gets the primary key
	 * @return An primary key
	 */
	public int getId() {
		return this.id;
	}
	
	/**
	 * Sets the primary key
	 * @param id the primary key of
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * Gets the ListItem's title
	 * @return
	 */
	public String getTitle() {
		return this.title;
	}
	
	/**
	 * Sets the ListItem's title
	 * @param title A title of ListItem
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	
	/**
	 * Gets the link of its details
	 * @return Returns the link of its details
	 */
	public String getLink() {
		return this.link;
	}
	
	/**
	 * Sets the link of its details
	 * @param link the ListItem's link
	 */
	public void setLink(String link) {
		this.link = link;
	}
}