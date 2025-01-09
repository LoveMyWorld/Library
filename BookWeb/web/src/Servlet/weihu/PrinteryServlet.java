package Servlet.weihu;

import Entity.Printery;
import Service.weihu.PrinteryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import static Servlet.Catalog.YanshouServlet.PAGE_SIZE;

@WebServlet(
        name = "PrinteryServlet",
        value = {"/PrinteryServlet"}
)
public class PrinteryServlet extends HttpServlet {
    //public static final int PAGE_SIZE = 16;  // 每页显示的读者数

    public PrinteryServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if (page != null) {
            this.changePage(request, response);  // 分页查询
        } else {
            this.searchPrintery(request, response);  // 搜索功能
        }

        request.getRequestDispatcher("/weihu/printery.jsp").forward(request, response);
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    // 分页查询方法
    public void changePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrinteryService printeryService = new PrinteryService();
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        int totalPrintery = printeryService.getCurrentListPrinteryNum();  // 获取当前查询条件下的总读者数
        int totalPage = (int) Math.ceil((double) totalPrintery / (double) PAGE_SIZE);  // 计算总页数
        if (currentPage > totalPage) {
            currentPage = totalPage;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        List<Printery> printeryList = printeryService.getCurrentPage(currentPage);  // 获取当前页的读者列表
        request.setAttribute("printeryList", printeryList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    // 搜索功能方法
    public void searchPrintery(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrinteryService printeryService = new PrinteryService();
        String searchField = request.getParameter("searchField");  // 搜索字段（如：readID、name、printeryLevel）
        String searchValue = request.getParameter("searchValue");  // 搜索值（如：某个具体的ID、名字等）
        List<Printery> printeryList = null;

        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
            printeryService.getSelectPrintery(searchField, searchValue);  // 根据搜索条件查询读者
        } else {
            printeryService.getTotalPrinteryNum();  // 如果没有搜索条件，获取所有读者数据
        }

        this.changePage(request, response);  // 搜索后分页显示
    }
}
