package Dao;

import Entity.Gender;
import Entity.WeiGui;
import Entity.WeiGui;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class WeiGuiDao {

    public int InsertWeiGui(WeiGui weiGui) {
        Dao dao = new Dao(); // 假设您有一个Dao类来处理数据库连接
        String sql = "INSERT INTO library.weigui (name, gender, readID, badContent) VALUES (?, ?, ?, ?)";
        int rowsAffected = 0; // 用于存储受影响的行数

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
            // 设置PreparedStatement的参数
            ps.setString(1, weiGui.getName());
            ps.setObject(2, weiGui.getGender().toString()); // 假设Gender是一个枚举类型
            ps.setString(3, weiGui.getReadID());
            ps.setString(4, weiGui.getBadContent());

            // 执行插入操作
            rowsAffected = ps.executeUpdate();

            // 如果插入成功，检索生成的主键（ID）
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        weiGui.setWeiguiID(generatedKeys.getInt(1));
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
//            return -1;
        }
        return rowsAffected;//被影响的行数
    }

    public List<WeiGui> getLastTenLines() {
        String sql ="SELECT * FROM library.weigui\n" +
                "ORDER BY    weiguiID DESC\n" +
                "LIMIT 10";

        Dao dao = new Dao();
        List<WeiGui> dataList = new ArrayList<>();
        try{
            PreparedStatement ps =dao.conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                WeiGui weigui = new WeiGui();
                weigui.setWeiguiID(rs.getInt("weiguiID"));
                weigui.setName(rs.getString("name"));
                String t = rs.getString("gender");
                weigui.setGender(Gender.fromDescription(t));
                weigui.setReadID(rs.getString("readID"));
                weigui.setBadContent(rs.getString("badContent"));




                dataList.add(weigui);

            }

            dao.AllClose();
            return dataList;



        } catch (SQLException e) {
            throw new RuntimeException(e);
        }



    }
}

