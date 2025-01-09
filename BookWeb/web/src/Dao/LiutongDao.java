package Dao;

import Entity.*;


import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class LiutongDao {
    //通过ISBN找流通的书籍全部信息
    public Liutong findDataByISBN(String isbn)
    {
        Dao dao = new Dao();
        Liutong liutong=null;           // 用于存储查询结果
        String sql = "SELECT * FROM   library.liutonglist where ISBN=? LIMIT 1"; // 查询表中的所有数据

        try
        {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, isbn);
            ResultSet rs = ps.executeQuery();

            // 处理查询结果
            if (rs.next())
            {
                // 假设编目号存储在 "categoryID" 字段中
                liutong=new Liutong();
                liutong.setISBN(isbn);
                liutong.setSupplier(rs.getString("supplier"));                                // 书商
                liutong.setTitle(rs.getString("title"));                                      // 书名
                liutong.setPublisher(rs.getString("publisher"));                              // 出版社
//                liutong.setOrderPerson(rs.getString("orderPerson"));                          // 订购人
//                liutong.setReceiver(rs.getString("receiver"));                                // 验收人
                liutong.setISBN(rs.getString("ISBN"));                                        // 国际标准书号
                String t = rs.getString("documentType");
                liutong.setDocumentType(DocumentType.fromDescription(t));                           // 币种编码
                liutong.setPrice(rs.getDouble("price"));                                      // 定价
                liutong.setEdition(rs.getString("edition"));                                  // 版次
                liutong.setPublicationDate(rs.getObject("publicationDate", LocalDate.class)); // 出版日期
                liutong.setCategoryName(rs.getString("categoryName"));
                liutong.setAuthor(rs.getString("author"));

            }
            dao.AllClose();
            return liutong; // 返回找到的编目号
        }
        catch (SQLException e)
        {
            e.printStackTrace(); // 打印异常信息
        }
        return null; // 如果没有找到对应的编目号，返回 null
    }


    public List<Liutong> getAllLiutongs() {
        Dao dao = new Dao();
        List<Liutong> liutongList = new ArrayList<>();
        String sql = "SELECT * FROM library.liutonglist"; // 表名是liutong
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Liutong liutong = new Liutong();
                liutong.setBookID(rs.getString("bookID"));
                liutong.setTitle(rs.getString("title"));
                liutong.setAuthor(rs.getString("author"));
                liutong.setISBN(rs.getString("ISBN"));  
                liutong.setPublicationDate(rs.getObject("publicationDate", LocalDate.class));
                liutong.setPublisher(rs.getString("publisher"));
                liutong.setEdition(rs.getString("edition"));
                liutong.setSupplier(rs.getString("supplier"));
                liutong.setCurrencyID(rs.getInt("currencyID") );
                liutong.setPrice(rs.getDouble("price")   );
                liutong.setBookNum(rs.getInt("bookNum"));
                liutong.setDocumentType(DocumentType.fromDescription(rs.getString("documentType")));
                liutong.setCategoryName(rs.getString("categoryName"));
                
                liutongList.add(liutong);
            }

            dao.AllClose();
            return liutongList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    public List<Liutong> findLiutongsBySearch(String searchField, String searchValue) {
        Dao dao = new Dao();
        List<Liutong> liutongList = new ArrayList<>();
        String sql = "";

        // 根据 searchField 决定查询条件
        if (searchField.equals("bookID")) {
            sql = "SELECT * FROM library.liutonglist WHERE bookID LIKE ?";
        } else if (searchField.equals("title")) {
            sql = "SELECT * FROM library.liutonglist WHERE title LIKE ?";
        } else if (searchField.equals("author")) {
            sql = "SELECT * FROM library.liutonglist WHERE author LIKE ?";
        }

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%" + searchValue + "%");  // 使用模糊匹配
            ResultSet rs = ps.executeQuery();

            // 遍历查询结果，构建 Liutong 对象列表
            while (rs.next()) {
                Liutong liutong = new Liutong();
                liutong.setBookID(rs.getString("bookID"));
                liutong.setTitle(rs.getString("title"));
                liutong.setAuthor(rs.getString("author"));
                liutong.setISBN(rs.getString("ISBN"));
                liutong.setPublicationDate(rs.getObject("publicationDate", LocalDate.class));
                liutong.setPublisher(rs.getString("publisher"));
                liutong.setEdition(rs.getString("edition"));
                liutong.setSupplier(rs.getString("supplier"));
                liutong.setCurrencyID(rs.getInt("currencyID") );
                liutong.setPrice(rs.getDouble("price")   );
                liutong.setBookNum(rs.getInt("bookNum"));
                liutong.setDocumentType(DocumentType.fromDescription(rs.getString("documentType")));
                liutong.setCategoryName(rs.getString("categoryName"));
                liutongList.add(liutong);
            }

            dao.AllClose();
            return liutongList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }   
        
        
    }
}
