package Service.weihu;

import Dao.BackupCycleDao;
import Entity.BackupCycle;

import java.util.ArrayList;
import java.util.List;

public class BackupCycleService {
    public static List<BackupCycle> backupCycleList = new ArrayList<>();

    public BackupCycleService() {
    }

    // 获取所有备份周期数
    public int getTotalBackupCycleNum() {
        BackupCycleDao backupCycleDao = new BackupCycleDao();
        backupCycleList.clear();
        backupCycleList = backupCycleDao.getAllBackupCycles();
        int totalBackupCycleNum = backupCycleList.size();
        return totalBackupCycleNum;
    }

    // 获取当前页的备份周期数据
    public List<BackupCycle> getCurrentPage(int currentPage) {
        List<BackupCycle> currentPageList = new ArrayList<>();

        // 假设每页显示16条数据，按页码分割数据
        for (int i = 16 * (currentPage - 1); i < 16 * currentPage && i < backupCycleList.size(); ++i) {
            currentPageList.add(backupCycleList.get(i));
        }

        return currentPageList;
    }

    // 获取当前页的备份周期数
    public int getCurrentListBackupCycleNum() {
        return backupCycleList.size();
    }

    // 按条件搜索备份周期
    public List<BackupCycle> getSelectBackupCycle(String searchField, String searchValue) {
        BackupCycleDao backupCycleDao = new BackupCycleDao();
        List<BackupCycle> selectBackupCycleList = backupCycleDao.findBackupCyclesBySearch(searchField, searchValue);
        backupCycleList.clear();
        backupCycleList.addAll(selectBackupCycleList);
        return selectBackupCycleList;
    }
}
