package com.goldengekko.bookshelf.api.v10.db;

import java.sql.*;
import java.util.ArrayList;

import javax.naming.*;
import javax.sql.DataSource;

/**
 * @class ItemRepository
 * @author Svetlin Ralchev
 * @discussion Represents an item repository
 */
public class ItemRepository {

	private DataSource dataSource;
		
	private Connection getConnection() throws NamingException, SQLException {
		if(dataSource == null) {
			InitialContext initContext = new InitialContext();
			Context environmentContext = (Context)initContext.lookup("java:comp/env");
			dataSource = (DataSource)environmentContext.lookup("jdbc/GoldenGekkoItemsDb");	
		}
		
		return dataSource.getConnection();
	}
	
	/**
	 * Fetch all item details by id
	 * @param key The id of the item details to be fetched
	 * @return Returns the ItemDetails object
	 * @throws NamingException
	 * @throws SQLException
	 */
	public ItemDetails getItemDetailsById(int key) throws NamingException, SQLException {
		ItemDetails details = null;
		Connection connection = null;
		
		String query = "SELECT items.id, items.title, details.author, details.image, details.price FROM Items items " +
					   "LEFT JOIN ItemDetails details ON items.id = details.id " + 
					   "WHERE items.id=?";
	
		try {
			connection = this.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setInt(1, key);
			ResultSet result = statement.executeQuery();
	
			if (result.next()) {
				int id = result.getInt("id");
				String title = result.getString("title");
				String author = result.getString("author");
				String image = result.getString("image");
				double price = result.getDouble("price");
				details = new ItemDetails(id, title, author, image, price);
			}
		}
		finally {
			if(connection != null) {
				connection.close();
			}
		}
		
		return details;	
	}
	
	/**
	 * Returns a list of ListItems
	 * @param offset The number of items that are skipped
	 * @param count The number of item that will be fetched
	 * @return Returns the list of ListItems
	 * @throws NamingException
	 * @throws SQLException
	 */
	public ArrayList<ListItem> getAllItems(int offset, int count) throws NamingException, SQLException {
		String query = null;
		ArrayList<ListItem> items = new ArrayList<ListItem>();
		Connection connection = null;
		boolean allowPaging = offset >=0 && count > 0;
		
		if(allowPaging) {
			query = "SELECT * FROM Items LIMIT ?, ?";
		}
		else {
			query = "SELECT * FROM Items";
		}
		
		try {
			connection = this.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			
			if(allowPaging) {
				statement.setInt(1, offset);
				statement.setInt(2, count);
			}
			
			ResultSet result = statement.executeQuery();
		
			while (result.next()) {
				int id = result.getInt("id");
				String title = result.getString("title");
				String link = result.getString("link");
				items.add(new ListItem(id, title, link));
			}
		
		}
		finally {
			if(connection != null) {
				connection.close();
			}
		}
		
		return items;
	}
}
