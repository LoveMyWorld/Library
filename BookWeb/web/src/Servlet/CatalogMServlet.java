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

@WebServlet(name = "CatalogMServlet", value = {"/CatalogMServlet", "/initBookForm", "/CatalogOneBook"}) public class CatalogMServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应类型为 JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String path = request.getServletPath();
        switch (path) {
            case "/initBookForm":
                processCatalogInfo(request, response);
                break;
            case "/CatalogMServlet":
                request.getRequestDispatcher("/bianmu/2_manage.jsp").forward(request, response);
                break;
            case "/CatalogOneBook"://操作：接收传回的数据，把数据写回编目清单
                //说明已经编目
                if (request.getParameter("bookID") != null && !request.getParameter("bookID").equals("")) {
                    //把已经编目的全部信息写入
                    CatalogMService catalogMService = new CatalogMService();
                    boolean iswriteDB= catalogMService.dirWriteCatalogList();
                    ResultInfo resultInfo = new ResultInfo();
                    String bookID = request.getParameter("bookID");
                    resultInfo.setData(bookID);
                    if(!iswriteDB){
                        resultInfo.setFlag(false);
                        resultInfo.setErrorMsg("出现意外的错误，没有写入数据库");
                    }
                    else{
                        resultInfo.setFlag(true);
                        resultInfo.setErrorMsg("编目成功");
                    }
                    HashMap<String , Object> map = new HashMap<>();
                    map.put("resultInfo", resultInfo);
                    map.put("bookID", bookID);
                    ObjectMapper objectMapper = new ObjectMapper();
                    String json = objectMapper.writeValueAsString(map);
                    PrintWriter out = response.getWriter();
                    out.print(json);
                    out.flush();
                    out.close();
                    processCatalogInfo(request, response);
                    break;
                }
                String precategoryName = request.getParameter("categoryName");
                //只取前面的几位
                String categoryName = precategoryName.replaceAll("[^A-Za-z0-9]", "");

                String isbn = request.getParameter("isbn");
                String bookID = categoryName + isbn;
                //传到编目清单
                HttpSession session = request.getSession();
                session.setAttribute("BianmuBookID", bookID);

                CatalogMService catalogMService = new CatalogMService();

                Cataloglist cataloglist = (Cataloglist) request.getSession().getAttribute("readyBMBook");


                cataloglist.setBookID(bookID);
                catalogMService.setCataloglistnew(cataloglist);

                boolean iswriteDB= catalogMService.writeCatalogNew(cataloglist, bookID, precategoryName);
                processCatalogInfo(request, response);

                break;
        }

    }
    @Override protected void doPost (HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException
    {
//            doGet(request, response);
    }
    public void processCatalogInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CatalogMService catalogMService = new CatalogMService();
        Cataloglist cataloglist = catalogMService.getCatalogInfoWithFallback();

        ResultInfo resultInfo = new ResultInfo();
        if (cataloglist != null) {
            resultInfo.setFlag(true);
            resultInfo.setData(cataloglist);
            // 判断是否已经编目
            if (cataloglist.getBookID() != null && !cataloglist.getBookID().equals("")) {
                resultInfo.setErrorMsg("isBianmu");
            } else {
                resultInfo.setErrorMsg("unBianmu");
            }
        } else {
            resultInfo.setFlag(false);
            resultInfo.setErrorMsg("all is ready");
        }

        // 放入requst
        HttpSession session = request.getSession();
        session.setAttribute("readyBMBook", cataloglist);

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = new HashMap<>();

        map.put("resultInfo", resultInfo);
        map.put("BianmuBookID", session.getAttribute("BianmuBookID"));

        // 获取 publicationDate 字段
        if (cataloglist != null && cataloglist.getPublicationDate() != null) {
            // 格式化 LocalDate 为 "yyyy-MM-dd"
            String formattedDate = cataloglist.getPublicationDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            // 更新 JSON 中的 publicationDate 字段
            map.put("publicationDate", formattedDate);
        }

        String json = mapper.writeValueAsString(map);
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
        out.close();
    }
}
