package Service;
import Dao.CaifangDao;
import Entity.Caifang;

import java.util.ArrayList;
import java.util.List;

import static Servlet.DingdanServlet.PAGE_SIZE;

public class DingdanService {

    // 相当于 当前搜索条件下的缓存
    public static List<Caifang> dingdanList = new ArrayList<>();

    public DingdanService() {
    }

    public int getTotalBookNum(){
        CaifangDao caifangdao = new CaifangDao();
        dingdanList.clear();
        dingdanList = caifangdao.getAllData();
        int totalOrderNum = dingdanList.size();
        return totalOrderNum;
    }

    public List<Caifang> getCurrentPage(int currentPage){
        CaifangDao caifangdao = new CaifangDao();
        List<Caifang> currentPageList = new ArrayList<>();
        for(int i = PAGE_SIZE * (currentPage - 1); i < PAGE_SIZE * currentPage && i < dingdanList.size(); i++){
            currentPageList.add(dingdanList.get(i));
        }
        return currentPageList;
    }

    public int getCurrentListBookNum(){
        return dingdanList.size();
    }

    public List<Caifang> getSelectBook(String searchField, String searchValue){
        CaifangDao caifangdao = new CaifangDao();
        List<Caifang> selectOrderList = caifangdao.findBooksBySearch(searchField, searchValue);
        dingdanList.clear();
        dingdanList.addAll(selectOrderList);
        return selectOrderList;
    }
}