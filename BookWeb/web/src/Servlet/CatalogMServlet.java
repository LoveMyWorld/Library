package Servlet;

import Dao.YanshouDao;
import Entity.Cataloglist;
import Entity.ResultInfo;
import Service.CatalogMService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;


import java.io.IOException;
import java.io.PrintWriter;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "CatalogMServlet", value = {"/CatalogMServlet", "/initBookForm"})
public class CatalogMServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应类型为 JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String path = request.getServletPath();
        switch (path) {
//            case "/initBookForm":
//                //传过来的不全的代编目信息
//                CatalogMService catalogMService = new CatalogMService();
//                Cataloglist cataloglist =catalogMService.getCatalogInfoWithFallback();
//                //弹框显示：无待编目书籍
//                if(cataloglist==null){
//
//                }
//                else{
//                    cataloglist = new Cataloglist();
//                    request.setAttribute("/initBookForm", cataloglist);
//                }
//                //
//
//            break;
//            case
            case "/initBookForm":
                CatalogMService catalogMService = new CatalogMService();
                Cataloglist cataloglist = catalogMService.getCatalogInfoWithFallback();

                ResultInfo resultInfo = new ResultInfo();
                if(cataloglist != null){
                    resultInfo.setFlag(true);
                    resultInfo.setData(cataloglist);
                    if(cataloglist.getBookID() != null && !cataloglist.getBookID().equals("")){
                        resultInfo.setErrorMsg("isBianmu");
                    }
                    else {
                        resultInfo.setErrorMsg("unBianmu");
                    }
                }
                else {
                    resultInfo.setFlag(false);
                    resultInfo.setErrorMsg("all is ready");
                }

                ObjectMapper mapper = new ObjectMapper();
                Map<String , Object > map = new HashMap<>();

                map.put("resultInfo", resultInfo);
                //jia
                // 获取 publicationDate 字段
                if (cataloglist.getPublicationDate() != null) {
                    //格式化 LocalDate 为 "yyyy-M-d"
                    String formattedDate = cataloglist.getPublicationDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

                    // 更新 JSON 中的 publicationDate 字段
                    map.put("publicationDate", formattedDate);
                }

                String json = mapper.writeValueAsString(map);
                PrintWriter out = response.getWriter();
                out.print(json);
                out.flush();
                out.close();

                break;
            case "/CatalogMServlet":
                request.getRequestDispatcher("/bianmu/2_manage.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
