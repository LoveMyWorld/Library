package Service.weihu;

import Dao.CollectionDao;
import Entity.Collection;

import java.util.ArrayList;
import java.util.List;

public class CollectionService {
    public static List<Collection> collectionList = new ArrayList<>();

    public CollectionService() {
    }

    // 获取总读者数
    public int getTotalCollectionNum() {
        CollectionDao collectionDao = new CollectionDao();
        collectionList.clear();
        collectionList = collectionDao.getAllCollections();
        int totalCollectionNum = collectionList.size();
        return totalCollectionNum;
    }

    // 获取当前页的读者数据
    public List<Collection> getCurrentPage(int currentPage) {
        new CollectionDao();
        List<Collection> currentPageList = new ArrayList<>();

        for (int i = 16 * (currentPage - 1); i < 16 * currentPage && i < collectionList.size(); ++i) {
            currentPageList.add(collectionList.get(i));
        }

        return currentPageList;
    }

    // 获取当前页的读者数
    public int getCurrentListCollectionNum() {
        return collectionList.size();
    }

    // 按条件搜索读者
    public List<Collection> getSelectCollection(String searchField, String searchValue) {
        CollectionDao collectionDao = new CollectionDao();
        List<Collection> selectCollectionList = collectionDao.findCollectionsBySearch(searchField, searchValue);
        collectionList.clear();
        collectionList.addAll(selectCollectionList);
        return selectCollectionList;
    }
}
