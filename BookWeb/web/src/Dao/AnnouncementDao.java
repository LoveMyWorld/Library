package Dao;

import Entity.Announcement;


import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public
class AnnouncementDao {
    // 数据库连接管理类

    public AnnouncementDao() {

    }
    ;

    // 查询表中的所有数据并返回
    public List<Announcement> getAllData() {
        Dao dao = new Dao();
        List<Announcement> dataList = new ArrayList<>();     // 用于存储查询结果
        String sql = "SELECT * FROM   library.announcement"; // 查询表中的所有数据

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 Announcement 对象并添加到列表
            while (rs.next()) {
                Announcement announcement = new Announcement();
                announcement.setAnnouncementID(rs.getInt("announcementID"));                                      // 书名
                announcement.setAnnouncementDate(rs.getObject("announceDate",LocalDate.class));                                    // 作者
                announcement.setPublisher(rs.getString("publisher"));
                announcement.setAnnouncementText(rs.getString("announcementText"));                                        // 国际标准书号
                announcement.setAnnouncementKey(rs.getString("announcementKey"));



                // 根据 Announcement 类的字段继续添加赋值逻辑
                dataList.add(announcement); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }


    public List<Announcement> findBooksBySearch(String searchField,String searchValue) {
        Dao dao = new Dao();
        List<Announcement> dataList = new ArrayList<>();
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

            // 遍历结果集，将每一行转换为 Announcement 对象并添加到列表
            while (rs.next()) {
                Announcement announcement = new Announcement();
                announcement.setAnnouncementID(rs.getInt("announcementID"));                                      // 书名
                announcement.setAnnouncementDate(rs.getObject("announceDate",LocalDate.class));                                    // 作者
                announcement.setPublisher(rs.getString("publisher"));
                announcement.setAnnouncementText(rs.getString("announcementText"));
                announcement.setAnnouncementKey(rs.getString("announcementKey"));   
                // 根据 Announcement 类的字段继续添加赋值逻辑
                dataList.add(announcement); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

//添加一行
public void addLine(Announcement announcement) {
        String sql = "INSERT INTO library.Announcement (announcementID, announcementDate,publisher,announcementText,announcementKey) VALUES (?, ?, ?, ?, ?)";

        Dao dao = new Dao();

        try{
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setInt(1, announcement.getAnnouncementID());
            ps.setObject(2, announcement.getAnnouncementDate());
            ps.setString(3, announcement.getPublisher());
            ps.setString(4, announcement.getAnnouncementText());
            ps.setString(5, announcement.getAnnouncementKey());
            ps.executeUpdate();
            dao.AllClose();


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


}

//删除一行
public void deleteLine(Announcement announcement) {
    String sql = "DELETE FROM library.Announcement WHERE announcementID = ?";
    Dao dao = new Dao();
    try {
        PreparedStatement ps = dao.conn.prepareStatement(sql);
        ps.setInt(1, announcement.getAnnouncementID());
        ps.executeUpdate();
        dao.AllClose();



    } catch (SQLException e) {
        throw new RuntimeException(e);
    }

}

//修改

public void updateLine(int id , Announcement announcement) {
    String sql = "UPDATE library.announcement SET announcementDate = ?,publisher=?,announcementText=?,announcementKey=?  WHERE id = ?";
    Dao dao = new Dao();
    try {
        PreparedStatement ps =dao.conn.prepareStatement(sql);

        ps.setObject(1, announcement.getAnnouncementDate());
        ps.setString(2, announcement.getPublisher());
        ps.setString(3, announcement.getAnnouncementText());
        ps.setString(4, announcement.getAnnouncementKey());
        ps.setInt(5, id);
        ps.executeUpdate();
        dao.AllClose();




    } catch (SQLException e) {
        throw new RuntimeException(e);
    }


}


    //查找最大id
public int findMaxID(){
        String sql = "SELECT MAX(announcementID) FROM library.Announcement";

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
public List<Announcement>  getLastTenLines(){
String sql ="SELECT * FROM library.announcement\n" +
        "ORDER BY    announcementID DESC\n" +
        "LIMIT 10";

Dao dao = new Dao();
List<Announcement> dataList = new ArrayList<>();
try{
    PreparedStatement ps =dao.conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {

        Announcement announcement = new Announcement();
        announcement.setAnnouncementID(rs.getInt("announcementID"));
        announcement.setAnnouncementDate(rs.getObject("announcementDate",LocalDate.class));
        announcement.setPublisher(rs.getString("publisher"));
        announcement.setAnnouncementText(rs.getString("announcementText"));
        announcement.setAnnouncementKey(rs.getString("announcementKey"));
        dataList.add(announcement);

    }

    dao.AllClose();
    return dataList;



} catch (SQLException e) {
    throw new RuntimeException(e);
}

}

public Announcement getAnnouncementByID(int announcementID) {
        String sql = "SELECT * FROM library.announcement WHERE announcementID = ?";
        Dao dao = new Dao();
        Announcement announcement = new Announcement();
        try{
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setInt(1, announcementID);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                announcement.setAnnouncementID(rs.getInt("announcementID"));
                announcement.setAnnouncementDate(rs.getObject("announcementDate",LocalDate.class));
                announcement.setPublisher(rs.getString("publisher"));
                announcement.setAnnouncementText(rs.getString("announcementText"));
                announcement.setAnnouncementKey(rs.getString("announcementKey"));

                dao.AllClose();

            }




        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    return announcement;

    }
}