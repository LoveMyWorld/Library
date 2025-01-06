package Dao;

import Entity.DocumentType;
import Entity.Caifang;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public
class CaifangDao {
    // 数据库连接管理类

    public CaifangDao() {

    }

    ;

    // 查询表中的所有数据并返回
    public List<Caifang> getAllData() {
        Dao dao = new Dao();
        List<Caifang> dataList = new ArrayList<>();     // 用于存储查询结果
        String sql = "SELECT * FROM   library.caifanglist"; // 查询表中的所有数据

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 Caifang 对象并添加到列表
            while (rs.next()) {
                Caifang caifang = new Caifang();
                caifang.setTitle(rs.getString("title"));                                      // 书名
                caifang.setAuthor(rs.getString("author"));                                    // 作者
                caifang.setPublicationDate(rs.getObject("publicationDate", LocalDate.class)); // 出版日期
                caifang.setISBN(rs.getString("ISBN"));                                        // 国际标准书号
                caifang.setPrice(rs.getDouble("price"));                                      // 定价
               caifang.setReferrer(rs.getString("referrer"));                               //推荐人
                caifang.setPhoneNum(rs.getString("phoneNum"));                  //电话



                // 根据 Caifang 类的字段继续添加赋值逻辑
                dataList.add(caifang); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }
    public List<Caifang> findBooksBySearch(String searchField,String searchValue) {
        Dao dao = new Dao();
        List<Caifang> dataList = new ArrayList<>();
        String sql="";
        if(searchField.equals("isbn")) {
            sql="select * from Library.caifanglist where ISBN like ?";
        }
        else if(searchField.equals("author")) {
            sql="select * from Library.caifanglist where author like ?";
        }
        else if(searchField.equals("title")) {
            sql="select * from Library.caifanglist where title like ?";
        }
        else if(searchField.equals("referrer")) {
            sql="select * from Library.caifanglist where referrer like ?";
        }

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%"+searchValue+"%");
            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 Caifang 对象并添加到列表
            while (rs.next()) {
                Caifang caifang = new Caifang();
                caifang.setTitle(rs.getString("title"));                                      // 书名
                caifang.setAuthor(rs.getString("author"));                                    // 作者
                caifang.setPublicationDate(rs.getObject("publicationDate", LocalDate.class)); // 出版日期
                caifang.setISBN(rs.getString("ISBN"));                                        // 国际标准书号
                caifang.setPrice(rs.getDouble("price"));                                      // 定价
                caifang.setReferrer(rs.getString("referrer"));                               //推荐人
                caifang.setPhoneNum(rs.getString("phoneNum"));                  //电话

                // 根据 Caifang 类的字段继续添加赋值逻辑
                dataList.add(caifang); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }
}