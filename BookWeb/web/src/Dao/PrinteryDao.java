package Dao;

import Entity.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PrinteryDao {
    public PrinteryDao() {
    }

    public List<Printery> getAllPrinterys() {
        Dao dao = new Dao();
        List<Printery> printeryList = new ArrayList<>();
        String sql = "SELECT * FROM library.printery"; // 表名是printery
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Printery printery = new Printery();
                printery.setName(rs.getString("name"));
                printery.setAddr(rs.getString("addr"));
                printery.setPlace(rs.getString("place"));
                printeryList.add(printery);
            }

            dao.AllClose();
            return printeryList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    public List<Printery> findPrinterysBySearch(String searchField, String searchValue) {
        Dao dao = new Dao();
        List<Printery> printeryList = new ArrayList<>();
        String sql = "";

        // 根据 searchField 决定查询条件
        if (searchField.equals("name")) {
            sql = "SELECT * FROM library.printery WHERE name LIKE ?";
        }else if (searchField.equals("addr")) {
            sql = "SELECT * FROM library.printery WHERE addr LIKE ?";
        }

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%" + searchValue + "%");  // 使用模糊匹配
            ResultSet rs = ps.executeQuery();

            // 遍历查询结果，构建 Printery 对象列表
            while (rs.next()) {
                Printery printery = new Printery();
                printery.setName(rs.getString("name"));
                printery.setAddr(rs.getString("addr"));
                printery.setPlace(rs.getString("contact"));
                printeryList.add(printery);
            }

            dao.AllClose();
            return printeryList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    // 添加
    public boolean addPrintery(Printery printery) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.printery (name, addr, place) " +
                "VALUES (?, ?, ?)";
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, printery.getName());
            ps.setString(2, printery.getAddr());
            ps.setString(3, printery.getPlace());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {

            throw new RuntimeException("添加印刷厂信息失败", e);
        }
    }

    // 查看
    public Printery getPrinteryByName(String name) {
        Dao dao = new Dao();
        Printery printery = new Printery();
        String sql = "SELECT * FROM library.printery WHERE name = ? LIMIT 1";
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                printery.setName(rs.getString("name"));
                printery.setAddr(rs.getString("addr"));
                printery.setPlace(rs.getString("place"));

            }
            dao.AllClose();
            return printery; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查看数据失败", e);
        }
    }

    // 更新
    public boolean updatePrintery(Printery printery) {
        Dao dao = new Dao();
        String sql = "UPDATE library.printery SET " +
                "addr = ?, place = ? " +
                "WHERE name = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, printery.getAddr());
            ps.setString(2, printery.getPlace());
            ps.setString(3, printery.getName());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {
            throw new RuntimeException("修改印刷厂信息数据失败", e);
        }
    }

    // 删除
    public boolean deletePrintery(String name) {
        Dao dao = new Dao();
        String sql = "DELETE FROM library.printery WHERE name = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {
            ps.setString(1, name);  // 设置要删除的读者ID

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;  // 如果删除的行数大于0，表示删除成功
        } catch (SQLException e) {
            throw new RuntimeException("删除印刷厂信息数据失败", e);
        }
    }
}
