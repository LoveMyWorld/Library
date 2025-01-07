package Service;

import Dao.AnnouncementDao;
import Entity.Announcement;

import java.util.ArrayList;
import java.util.List;


public class HistoryAnnouncementService {



    public List<Announcement> getLastTenLines(){
        AnnouncementDao dao = new AnnouncementDao();
        List<Announcement> dataList = dao.getLastTenLines();
        return dataList;






    }





}
