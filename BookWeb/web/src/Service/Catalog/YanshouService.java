package Service.Catalog;
import Dao.YanshouDao;
import Entity.Yanshou;

import java.util.ArrayList;
import java.util.List;

import static Servlet.Catalog.YanshouServlet.PAGE_SIZE;

public class YanshouService {

    // 相当于 当前搜索条件下的缓存
    public static List<Yanshou> yanshouList = new ArrayList<>();

    public YanshouService() {

    }

    public int getTotalBookNum(){
        YanshouDao yanshouDao = new YanshouDao();
        yanshouList.clear();
        yanshouList = yanshouDao.getAllData();
        int totalBookNum = yanshouList.size();
        return totalBookNum;
    }

    public List<Yanshou> getCurrentPage(int currentPage){
        YanshouDao yanshouDao = new YanshouDao();
        List <Yanshou> currentPageList=new ArrayList<>();
        for(int i=PAGE_SIZE*(currentPage-1);i<PAGE_SIZE*currentPage&&i<yanshouList.size();i++){
            currentPageList.add(yanshouList.get(i));
        }
        return currentPageList;
    }

    public int getCurrentListBookNum(){
        return yanshouList.size();
    }
    public  List<Yanshou> getSelectBook(String searchField,String searchValue){
        YanshouDao yanshouDao = new YanshouDao();
        List<Yanshou> selectBookList=yanshouDao.findBooksBySearch(searchField,searchValue);
        yanshouList.clear();
        yanshouList.addAll(selectBookList);
        return selectBookList;
    }

}
