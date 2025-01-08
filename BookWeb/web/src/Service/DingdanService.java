
package Service;

import Dao.DingdanDao;
import Entity.Dingdan;

import java.util.ArrayList;
import java.util.List;

public class DingdanService {
    public static List<Dingdan> dingdanList = new ArrayList<>();

    public DingdanService() {
    }

    // 获取总读者数
    public int getTotalDingdanNum() {
        DingdanDao dingdanDao = new DingdanDao();
        dingdanList.clear();
        dingdanList = dingdanDao.getAllDingdans();
        int totalDingdanNum = dingdanList.size();
        return totalDingdanNum;
    }

    // 获取当前页的读者数据
    public List<Dingdan> getCurrentPage(int currentPage) {
        new DingdanDao();
        List<Dingdan> currentPageList = new ArrayList<>();

        for (int i = 16 * (currentPage - 1); i < 16 * currentPage && i < dingdanList.size(); ++i) {
            currentPageList.add(dingdanList.get(i));
        }

        return currentPageList;
    }

    // 获取当前页的读者数
    public int getCurrentListDingdanNum() {
        return dingdanList.size();
    }

    // 按条件搜索读者
    public List<Dingdan> getSelectDingdan(String searchField, String searchValue) {
        DingdanDao dingdanDao = new DingdanDao();
        List<Dingdan> selectDingdanList = dingdanDao.findDingdansBySearch(searchField, searchValue);
        dingdanList.clear();
        dingdanList.addAll(selectDingdanList);
        return selectDingdanList;
    }
}







































//package Service;
//import Dao.CaifangDao;
//import Entity.Caifang;
//
//import java.util.ArrayList;
//import java.util.List;
//
//import static Servlet.DingdanServlet.PAGE_SIZE;
//
//public class DingdanService {
//
//    // 相当于 当前搜索条件下的缓存
//    public static List<Caifang> dingdanList = new ArrayList<>();
//
//    public DingdanService() {
//    }
//
//    public int getTotalBookNum(){
//        CaifangDao caifangdao = new CaifangDao();
//        dingdanList.clear();
//        dingdanList = caifangdao.getAllData();
//        int totalOrderNum = dingdanList.size();
//        return totalOrderNum;
//    }
//
//    public List<Caifang> getCurrentPage(int currentPage){
//        CaifangDao caifangdao = new CaifangDao();
//        List<Caifang> currentPageList = new ArrayList<>();
//        for(int i = PAGE_SIZE * (currentPage - 1); i < PAGE_SIZE * currentPage && i < dingdanList.size(); i++){
//            currentPageList.add(dingdanList.get(i));
//        }
//        return currentPageList;
//    }
//
//    public int getCurrentListBookNum(){
//        return dingdanList.size();
//    }
//
//    public List<Caifang> getSelectBook(String searchField, String searchValue){
//        CaifangDao caifangdao = new CaifangDao();
//        List<Caifang> selectOrderList = caifangdao.findBooksBySearch(searchField, searchValue);
//        dingdanList.clear();
//        dingdanList.addAll(selectOrderList);
//        return selectOrderList;
//    }
//}