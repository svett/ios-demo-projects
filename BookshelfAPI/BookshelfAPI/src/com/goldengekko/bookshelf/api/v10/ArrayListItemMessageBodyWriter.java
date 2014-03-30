package com.goldengekko.bookshelf.api.v10;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.annotation.Annotation;
import java.lang.reflect.Type;
import java.util.ArrayList;

import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.ext.MessageBodyWriter;
import javax.ws.rs.ext.Provider;

import com.goldengekko.bookshelf.api.v10.db.ListItem;
import com.google.gson.Gson;

@Provider
@Produces({"application/json", "application/x-javascript"})
public class ArrayListItemMessageBodyWriter implements MessageBodyWriter<ArrayList<ListItem>> {
	
	@Override
	public long getSize(ArrayList<ListItem> item, Class<?> classType, Type type,
			Annotation[] annotation, MediaType mediaType) {
		return 0;
	}

	@Override
	public boolean isWriteable(Class<?> classType, Type type, Annotation[] annotations,
			MediaType mediaType) {
		return classType == (new ArrayList<ListItem>()).getClass();
	}

	@Override
	public void writeTo(ArrayList<ListItem> items, Class<?> classType, Type type,
			Annotation[] annotations, MediaType mediaType,
			MultivaluedMap<String, Object> map, OutputStream output)
			throws IOException, WebApplicationException {
	
		Gson gson = new Gson();
		String jsonString = gson.toJson(items);
		PrintWriter writer = new PrintWriter(output);
		writer.write(jsonString);
		writer.flush();
	}

}
