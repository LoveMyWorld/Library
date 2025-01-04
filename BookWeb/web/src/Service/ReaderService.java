package Service;

import Dao.ReaderDao;
import Entity.Reader;

import java.util.ArrayList;
import java.util.List;

public class ReaderService {
    public static List<Reader> readerList = new ArrayList<>();

    public ReaderService() {
    }

    // 获取总读者数
    public int getTotalReaderNum() {
        ReaderDao readerDao = new ReaderDao();
        readerList.clear();
        readerList = readerDao.getAllReaders();
        int totalReaderNum = readerList.size();
        return totalReaderNum;
    }

    // 获取当前页的读者数据
    public List<Reader> getCurrentPage(int currentPage) {
        new ReaderDao();
        List<Reader> currentPageList = new ArrayList<>();

        for (int i = 16 * (currentPage - 1); i < 16 * currentPage && i < readerList.size(); ++i) {
            currentPageList.add(readerList.get(i));
        }

        return currentPageList;
    }

    // 获取当前页的读者数
    public int getCurrentListReaderNum() {
        return readerList.size();
    }

    // 按条件搜索读者
    public List<Reader> getSelectReader(String searchField, String searchValue) {
        ReaderDao readerDao = new ReaderDao();
        List<Reader> selectReaderList = readerDao.findReadersBySearch(searchField, searchValue);
        readerList.clear();
        readerList.addAll(selectReaderList);
        return selectReaderList;
    }
}
