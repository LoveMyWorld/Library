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
    public Appointment getOneBookByApID(long apID){
        Dao dao = new Dao();
        Appointment appointment = null;
        String sql="select * from Library.appointmentlist where apID like ?";
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setLong(1, apID);
            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 Appointment 对象并添加到列表
            while (rs.next()) {
                appointment = new Appointment();
                appointment.setApID(rs.getLong("apID"));
                appointment.setReadID(rs.getString("readID"));
                appointment.setName(rs.getString("name"));
                appointment.setPhoneNum(rs.getString("phoneNum"));
                appointment.setBookID(rs.getString("bookID"));
                appointment.setTitle(rs.getString("title"));
                appointment.setAppointmentStart(rs.getObject("appointmentStart", LocalDate.class));
                appointment.setAppointmentEnd(rs.getObject("appointmentEnd", LocalDate.class));

            }
            dao.AllClose();
            return appointment; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }
    //删除预约表的此条记录
    public boolean deleteAppointmentByApID(long apID) {
        Dao dao = new Dao();
        String sql = "DELETE FROM Library.appointmentlist WHERE apID = ?";

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setLong(1, apID); // 设置要删除的预约记录的 apID
            int rowsAffected = ps.executeUpdate(); // 执行删除操作

            dao.AllClose(); // 关闭资源
            return rowsAffected > 0; // 如果影响的行数大于0，表示删除成功
        } catch (SQLException e) {
            throw new RuntimeException("删除预约记录失败", e);
        }
    }
    public int Ap_FindBookNumByBookID(String bookID) {
        Dao dao = new Dao();
        int rowCount = 0; // 初始化行数为0
        String sql = "SELECT COUNT(*) FROM library.appointmentlist WHERE bookID = ?";

        try {
            // 准备 PreparedStatement
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            // 设置参数，bookID 作为搜索条件
            ps.setString(1, bookID);

            // 执行查询操作
            ResultSet rs = ps.executeQuery();

            // 检查结果集，获取行数
            if (rs.next()) {
                rowCount = rs.getInt(1); // 获取第一列的值，即行数
            }

            // 关闭资源
            dao.AllClose();
            return rowCount; // 返回行数
        } catch (SQLException e) {
            // 如果发生 SQL 异常，抛出运行时异常
            throw new RuntimeException("查找数据失败", e);
        }
    }

}


