package Servlet.Catalog;
import Entity.DamageList;
import Service.Catalog.DamageService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.List;

import static Servlet.Catalog.YanshouServlet.PAGE_SIZE;

@WebServlet( name = "DamageServlet" , value = "/DamageServlet")
public class DamageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if(page != null ){ // 需要进行上下页切换
            changePage(request, response);
        }
        else { // 遇到新的搜索条件，默认从第1页起。
            searchBook(request, response);
        }
        request.getRequestDispatcher("/bianmu/damage.jsp").forward(request, response);
    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doGet(request, response);
    }

    public void changePage(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException{
        // 分页处理
        DamageService damageService = new DamageService();
        // 当前页面
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        // 获取总记录数
        int totalbook = damageService.getCurrentListBookNum();
        int totalPage = (int)Math.ceil(totalbook / (double)PAGE_SIZE);
        // 边界检测
        if (currentPage > totalPage)
            currentPage = totalPage;
        if (currentPage < 1)
            currentPage = 1;
        // 获取当前页的数据
        List<DamageList> DamageList = null;
        DamageList = damageService.getCurrentPage(currentPage);
        // 传给前端
        request.setAttribute("damageLists", DamageList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    public void searchBook(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
        DamageService damageService = new DamageService();
        String searchField = request.getParameter("searchField");
        String searchValue = request.getParameter("searchValue");
        List<DamageList> DamageList = null;
        // 搜索条件不为空
        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty())
        {
            DamageList=damageService.getSelectBook(searchField,searchValue);
        }
        else { // 搜索条件为空
            damageService.getTotalBookNum();
        }

        changePage(request,response);
    }
}
