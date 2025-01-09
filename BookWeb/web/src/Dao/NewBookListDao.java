package Dao;

import Entity.Cataloglist;
import Entity.DocumentType;
import Entity.NewBookList;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class NewBookListDao {
    public NewBookListDao() {
    }

    public int clearNewBookList() {
        String sql = "delete from booklist";
        Dao dao = new Dao();
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.executeUpdate();
            dao.AllClose();
            return 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int insertByCatelogList(){
        String sql = "insert into library.newbooklist  select * from  library.cateloglist";
        Dao dao = new Dao();
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.executeUpdate();
            dao.AllClose();
            return 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<NewBookList> getAllNewBookList(){
        List<NewBookList> list = new ArrayList<NewBookList>();
        String sql = "select * from library.newbooklist ";
        Dao dao = new Dao();
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                NewBookList newBookList = new NewBookList();

                newBookList.setBookID(rs.getString("bookID"));                                // 订单号
                newBookList.setSupplier(rs.getString("supplier"));                                // 书商
                newBookList.setTitle(rs.getString("title"));                                      // 书名
                newBookList.setPublisher(rs.getString("publisher"));                              // 出版社
                newBookList.setOrderPerson(rs.getString("orderPerson"));                          // 编目人
                newBookList.setISBN(rs.getString("ISBN"));                                        // 国际标准书号
                String t = rs.getString("documentType");
                newBookList.setCurrencyID(rs.getInt("currencyID"));
                newBookList.setDocumentType(DocumentType.fromDescription(t));                           // 币种编码
                newBookList.setPrice(rs.getDouble("price"));                                      // 定价
                newBookList.setEdition(rs.getString("edition"));                                  // 版次// 印刷厂
                newBookList.setPublicationDate(rs.getObject("publicationDate", LocalDate.class)); // 出版日期
                newBookList.setBookNum(rs.getInt("bookNum"));                           // 征订册数
                newBookList.setAuthor(rs.getString("author"));                                    // 作者

                list.add(newBookList);
            }
            dao.AllClose();
            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
