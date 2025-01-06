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
    //把Cataloglist类型写入library.catalolist数据库
    public boolean pushCatalogList(Cataloglist cataloglist){
        Dao dao = new Dao();
        String checkSql = "SELECT bookNum FROM library.cataloglist WHERE bookID = ?";
        String updateSql = "UPDATE library.cataloglist SET bookNum = ? WHERE bookID = ?";
        String insertSql = "INSERT INTO library.cataloglist (supplier, title, publisher, orderPerson, ISBN, " +
                "documentType, price, edition, publicationDate, categoryName, author, bookID, bookNum) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String updateSql2 = "update library.yanshou set isBianmu = 1 where ISBN = ?";

        try {
            // 检查是否存在具有相同 bookID 的记录
            PreparedStatement checkPs = dao.conn.prepareStatement(checkSql);
            checkPs.setString(1, cataloglist.getBookID());
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // 如果存在，更新 bookNum
                PreparedStatement updatePs = dao.conn.prepareStatement(updateSql);
                updatePs.setInt(1, cataloglist.getBookNum());
                updatePs.setString(2, cataloglist.getBookID());
                int rowsAffected = updatePs.executeUpdate();
                dao.AllClose();
            } else {
                // 如果不存在，插入新记录
                PreparedStatement insertPs = dao.conn.prepareStatement(insertSql);
                insertPs.setString(1, cataloglist.getSupplier());
                insertPs.setString(2, cataloglist.getTitle());
                insertPs.setString(3, cataloglist.getPublisher());
                insertPs.setString(4, cataloglist.getOrderPerson());
                insertPs.setString(5, cataloglist.getISBN());
                insertPs.setString(6, cataloglist.getDocumentType().getDescription());
                insertPs.setDouble(7, cataloglist.getPrice());
                insertPs.setString(8, cataloglist.getEdition());
                insertPs.setObject(9, cataloglist.getPublicationDate());
                insertPs.setString(10, cataloglist.getCategoryName());
                insertPs.setString(11, cataloglist.getAuthor());
                insertPs.setString(12, cataloglist.getBookID());
                insertPs.setInt(13, cataloglist.getBookNum());
                int rowsAffected = insertPs.executeUpdate();
                dao.AllClose();

            }

            dao = new Dao();
            PreparedStatement updatePs2 = dao.conn.prepareStatement(updateSql2);
            updatePs2.setString(1, cataloglist.getISBN());
            dao.dbcmd(updatePs2);

            dao.AllClose();
        } catch (SQLException e) {
            e.printStackTrace(); // 打印异常信息
        }
        return false; // 如果发生异常或没有影响行，则操作失败
    }
}

