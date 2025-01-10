package Service.Catalog;

import Dao.DamageListDao;
import Entity.DamageList;

import java.util.ArrayList;
import java.util.List;

import static Servlet.Catalog.YanshouServlet.PAGE_SIZE;

public class DamageService {
    // 相当于 当前搜索条件下的缓存
    public static List<DamageList> damageLists = new ArrayList<>();

    public DamageService() {

    }

    public int getTotalBookNum(){
        DamageListDao damageDao = new DamageListDao();
        damageLists.clear();
        damageLists = damageDao.getAllData();
        int totalBookNum = damageLists.size();
        return totalBookNum;
    }

    public List<DamageList> getCurrentPage(int currentPage){
        DamageListDao damageDao = new DamageListDao();
        List <DamageList> currentPageList=new ArrayList<>();
        for(int i=PAGE_SIZE*(currentPage-1);i<PAGE_SIZE*currentPage&&i<damageLists.size();i++){
            currentPageList.add(damageLists.get(i));
        }
        return currentPageList;
    }

    public int getCurrentListBookNum(){
        return damageLists.size();
    }
    public  List<DamageList> getSelectBook(String searchField,String searchValue){
        DamageListDao damageDao = new DamageListDao();
        List<DamageList> selectBookList=damageDao.findBooksBySearch(searchField,searchValue);
        damageLists.clear();
        damageLists.addAll(selectBookList);
        return selectBookList;
    }
}
