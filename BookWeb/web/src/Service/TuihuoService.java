
package Service;

import Dao.TuihuoDao;
import Entity.Tuihuo;

import java.util.ArrayList;
import java.util.List;

public class TuihuoService {
    public static List<Tuihuo> tuihuoList = new ArrayList<>();

    public TuihuoService() {
    }

    // 获取总读者数
    public int getTotalTuihuoNum() {
        TuihuoDao tuihuoDao = new TuihuoDao();
        tuihuoList.clear();
        tuihuoList = tuihuoDao.getAllTuihuos();
        int totalTuihuoNum = tuihuoList.size();
        return totalTuihuoNum;
    }

    // 获取当前页的读者数据
    public List<Tuihuo> getCurrentPage(int currentPage) {
        new TuihuoDao();
        List<Tuihuo> currentPageList = new ArrayList<>();

        for (int i = 16 * (currentPage - 1); i < 16 * currentPage && i < tuihuoList.size(); ++i) {
            currentPageList.add(tuihuoList.get(i));
        }

        return currentPageList;
    }

    // 获取当前页的读者数
    public int getCurrentListTuihuoNum() {
        return tuihuoList.size();
    }

    // 按条件搜索读者
//    public List<Tuihuo> getSelectTuihuo(String searchField, String searchValue) {
//        TuihuoDao tuihuoDao = new TuihuoDao();
//        List<Tuihuo> selectTuihuoList = tuihuoDao.findTuihuosBySearch(searchField, searchValue);
//        tuihuoList.clear();
//        tuihuoList.addAll(selectTuihuoList);
//        return selectTuihuoList;
//    }
}







































//package Service;
//import Dao.CaifangDao;
//import Entity.Caifang;
//
//import java.util.ArrayList;
//import java.util.List;
//
//import static Servlet.TuihuoServlet.PAGE_SIZE;
//
//public class TuihuoService {
//
//    // 相当于 当前搜索条件下的缓存
//    public static List<Caifang> tuihuoList = new ArrayList<>();
//
//    public TuihuoService() {
//    }
//
//    public int getTotalBookNum(){
//        CaifangDao caifangdao = new CaifangDao();
//        tuihuoList.clear();
//        tuihuoList = caifangdao.getAllData();
//        int totalOrderNum = tuihuoList.size();
//        return totalOrderNum;
//    }
//
//    public List<Caifang> getCurrentPage(int currentPage){
//        CaifangDao caifangdao = new CaifangDao();
//        List<Caifang> currentPageList = new ArrayList<>();
//        for(int i = PAGE_SIZE * (currentPage - 1); i < PAGE_SIZE * currentPage && i < tuihuoList.size(); i++){
//            currentPageList.add(tuihuoList.get(i));
//        }
//        return currentPageList;
//    }
//
//    public int getCurrentListBookNum(){
//        return tuihuoList.size();
//    }
//
//    public List<Caifang> getSelectBook(String searchField, String searchValue){
//        CaifangDao caifangdao = new CaifangDao();
//        List<Caifang> selectOrderList = caifangdao.findBooksBySearch(searchField, searchValue);
//        tuihuoList.clear();
//        tuihuoList.addAll(selectOrderList);
//        return selectOrderList;
//    }
//}