package Dao;

import Entity.DocumentType;
import Entity.Appointment;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDao {
    public AppointmentDao() {

    }

    ;

    // 查询表中的所有数据并返回
    public List<Appointment> getAllData() {
        Dao dao = new Dao();
        List<Appointment> dataList = new ArrayList<>();     // 用于存储查询结果
        String sql = "SELECT * FROM   library.appointmentlist"; // 查询表中的所有数据

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 Appointment 对象并添加到列表
            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setApID(rs.getLong("apID"));
                appointment.setReadID(rs.getString("readID"));
                appointment.setName(rs.getString("name"));
                appointment.setPhoneNum(rs.getString("phoneNum"));
                appointment.setBookID(rs.getString("bookID"));
                appointment.setTitle(rs.getString("title"));
                appointment.setAppointmentStart(rs.getObject("appointmentStart", LocalDate.class));
                appointment.setAppointmentEnd(rs.getObject("appointmentEnd", LocalDate.class));
                // 根据 Appointment 类的字段继续添加赋值逻辑
                dataList.add(appointment); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }
    public List<Appointment> findBooksBySearch(String searchField,String searchValue) {
        Dao dao = new Dao();
        List<Appointment> dataList = new ArrayList<>();
        String sql="";
        if(searchField.equals("readID")) {
            sql="select * from Library.appointmentlist where readID like ?";
        }
        else if(searchField.equals("name")) {
            sql="select * from Library.appointmentlist where name like ?";
        }
        else if(searchField.equals("bookID")) {
            sql="select * from Library.appointmentlist where bookID like ?";
        }
        else if(searchField.equals("title")){
            sql="select * from Library.appointmentlist where title like ?";
        }
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%"+searchValue+"%");
            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 Appointment 对象并添加到列表
            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setApID(rs.getLong("apID"));
                appointment.setReadID(rs.getString("readID"));
                appointment.setName(rs.getString("name"));
                appointment.setPhoneNum(rs.getString("phoneNum"));
                appointment.setBookID(rs.getString("bookID"));
                appointment.setTitle(rs.getString("title"));
                appointment.setAppointmentStart(rs.getObject("appointmentStart", LocalDate.class));
                appointment.setAppointmentEnd(rs.getObject("appointmentEnd", LocalDate.class));
                // 根据 Appointment 类的字段继续添加赋值逻辑
                dataList.add(appointment); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }
}
