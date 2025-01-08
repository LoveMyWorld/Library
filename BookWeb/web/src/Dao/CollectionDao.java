package Dao;

import Entity.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CollectionDao {
    public CollectionDao() {
    }

    public List<Collection> getAllCollections() {
        Dao dao = new Dao();
        List<Collection> collectionList = new ArrayList<>();
        String sql = "SELECT * FROM library.collection"; // 表名是collection
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Collection collection = new Collection();
                collection.setName(rs.getString("name"));
                collection.setAddr(rs.getString("addr"));
                collection.setContact(rs.getString("contact"));
                collection.setPhoneNum(rs.getString("PhoneNum"));
                collection.setPostcode(rs.getString("postcode"));
                collectionList.add(collection);
            }

            dao.AllClose();
            return collectionList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    public List<Collection> findCollectionsBySearch(String searchField, String searchValue) {
        Dao dao = new Dao();
        List<Collection> collectionList = new ArrayList<>();
        String sql = "";

        // 根据 searchField 决定查询条件
        if (searchField.equals("name")) {
            sql = "SELECT * FROM library.collection WHERE name LIKE ?";
        }else if (searchField.equals("addr")) {
            sql = "SELECT * FROM library.collection WHERE addr LIKE ?";
        }

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%" + searchValue + "%");  // 使用模糊匹配
            ResultSet rs = ps.executeQuery();

            // 遍历查询结果，构建 Collection 对象列表
            while (rs.next()) {
                Collection collection = new Collection();
                collection.setName(rs.getString("name"));
                collection.setAddr(rs.getString("addr"));
                collection.setContact(rs.getString("contact"));
                collection.setPhoneNum(rs.getString("PhoneNum"));
                collection.setPostcode(rs.getString("postcode"));
                collectionList.add(collection);
            }

            dao.AllClose();
            return collectionList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    // 添加
    public boolean addCollection(Collection collection) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.collection (name, addr, contact, phoneNum, postcode) " +
                "VALUES (?, ?, ?, ?, ?)";
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, collection.getName());
            ps.setString(2, collection.getAddr());
            ps.setString(3, collection.getContact());
            ps.setString(4, collection.getPhoneNum());
            ps.setString(5, collection.getPostcode());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {

            throw new RuntimeException("添加收藏单位信息失败", e);
        }
    }

    // 查看
    public Collection getCollectionByName(String name) {
        Dao dao = new Dao();
        Collection collection = new Collection();
        String sql = "SELECT * FROM library.collection WHERE name = ? LIMIT 1";
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                collection.setName(rs.getString("name"));
                collection.setAddr(rs.getString("addr"));
                collection.setContact(rs.getString("contact"));
                collection.setPhoneNum(rs.getString("phoneNum"));
                collection.setPostcode(rs.getString("postcode"));

            }
            dao.AllClose();
            return collection; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查看数据失败", e);
        }
    }

    // 更新
    public boolean updateCollection(Collection collection) {
        Dao dao = new Dao();
        String sql = "UPDATE library.collection SET " +
                "addr = ?, contact = ?, phoneNum = ?, postcode = ? " +
                "WHERE name = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, collection.getAddr());
            ps.setString(2, collection.getContact());
            ps.setString(3, collection.getPhoneNum());
            ps.setString(4, collection.getPostcode());
            ps.setString(5, collection.getName());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {
            throw new RuntimeException("修改收藏单位信息数据失败", e);
        }
    }

    // 删除
    public boolean deleteCollection(String name) {
        Dao dao = new Dao();
        String sql = "DELETE FROM library.collection WHERE name = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {
            ps.setString(1, name);  // 设置要删除的读者ID

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;  // 如果删除的行数大于0，表示删除成功
        } catch (SQLException e) {
            throw new RuntimeException("删除收藏单位信息数据失败", e);
        }
    }
}
