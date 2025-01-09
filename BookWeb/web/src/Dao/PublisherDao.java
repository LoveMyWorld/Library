package Dao;

import Entity.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PublisherDao {
    public PublisherDao() {
    }

    public List<Publisher> getAllPublishers() {
        Dao dao = new Dao();
        List<Publisher> publisherList = new ArrayList<>();
        String sql = "SELECT * FROM library.publisher"; // 表名是publisher
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Publisher publisher = new Publisher();
                publisher.setName(rs.getString("name"));
                publisher.setAddr(rs.getString("addr"));
                publisher.setContact(rs.getString("contact"));
                publisher.setPhoneNum(rs.getString("PhoneNum"));
                publisher.setPostcode(rs.getString("postcode"));
                publisherList.add(publisher);
            }

            dao.AllClose();
            return publisherList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    public List<Publisher> findPublishersBySearch(String searchField, String searchValue) {
        Dao dao = new Dao();
        List<Publisher> publisherList = new ArrayList<>();
        String sql = "";

        // 根据 searchField 决定查询条件
        if (searchField.equals("name")) {
            sql = "SELECT * FROM library.publisher WHERE name LIKE ?";
        }else if (searchField.equals("addr")) {
            sql = "SELECT * FROM library.publisher WHERE addr LIKE ?";
        }

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%" + searchValue + "%");  // 使用模糊匹配
            ResultSet rs = ps.executeQuery();

            // 遍历查询结果，构建 Publisher 对象列表
            while (rs.next()) {
                Publisher publisher = new Publisher();
                publisher.setName(rs.getString("name"));
                publisher.setAddr(rs.getString("addr"));
                publisher.setContact(rs.getString("contact"));
                publisher.setPhoneNum(rs.getString("PhoneNum"));
                publisher.setPostcode(rs.getString("postcode"));
                publisherList.add(publisher);
            }

            dao.AllClose();
            return publisherList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    // 添加
    public boolean addPublisher(Publisher publisher) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.publisher (name, addr, contact, phoneNum, postcode) " +
                "VALUES (?, ?, ?, ?, ?)";
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, publisher.getName());
            ps.setString(2, publisher.getAddr());
            ps.setString(3, publisher.getContact());
            ps.setString(4, publisher.getPhoneNum());
            ps.setString(5, publisher.getPostcode());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {

            throw new RuntimeException("添加书商信息失败", e);
        }
    }

    // 查看
    public Publisher getPublisherByName(String name) {
        Dao dao = new Dao();
        Publisher publisher = new Publisher();
        String sql = "SELECT * FROM library.publisher WHERE name = ? LIMIT 1";
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                publisher.setName(rs.getString("name"));
                publisher.setAddr(rs.getString("addr"));
                publisher.setContact(rs.getString("contact"));
                publisher.setPhoneNum(rs.getString("phoneNum"));
                publisher.setPostcode(rs.getString("postcode"));

            }
            dao.AllClose();
            return publisher; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查看数据失败", e);
        }
    }

    // 更新
    public boolean updatePublisher(Publisher publisher) {
        Dao dao = new Dao();
        String sql = "UPDATE library.publisher SET " +
                "addr = ?, contact = ?, phoneNum = ?, postcode = ? " +
                "WHERE name = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, publisher.getAddr());
            ps.setString(2, publisher.getContact());
            ps.setString(3, publisher.getPhoneNum());
            ps.setString(4, publisher.getPostcode());
            ps.setString(5, publisher.getName());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {
            throw new RuntimeException("修改书商信息数据失败", e);
        }
    }

    // 删除
    public boolean deletePublisher(String name) {
        Dao dao = new Dao();
        String sql = "DELETE FROM library.publisher WHERE name = ?";
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
