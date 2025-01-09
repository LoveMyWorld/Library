package Service.weihu;

import Dao.TermDicDao;
import Entity.TermDic;

import java.util.ArrayList;
import java.util.List;

public class TermDicService {
    public static List<TermDic> termDicList = new ArrayList<>();

    public TermDicService() {
    }

    // 获取总读者数
    public int getTotalTermDicNum() {
        TermDicDao termDicDao = new TermDicDao();
        termDicList.clear();
        termDicList = termDicDao.getAllTermDics();
        int totalTermDicNum = termDicList.size();
        return totalTermDicNum;
    }

    // 获取当前页的读者数据
    public List<TermDic> getCurrentPage(int currentPage) {
        new TermDicDao();
        List<TermDic> currentPageList = new ArrayList<>();

        for (int i = 16 * (currentPage - 1); i < 16 * currentPage && i < termDicList.size(); ++i) {
            currentPageList.add(termDicList.get(i));
        }

        return currentPageList;
    }

    // 获取当前页的读者数
    public int getCurrentListTermDicNum() {
        return termDicList.size();
    }

    // 按条件搜索读者
    public List<TermDic> getSelectTermDic(String searchField, String searchValue) {
        TermDicDao termDicDao = new TermDicDao();
        List<TermDic> selectTermDicList = termDicDao.findTermDicsBySearch(searchField, searchValue);
        termDicList.clear();
        termDicList.addAll(selectTermDicList);
        return selectTermDicList;
    }
}
