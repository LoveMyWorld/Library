package Service;

import Dao.AnnouncementDao;
import Entity.Announcement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AnnouncementService {


    //添加一行
   public void addLine(Announcement announcement) {
        AnnouncementDao announcementDao = new AnnouncementDao();
        announcementDao.addLine(announcement);

    }


    //计算当前最大id
    public  int maxID(){

       AnnouncementDao announcementDao = new AnnouncementDao();
       int id =announcementDao.findMaxID();


       return  id;
    }






















    // 假设有一个方法来获取数据库连接
//    private Connection getConnection() {
//        // 这里应该实现数据库连接的获取逻辑
//        // 例如使用JDBC连接池等
//        return null;
//    }
//
//    public boolean publishAnnouncement(String publisher, String publishDate, String title, String content) {
//        String sql = "INSERT INTO library.announcement (publisher, publish_date, title, content) VALUES (?, ?, ?, ?)";
//
//        try (Connection conn = getConnection();
//             PreparedStatement pstmt = conn.prepareStatement(sql)) {
//            pstmt.setString(1, publisher);
//            pstmt.setString(2, publishDate);
//            pstmt.setString(3, title);
//            pstmt.setString(4, content);
//
//            int rowsAffected = pstmt.executeUpdate();
//            return rowsAffected > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
}