package Servlet.yonghu;

import Entity.Reader;
import Service.yonghu.ReaderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(
        name = "ReaderServlet",
        value = {"/ReaderServlet"}
)
public class ReaderServlet extends HttpServlet {
    public static final int PAGE_SIZE = 16;  // 每页显示的读者数

    public ReaderServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if (page != null) {
            this.changePage(request, response);  // 分页查询
        } else {
            this.searchReader(request, response);  // 搜索功能
        }

        request.getRequestDispatcher("/yonghu/reader.jsp").forward(request, response);
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    // 分页查询方法
    public void changePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReaderService readerService = new ReaderService();
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        int totalReader = readerService.getCurrentListReaderNum();  // 获取当前查询条件下的总读者数
        int totalPage = (int) Math.ceil((double) totalReader / (double) PAGE_SIZE);  // 计算总页数
        if (currentPage > totalPage) {
            currentPage = totalPage;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        List<Reader> readerList = readerService.getCurrentPage(currentPage);  // 获取当前页的读者列表
        request.setAttribute("readerList", readerList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    // 搜索功能方法
    public void searchReader(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReaderService readerService = new ReaderService();
        String searchField = request.getParameter("searchField");  // 搜索字段（如：readID、name、readerLevel）
        String searchValue = request.getParameter("searchValue");  // 搜索值（如：某个具体的ID、名字等）
        List<Reader> readerList = null;

        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
            readerService.getSelectReader(searchField, searchValue);  // 根据搜索条件查询读者
        } else {
            readerService.getTotalReaderNum();  // 如果没有搜索条件，获取所有读者数据
        }

        this.changePage(request, response);  // 搜索后分页显示
    }
}
