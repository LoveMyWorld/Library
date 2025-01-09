package Servlet.Catalog;

import Dao.CatalogMDao;
import Entity.*;
import Entity.Cataloglist;
import Service.Catalog.CatalogMService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static Servlet.Catalog.YanshouServlet.PAGE_SIZE;

@WebServlet(name = "CatalogMServlet", value = {"/CatalogMServlet", "/editBookForm","/initBookForm", "/CatalogOneBook"  ,"/lookBookForm"}) public class CatalogMServlet extends HttpServlet {
//    static final int PAGE_SIZE = 16;
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
            case "/editBookForm":
                editCatalogInfo(request, response);
                break;
            case "/lookBookForm":
                lookCatalogInfo(request, response);
                break;
            case "/CatalogMServlet":
                String page = request.getParameter("currentPage");
                if(page != null ){ // 需要进行上下页切换
                    changePage(request, response);
                }
                else { // 遇到新的搜索条件，默认从第1页起。
                    searchBook(request, response);
                }
                request.getRequestDispatcher("/bianmu/2_manage.jsp").forward(request, response);
                break;
            case "/CatalogOneBook"://操作：接收传回的数据，把数据写回编目清单
                //说明已经编目
                if (request.getParameter("bookID") != null && !request.getParameter("bookID").equals("")) {
                    //把已经编目的全部信息写入
                    String bookID = request.getParameter("bookID");
                    String title = request.getParameter("title");
                    String author = request.getParameter("author");
                    String ISBN = request.getParameter("isbn");
                    LocalDate publicationDate = LocalDate.parse(request.getParameter("publicationDate"), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    String publisher = request.getParameter("publisher");
                    String edition = request.getParameter("edition");
                    String supplier = request.getParameter("supplier");
                    String tcurrencyID = request.getParameter("currencyID")==null? "1" : request.getParameter("currencyID");
                    int currencyID = Integer.parseInt(tcurrencyID);
                    double price = Double.valueOf(request.getParameter("price"));
                    int bookNum = Integer.parseInt(request.getParameter("bookNum"));
                    DocumentType documentType = (DocumentType.valueOf(request.getParameter("documentType")));
                    String categoryName = request.getParameter("categoryName");
                    String orderPerson = request.getParameter("orderPerson");

                    if(categoryName == null || !categoryName.equals("")){
                        Cataloglist aCataloglist = (Cataloglist) request.getSession().getAttribute("readyConfirmBook");
                        categoryName = aCataloglist.getCategoryName();
                    }

                    Cataloglist cataloglist = new Cataloglist(
                            bookID,title , author,ISBN,publicationDate,publisher,edition,supplier,
                            currencyID,price,orderPerson,bookNum,documentType,categoryName
                    );

                    CatalogMService catalogMService = new CatalogMService();
                    boolean iswriteDB= catalogMService.dirWriteCatalogList(cataloglist);
                    ResultInfo resultInfo = new ResultInfo();
                    if(bookID==null || bookID.equals("")){
                        bookID = request.getParameter("BianmuBookID");
                    }
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
                    map.put("BianmuBookID", bookID);
                    if(resultInfo.isFlag()){
                        CatalogMService.addCatalog(cataloglist);
                    }
                    ObjectMapper objectMapper = new ObjectMapper();
                    String json = objectMapper.writeValueAsString(map);
                    PrintWriter out = response.getWriter();
                    out.print(json);
                    out.flush();
                    out.close();
                    System.out.println("I am a CatalogOneBook");
                    break;
                }
                else{
                    String precategoryName = request.getParameter("categoryName");
                    //只取前面的几位
                    String categoryName = precategoryName.replaceAll("[^A-Za-z0-9]", "");

                    String isbn = request.getParameter("isbn");
                    String bookID = categoryName + isbn;
                    //传到编目清单
                    HttpSession session = request.getSession();
//                session.setAttribute("BianmuBookID", bookID);

                    CatalogMService catalogMService = new CatalogMService();

                    Cataloglist cataloglist = (Cataloglist) request.getSession().getAttribute("readyConfirmBook");
                    cataloglist.setBookID(bookID);
                    cataloglist.setCategoryName(precategoryName);
//                catalogMService.setCataloglistnew(cataloglist);

                    boolean iswriteDB= catalogMService.writeCatalogNew(cataloglist, bookID, precategoryName);

                    if(iswriteDB){
                        ResultInfo resultInfo = new ResultInfo();
                        resultInfo.setFlag(true);
                        resultInfo.setData(cataloglist);
                        resultInfo.setErrorMsg("编目成功");
                        HashMap<String , Object> map = new HashMap<>();
                        map.put("resultInfo", resultInfo);
                        map.put("BianmuBookID", bookID);
                        if(resultInfo.isFlag()){
                            CatalogMService.addCatalog(cataloglist);
                        }
                        ObjectMapper objectMapper = new ObjectMapper();
                        String json = objectMapper.writeValueAsString(map);
                        PrintWriter out = response.getWriter();
                        out.print(json);
                        out.flush();
                        out.close();
                        System.out.println("I am a CatalogOneBook");
                    }
                }

                break;
        }

    }
    @Override
    protected void doPost (HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException
    {
            doGet(request, response);
    }


    public String processCatalogInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        CatalogMService catalogMService = new CatalogMService();
        Cataloglist cataloglist = catalogMService.getCatalogInfoWithFallback();

        ResultInfo resultInfo = new ResultInfo();
        if (cataloglist != null) {
            resultInfo.setFlag(true);
            resultInfo.setData(cataloglist);
            session.setAttribute("readyConfirmBook", cataloglist);
            // 判断是否已经编目
            if (cataloglist.getBookID() != null && !cataloglist.getBookID().equals("")) {
                resultInfo.setErrorMsg("haveBookID");

                session.setAttribute("BianmuBookID", cataloglist.getBookID());
            } else {
                resultInfo.setErrorMsg("noBookID");
            }

            // 放入requst


        } else {
            resultInfo.setFlag(false);
            resultInfo.setErrorMsg("书籍已经全部编目，无待编目书籍");
        }



        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = new HashMap<>();

        map.put("resultInfo", resultInfo);
        if(cataloglist != null) {
            map.put("categoryIndex", ZhongTu.strToidx(cataloglist.getCategoryName()));
        }
        if(resultInfo.getErrorMsg().equals("haveBookID")){
            map.put("BianmuBookID", session.getAttribute("BianmuBookID"));
        }
        else{

        }


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
        return json;
    }

    public void editCatalogInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求中获取参数
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String ISBN = request.getParameter("isbn");
        String publicationDate = request.getParameter("publicationDate");
        String publisher = request.getParameter("publisher");
        String edition = request.getParameter("edition");
        String supplier = request.getParameter("supplier");
        String currencyID = request.getParameter("currencyID");
        if(currencyID == null || currencyID.equals("")){currencyID="0";}
        String price = request.getParameter("price");
        String bookNum = request.getParameter("bookNum");
        String documentType = request.getParameter("documentType");
//        String categoryName = request.getParameter("categoryName");
        String orderPerson = request.getParameter("orderPerson");

        String precategoryName = request.getParameter("categoryName");
        //只取前面的几位
        String categoryName = precategoryName.replaceAll("[^A-Za-z0-9]", "");
        String bookID = categoryName + ISBN;

        // 创建 Cataloglist 对象
        Cataloglist newCataloglist = new Cataloglist(bookID,title,author,ISBN, LocalDate.parse(publicationDate),publisher,edition,supplier, Integer.parseInt(currencyID),Double.valueOf(price),orderPerson, Integer.parseInt(bookNum),DocumentType.valueOf(documentType),precategoryName);
        // 使用 CataloglistDao 保存数据
        CatalogMDao cataloglistDao = new CatalogMDao();
        boolean success = cataloglistDao.updateCataloglist(newCataloglist);

        if (success) {
            ResultInfo resultInfo = new ResultInfo();
            resultInfo.setFlag(true);
            resultInfo.setErrorMsg("修改成功！");
            resultInfo.setData(newCataloglist);
            HashMap<String,Object> map = new HashMap<>();
            map.put("resultInfo",resultInfo);
            map.put("BianmuBookID", bookID);
            // 格式化 LocalDate 为 "yyyy-MM-dd"
            String formattedDate = newCataloglist.getPublicationDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            // 更新 JSON 中的 publicationDate 字段
            map.put("publicationDate", formattedDate);
            // 对应中图分类表
            map.put("categoryIndex", ZhongTu.strToidx(newCataloglist.getCategoryName()));


            ObjectMapper objectMapper = new ObjectMapper();
            String json = objectMapper.writeValueAsString(map);

            Writer writer = response.getWriter();
            writer.write(json);
            writer.flush();
            writer.close();
        } else {
            ResultInfo resultInfo = new ResultInfo();
            resultInfo.setFlag(false);
            resultInfo.setErrorMsg("修改成功！");

            HashMap<String,Object> map = new HashMap<>();
            map.put("resultInfo",resultInfo);
            // 对应中图分类表
            map.put("categoryIndex", ZhongTu.strToidx(newCataloglist.getCategoryName()));


            ObjectMapper objectMapper = new ObjectMapper();
            String json = objectMapper.writeValueAsString(map);

            Writer writer = response.getWriter();
            writer.write(json);
            writer.flush();
            writer.close();
        }
    }
    
    public void lookCatalogInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应的编码格式
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 获取传递的 isbn 参数
        String ISBN = request.getParameter("ISBN");
        ResultInfo resultInfo = new ResultInfo();

        HashMap<String,Object> map = new HashMap<>();
        ObjectMapper objectMapper = new ObjectMapper();

        if (ISBN != null && !ISBN.isEmpty()) {
            // 通过 isbn 从数据库中查询该读者的详细信息
            CatalogMDao catalogMDao = new CatalogMDao();
            Cataloglist cataloglist = catalogMDao.findDataByISBN(ISBN);

            // 如果找到该读者的信息，返回成功的 JSON 响应
            if (cataloglist != null) {
                resultInfo.setFlag(true);
                resultInfo.setData(cataloglist);
                resultInfo.setErrorMsg("查询成功");
                map.put("selectIndex" , ZhongTu.strToidx(cataloglist.getCategoryName()));
                map.put("bookID", cataloglist.getBookID());
                String formattedDate = cataloglist.getPublicationDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                map.put("publicationDate", formattedDate);
            } else {
                resultInfo.setFlag(false);
                resultInfo.setData(cataloglist);
                resultInfo.setErrorMsg("查询失败，数据库有误");
            }
        } else {
            resultInfo.setFlag(false);
            resultInfo.setData(null);
            resultInfo.setErrorMsg("传参失败，服务器异常，请重试");
        }


        map.put("resultInfo", resultInfo);
        String json = objectMapper.writeValueAsString(map);
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
        out.close();

    }
    
    
    public void changePage(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException{
        // 分页处理
        CatalogMService catalogMService = new CatalogMService();
        // 当前页面
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        // 获取总记录数
        int totalbook = catalogMService.getCurrentListBookNum();
        int totalPage = (int)Math.ceil(totalbook / (double)PAGE_SIZE);
        // 边界检测
        if (currentPage > totalPage)
            currentPage = totalPage;
        if (currentPage < 1)
            currentPage = 1;
        // 获取当前页的数据
        List<Cataloglist> cataloglist = null;
        cataloglist  = CatalogMService.getCurrentPage(currentPage);
        // 传给前端
        request.setAttribute("Cataloglist", cataloglist);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    public void searchBook(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
        CatalogMService catalogMService = new CatalogMService();
        String searchField = request.getParameter("searchField");
        String searchValue = request.getParameter("searchValue");
        List<Cataloglist> cataloglist = null;
        // 搜索条件不为空
        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty())
        {
            cataloglist=catalogMService.getSelectBook(searchField,searchValue);
        }
        else { // 搜索条件为空
            catalogMService.getTotalBookNum();
        }

        changePage(request,response);
    }
}
