package Service;

import DB.UserDao;
import Entity.User;

public class LoginService {


    public String isCorrect(User user) {

        User correctUser ;
        UserDao userDao = new UserDao();
        correctUser = userDao.findUserByUsername(user.getUsername());
        if(correctUser != null) {
            if(correctUser.getPassword().equals(user.getPassword())) {
                return "true";
            }
            else {
                return "密码错误";
            }
        }
        else {
            return "用户不存在";
        }

    }

}
