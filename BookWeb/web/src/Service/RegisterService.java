package Service;

import Dao.UserDao;
import Entity.User;

public class RegisterService {
    public String isCorrect(User user) {
        String ret = "true";
        String uname = user.getUsername();
        String pwd = user.getPassword();

        // 用户名是否为12位数字
        if (uname.length() != 12 || !uname.matches("\\d{12}")) {
            ret = "账号必须是12位数字";
        } else {
            // 用户名是否存在
            UserDao userDao = new UserDao();
            User correctuser = userDao.findUserByUserName(uname);
            if (correctuser != null) {
                // 用户名已存在
                ret = "账号已存在";
            } else {
                // 校验密码长度
                if (pwd.length() < 6) {
                    ret = "密码长度不能小于6";
                } else if (pwd.length() > 12) {
                    ret = "密码长度不能大于12";
                } else {
                    ret = "true";
                }
            }
        }
        return ret;
    }
}
