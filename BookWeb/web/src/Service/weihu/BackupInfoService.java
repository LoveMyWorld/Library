package Service.weihu;

import Dao.BackupInfoDao;
import Entity.BackupInfo;

import java.util.ArrayList;
import java.util.List;

public class BackupInfoService {
    // 存储所有备份信息
    public static List<BackupInfo> backupInfoList = new ArrayList<>();

    public BackupInfoService() {
    }

    // 获取所有备份信息数
    public int getTotalBackupInfoNum() {
        BackupInfoDao backupInfoDao = new BackupInfoDao();
        backupInfoList.clear();
        backupInfoList = backupInfoDao.getAllBackupInfos();
        int totalBackupInfoNum = backupInfoList.size();
        return totalBackupInfoNum;
    }

    // 获取当前页的备份信息数据
    public List<BackupInfo> getCurrentPage(int currentPage) {
        List<BackupInfo> currentPageList = new ArrayList<>();

        // 假设每页显示16条数据，按页码分割数据
        for (int i = 16 * (currentPage - 1); i < 16 * currentPage && i < backupInfoList.size(); ++i) {
            currentPageList.add(backupInfoList.get(i));
        }

        return currentPageList;
    }

    // 获取当前页的备份信息数
    public int getCurrentListBackupInfoNum() {
        return backupInfoList.size();
    }

    // 按条件搜索备份信息
    public List<BackupInfo> getSelectBackupInfo(String searchField, String searchValue) {
        BackupInfoDao backupInfoDao = new BackupInfoDao();
        List<BackupInfo> selectBackupInfoList = backupInfoDao.findBackupInfoBySearch(searchField, searchValue);
        backupInfoList.clear();
        backupInfoList.addAll(selectBackupInfoList);
        return selectBackupInfoList;
    }


}
