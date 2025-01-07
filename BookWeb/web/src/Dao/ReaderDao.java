package Dao;

import Entity.*;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ReaderDao {
    public ReaderDao() {
    }

    public List<Reader> getAllReaders() {
        Dao dao = new Dao();
        List<Reader> readerList = new ArrayList<>();
        String sql = "SELECT * FROM library.reader"; // 表名是reader
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reader reader = new Reader();
                reader.setReadID(rs.getString("readID"));
                reader.setName(rs.getString("name"));
                String t = rs.getString("gender");
                reader.setGender(Gender.fromDescription(t));
                reader.setBirthDay((Date) rs.getObject("birthDay", Date.class));
                reader.setUnit(rs.getString("unit"));
                reader.setHomeAdd(rs.getString("homeAdd"));
                reader.setPhoneNum(rs.getString("PhoneNum"));
                reader.setEmailAdd(rs.getString("emailAdd"));
                String rt = rs.getString("readerLevel");
                reader.setReaderLevel(ReaderLevelType.fromDescription(rt));
                reader.setCreditPoint(rs.getInt("creditPoint"));
                readerList.add(reader);
            }

            dao.AllClose();
            return readerList;
        } catch (SQLException e) {
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
                reader.setBirthDay((Date) rs.getObject("birthDay", Date.class));
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

    // 添加
    public boolean addReader(Reader reader) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.reader (readID, name, gender, birthDay, unit, homeAdd, phoneNum, emailAdd, readerLevel, creditPoint) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, reader.getReadID());
            ps.setString(2, reader.getName());
            ps.setString(3, reader.getGender().getDescription());
            ps.setDate(4, reader.getBirthDay());
            ps.setString(5, reader.getUnit());
            ps.setString(6, reader.getHomeAdd());
            ps.setString(7, reader.getPhoneNum());
            ps.setString(8, reader.getEmailAdd());
            ps.setString(9, reader.getReaderLevel().getDescription());
            ps.setInt(10, reader.getCreditPoint());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {

            throw new RuntimeException("添加备份信息数据失败", e);
        }
    }

    // 查看
    public Reader getReaderByID(String readID) {
        Dao dao = new Dao();
        Reader reader = new Reader();
        String sql = "SELECT * FROM library.reader WHERE readID = ? LIMIT 1";
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, readID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                reader.setReadID(rs.getString("readID"));
                reader.setName(rs.getString("name"));
                String t = rs.getString("gender");
                reader.setGender(Gender.fromDescription(t));
                reader.setBirthDay((Date) rs.getObject("birthDay", Date.class));
                reader.setUnit(rs.getString("unit"));
                reader.setHomeAdd(rs.getString("homeAdd"));
                reader.setPhoneNum(rs.getString("PhoneNum"));
                reader.setEmailAdd(rs.getString("emailAdd"));
                String rt = rs.getString("readerLevel");
                reader.setReaderLevel(ReaderLevelType.fromDescription(rt));
                reader.setCreditPoint(rs.getInt("creditPoint"));

            }
            dao.AllClose();
            return reader; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    // 更新
    public boolean updateReader(Reader reader) {
        Dao dao = new Dao();
        String sql = "UPDATE library.reader SET " +
                "name = ?, gender = ?, birthDay = ?, unit = ?, homeAdd = ?, phoneNum = ?, emailAdd = ?, readerLevel = ?, creditPoint = ? " +
                "WHERE readID = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, reader.getName());
            ps.setString(2, reader.getGender().getDescription());
            ps.setDate(3, reader.getBirthDay());
            ps.setString(4, reader.getUnit());
            ps.setString(5, reader.getHomeAdd());
            ps.setString(6, reader.getPhoneNum());
            ps.setString(7, reader.getEmailAdd());
            ps.setString(8, reader.getReaderLevel().getDescription());
            ps.setInt(9, reader.getCreditPoint());
            ps.setString(10, reader.getReadID());  // 根据读者ID更新

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {
            throw new RuntimeException("修改读者信息数据失败", e);
        }
    }

    // 删除
    public boolean deleteReader(String readID) {
        Dao dao = new Dao();
        String sql = "DELETE FROM library.reader WHERE readID = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {
            ps.setString(1, readID);  // 设置要删除的读者ID

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;  // 如果删除的行数大于0，表示删除成功
        } catch (SQLException e) {
            throw new RuntimeException("删除读者信息数据失败", e);
        }
    }
}
