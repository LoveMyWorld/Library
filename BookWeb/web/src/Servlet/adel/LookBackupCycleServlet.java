package Servlet.adel;

import Dao.BackupCycleDao;
import Entity.BackupCycle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;

@WebServlet("/LookBackupCycleServlet")
public class LookBackupCycleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应的编码格式
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 获取传递的 readID 参数
        String backupName = request.getParameter("backupName");

        if (backupName != null && !backupName.isEmpty()) {
            // 通过 readID 从数据库中查询该读者的详细信息
            BackupCycleDao backupCycleDao = new BackupCycleDao();
            BackupCycle backupCycle1 = backupCycleDao.getBackupCycleByName(backupName);

            // 如果找到该读者的信息，返回成功的 JSON 响应
            if (backupCycle1 != null) {
                // 创建一个包含读者详细信息的 JSON 对象
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", true);
                jsonResponse.put("data", new JSONObject()
                        .put("backupName", backupCycle1.getBackupName().getDescription())
                        .put("backupCycle", backupCycle1.getBackupCycle())
                        .put("backupLoc", backupCycle1.getBackupLoc())
                        .put("operator", backupCycle1.getOperator()));

                // 返回响应
                response.getWriter().write(jsonResponse.toString());
            } else {
                // 如果没有找到该读者信息，返回错误的 JSON 响应
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", false);
                jsonResponse.put("message", "未找到该备份周期信息");
                response.getWriter().write(jsonResponse.toString());
            }
        } else {
            // 如果没有传递 backupCycleID，返回错误的 JSON 响应
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "缺少备份表名");
            response.getWriter().write(jsonResponse.toString());
        }
    }
}