package Dao;

import Entity.DocumentType;
import Entity.Yanshou;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public
class YanshouDao {
    // 数据库连接管理类

    public YanshouDao() {

    }

    ;

    // 查询表中的所有数据并返回
    public List<Yanshou> getAllData() {
        Dao dao = new Dao();
        List<Yanshou> dataList = new ArrayList<>();     // 用于存储查询结果
        String sql = "SELECT * FROM   library.yanshou"; // 查询表中的所有数据

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 Yanshou 对象并添加到列表
            while (rs.next()) {
                Yanshou yanshou = new Yanshou();
                yanshou.setOrderName(rs.getString("orderName"));                                // 订单号
                yanshou.setSupplier(rs.getString("supplier"));                                // 书商
                yanshou.setTitle(rs.getString("title"));                                      // 书名
                yanshou.setPublisher(rs.getString("publisher"));                              // 出版社
                yanshou.setOrderPerson(rs.getString("orderPerson"));                          // 订购人
                yanshou.setReceiver(rs.getString("receiver"));                                // 验收人
                yanshou.setISBN(rs.getString("ISBN"));                                        // 国际标准书号
                String t = rs.getString("documentType");
                yanshou.setDocumentType(DocumentType.fromDescription(t));                           // 币种编码
                yanshou.setPrice(rs.getDouble("price"));                                      // 定价
                yanshou.setEdition(rs.getString("edition"));                                  // 版次
                yanshou.setPrintingHouse(rs.getString("printingHouse"));                      // 印刷厂
                yanshou.setPublicationDate(rs.getObject("publicationDate", LocalDate.class)); // 出版日期
                yanshou.setSubscribeNum(rs.getInt("subscribeNum"));                           // 征订册数
                yanshou.setAuthor(rs.getString("author"));                                    // 作者

                // 根据 Yanshou 类的字段继续添加赋值逻辑
                dataList.add(yanshou); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }
    public List<Yanshou> findBooksBySearch(String searchField,String searchValue) {
        Dao dao = new Dao();
        List<Yanshou> dataList = new ArrayList<>();
        String sql="";
        if(searchField.equals("isbn")) {
             sql="select * from Library.Yanshou where ISBN like ?";
        }
        else if(searchField.equals("author")) {
            sql="select * from Library.Yanshou where author like ?";
        }
        else if(searchField.equals("title")) {
             sql="select * from Library.Yanshou where title like ?";
        }
        else if(searchField.equals("publisher")){
             sql="select * from Library.Yanshou where publisher like ?";
        }
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%"+searchValue+"%");
            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 Yanshou 对象并添加到列表
            while (rs.next()) {
                Yanshou yanshou = new Yanshou();
                yanshou.setOrderName(rs.getString("orderName"));                                // 订单号
                yanshou.setSupplier(rs.getString("supplier"));                                // 书商
                yanshou.setTitle(rs.getString("title"));                                      // 书名
                yanshou.setPublisher(rs.getString("publisher"));                              // 出版社
                yanshou.setOrderPerson(rs.getString("orderPerson"));                          // 订购人
                yanshou.setReceiver(rs.getString("receiver"));                                // 验收人
                yanshou.setISBN(rs.getString("ISBN"));                                        // 国际标准书号
                String t = rs.getString("documentType");
                yanshou.setDocumentType(DocumentType.fromDescription(t));                           // 币种编码
                yanshou.setPrice(rs.getDouble("price"));                                      // 定价
                yanshou.setEdition(rs.getString("edition"));                                  // 版次
                yanshou.setPrintingHouse(rs.getString("printingHouse"));                      // 印刷厂
                yanshou.setPublicationDate(rs.getObject("publicationDate", LocalDate.class)); // 出版日期
                yanshou.setSubscribeNum(rs.getInt("subscribeNum"));                           // 征订册数
                yanshou.setAuthor(rs.getString("author"));                                    // 作者

                // 根据 Yanshou 类的字段继续添加赋值逻辑
                dataList.add(yanshou); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }
}