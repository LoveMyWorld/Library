package Dao;

import Entity.Tongbao;


import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public
class TongbaoDao {
    // 数据库连接管理类

    public TongbaoDao() {

    }
    ;

    // 查询表中的所有数据并返回
    public List<Tongbao> getAllData() {
        Dao dao = new Dao();
        List<Tongbao> dataList = new ArrayList<>();     // 用于存储查询结果
        String sql = "SELECT * FROM   library.announcement"; // 查询表中的所有数据

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 Tongbao 对象并添加到列表
            while (rs.next()) {
                Tongbao announcement = new Tongbao();
                announcement.setTongbaoID(rs.getInt("announcementID"));                                      // 书名
                announcement.setTongbaoDate(rs.getObject("announceDate",LocalDate.class));                                    // 作者
                announcement.setPublisher(rs.getString("publisher"));
                announcement.setTongbaoText(rs.getString("announcementText"));                                        // 国际标准书号
                announcement.setTongbaoKey(rs.getString("announcementKey"));



                // 根据 Tongbao 类的字段继续添加赋值逻辑
                dataList.add(announcement); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }


    public List<Tongbao> findBooksBySearch(String searchField,String searchValue) {
        Dao dao = new Dao();
        List<Tongbao> dataList = new ArrayList<>();
        String sql="";
        if(searchField.equals("announcementText")) {
            sql="select * from Library.announcement where announcementText like ?";
        }

        else if(searchField.equals("announcementID")) {
            sql="select * from Library.announcement where announcementID like ?";
        }


        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%"+searchValue+"%");
            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 Tongbao 对象并添加到列表
            while (rs.next()) {
                Tongbao announcement = new Tongbao();
                announcement.setTongbaoID(rs.getInt("announcementID"));                                      // 书名
                announcement.setTongbaoDate(rs.getObject("announceDate",LocalDate.class));                                    // 作者
                announcement.setPublisher(rs.getString("publisher"));
                announcement.setTongbaoText(rs.getString("announcementText"));
                announcement.setTongbaoKey(rs.getString("announcementKey"));
                // 根据 Tongbao 类的字段继续添加赋值逻辑
                dataList.add(announcement); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    //添加一行
    public void addLine(Tongbao announcement) {
        String sql = "INSERT INTO library.Tongbao (tongbaoID, tongbaoDate,publisher,tongbaoText,tongbaoKey) VALUES (?, ?, ?, ?, ?)";

        Dao dao = new Dao();

        try{
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setInt(1, announcement.getTongbaoID());
            ps.setObject(2, announcement.getTongbaoDate());
            ps.setString(3, announcement.getPublisher());
            ps.setString(4, announcement.getTongbaoText());
            ps.setString(5, announcement.getTongbaoKey());
            ps.executeUpdate();
            dao.AllClose();


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

    //删除一行
    public void deleteLine(Tongbao announcement) {
        String sql = "DELETE FROM library.Tongbao WHERE announcementID = ?";
        Dao dao = new Dao();
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setInt(1, announcement.getTongbaoID());
            ps.executeUpdate();
            dao.AllClose();



        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

//修改

    public void updateLine(int id , Tongbao announcement) {
        String sql = "UPDATE library.announcement SET announcementDate = ?,publisher=?,announcementText=?,announcementKey=?  WHERE id = ?";
        Dao dao = new Dao();
        try {
            PreparedStatement ps =dao.conn.prepareStatement(sql);

            ps.setObject(1, announcement.getTongbaoDate());
            ps.setString(2, announcement.getPublisher());
            ps.setString(3, announcement.getTongbaoText());
            ps.setString(4, announcement.getTongbaoKey());
            ps.setInt(5, id);
            ps.executeUpdate();
            dao.AllClose();




        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }


    //查找最大id
    public int findMaxID(){
        String sql = "SELECT MAX(tongbaoID) FROM library.Tongbao";

        Dao dao = new Dao();
        int id =0;
        try{
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                id = rs.getInt(1);
            }

            dao.AllClose();


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return id;
    }



    //取最后十条公告
    public List<Tongbao>  getLastTenLines(){
        String sql ="SELECT * FROM library.tongbao\n" +
                "ORDER BY    tongbaoID DESC\n" +
                "LIMIT 10";

        Dao dao = new Dao();
        List<Tongbao> dataList = new ArrayList<>();
        try{
            PreparedStatement ps =dao.conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Tongbao announcement = new Tongbao();
                announcement.setTongbaoID(rs.getInt("tongbaoID"));
                announcement.setTongbaoDate(rs.getObject("tongbaoDate",LocalDate.class));
                announcement.setPublisher(rs.getString("publisher"));
                announcement.setTongbaoText(rs.getString("tongbaoText"));
                announcement.setTongbaoKey(rs.getString("tongbaoKey"));
                dataList.add(announcement);

            }

            dao.AllClose();
            return dataList;



        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public Tongbao getTongbaoByID(int announcementID) {
        String sql = "SELECT * FROM library.announcement WHERE announcementID = ?";
        Dao dao = new Dao();
        Tongbao announcement = new Tongbao();
        try{
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setInt(1, announcementID);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                announcement.setTongbaoID(rs.getInt("announcementID"));
                announcement.setTongbaoDate(rs.getObject("announcementDate",LocalDate.class));
                announcement.setPublisher(rs.getString("publisher"));
                announcement.setTongbaoText(rs.getString("announcementText"));
                announcement.setTongbaoKey(rs.getString("announcementKey"));

                dao.AllClose();

            }




        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return announcement;

    }
}