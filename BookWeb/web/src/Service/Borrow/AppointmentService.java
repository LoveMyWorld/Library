package Service.Borrow;

import Dao.AppointmentDao;
import Dao.BorrowBookRecordDao;
import Dao.LiutongDao;
import Entity.Appointment;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import static Servlet.Catalog.YanshouServlet.PAGE_SIZE;

public class AppointmentService {
    public static List<Appointment> appointmentList = new ArrayList<>();
    public AppointmentService() {

    }
    public int getTotalBookNum(){
        AppointmentDao appointmentDao = new AppointmentDao();
        appointmentList.clear();
        appointmentList = appointmentDao.getAllData();
        int totalBookNum = appointmentList.size();
        return totalBookNum;
    }

    public List<Appointment> getCurrentPage(int currentPage){
        AppointmentDao appointmentDao = new AppointmentDao();
        List <Appointment> currentPageList=new ArrayList<>();
        for(int i=PAGE_SIZE*(currentPage-1);i<PAGE_SIZE*currentPage&&i<appointmentList.size();i++){
            currentPageList.add(appointmentList.get(i));
        }
        return currentPageList;
    }

    public int getCurrentListBookNum(){
        return appointmentList.size();
    }
    public  List<Appointment> getSelectBook(String searchField,String searchValue){
        AppointmentDao appointmentDao = new AppointmentDao();
        List<Appointment> selectBookList=appointmentDao.findBooksBySearch(searchField,searchValue);
        appointmentList.clear();
        appointmentList.addAll(selectBookList);
        return selectBookList;
    }
    //返回是否审核修改数据库成功
    public  int CheckOneAppointment(long apID, LocalDate currentDate){
        //通过主键String searchField,String searchValue,找到这本书，用了list,其实仅能找到一本
        AppointmentDao appointmentDao = new AppointmentDao();
        Appointment appointment= appointmentDao.getOneBookByApID(apID);
        int  flag=0;//没有找到预约表中的记录
        if(appointment!=null){
            //把这条预约的内容写入借阅记录borrowBookRecord,borrowStart=searchValue,
            //预约记录bookID,后续可以写入appointment的全部，把当前日期写入借书开始,写入借阅清单
            BorrowBookRecordDao borrowBookRecordDao = new BorrowBookRecordDao();


            // 流通库表liutonglist此书的册数减1
            LiutongDao liutongDao = new LiutongDao();
            int rtn2=liutongDao.subOneBookNuminLiutongList(appointment.getBookID());//返回值为1表示有书，减1成功
            if(rtn2==0){
                flag=1;//流通库表没书了
                return flag;
            }
            boolean issuccess=borrowBookRecordDao.addBorrowRecord(appointment,  currentDate);
            if(!issuccess){
                flag=2;//没有写入预约表，操作失误
                return flag;
            }
            //同时删去此条预约内容
            boolean rtn3=appointmentDao.deleteAppointmentByApID(apID);

            if(!rtn3){
                flag=3;//预约内容未删去
                return flag;
            }
            flag=4;
            return flag;
        }
        return flag;
    }



}

