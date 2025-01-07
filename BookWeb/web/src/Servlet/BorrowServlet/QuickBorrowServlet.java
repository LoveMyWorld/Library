package Servlet.BorrowServlet;

import Entity.Appointment;
import Service.AppointmentService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import static Servlet.YanshouServlet.PAGE_SIZE;

@WebServlet(name = "QuickBorrowServlet", value = "/QuickBorrowServlet")
public class QuickBorrowServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
//        String path = request.getServletPath();
//        if (path.equals("/QuickBorrowServlet")) {
            //把预约表搞出来
            String page = request.getParameter("currentPage");
            if (page != null) { // 需要进行上下页切换
                changePage(request, response);
            } else { // 遇到新的搜索条件，默认从第1页起
                searchBook(request, response);
            }


        request.getRequestDispatcher("/liutong/QuickBorrow.jsp").forward(request, response);
//        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    public void changePage(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException{
        // 分页处理
        AppointmentService appointmentService = new AppointmentService();
        // 当前页面
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        // 获取总记录数
        int totalbook = appointmentService.getCurrentListBookNum();
        int totalPage = (int)Math.ceil(totalbook / (double)PAGE_SIZE);
        // 边界检测
        if (currentPage > totalPage)
            currentPage = totalPage;
        if (currentPage < 1)
            currentPage = 1;
        // 获取当前页的数据
        List<Appointment> appointmentList = null;
        appointmentList = appointmentService.getCurrentPage(currentPage);
        // 传给前端
        request.setAttribute("appointmentList", appointmentList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    public void searchBook(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
        AppointmentService appointmentService = new AppointmentService();
        String searchField = request.getParameter("searchField");
        String searchValue = request.getParameter("searchValue");
        List<Appointment> appointmentList = null;
        // 搜索条件不为空
        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty())
        {
            appointmentList=appointmentService.getSelectBook(searchField,searchValue);
        }
        else { // 搜索条件为空
            appointmentService.getTotalBookNum();
        }

        changePage(request,response);
    }

}
