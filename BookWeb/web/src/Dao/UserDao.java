package Dao;

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
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("userphone"));

            }

            dao.AllClose();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }

}
