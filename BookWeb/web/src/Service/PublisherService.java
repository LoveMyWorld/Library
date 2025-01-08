package Service;

import Dao.PublisherDao;
import Entity.Publisher;

import java.util.ArrayList;
import java.util.List;

public class PublisherService {
    public static List<Publisher> publisherList = new ArrayList<>();

    public PublisherService() {
    }

    // 获取总读者数
    public int getTotalPublisherNum() {
        PublisherDao publisherDao = new PublisherDao();
        publisherList.clear();
        publisherList = publisherDao.getAllPublishers();
        int totalPublisherNum = publisherList.size();
        return totalPublisherNum;
    }

    // 获取当前页的读者数据
    public List<Publisher> getCurrentPage(int currentPage) {
        new PublisherDao();
        List<Publisher> currentPageList = new ArrayList<>();

        for (int i = 16 * (currentPage - 1); i < 16 * currentPage && i < publisherList.size(); ++i) {
            currentPageList.add(publisherList.get(i));
        }

        return currentPageList;
    }

    // 获取当前页的读者数
    public int getCurrentListPublisherNum() {
        return publisherList.size();
    }

    // 按条件搜索读者
    public List<Publisher> getSelectPublisher(String searchField, String searchValue) {
        PublisherDao publisherDao = new PublisherDao();
        List<Publisher> selectPublisherList = publisherDao.findPublishersBySearch(searchField, searchValue);
        publisherList.clear();
        publisherList.addAll(selectPublisherList);
        return selectPublisherList;
    }
}
