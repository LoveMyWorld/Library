package Service;

import Dao.LiutongDao;
import Entity.Liutong;

import java.util.ArrayList;
import java.util.List;

public class SearchService {
    public static List<Liutong> liutongList = new ArrayList<>();

    public SearchService() {
    }

    // 获取总数数
    public int getTotalLiutongNum() {
        LiutongDao liutongDao = new LiutongDao();
        liutongList.clear();
        liutongList = liutongDao.getAllLiutongs();
        int totalLiutongNum = liutongList.size();
        return totalLiutongNum;
    }

    // 获取当前页的读者数据
    public List<Liutong> getCurrentPage(int currentPage) {
        new LiutongDao();
        List<Liutong> currentPageList = new ArrayList<>();

        for (int i = 16 * (currentPage - 1); i < 16 * currentPage && i < liutongList.size(); ++i) {
            currentPageList.add(liutongList.get(i));
        }

        return currentPageList;
    }

    // 获取当前页的读者数
    public int getCurrentListLiutongNum() {
        return liutongList.size();
    }

    // 按条件搜索读者
    public List<Liutong> getSelectLiutong(String searchField, String searchValue) {
        LiutongDao liutongDao = new LiutongDao();
        List<Liutong> selectLiutongList = liutongDao.findLiutongsBySearch(searchField, searchValue);
        liutongList.clear();
        liutongList.addAll(selectLiutongList);
        return selectLiutongList;
    }
}
