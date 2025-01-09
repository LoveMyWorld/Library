package Dao;

import Entity.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookmanDao {
    public BookmanDao() {
    }

    public List<Bookman> getAllBookmans() {
        Dao dao = new Dao();
        List<Bookman> bookmanList = new ArrayList<>();
        String sql = "SELECT * FROM library.bookman"; // 表名是bookman
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Bookman bookman = new Bookman();
                bookman.setName(rs.getString("name"));
                bookman.setAddr(rs.getString("addr"));
                bookman.setContact(rs.getString("contact"));
                bookman.setPhoneNum(rs.getString("PhoneNum"));
                bookman.setPostcode(rs.getString("postcode"));
                bookmanList.add(bookman);
            }

            dao.AllClose();
            return bookmanList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    public List<Bookman> findBookmansBySearch(String searchField, String searchValue) {
        Dao dao = new Dao();
        List<Bookman> bookmanList = new ArrayList<>();
        String sql = "";

        // 根据 searchField 决定查询条件
        if (searchField.equals("name")) {
            sql = "SELECT * FROM library.bookman WHERE name LIKE ?";
        }else if (searchField.equals("addr")) {
            sql = "SELECT * FROM library.bookman WHERE addr LIKE ?";
        }

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%" + searchValue + "%");  // 使用模糊匹配
            ResultSet rs = ps.executeQuery();

            // 遍历查询结果，构建 Bookman 对象列表
            while (rs.next()) {
                Bookman bookman = new Bookman();
                bookman.setName(rs.getString("name"));
                bookman.setAddr(rs.getString("addr"));
                bookman.setContact(rs.getString("contact"));
                bookman.setPhoneNum(rs.getString("PhoneNum"));
                bookman.setPostcode(rs.getString("postcode"));
                bookmanList.add(bookman);
            }

            dao.AllClose();
            return bookmanList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    // 添加
    public boolean addBookman(Bookman bookman) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.bookman (name, addr, contact, phoneNum, postcode) " +
                "VALUES (?, ?, ?, ?, ?)";
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, bookman.getName());
            ps.setString(2, bookman.getAddr());
            ps.setString(3, bookman.getContact());
            ps.setString(4, bookman.getPhoneNum());
            ps.setString(5, bookman.getPostcode());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {

            throw new RuntimeException("添加书商信息失败", e);
        }
    }

    // 查看
    public Bookman getBookmanByName(String name) {
        Dao dao = new Dao();
        Bookman bookman = new Bookman();
        String sql = "SELECT * FROM library.bookman WHERE name = ? LIMIT 1";
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bookman.setName(rs.getString("name"));
                bookman.setAddr(rs.getString("addr"));
                bookman.setContact(rs.getString("contact"));
                bookman.setPhoneNum(rs.getString("phoneNum"));
                bookman.setPostcode(rs.getString("postcode"));

            }
            dao.AllClose();
            return bookman; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查看数据失败", e);
        }
    }

    // 更新
    public boolean updateBookman(Bookman bookman) {
        Dao dao = new Dao();
        String sql = "UPDATE library.bookman SET " +
                "addr = ?, contact = ?, phoneNum = ?, postcode = ? " +
                "WHERE name = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, bookman.getAddr());
            ps.setString(2, bookman.getContact());
            ps.setString(3, bookman.getPhoneNum());
            ps.setString(4, bookman.getPostcode());
            ps.setString(5, bookman.getName());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {
            throw new RuntimeException("修改书商信息数据失败", e);
        }
    }

    // 删除
    public boolean deleteBookman(String name) {
        Dao dao = new Dao();
        String sql = "DELETE FROM library.bookman WHERE name = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {
            ps.setString(1, name);  // 设置要删除的读者ID

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;  // 如果删除的行数大于0，表示删除成功
        } catch (SQLException e) {
            throw new RuntimeException("删除书商信息数据失败", e);
        }
    }
}
