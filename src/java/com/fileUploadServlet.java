
package com;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
/**
 *
 * @author Taylor Vincent
 */
@WebServlet(name = "fileUploadServlet", urlPatterns = {"/Upload"})
@MultipartConfig
public class fileUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private final String UPLOAD_DIRECTORY = "C:/Users/Taylor Vincent/Desktop/Upload";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
    public fileUploadServlet() {
	super();
    }
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
	processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
	if (ServletFileUpload.isMultipartContent(request)) {
	    try {
                List<FileItem> multiparts = new ServletFileUpload(
                    new DiskFileItemFactory()).parseRequest(request);

		for (FileItem item : multiparts) {
		    if (!item.isFormField()) {
                        String name = new File(item.getName()).getName();
			item.write(new File(UPLOAD_DIRECTORY + File.separator + name));
                    }
                }

		// File uploaded successfully
                request.setAttribute("message", "File Uploaded Successfully");

	    }catch (Exception ex) {
                request.setAttribute("message", "File Upload Failed due to " + ex);
            }
	} else {
            request.setAttribute("message","Sorry this Servlet only handles file upload request");
	}
            request.getRequestDispatcher("/result.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
