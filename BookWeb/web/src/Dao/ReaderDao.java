package Dao;

import Entity.Gender;
import Entity.Reader;
import Entity.ReaderLevelType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ReaderDao {
    public ReaderDao() {}

    public List<Reader> getAllReaders(){
        Dao dao = new Dao();
        List<Reader> readerList = new ArrayList<>();
        String sql = "SELECT * FROM library.reader"; // 表名是reader
        try (
             PreparedStatement ps = dao.conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reader reader = new Reader();
                reader.setReadID( rs.getString("readID"));
                reader.setName( rs.getString("name"));
                String t= rs.getString("gender");
                reader.setGender(Gender.fromDescription(t));
                reader.setBirthDay((LocalDate)rs.getObject("birthDay", LocalDate.class));
                reader.setUnit( rs.getString("unit"));
                reader.setHomeAdd( rs.getString("homeAdd"));
                reader.setPhoneNum( rs.getString("PhoneNum"));
                reader.setEmailAdd( rs.getString("emailAdd"));
                String rt= rs.getString("readerLevel");
                reader.setReaderLevel(ReaderLevelType.fromDescription(rt));
                reader.setCreditPoint( rs.getInt("creditPoint"));
                readerList.add(reader);
            }

            dao.AllClose();
            return readerList;
        }catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

     public List<Reader> findReadersBySearch(String searchField, String searchValue) {
         Dao dao = new Dao();
         List<Reader> readerList = new ArrayList<>();
         String sql = "";

         // 根据 searchField 决定查询条件
         if (searchField.equals("readID")) {
             sql = "SELECT * FROM library.reader WHERE readID LIKE ?";
         } else if (searchField.equals("name")) {
             sql = "SELECT * FROM library.reader WHERE name LIKE ?";
         } else if (searchField.equals("readerLevel")) {
             sql = "SELECT * FROM library.reader WHERE readerLevel LIKE ?";
         }

         try {
             PreparedStatement ps = dao.conn.prepareStatement(sql);
             ps.setString(1, "%" + searchValue + "%");  // 使用模糊匹配
             ResultSet rs = ps.executeQuery();

             // 遍历查询结果，构建 Reader 对象列表
             while (rs.next()) {
                 Reader reader = new Reader();
                 reader.setReadID(rs.getString("readID"));
                 reader.setName(rs.getString("name"));
                 String genderStr = rs.getString("gender");
                 reader.setGender(Gender.fromDescription(genderStr));
                 reader.setBirthDay((LocalDate) rs.getObject("birthDay", LocalDate.class));
                 reader.setUnit(rs.getString("unit"));
                 reader.setHomeAdd(rs.getString("homeAdd"));
                 reader.setPhoneNum(rs.getString("PhoneNum"));
                 reader.setEmailAdd(rs.getString("emailAdd"));
                 String readerLevelStr = rs.getString("readerLevel");
                 reader.setReaderLevel(ReaderLevelType.fromDescription(readerLevelStr));
                 reader.setCreditPoint(rs.getInt("creditPoint"));
                 readerList.add(reader);
             }

             dao.AllClose();
             return readerList;
         } catch (SQLException e) {
             throw new RuntimeException("查询数据失败", e);
         }
     }




    // 其他数据库操作方法，如添加、更新、删除等
}
