package Dao;

import Entity.Cataloglist;
import Entity.DocumentType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public
class CatalogMDao
{
    // 通过ISBN找编目的书籍的编目号,返回编目号
    public Cataloglist findDataByISBN(String isbn)
    {
        Dao dao = new Dao();
        Cataloglist cataloglist = null ;             // 用于存储查询结果
        String sql = "SELECT * FROM   library.cataloglist where ISBN=? LIMIT 1"; // 查询表中的所有数据

        try
        {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, isbn);
            ResultSet rs = ps.executeQuery();

            // 处理查询结果
            if (rs.next())
            {
                // 假设编目号存储在 "categoryID" 字段中
                cataloglist=new Cataloglist();
                cataloglist.setISBN(isbn);
                cataloglist.setSupplier(rs.getString("supplier"));                                // 书商
                cataloglist.setTitle(rs.getString("title"));                                      // 书名
                cataloglist.setPublisher(rs.getString("publisher"));                              // 出版社
                cataloglist.setOrderPerson(rs.getString("orderPerson"));                          // 订购人
                cataloglist.setReceiver(rs.getString("receiver"));                                // 验收人
                cataloglist.setISBN(rs.getString("ISBN"));                                        // 国际标准书号
                String t = rs.getString("documentType");
                cataloglist.setDocumentType(DocumentType.fromDescription(t));                           // 币种编码
                cataloglist.setPrice(rs.getDouble("price"));                                      // 定价
                cataloglist.setEdition(rs.getString("edition"));                                  // 版次
                cataloglist.setPublicationDate(rs.getObject("publicationDate", LocalDate.class)); // 出版日期
                cataloglist.setCategoryName(rs.getString("categoryName"));
                cataloglist.setAuthor(rs.getString("author"));

            }
            dao.AllClose();
            return cataloglist; // 返回找到的编目号
        }
        catch (SQLException e)
        {
            e.printStackTrace(); // 打印异常信息
        }
        return null; // 如果没有找到对应的编目号，返回 null
    }
}
