package Service;

import Dao.AppointmentDao;
import Dao.YanshouDao;
import Entity.Appointment;
import Entity.Appointment;

import java.util.ArrayList;
import java.util.List;

import static Servlet.YanshouServlet.PAGE_SIZE;

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
}
