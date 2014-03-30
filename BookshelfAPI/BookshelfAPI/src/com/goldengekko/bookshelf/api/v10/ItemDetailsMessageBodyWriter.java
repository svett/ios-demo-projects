package com.goldengekko.bookshelf.api.v10;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.annotation.Annotation;
import java.lang.reflect.Type;

import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.ext.MessageBodyWriter;
import javax.ws.rs.ext.Provider;

import com.goldengekko.bookshelf.api.v10.db.ItemDetails;
import com.google.gson.Gson;

@Provider
@Produces({"application/json", "application/x-javascript"})
public class ItemDetailsMessageBodyWriter implements MessageBodyWriter<ItemDetails> {

	@Override
	public long getSize(ItemDetails itemDetails, Class<?> classType, Type type,
			Annotation[] annotation, MediaType mediaType) {
		return 0;
	}

	@Override
	public boolean isWriteable(Class<?> classType, Type type, Annotation[] annotations,
			MediaType mediaType) {
		return classType == ItemDetails.class;
	}

	@Override
	public void writeTo(ItemDetails itemDetails, Class<?> classType, Type type,
			Annotation[] annotations, MediaType mediaType,
			MultivaluedMap<String, Object> map, OutputStream output)
			throws IOException, WebApplicationException {
		Gson gson = new Gson();
		String jsonString = gson.toJson(itemDetails);
		PrintWriter writer = new PrintWriter(output);
		writer.write(jsonString);
		writer.flush();
		
	}

}
