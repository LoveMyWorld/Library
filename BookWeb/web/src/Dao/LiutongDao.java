package Dao;

import Entity.Cataloglist;
import Entity.DocumentType;
import Entity.Liutong;


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
                liutong.setOrderPerson(rs.getString("orderPerson"));                          // 订购人
                liutong.setReceiver(rs.getString("receiver"));                                // 验收人
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

}
