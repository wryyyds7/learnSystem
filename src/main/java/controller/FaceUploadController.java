package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import static utils.FileUploadUtil.uploadFile;

@WebServlet(name = "FaceUploadController", urlPatterns = "/user/faceUpload")
public class FaceUploadController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String relaPath = "images/face";
        String savePath = getServletContext().getRealPath(relaPath);
        PrintWriter out = response.getWriter();
        out.print(uploadFile(relaPath,savePath,request));
        out.close();
    }
}
