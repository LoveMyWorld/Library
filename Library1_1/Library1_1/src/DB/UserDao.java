package DB;

import Entity.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {

    public User findUserByUsername(String username){

        Dao dao = new Dao();
        String sql = "select * from library.user where username=?";
        User user = null;
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = dao.dbsel(ps);
            while(rs.next()){
                user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("userpwd"));

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }

}
