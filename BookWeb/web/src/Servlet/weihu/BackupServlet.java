package Servlet.weihu;

import Dao.BackupDao;
import Service.BackupService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;


import java.io.IOException;
import java.sql.*;

@WebServlet(
        name = "BackupServlet",
        value = {"/BackupServlet"}
)
public class BackupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取表单数据
        String tableName = request.getParameter("backupTable");
        String backupReason = request.getParameter("backup-reason");
        String operator = request.getParameter("operator");

        // 获取 Web 应用的绝对路径
        String webAppPath = getServletContext().getRealPath("");

        // 获取用户选择的表和其他信息
        int tableIndex = getTableIndex(tableName);

        // 生成备份路径
        String backupFilePath;
        try {
            backupFilePath = BackupService.generateBackupPath(tableName, webAppPath, tableIndex);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("备份失败: " + e.getMessage());
            return;
        }

        // 生成备份编号
        String backupId = BackupService.generateBackupId(tableIndex);

        // 执行数据库备份操作
        boolean backupSuccess = BackupDao.performDatabaseBackup(tableName, backupFilePath);

        // 将备份信息插入数据库
        if (backupSuccess) {
            // 插入到数据库
            try {
                BackupDao.insertBackupInfo(backupId, tableName, backupFilePath, backupReason, operator);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        // 返回备份路径和编号，使用“|”分隔
        response.setContentType("text/plain");
        if (backupSuccess) {
            response.getWriter().write(backupFilePath + "|" + backupId); // 返回路径和编号
        } else {
            response.getWriter().write("备份失败");
        }
    }

    private int getTableIndex(String tableName) {
//        if(tableName.equals("图书流通库表")) {
//            return 0;
//        }else if(tableName.equals("读者信息表")){
//            return 1;
//        }else if(tableName.equals("读者级别规则表")){
//            return 2;
//        }else{
//            return -1;
//        }
        switch (tableName) {
            case "图书流通库表":
                return 0;
            case "读者信息表":
                return 1;
            case "读者级别规则表":
                return 2;
            default:
                return -1; // 不支持的表
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取 Web 应用的绝对路径
        String webAppPath = getServletContext().getRealPath("");

        // 获取用户选择的表名
        String tableName = request.getParameter("tableName");
        int tableIndex = getTableIndex(tableName);

        // 生成备份路径
        String backupFilePath;
        try {
            backupFilePath = BackupService.generateBackupPath(tableName, webAppPath, tableIndex);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("生成备份路径失败");
            return;
        }

        // 返回备份路径给前端
        response.setContentType("text/plain");
        response.getWriter().print(backupFilePath);
    }


}

