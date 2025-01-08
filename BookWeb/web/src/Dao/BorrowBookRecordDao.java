package Dao;

import Entity.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

public class BorrowBookRecordDao {
    //通过readID找天数
    public int getBorrowDayByReaderID(String readID) {
        Dao dao = new Dao();
        String sql = "";
        int borrowDay = 0;
        sql =
        "SELECT rlevel_rule.borrowDay\n" +
                "        FROM library.reader\n" +
                "        JOIN library.rlevel_rule\n" +
                "        ON library.reader.readerLevel = library.rlevel_rule.readerLevel\n" +
                "        WHERE library.reader.readID = ?";


        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, readID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                borrowDay = rs.getInt("borrowDay");
            }
            dao.AllClose(); // 关闭资源
        } catch (SQLException e) {
            throw new RuntimeException("查询最大借阅天数失败", e);
        }
        return borrowDay;
    }
    //预约的一条记录加入借阅记录
    public boolean addBorrowRecord(Appointment appointment, LocalDate currentDate) {
        Dao dao = new Dao();
        String sql = "";

        // 从 Appointment 对象中获取必要的信息

        String readID = appointment.getReadID();
        String Name = appointment.getName();
        String phoneNum = appointment.getPhoneNum();
        String bookID = appointment.getBookID();
        String title = appointment.getTitle();

        // 创建 BorrowBookRecord 对象
//        BorrowBookRecord borrowRecord = new BorrowBookRecord();
//        borrowRecord.setBookID(bookID);
//        borrowRecord.setReadID(readID);
//        borrowRecord.setName(Name);
//        borrowRecord.setPhoneNum(phoneNum);
//        borrowRecord.setTitle(title);
//        borrowRecord.setBorrowStart(currentDate);

        sql = "INSERT INTO borrowbookrecord (readID, name, phoneNum, bookID, title, borrowStart, borrowEnd,borrowStatus) VALUES (?, ?,?, ?, ?, ?, ?, ?)";
        boolean isSuccess = false;

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, appointment.getReadID());
            ps.setString(2, appointment.getName());
            ps.setString(3, appointment.getPhoneNum());
            ps.setString(4, appointment.getBookID());
            ps.setString(5, appointment.getTitle());
            ps.setDate(6, java.sql.Date.valueOf(currentDate));
            // 假设 borrowEnd 是当前日期加上30天，你可以根据实际情况调整
            ps.setDate(7, java.sql.Date.valueOf(currentDate.plusDays(getBorrowDayByReaderID(readID))));
            ps.setString(8,"借阅中");

            int rowsAffected = ps.executeUpdate();
            isSuccess = rowsAffected > 0;

            dao.AllClose(); // 关闭资源，假设这个方法关闭了 PreparedStatement 和 Connection
        } catch (SQLException e) {
//            return e.toString();
            throw new RuntimeException("插入数据失败", e);
        }

        return isSuccess;
    }
    //从reader中通过读者编号找到读者的name和phoneNum,通过bookID找到书的title,borrowStart=currentDate,borrowEnd=currentDate+borrowDay,borrowStatus="借阅中"
    public boolean mIntoBorrowBookRecord(String readID,String bookID,LocalDate currentDate ){
        ReaderDao readerDao = new ReaderDao();
        Reader reader = null;
        Reader tmpReader = readerDao.getReaderByID(readID);
        if(tmpReader.getReadID()!=null){
            reader = tmpReader;
        };
        if(reader != null){
            LiutongDao liutongDao = new LiutongDao();
            Liutong liutong = null;
            Liutong tmpLiutong = liutongDao.FindLiutongByBookID(bookID);
            if(tmpLiutong.getBookID()!=null){
                liutong = tmpLiutong;
            };
            if(liutong != null){
                Appointment appointment = new Appointment();
                appointment.setReadID(readID);
                appointment.setBookID(bookID);
                appointment.setName(reader.getName());
                appointment.setPhoneNum(reader.getPhoneNum());
                appointment.setTitle(liutong.getTitle());
                addBorrowRecord(appointment, currentDate);
                return true;
            }
        }
        return false;

    }

}
