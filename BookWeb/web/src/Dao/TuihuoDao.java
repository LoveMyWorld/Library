package Dao;

import Entity.Dingdan;
import Entity.Tuihuo;
import Entity.DocumentType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TuihuoDao {

    public boolean addTuihuo(Dingdan dingdan) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.tuihuo (title,author) " +
                "VALUES (?,?)";
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {
            ps.setString(1, dingdan.getTitle());
            ps.setString(2, dingdan.getAuthor());


            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {

            throw new RuntimeException("添加备份信息数据失败", e);
        }
    }

    public List<Tuihuo> getAllTuihuos() {
        Dao dao = new Dao();
        List<Tuihuo> tuihuoList = new ArrayList<>();
        String sql = "SELECT * FROM library.tuihuo"; // 表名是tuihuo
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Tuihuo tuihuo = new Tuihuo();
                tuihuo.setTitle(rs.getString("title"));
                tuihuo.setAuthor(rs.getString("author"));
//                tuihuo.setBianmu(rs.getBoolean("bianmu"));
                tuihuoList.add(tuihuo);
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tuihuoList;
    }
}