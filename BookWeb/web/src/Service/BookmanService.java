package Service;

import Dao.BookmanDao;
import Entity.Bookman;

import java.util.ArrayList;
import java.util.List;

public class BookmanService {
    public static List<Bookman> bookmanList = new ArrayList<>();

    public BookmanService() {
    }

    // 获取总读者数
    public int getTotalBookmanNum() {
        BookmanDao bookmanDao = new BookmanDao();
        bookmanList.clear();
        bookmanList = bookmanDao.getAllBookmans();
        int totalBookmanNum = bookmanList.size();
        return totalBookmanNum;
    }

    // 获取当前页的读者数据
    public List<Bookman> getCurrentPage(int currentPage) {
        new BookmanDao();
        List<Bookman> currentPageList = new ArrayList<>();

        for (int i = 16 * (currentPage - 1); i < 16 * currentPage && i < bookmanList.size(); ++i) {
            currentPageList.add(bookmanList.get(i));
        }

        return currentPageList;
    }

    // 获取当前页的读者数
    public int getCurrentListBookmanNum() {
        return bookmanList.size();
    }

    // 按条件搜索读者
    public List<Bookman> getSelectBookman(String searchField, String searchValue) {
        BookmanDao bookmanDao = new BookmanDao();
        List<Bookman> selectBookmanList = bookmanDao.findBookmansBySearch(searchField, searchValue);
        bookmanList.clear();
        bookmanList.addAll(selectBookmanList);
        return selectBookmanList;
    }
}
