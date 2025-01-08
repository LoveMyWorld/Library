package Service;

import Dao.PrinteryDao;
import Entity.Printery;

import java.util.ArrayList;
import java.util.List;

public class PrinteryService {
    public static List<Printery> printeryList = new ArrayList<>();

    public PrinteryService() {
    }

    // 获取总读者数
    public int getTotalPrinteryNum() {
        PrinteryDao printeryDao = new PrinteryDao();
        printeryList.clear();
        printeryList = printeryDao.getAllPrinterys();
        int totalPrinteryNum = printeryList.size();
        return totalPrinteryNum;
    }

    // 获取当前页的读者数据
    public List<Printery> getCurrentPage(int currentPage) {
        new PrinteryDao();
        List<Printery> currentPageList = new ArrayList<>();

        for (int i = 16 * (currentPage - 1); i < 16 * currentPage && i < printeryList.size(); ++i) {
            currentPageList.add(printeryList.get(i));
        }

        return currentPageList;
    }

    // 获取当前页的读者数
    public int getCurrentListPrinteryNum() {
        return printeryList.size();
    }

    // 按条件搜索读者
    public List<Printery> getSelectPrintery(String searchField, String searchValue) {
        PrinteryDao printeryDao = new PrinteryDao();
        List<Printery> selectPrinteryList = printeryDao.findPrinterysBySearch(searchField, searchValue);
        printeryList.clear();
        printeryList.addAll(selectPrinteryList);
        return selectPrinteryList;
    }
}
