package Servlet;

import Entity.BackupCycle;
import Service.BackupCycleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import static Servlet.YanshouServlet.PAGE_SIZE;

@WebServlet(
        name = "BackupCycleServlet",
        value = {"/BackupCycleServlet"}
)
public class BackupCycleServlet extends HttpServlet {
    //public static final int PAGE_SIZE = 16;  // 每页显示的备份周期数

    public BackupCycleServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if (page != null) {
            this.changePage(request, response);  // 分页查询
        } else {
            this.searchBackupCycle(request, response);  // 搜索功能
        }

        request.getRequestDispatcher("/weihu/backup0.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    // 分页查询方法
    public void changePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BackupCycleService backupCycleService = new BackupCycleService();
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        int totalBackupCycle = backupCycleService.getCurrentListBackupCycleNum();  // 获取当前查询条件下的总备份周期数
        int totalPage = (int) Math.ceil((double) totalBackupCycle / (double) PAGE_SIZE);  // 计算总页数
        if (currentPage > totalPage) {
            currentPage = totalPage;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        List<BackupCycle> backupCycleList = backupCycleService.getCurrentPage(currentPage);  // 获取当前页的备份周期列表
        request.setAttribute("backupCycleList", backupCycleList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("showBackupCycleTable", true);  // 新增的标志，表示显示备份周期表
    }

    // 搜索功能方法
    public void searchBackupCycle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BackupCycleService backupCycleService = new BackupCycleService();
        String searchField = request.getParameter("searchField");  // 搜索字段（如：backupName）
        String searchValue = request.getParameter("searchValue");  // 搜索值（如：某个具体的备份表名）
        List<BackupCycle> backupCycleList = null;

        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
            backupCycleService.getSelectBackupCycle(searchField, searchValue);  // 根据搜索条件查询备份周期
        } else {
            backupCycleService.getTotalBackupCycleNum();  // 如果没有搜索条件，获取所有备份周期数据
        }

        this.changePage(request, response);  // 搜索后分页显示
    }
}
