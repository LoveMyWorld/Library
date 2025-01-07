package Dao;

import Entity.Announcement;
import Entity.Message;


import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class MessageDao {



    public List<Message> getAllData() {
        Dao dao = new Dao();
        List<Message> messageList = new ArrayList<>();     // 用于存储查询结果
        String sql = "SELECT * FROM   library.message"; // 查询表中的所有数据

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 Announcement 对象并添加到列表
            while (rs.next()) {
               Message message = new Message();
               message.setMessageID(rs.getInt("messageID"));
               message.setPublisher(rs.getString("publisher"));
               message.setMessageText(rs.getString("messageText")
               );


                // 根据 Announcement 类的字段继续添加赋值逻辑
                messageList.add(message); // 将对象添加到列表
            }
            dao.AllClose();
            return messageList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }


}
