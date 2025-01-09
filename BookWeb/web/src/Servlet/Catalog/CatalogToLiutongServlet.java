package Servlet.Catalog;

import Dao.CatalogMDao;
import Dao.LiutongDao;
import Entity.Cataloglist;
import Entity.Liutong;
import Entity.ResultInfo;
import Service.Borrow.AppointmentService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "CatalogToLiutongServlet", value = "/CatalogToLiutongServlet")
public class CatalogToLiutongServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        // 导出逻辑
        int success = performExportOperation();
        // 创建 ResultInfo 对象并设置响应内容
        ResultInfo resultInfo = new ResultInfo();
        resultInfo.setFlag(success == 3); // 假设 msg 为 3 表示成功
        if (resultInfo.isFlag()) {
//            resultInfo.setErrorMsg("审核成功");
        } else {
            if(success==1){
                resultInfo.setErrorMsg("编目清单无内容,无需导出");
            }
            if(success==2){
                resultInfo.setErrorMsg("插入流通库表失败");
            }

        }

        // 返回 JSON 响应

        sendJsonResponse(response, resultInfo);
    }

    private int performExportOperation() {
        //直接跳过service层
        //将catalolist全部取出
        CatalogMDao catalogMDao=new CatalogMDao();
        List<Cataloglist> dataList = new ArrayList<>();
        dataList=catalogMDao.getAllData();
        //将流通库表写入
        // 创建 LiutongDao 实例
        LiutongDao liutongDao = new LiutongDao();
        if(dataList.size()==0){
            return 1;//编目清单无内容
        }
        // 遍历 dataList 并插入到 liutonglist 表
        for (Cataloglist catalog : dataList) {
            // 假设 Cataloglist 到 Liutong 的转换逻辑已经实现
            Liutong liutong = new Liutong();
            //先看有没有这个图书编号,如果有，就结束啦

            int effect=liutongDao.UpdateByBookID(catalog.getBookID(), catalog.getBookNum());
            if(effect>0){//影响大于一行
               ;
               //删去此条编目清单,通过bookID
                


            }
            else{
                liutong.setBookID(catalog.getBookID());
                liutong.setBookNum(catalog.getBookNum());
                liutong.setCategoryName(catalog.getCategoryName());
                liutong.setAuthor(catalog.getAuthor());
                liutong.setPublisher(catalog.getPublisher());
                liutong.setPrice(catalog.getPrice());
                liutong.setEdition(catalog.getEdition());
                liutong.setDocumentType(catalog.getDocumentType());
                liutong.setPublicationDate(catalog.getPublicationDate());
                liutong.setTitle(catalog.getTitle());
                liutong.setISBN(catalog.getISBN());
                liutong.setSupplier(catalog.getSupplier());
                liutong.setOrderPerson(catalog.getOrderPerson());
                liutong.setOrderPerson(catalog.getOrderPerson());
                // 插入 Liutong 到 liutonglist 表
                int result = liutongDao.insertIntoLiutongList(liutong);
                if (result <= 0) {
                    return 2;
                    // 如果插入流通库表失败

                }
                //删除此条编目清单


            }
        }

        return 3; // 导出成功
    }

    private void sendJsonResponse(HttpServletResponse response, ResultInfo resultInfo) throws IOException {
        HashMap<String, Object> map = new HashMap<>();
        map.put("resultInfo", resultInfo);

        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(map);

        PrintWriter writer = response.getWriter();
        writer.write(json);
        writer.flush();
        writer.close();
    }
}