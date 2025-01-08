package Servlet;

import Entity.Rlevel;
import Service.RlevelService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import static Servlet.Catalog.YanshouServlet.PAGE_SIZE;

@WebServlet(
        name = "RlevelServlet",
        value = {"/RlevelServlet"}
)
public class RlevelServlet extends HttpServlet {
//    public static final int PAGE_SIZE = 16;  // 每页显示的规则数

    public RlevelServlet() {}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if (page != null) {
            this.changePage(request, response);  // 分页查询
        } else {
            this.searchRlevel(request, response);  // 搜索功能
        }

        request.getRequestDispatcher("/yonghu/rlevel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    // 分页查询方法
    public void changePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RlevelService rlevelService = new RlevelService();
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        int totalRlevel = rlevelService.getCurrentListRlevelNum();  // 获取当前查询条件下的总规则数
        int totalPage = (int) Math.ceil((double) totalRlevel / (double) PAGE_SIZE);  // 计算总页数
        if (currentPage > totalPage) {
            currentPage = totalPage;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        List<Rlevel> rlevelList = rlevelService.getCurrentPage(currentPage);  // 获取当前页的规则列表
        request.setAttribute("rlevelList", rlevelList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    // 搜索功能方法
    public void searchRlevel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RlevelService rlevelService = new RlevelService();
        String searchField = request.getParameter("searchField");  // 搜索字段（如：readerLevel）
        String searchValue = request.getParameter("searchValue");  // 搜索值（如：具体级别描述）
        List<Rlevel> rlevelList = null;

        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
            rlevelList = rlevelService.getSelectRlevel(searchField, searchValue);  // 根据搜索条件查询规则
        } else {
            rlevelService.getTotalRlevelNum();  // 如果没有搜索条件，加载所有规则
        }

        this.changePage(request, response);  // 搜索后分页显示
    }
}
