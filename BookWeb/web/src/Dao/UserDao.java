package Dao;

import Entity.User;
import Entity.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {

    public User findUserByUserName(String userName) {
        User user = null;

        String sql = "select * from library.user where username = ?";

        Dao dao = new Dao();

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, userName);
            ResultSet rs = dao.dbsel(ps);

            while(rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("userpwd"));

            }

            dao.AllClose();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }

    public User findUserByAdmName(String userName) {
        User user = null;

        String sql = "select * from library.administrator where admname = ?";

        Dao dao = new Dao();

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, userName);
            ResultSet rs = dao.dbsel(ps);

            while(rs.next()) {
                user = new User();
                user.setUsername(rs.getString("admname"));
                user.setPassword(rs.getString("admpwd"));

            }

            dao.AllClose();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }

    // 添加
    public boolean addUser(User user) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.user (username, userpwd) " +
                "VALUES (?, ?)";
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {

            throw new RuntimeException("添加用户信息失败", e);
        }
    }


}
