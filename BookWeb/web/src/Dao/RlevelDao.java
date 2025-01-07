package Dao;

import Entity.Gender;
import Entity.Reader;
import Entity.ReaderLevelType;
import Entity.Rlevel;

import java.sql.Date;
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

    // 添加
    public boolean addRlevel(Rlevel rlevel) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.rlevel_rule (readerLevel, creditPointRange, borrowNum, borrowDay, orderNum, orderDay, fineEveryday) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, rlevel.getReaderLevel().getDescription());
            ps.setString(2, rlevel.getCreditPointRange());
            ps.setInt(3, rlevel.getBorrowNum());
            ps.setInt(4, rlevel.getBorrowDay());
            ps.setInt(5, rlevel.getOrderNum());
            ps.setInt(6, rlevel.getOrderDay());
            ps.setFloat(7, rlevel.getFineEveryday());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {

            throw new RuntimeException("添加读者级别规则失败", e);
        }
    }

    // 查看
    public Rlevel getRlevelByRlevel(String readerLevel) {
        Dao dao = new Dao();
        Rlevel rlevel = new Rlevel();
        String sql = "SELECT * FROM library.rlevel_rule WHERE readerLevel = ? LIMIT 1";
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, readerLevel);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String rt = rs.getString("readerLevel");
                rlevel.setReaderLevel(ReaderLevelType.fromDescription(rt));
                rlevel.setCreditPointRange(rs.getString("creditPointRange"));
                rlevel.setBorrowNum(rs.getInt("borrowNum"));
                rlevel.setBorrowDay(rs.getInt("borrowDay"));
                rlevel.setOrderNum(rs.getInt("orderNum"));
                rlevel.setOrderDay(rs.getInt("orderDay"));
                rlevel.setFineEveryday(rs.getFloat("fineEveryday"));
            }
            dao.AllClose();
            return rlevel; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查看数据失败", e);
        }
    }

    // 更新
    public boolean updateRlevel(Rlevel rlevel) {
        Dao dao = new Dao();
        String sql = "UPDATE library.rlevel_rule SET " +
                "creditPointRange = ?, borrowNum = ?, borrowDay = ?, orderNum = ?, orderDay = ?, fineEveryday = ? " +
                "WHERE readerLevel = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, rlevel.getCreditPointRange());
            ps.setInt(2, rlevel.getBorrowNum());
            ps.setInt(3, rlevel.getBorrowDay());
            ps.setInt(4, rlevel.getOrderNum());
            ps.setInt(5, rlevel.getOrderDay());
            ps.setFloat(6, rlevel.getFineEveryday());
            ps.setString(7, rlevel.getReaderLevel().getDescription());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {
            throw new RuntimeException("修改读者信息数据失败", e);
        }
    }

    // 删除
    public boolean deleteRlevel(String readerLevel) {
        Dao dao = new Dao();
        String sql = "DELETE FROM library.rlevel_rule WHERE readerLevel = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {
            ps.setString(1, readerLevel);  // 设置要删除的读者ID

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;  // 如果删除的行数大于0，表示删除成功
        } catch (SQLException e) {
            throw new RuntimeException("删除读者信息数据失败", e);
        }
    }
}
