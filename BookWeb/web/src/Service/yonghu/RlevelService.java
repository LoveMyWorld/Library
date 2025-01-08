package Service.yonghu;

import Dao.RlevelDao;
import Entity.Rlevel;

import java.util.ArrayList;
import java.util.List;

public class RlevelService {
    public static List<Rlevel> rlevelList = new ArrayList<>();

    public RlevelService() {}

    // 获取总规则数
    public int getTotalRlevelNum() {
        RlevelDao rlevelDao = new RlevelDao();
        rlevelList.clear();
        rlevelList = rlevelDao.getAllRlevels(); // 加载所有规则
        return rlevelList.size();
    }

    // 获取当前页的规则数据
    public List<Rlevel> getCurrentPage(int currentPage) {
        List<Rlevel> currentPageList = new ArrayList<>();
        int pageSize = 16;

        for (int i = pageSize * (currentPage - 1); i < pageSize * currentPage && i < rlevelList.size(); ++i) {
            currentPageList.add(rlevelList.get(i));
        }

        return currentPageList;
    }

    // 获取当前加载的规则数
    public int getCurrentListRlevelNum() {
        return rlevelList.size();
    }

    // 按条件搜索规则
    public List<Rlevel> getSelectRlevel(String searchField, String searchValue) {
        RlevelDao rlevelDao = new RlevelDao();
        List<Rlevel> selectRlevelList = rlevelDao.getRlevelBySearch(searchField, searchValue);
        rlevelList.clear();
        rlevelList.addAll(selectRlevelList);
        return selectRlevelList;
    }
}
