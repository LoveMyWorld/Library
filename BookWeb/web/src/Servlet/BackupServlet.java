package Servlet;

import Dao.BackupDao;
import Service.BackupService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;


import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(
        name = "BackupServlet",
        value = {"/BackupServlet"}
)
public class BackupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取表单数据
        String tableName = request.getParameter("backupTable");
        String backupReason = request.getParameter("backupReason");
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

        // 返回备份路径和编号，使用“|”分隔
        response.setContentType("text/plain");
        if (backupSuccess) {
            response.getWriter().write(backupFilePath + "|" + backupId); // 返回路径和编号
        } else {
            response.getWriter().write("备份失败");
        }
    }

    private int getTableIndex(String tableName) {
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

//    private String getRealTableName(String tableName) {
//        switch (tableName) {
//            case "图书流通库表":
//                return "liutonglist";
//            case "读者信息表":
//                return "reader";
//            case "读者级别规则表":
//                return "rlevel_rule";
//            default:
//                return ""; // 不支持的表
//        }
//    }
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

    // 执行数据库备份操作
//    private boolean performDatabaseBackup(String tableName, String backupFilePath) {
//        Dao dao = new Dao();
//        String realTableName=getRealTableName(tableName);
//        String sql = "SELECT * FROM " + realTableName;
////        Connection conn = null;
////        Statement stmt = null;
////        ResultSet rs = null;
//
////        try {
////            // 连接到数据库
////            conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/library?useSSL=false&serverTimezone=UTC", "root1", "123456");
////            stmt = conn.createStatement();
//
//            // 根据表名查询数据并写入到备份文件
////            String realTableName=getRealTableName(tableName);
////            String query = "SELECT * FROM " + realTableName;
////            rs = stmt.executeQuery(query);
//
//            // 打开文件流进行写入
////            BufferedWriter writer = new BufferedWriter(new FileWriter(backupFilePath));
////
////            // 获取表头（列名）
////            ResultSetMetaData rsMeta = rs.getMetaData();
////            int columnCount = rsMeta.getColumnCount();
////
////            // 写入表头
////            for (int i = 1; i <= columnCount; i++) {
////                writer.write(rsMeta.getColumnLabel(i));
////                if (i < columnCount) {
////                    writer.write("\t");
////                }
////            }
////            writer.newLine();
////
////            // 写入数据行
////            while (rs.next()) {
////                for (int i = 1; i <= columnCount; i++) {
////                    writer.write(rs.getString(i));
////                    if (i < columnCount) {
////                        writer.write("\t");
////                    }
////                }
////                writer.newLine();
////            }
////
////            writer.close();
////            return true;
//
////        } catch (IOException | SQLException e) {
////            e.printStackTrace();
////            return false;
////        } finally {
////            // 关闭数据库连接
////            try {
////                if (rs != null) rs.close();
////                if (stmt != null) stmt.close();
////                if (conn != null) conn.close();
////            } catch (SQLException e) {
////                e.printStackTrace();
////            }
////        }
//
//
//        try (
//                PreparedStatement ps = dao.conn.prepareStatement(sql);
//                ResultSet rs = ps.executeQuery()) {
//            // 打开文件流进行写入
//            BufferedWriter writer = new BufferedWriter(new FileWriter(backupFilePath));
//
//            // 获取表头（列名）
//            ResultSetMetaData rsMeta = rs.getMetaData();
//            int columnCount = rsMeta.getColumnCount();
//
//            // 写入表头
//            for (int i = 1; i <= columnCount; i++) {
//                writer.write(rsMeta.getColumnLabel(i));
//                if (i < columnCount) {
//                    writer.write("\t");
//                }
//            }
//            writer.newLine();
//
//            // 写入数据行
//            while (rs.next()) {
//                for (int i = 1; i <= columnCount; i++) {
//                    writer.write(rs.getString(i));
//                    if (i < columnCount) {
//                        writer.write("\t");
//                    }
//                }
//                writer.newLine();
//            }
//
//            writer.close();
//            return true;
//
//            }
//
//            dao.AllClose();
//            return readerList;
//        }catch (SQLException e) {
//            throw new RuntimeException("查询数据失败", e);
//        }
//    }
}

