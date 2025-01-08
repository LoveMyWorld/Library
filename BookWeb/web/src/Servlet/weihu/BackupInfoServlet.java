package Servlet.weihu;

import Entity.BackupInfo;
import Service.weihu.BackupInfoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import static Servlet.YanshouServlet.PAGE_SIZE;

@WebServlet(
        name = "BackupInfoServlet",
        value = {"/BackupInfoServlet"}
)
public class BackupInfoServlet extends HttpServlet {
    //public static final int PAGE_SIZE = 16;  // 每页显示的备份信息数

    public BackupInfoServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if (page != null) {
            this.changePage(request, response);  // 分页查询
        } else {
            this.searchBackupInfo(request, response);  // 搜索功能
        }

        request.getRequestDispatcher("/weihu/backup0.jsp").forward(request, response);  // JSP页面路径根据实际情况调整
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    // 分页查询方法
    public void changePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BackupInfoService backupInfoService = new BackupInfoService();
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        int totalBackupInfo = backupInfoService.getCurrentListBackupInfoNum();  // 获取当前查询条件下的总备份信息数
        int totalPage = (int) Math.ceil((double) totalBackupInfo / (double) PAGE_SIZE);  // 计算总页数
        if (currentPage > totalPage) {
            currentPage = totalPage;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        List<BackupInfo> backupInfoList = backupInfoService.getCurrentPage(currentPage);  // 获取当前页的备份信息列表
        request.setAttribute("backupInfoList", backupInfoList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("showBackupInfoTable", true);  // 新增的标志，表示显示备份信息表
    }

    // 搜索功能方法
    public void searchBackupInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BackupInfoService backupInfoService = new BackupInfoService();
        String searchField = request.getParameter("searchField");  // 搜索字段（如：backupName）
        String searchValue = request.getParameter("searchValue");  // 搜索值（如：某个具体的备份表名）
        List<BackupInfo> backupInfoList = null;

        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
            backupInfoService.getSelectBackupInfo(searchField, searchValue);  // 根据搜索条件查询备份信息
        } else {
            backupInfoService.getTotalBackupInfoNum();  // 如果没有搜索条件，获取所有备份信息数据
        }

        this.changePage(request, response);  // 搜索后分页显示
    }
}
