package Servlet.ReturnServlet;

import Entity.BorrowBookRecord;
import Service.ReturnBookService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.List;

import static Servlet.YanshouServlet.PAGE_SIZE;


@WebServlet(name = "ReturnBookServlet", value = "/ReturnBookServlet")
public class ReturnBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if(page != null ){ // 需要进行上下页切换
            changePage(request, response);
        }
        else { // 遇到新的搜索条件，默认从第1页起。
            searchBook(request, response);
        }
        request.getRequestDispatcher("/liutong/ReturnBook.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    public void changePage(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException{
        // 分页处理
        ReturnBookService returnBookService = new ReturnBookService();
        // 当前页面
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        // 获取总记录数
        int totalbook = returnBookService.getCurrentListBookNum();
        int totalPage = (int)Math.ceil(totalbook / (double)PAGE_SIZE);
        // 边界检测
        if (currentPage > totalPage)
            currentPage = totalPage;
        if (currentPage < 1)
            currentPage = 1;
        // 获取当前页的数据
        List<BorrowBookRecord> borrowBookRecordList = null;
        borrowBookRecordList = returnBookService.getCurrentPage(currentPage);
        // 传给前端
        request.setAttribute("borrowBookRecordList", borrowBookRecordList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    public void searchBook(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
        ReturnBookService returnBookService = new ReturnBookService();
        String searchField = request.getParameter("searchField");
        String searchValue = request.getParameter("searchValue");
        List<BorrowBookRecord> borrowBookRecordList = null;
        // 搜索条件不为空
        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty())
        {
            borrowBookRecordList=returnBookService.getSelectBook(searchField,searchValue);
        }
        else { // 搜索条件为空
            returnBookService.getTotalBookNum();
        }

        changePage(request,response);
    }
}
