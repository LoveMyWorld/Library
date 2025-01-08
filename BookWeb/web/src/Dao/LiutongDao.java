package Dao;

import Entity.Appointment;
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
                liutong.setBookNum(rs.getInt("bookNum"));
                liutong.setBookID(rs.getString("bookID"));

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
    //返回值为0，说明没有待修改的数据，返回值为1，说明更新流通库成功
    public int updateLiutongList(String bookID) {
        Dao dao = new Dao();
        String sql = "UPDATE library.liutonglist SET bookNum = bookNum - 1 WHERE bookID = ? AND bookNum > 0";

        try {
            // 准备 PreparedStatement
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            // 设置参数，bookID 作为搜索条件
            ps.setString(1, bookID);

            // 执行更新操作
            int rowsAffected = ps.executeUpdate();

            // 关闭资源
            dao.AllClose();

            // 如果影响的行数大于0，表示更新成功
            return rowsAffected > 0 ? 1 : 0;
        } catch (SQLException e) {
            // 如果发生 SQL 异常，抛出运行时异常
            throw new RuntimeException("更新数据失败", e);
        }
    }
    //找一条记录,通过bookID找到library.liutonglist中的bookNum表项
    public int FindBookNumByBookID(String bookID) {
        Dao dao = new Dao();
        String sql = "SELECT bookNum FROM library.liutonglist WHERE bookID = ? LIMIT 1";

        try {
            // 准备 PreparedStatement
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            // 设置参数，bookID 作为搜索条件
            ps.setString(1, bookID);

            // 执行查询操作
            ResultSet rs = ps.executeQuery();

            // 检查结果集是否有数据
            while (rs.next()) {
                // 如果有数据，返回 bookNum 的值
                int bookNum = rs.getInt("bookNum");
                // 关闭资源
                dao.AllClose();
                return bookNum;
            }
            dao.AllClose();
               return 0;

        } catch (SQLException e) {
            // 如果发生 SQL 异常，抛出运行时异常
            throw new RuntimeException("查找数据失败", e);
        }
    }
    public Liutong FindLiutongByBookID(String bookID) {
        Dao dao = new Dao();
        String sql = "SELECT bookNum FROM library.liutonglist WHERE bookID = ? LIMIT 1";

        try {
            // 准备 PreparedStatement
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            // 设置参数，bookID 作为搜索条件
            ps.setString(1, bookID);

            // 执行查询操作
            ResultSet rs = ps.executeQuery();
            Liutong liutong=null;
            // 检查结果集是否有数据
            while (rs.next()) {
                // 如果有数据，返回 bookNum 的值
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
                liutong.setBookNum(rs.getInt("bookNum"));
                // 关闭资源
                dao.AllClose();
                return liutong;
            }
            dao.AllClose();
            return null;

        } catch (SQLException e) {
            // 如果发生 SQL 异常，抛出运行时异常
            throw new RuntimeException("查找数据失败", e);
        }
    }
}
