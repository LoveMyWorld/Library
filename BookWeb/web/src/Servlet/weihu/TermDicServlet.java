package Servlet.weihu;

import Entity.TermDic;
import Service.weihu.TermDicService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(
        name = "TermDicServlet",
        value = {"/TermDicServlet"}
)
public class TermDicServlet extends HttpServlet {
    public static final int PAGE_SIZE = 16;  // 每页显示的读者数

    public TermDicServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if (page != null) {
            this.changePage(request, response);  // 分页查询
        } else {
            this.searchTermDic(request, response);  // 搜索功能
        }

        request.getRequestDispatcher("/weihu/termdic.jsp").forward(request, response);
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    // 分页查询方法
    public void changePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TermDicService termDicService = new TermDicService();
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        int totalTermDic = termDicService.getCurrentListTermDicNum();  // 获取当前查询条件下的总读者数
        int totalPage = (int) Math.ceil((double) totalTermDic / (double) PAGE_SIZE);  // 计算总页数
        if (currentPage > totalPage) {
            currentPage = totalPage;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        List<TermDic> termDicList = termDicService.getCurrentPage(currentPage);  // 获取当前页的读者列表
        request.setAttribute("termDicList", termDicList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    // 搜索功能方法
    public void searchTermDic(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TermDicService termDicService = new TermDicService();
        String searchField = request.getParameter("searchField");  // 搜索字段（如：readID、name、termDicLevel）
        String searchValue = request.getParameter("searchValue");  // 搜索值（如：某个具体的ID、名字等）
        List<TermDic> termDicList = null;

        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
            termDicService.getSelectTermDic(searchField, searchValue);  // 根据搜索条件查询读者
        } else {
            termDicService.getTotalTermDicNum();  // 如果没有搜索条件，获取所有读者数据
        }

        this.changePage(request, response);  // 搜索后分页显示
    }
}
