package Service;

import Dao.WeiGuiDao;
import Entity.WeiGui;

import java.util.List;


public class WeiguiService {



    public List<WeiGui> getLastTenLines(){
        WeiGuiDao dao = new WeiGuiDao();
        List<WeiGui> dataList = dao.getLastTenLines();
        return dataList;






    }





}
