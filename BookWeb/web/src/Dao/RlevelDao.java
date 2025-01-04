package Dao;

import Entity.ReaderLevelType;
import Entity.Rlevel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RlevelDao {
    public RlevelDao() {}

    // 查询所有的读者级别规则
    public List<Rlevel> getAllRlevels() {
        Dao dao = new Dao();
        List<Rlevel> rlevelList = new ArrayList<>(); // 用于存储查询结果
        String sql = "SELECT * FROM library.rlevel_rule"; // 查询所有规则

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // 构造 Rlevel 对象并加入列表
                Rlevel rlevel = new Rlevel(
                        ReaderLevelType.fromDescription(rs.getString("readerLevel")), // 枚举类型转换
                        rs.getString("creditPointRange"),
                        rs.getInt("borrowNum"),
                        rs.getInt("borrowDay"),
                        rs.getInt("orderNum"),
                        rs.getInt("orderDay"),
                        rs.getFloat("fineEveryday")
                );
                rlevelList.add(rlevel);
            }

            dao.AllClose();
            return rlevelList; // 返回查询结果列表
        } catch (SQLException e) {
            throw new RuntimeException("查询所有读者级别规则失败", e);
        }
    }

    // 根据 readerLevel 查询对应的规则
    public List<Rlevel> getRlevelBySearch(String searchField, String searchValue) {
        Dao dao = new Dao();
        List<Rlevel> rlevelList = new ArrayList<>(); // 查询结果
        String sql = " "; // 表名为 rlevel_rule

        if (searchField.equals("readerLevel")) {
            sql = "SELECT * FROM library.rlevel_rule WHERE readerLevel = ?";
        }
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1,  searchValue ); // 使用 readerLevel 的字符串形式作为查询条件
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // 构造 Rlevel 对象
                Rlevel rlevel = new Rlevel(
                        ReaderLevelType.fromDescription(rs.getString("readerLevel")), // 枚举类型转换
                        rs.getString("creditPointRange"),
                        rs.getInt("borrowNum"),
                        rs.getInt("borrowDay"),
                        rs.getInt("orderNum"),
                        rs.getInt("orderDay"),
                        rs.getFloat("fineEveryday")
                );
                rlevelList.add(rlevel);
            }

            dao.AllClose();
            return rlevelList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询读者级别规则失败", e);
        }
    }
}
