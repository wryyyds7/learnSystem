package utils;

import com.alibaba.fastjson.JSON;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FileUploadUtil {
    /**
     * @param savePath 保存路径
     * @param request  请求对象
     */
    public static String uploadFile(String relaPath,String savePath, HttpServletRequest request) {
        Map map = new HashMap();
        File f = new File(savePath);
        if (!f.exists()) {
            f.mkdirs();
        }
        //创建磁盘工厂类
        DiskFileItemFactory factory = new DiskFileItemFactory();
        //servlet文件上传
        ServletFileUpload upload = new ServletFileUpload(factory);
        //防止乱码
        upload.setHeaderEncoding("UTF-8");
        //开始解析request对象中的文件数据和表单数据
        try {
            List<FileItem> list = upload.parseRequest(request);
            for (FileItem item : list) {
                //isFormField判断是否是表单项
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    String value = item.getString("UTF-8");
                    System.out.println(name + ":::" + value);
                } else {
                    //复制文件，把temp文件夹中的文件写到upload目录中
                    InputStream in = item.getInputStream();
                    String originName = item.getName();
                    Date d = new Date();
                    String newFileName = d.getTime() + originName.substring(originName.indexOf("."));
                    map.put("src", relaPath + "/" + newFileName);
                    FileOutputStream out = new FileOutputStream(savePath + "\\" + newFileName);
                    byte[] b = new byte[1024];
                    int len = 0;
                    while ((len = in.read(b)) != -1) {
                        out.write(b, 0, len);
                    }
                    out.close();
                    in.close();
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return JSON.toJSONString(map);
    }
}
