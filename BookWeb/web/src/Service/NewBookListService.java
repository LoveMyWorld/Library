package Service;

import Dao.NewBookListDao;
import Entity.NewBookList;

import java.util.List;

public class NewBookListService {
    public int CatelogListToNewBookList(){
        NewBookListDao newBookListDao = new NewBookListDao();
        int successful = -1 ;
        successful = newBookListDao.clearNewBookList();
        successful = newBookListDao.insertByCatelogList();
        return successful;
    }

    public List<NewBookList> getAllNewBookList(){
        NewBookListDao newBookListDao = new NewBookListDao();
        return newBookListDao.getAllNewBookList();
    }
}
