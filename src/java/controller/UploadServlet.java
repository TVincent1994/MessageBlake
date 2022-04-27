
package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Taylor Vincent
 */

@MultipartConfig(maxFileSize = 1024*1024*50,            // 50 MB - Max size to upload a file in bytes.  
                 maxRequestSize=1024*1024*100,      // 100 MB - Maximum size allowed for multipart/form-data request.
                 fileSizeThreshold=1024*1024*10)    // 10 MB - Specify the threshold after which the file will be written to disk.
public class UploadServlet extends HttpServlet {

    // directory of folder where photos will be inserted 
    private static final String SAVE_DIR = "uploads";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         
        RequestDispatcher rd = request.getRequestDispatcher("Blake_Upload.jsp");
        rd.forward(request, response);
    }
 
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String photoName = request.getParameter("filename");
        
        // if file of folder doesn't exist, create a new foler
        // "savePath" is the location you want to input images into
        String savePath = "C:\\Users\\Taylor Vincent\\Documents\\NetBeansProjects\\MessageTheBlake\\web" + File.separator + SAVE_DIR;
        System.out.println(savePath);   // output file path
        
        File file = new File(savePath);
        if(!file.exists()){
            file.mkdir();
        }
        
        InputStream inputS = null;
        
        // Obtains the upload file part in this mulipart request
        Part filePart = request.getPart("file");
        Part vidPart = request.getPart("videoFile");
        
        String fileName = extractFileName(filePart);
        String vidName = extractFileName(vidPart);
        
        /* if you may have more than one files with same name then you can calculate some random characters 
        and append that characters in fileName so that it will make your each image name identical.*/
        filePart.write(savePath + File.separator + fileName);  // add image file
        filePart.write(savePath + File.separator + vidName);   // add video file 
        
        // Displays info when successfully uploaded
        if(filePart != null){
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
            System.out.println("Succesfully Uploaded");
            // obtains input stream of the upload file
            inputS = filePart.getInputStream();
        }
        
        Connection con = null;  // connection to database
        String message = null;  // message will be sent back to client
        
        try{
            // connect to database
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://instancemtb.cbvlbcyf5pmu.us-west-2.rds.amazonaws.com:3306/messagetheblake", "messageRoot", "messageTheBRoot");
            PreparedStatement ps = con.prepareStatement("INSERT INTO photos (title, img_date, img_time, fileName, video, views) values(?, CURRENT_DATE, CURRENT_TIME, ?,?, 0)");            
            ps.setString(1, photoName);
            ps.setString(2, fileName);
            ps.setString(3, vidName);
            // sends the statement to the database server
            int row = ps.executeUpdate();
            
            if (row > 0) {
                message = "File uploaded and saved into database";
            }
        }catch(SQLException sqle){
            System.out.println(sqle);
        }catch(Exception e){
            System.out.println(e);
        }finally{
            if (con != null) {
                // closes the database connection
                try {
                    con.close();
                }catch(SQLException ex) {
                    System.out.println(ex);
                }
            }
            // stay on current page
            response.sendRedirect("Blake_Upload.jsp");
        }
    }
    
    // file name of the upload file is included in the "content-disposition" header like this:
    // form-data; name="dataFile"; filename="PHOTO.JPG"
    private String extractFileName(Part part){
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for(String s: items){
            if(s.trim().startsWith("filename")){
                return s.substring(s.indexOf("=") + 2, s.length()-1);
            }
        }
        return "";
    }
}
