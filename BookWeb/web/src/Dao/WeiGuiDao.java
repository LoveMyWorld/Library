package Dao;

import Entity.WeiGui;

import java.sql.*;

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
}

