package Service;

import Dao.TongbaoDao;
import Entity.Tongbao;

import java.util.ArrayList;
import java.util.List;


public class UserTongbaoService {



    public List<Tongbao> getLastTenLines(){
        TongbaoDao dao = new TongbaoDao();
        List<Tongbao> dataList = dao.getLastTenLines();
        return dataList;






    }





}
