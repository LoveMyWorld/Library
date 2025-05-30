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
                liutong.setBookID(rs.getString("BookID"));
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

    //返回值为0，说明没有待修改的数据，返回值为1，说明更新流通库成功
    public int subOneBookNuminLiutongList(String bookID) {
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
        String sql = "SELECT * FROM library.liutonglist WHERE bookID = ? LIMIT 1";
        Liutong liutong =null;
        try {
            // 准备 PreparedStatement
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            // 设置参数，bookID 作为搜索条件
            ps.setString(1, bookID);

            // 执行查询操作
            ResultSet rs = ps.executeQuery();

            // 检查结果集是否有数据
            while (rs.next()) {
                liutong = new Liutong(); // 初始化 Liutong 对象
                // 如果有数据，返回 bookNum 的值
                liutong.setBookID(rs.getString("bookID"));
                liutong.setSupplier(rs.getString("supplier"));                                // 书商
                liutong.setTitle(rs.getString("title"));                                      // 书名
                liutong.setPublisher(rs.getString("publisher"));                              // 出版社
                //               liutong.setOrderPerson(rs.getString("orderPerson"));                          // 编目人
                // liutong.setReceiver(rs.getString("receiver"));                                // 验收人
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

    //更改册数，通过id
    public int UpdateByBookID(String bookID,int bookNum) {
        Dao dao = new Dao();
        String sql = "UPDATE library.liutonglist SET bookNum = bookNum + ? WHERE bookID = ?";
        int rowsAffected = 0; // 用于存储受影响的行数

        try {
            // 准备 PreparedStatement
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            // 设置参数
            ps.setInt(1, bookNum);
            ps.setString(2, bookID);

            // 执行更新操作
            rowsAffected = ps.executeUpdate();

            dao.AllClose(); // 关闭资源
        } catch (SQLException e) {
            throw new RuntimeException("更新数据失败", e);
        }

        return rowsAffected; // 返回受影响的行数
    }


    //返回值为0，说明没有待修改的数据，返回值为1，说明更新流通库成功
    public int addOneBookNuminLiutongList(String bookID) {
        Dao dao = new Dao();
        String sql = "UPDATE library.liutonglist SET bookNum = bookNum + 1 WHERE bookID = ? ";

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
    public int insertIntoLiutongList(Liutong liutong) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.liutonglist (bookID, supplier, title, publisher,  ISBN, documentType, price, edition, publicationDate, categoryName, author, bookNum) VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int rowsAffected = 0; // 用于存储受影响的行数

        try {
            // 准备 PreparedStatement
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            // 设置参数
            ps.setString(1, liutong.getBookID());
            ps.setString(2, liutong.getSupplier());
            ps.setString(3, liutong.getTitle());
            ps.setString(4, liutong.getPublisher());

            ps.setString(5, liutong.getISBN());
            ps.setString(6, liutong.getDocumentType().getDescription());
            ps.setDouble(7, liutong.getPrice());
            ps.setString(8, liutong.getEdition());
            ps.setObject(9, liutong.getPublicationDate(), java.sql.Types.DATE);
            ps.setString(10, liutong.getCategoryName());
            ps.setString(11, liutong.getAuthor());
            ps.setInt(12, liutong.getBookNum());


            // 执行插入操作
            rowsAffected = ps.executeUpdate();
            // 如果影响的行数大于0，表示更新成功
            dao.AllClose(); // 关闭资源
        } catch (SQLException e) {
            throw new RuntimeException("插入数据失败", e);
        }

        return rowsAffected; // 返回受影响的行数
    }


}
