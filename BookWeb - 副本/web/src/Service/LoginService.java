package Service;

import Dao.UserDao;
import Entity.User;

public class LoginService {

    public String isCorrect(User user) {
        String ret = "true";
        String uname = user.getUsername();
        String pwd = user.getPassword();
        String correctpwd = "";

        // 用户名是否存在
        UserDao userDao = new UserDao();
        User correctuser = userDao.findUserByUserName(uname);
        if(correctuser != null) {
            correctpwd = correctuser.getPassword();

            if(correctpwd.equals(pwd)) {
                ret = "true";
            }
            else {
                ret = "密码不正确";
            }
        }
        else {
            // 用户名不存在
            ret = "用户名不存在";
        }
        return ret ;
    }

}
