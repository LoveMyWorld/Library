package Service.ReturnBook;

import Dao.BorrowBookRecordDao;
import Entity.BorrowBookRecord;

import java.util.ArrayList;
import java.util.List;

import static Servlet.Catalog.YanshouServlet.PAGE_SIZE;

public class ReturnBookService {
    // 相当于 当前搜索条件下的缓存
    public static List<BorrowBookRecord> BorrowBookRecordList = new ArrayList<>();

    public ReturnBookService() {

    };

    public int getTotalBookNum(){
        BorrowBookRecordDao BorrowBookRecordDao = new BorrowBookRecordDao();
        BorrowBookRecordList.clear();
        BorrowBookRecordList = BorrowBookRecordDao.getAllData();
        int totalBookNum = BorrowBookRecordList.size();
        return totalBookNum;
    }

    public List<BorrowBookRecord> getCurrentPage(int currentPage){
        BorrowBookRecordDao BorrowBookRecordDao = new BorrowBookRecordDao();
        List <BorrowBookRecord> currentPageList=new ArrayList<>();
        for(int i=PAGE_SIZE*(currentPage-1);i<PAGE_SIZE*currentPage&&i<BorrowBookRecordList.size();i++){
            currentPageList.add(BorrowBookRecordList.get(i));
        }
        return currentPageList;
    }

    public int getCurrentListBookNum(){
        return BorrowBookRecordList.size();
    }
    public  List<BorrowBookRecord> getSelectBook(String searchField,String searchValue){
        BorrowBookRecordDao BorrowBookRecordDao = new BorrowBookRecordDao();
        List<BorrowBookRecord> selectBookList=BorrowBookRecordDao.findBooksBySearch(searchField,searchValue);
        BorrowBookRecordList.clear();
        BorrowBookRecordList.addAll(selectBookList);
        return selectBookList;
    }
}
