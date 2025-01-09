package Dao;

import Entity.*;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DingdanDao {
    public DingdanDao() {
    }

    public List<Dingdan> getAllDingdans() {
        Dao dao = new Dao();
        List<Dingdan> dingdanList = new ArrayList<>();
        String sql = "SELECT * FROM library.dingdan"; // 表名是dingdan
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Dingdan dingdan = new Dingdan();
                dingdan.setOrderName(rs.getString("orderName"));
                dingdan.setSupplier(rs.getString("supplier"));
                dingdan.setTitle(rs.getString("title"));
                dingdan.setPublisher(rs.getString("publisher"));
                dingdan.setOrderPerson(rs.getString("orderPerson"));
                dingdan.setReceiver(rs.getString("receiver"));
                dingdan.setISBN(rs.getString("ISBN"));

                String t = rs.getString("documentType");
                dingdan.setDocumentType(DocumentType.fromDescription(t));


                dingdan.setCurrencyID(rs.getInt("currencyID"));
                dingdan.setPrice(rs.getDouble("price"));
                dingdan.setEdition(rs.getString("edition"));
                dingdan.setPrintingHouse(rs.getString("printingHouse"));
                dingdan.setPublicationDate(rs.getObject("publicationDate",LocalDate.class));
                dingdan.setSubscribeNum(rs.getInt("subscribeNum"));
                dingdan.setAuthor(rs.getString("author"));
//                dingdan.setBianmu(rs.getBoolean("bianmu"));
                dingdanList.add(dingdan);
            }

            dao.AllClose();
            return dingdanList;
            } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    public List<Dingdan> findDingdansBySearch(String searchField, String searchValue) {
        Dao dao = new Dao();
        List<Dingdan> dingdanList = new ArrayList<>();
        String sql = "";

        // 根据 searchField 决定查询条件
        if (searchField.equals("orderName")) {
            sql = "SELECT * FROM library.dingdan WHERE orderName LIKE ?";
        } else if (searchField.equals("name")) {
            sql = "SELECT * FROM library.dingdan WHERE name LIKE ?";
        } else if (searchField.equals("dingdanLevel")) {
            sql = "SELECT * FROM library.dingdan WHERE dingdanLevel LIKE ?";
        }

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%" + searchValue + "%");  // 使用模糊匹配
            ResultSet rs = ps.executeQuery();

            // 遍历查询结果，构建 Dingdan 对象列表
            while (rs.next()) {
                Dingdan dingdan = new Dingdan();
                dingdan.setOrderName(rs.getString("orderName"));
                dingdan.setSupplier(rs.getString("supplier"));
                dingdan.setTitle(rs.getString("title"));
                dingdan.setPublisher(rs.getString("publisher"));
                dingdan.setOrderPerson(rs.getString("orderPerson"));
                dingdan.setReceiver(rs.getString("receiver"));
                dingdan.setISBN(rs.getString("ISBN"));

                String t = rs.getString("documentType");
                dingdan.setDocumentType(DocumentType.fromDescription(t));
                dingdan.setCurrencyID(rs.getInt("currencyID"));
                dingdan.setPrice(rs.getDouble("price"));
                dingdan.setEdition(rs.getString("edition"));
                dingdan.setPrintingHouse(rs.getString("printingHouse"));
                dingdan.setPublicationDate(rs.getObject("publicationDate",LocalDate.class));
                dingdan.setSubscribeNum(rs.getInt("subscribeNum"));
                dingdan.setAuthor(rs.getString("author"));
//                dingdan.setBianmu(rs.getBoolean("bianmu"));
                dingdanList.add(dingdan);
            }

            dao.AllClose();
            return dingdanList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    public boolean addDingdan1(Dingdan dingdan) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.dingdan (orderName, supplier, title, publisher, orderPerson,  ISBN, documentType, currencyID, price,edition,printingHouse,author) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)";
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {
            ps.setString(1, dingdan.getOrderName());
            ps.setString(2, dingdan.getSupplier());
            ps.setString(3, dingdan.getTitle());
            ps.setString(4, dingdan.getPublisher());
            ps.setString(5, dingdan.getOrderPerson());

            ps.setString(6, dingdan.getISBN());
            ps.setString(7,dingdan.getDocumentType().getDescription());
            ps.setInt(8, dingdan.getCurrencyID());
            ps.setDouble(9, dingdan.getPrice());
            ps.setString(10, dingdan.getEdition());
            ps.setString(11, dingdan.getPrintingHouse());


            ps.setString(12,dingdan.getAuthor());
//            ps.setBoolean(13,dingdan.isBianmu());



            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {

            throw new RuntimeException("添加备份信息数据失败", e);
        }
    }

    // 添加
    public boolean addDingdan(Dingdan dingdan) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.dingdan (orderName, supplier, title, publisher, orderPerson, receiver, ISBN, documentType, currencyID, price,edition,printingHouse,publicationDate,subscribeNum,author,isBianmu) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?,?,?)";
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {
            ps.setString(1, dingdan.getOrderName());
            ps.setString(2, dingdan.getSupplier());
            ps.setString(3, dingdan.getTitle());
            ps.setString(4, dingdan.getPublisher());
            ps.setString(5, dingdan.getOrderPerson());
            ps.setString(6, dingdan.getReceiver());
            ps.setString(7, dingdan.getISBN());
            ps.setString(8,dingdan.getDocumentType().getDescription());
            ps.setInt(9, dingdan.getCurrencyID());
            ps.setDouble(10, dingdan.getPrice());
            ps.setString(11, dingdan.getEdition());
            ps.setString(12, dingdan.getPrintingHouse());
            ps.setObject(13, dingdan.getPublicationDate());
            ps.setInt(14,dingdan.getSubscribeNum());
            ps.setString(15,dingdan.getAuthor());
            ps.setBoolean(16,dingdan.isBianmu());



            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {

            throw new RuntimeException("添加备份信息数据失败", e);
        }
    }

    // 查看
    public Dingdan getDingdanByID(String readID) {
        Dao dao = new Dao();
        Dingdan dingdan = new Dingdan();
        String sql = "SELECT * FROM library.dingdan WHERE orderName = ? LIMIT 1";
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, readID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                dingdan.setOrderName(rs.getString("orderName"));
                dingdan.setSupplier(rs.getString("supplier"));
                dingdan.setTitle(rs.getString("title"));
                dingdan.setPublisher(rs.getString("publisher"));
                dingdan.setOrderPerson(rs.getString("orderPerson"));
                dingdan.setReceiver(rs.getString("receiver"));
                dingdan.setISBN(rs.getString("ISBN"));

                String t = rs.getString("documentType");
                dingdan.setDocumentType(DocumentType.fromDescription(t));
                dingdan.setCurrencyID(rs.getInt("currencyID"));
                dingdan.setPrice(rs.getDouble("price"));
                dingdan.setEdition(rs.getString("edition"));
                dingdan.setPrintingHouse(rs.getString("printingHouse"));
                dingdan.setPublicationDate(rs.getObject("publicationDate",LocalDate.class));
                dingdan.setSubscribeNum(rs.getInt("subscribeNum"));
                dingdan.setAuthor(rs.getString("author"));
//                dingdan.setBianmu(rs.getBoolean("bianmu"));

            }
            dao.AllClose();
            return dingdan; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    // 更新
    public boolean updateDingdan(Dingdan dingdan) {
        Dao dao = new Dao();
        String sql = "UPDATE library.dingdan SET " +
                "supplier = ?, title = ?, publisher = ?, orderPerson = ?, receiver = ?, ISBN = ?, documentType = ?, currencyID = ?, price = ?,edition= ?,printingHouse = ?,publicationDate = ?,subscribeNum = ?,author =?,isBianmu = ? " +
                "WHERE orderName = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, dingdan.getSupplier());
            ps.setString(2, dingdan.getTitle());
            ps.setString(3, dingdan.getPublisher());
            ps.setString(4, dingdan.getOrderPerson());
            ps.setString(5, dingdan.getReceiver());
            ps.setString(6, dingdan.getISBN());
            ps.setString(7,dingdan.getDocumentType().getDescription());
            ps.setInt(8, dingdan.getCurrencyID());
            ps.setDouble(9, dingdan.getPrice());
            ps.setString(10, dingdan.getEdition());
            ps.setString(11, dingdan.getPrintingHouse());
            ps.setObject(12, dingdan.getPublicationDate());
            ps.setInt(13,dingdan.getSubscribeNum());
            ps.setString(14,dingdan.getAuthor());
            ps.setBoolean(15,dingdan.isBianmu());
            ps.setString(16,dingdan.getOrderName());




            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {
            throw new RuntimeException("修改读者信息数据失败", e);
        }
    }

    // 删除
    public boolean deleteDingdan(String orderName) {
        Dao dao = new Dao();
        String sql = "DELETE FROM library.dingdan WHERE orderName = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {
            ps.setString(1, orderName);  // 设置要删除的读者ID

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;  // 如果删除的行数大于0，表示删除成功
        } catch (SQLException e) {
            throw new RuntimeException("删除读者信息数据失败", e);
        }
    }
}
