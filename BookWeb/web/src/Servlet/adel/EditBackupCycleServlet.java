package Servlet.adel;


import Dao.BackupCycleDao;
import Entity.BackupCycle;
import Entity.BackupNameType;
import Entity.ResultInfo;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;

@WebServlet("/EditBackupCycleServlet")
public class EditBackupCycleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求中获取参数
        String backupName = request.getParameter("backupName");
        String backupCycle = request.getParameter("backupCycle");
        String backupLoc = request.getParameter("backupLoc");
        String operator = request.getParameter("operator");

        // 创建 BackupCycle 对象
        BackupCycle newBackupCycle = new BackupCycle(BackupNameType.fromDescription(backupName), Integer.parseInt(backupCycle), backupLoc, operator);
        // 使用 BackupCycleDao 保存数据
        BackupCycleDao backupCycleDao = new BackupCycleDao();
        boolean success = backupCycleDao.updateBackupCycle(newBackupCycle);

        if (success) {
            ResultInfo resultInfo = new ResultInfo();
            resultInfo.setFlag(true);
            resultInfo.setErrorMsg("提交成功！");
            resultInfo.setData(newBackupCycle);
            HashMap<String,Object> map = new HashMap<>();
            map.put("resultInfo",resultInfo);

            ObjectMapper objectMapper = new ObjectMapper();
            String json = objectMapper.writeValueAsString(map);

            Writer writer = response.getWriter();
            writer.write(json);
            writer.flush();
            writer.close();
        } else {
            response.getWriter().write("Failed");
        }
    }
}
