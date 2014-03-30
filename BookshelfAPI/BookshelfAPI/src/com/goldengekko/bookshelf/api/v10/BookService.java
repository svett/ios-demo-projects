package com.goldengekko.bookshelf.api.v10;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.NamingException;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import org.glassfish.jersey.server.JSONP;

import com.goldengekko.bookshelf.api.v10.db.*;

/**
 * @class BookService
 * @author Svetlin Ralchev
 * @discussion Represent a restful service
 */
@Path("items")
@Produces({"application/json", "application/x-javascript"})
public class BookService {

	/**
	 * Returns an list of items
	 * @param offset The number of items that should be skipped.
	 * @param count The number of items that should be fetched.
	 * @return Returns an list of items.
	 * @throws NamingException
	 * @throws SQLException
	 */
    @GET
    @JSONP(queryParam = "callback")
    public ArrayList<ListItem> getAllItems(@QueryParam("offset") int offset, @QueryParam("count") int count) throws NamingException, SQLException {
    	ItemRepository repository = new ItemRepository();
    	ArrayList<ListItem> items = repository.getAllItems(offset, count);
    	return items;
    }
    
    
    /**
     * Returns an item's details
     * @param id The key of item's details
     * @return Returns an item's details by key
     * @throws NamingException
     * @throws SQLException
     */
    @GET
    @JSONP(queryParam = "callback")
    @Path("{id}")
    public ItemDetails getItemById(@PathParam("id") int id) throws NamingException, SQLException {
    	ItemRepository repository = new ItemRepository();
    	return repository.getItemDetailsById(id);
    }
}
