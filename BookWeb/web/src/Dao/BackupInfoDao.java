package Dao;

import Entity.BackupInfo;
import Entity.BackupNameType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BackupInfoDao {

    public BackupInfoDao() {}

    // 获取所有备份信息
    public List<BackupInfo> getAllBackupInfos() {
        Dao dao = new Dao();
        List<BackupInfo> backupInfoList = new ArrayList<>();
        String sql = "SELECT * FROM library.backup_info";  // 假设表名是 backup_info
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BackupInfo backupInfo = new BackupInfo();
                backupInfo.setBackupID(rs.getString("backupID"));
                backupInfo.setBackupName(BackupNameType.fromDescription(rs.getString("backupName")));
                backupInfo.setBackupLoc(rs.getString("backupLoc"));
                backupInfo.setBackupReason(rs.getString("backupReason"));
                backupInfo.setBackupTime(rs.getString("backupTime"));
                backupInfo.setOperator(rs.getString("operator"));
                backupInfoList.add(backupInfo);
            }

            dao.AllClose();
            return backupInfoList;
        } catch (SQLException e) {
            throw new RuntimeException("查询备份信息数据失败", e);
        }
    }

    // 根据字段搜索备份信息
    public List<BackupInfo> findBackupInfoBySearch(String searchField, String searchValue) {
        Dao dao = new Dao();
        List<BackupInfo> backupInfoList = new ArrayList<>();
        String sql = "";

        // 根据 searchField 决定查询条件
        switch (searchField) {
            case "backupID":
                sql = "SELECT * FROM library.backup_info WHERE backupID LIKE ?";
                break;
            case "backupName":
                sql = "SELECT * FROM library.backup_info WHERE backupName LIKE ?";
                break;
            default:
                throw new IllegalArgumentException("不支持的查询字段: " + searchField);
        }

        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, "%" + searchValue + "%");  // 使用模糊匹配
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BackupInfo backupInfo = new BackupInfo();
                backupInfo.setBackupID(rs.getString("backupID"));
                backupInfo.setBackupName(BackupNameType.fromDescription(rs.getString("backupName")));
                backupInfo.setBackupLoc(rs.getString("backupLoc"));
                backupInfo.setBackupReason(rs.getString("backupReason"));
                backupInfo.setBackupTime(rs.getString("backupTime"));
                backupInfo.setOperator(rs.getString("operator"));
                backupInfoList.add(backupInfo);
            }

            dao.AllClose();
            return backupInfoList;
        } catch (SQLException e) {
            throw new RuntimeException("查询备份信息数据失败", e);
        }
    }

//    // 添加备份信息
//    public void addBackupInfo(BackupInfo backupInfo) {
//        Dao dao = new Dao();
//        String sql = "INSERT INTO library.backup_info (backupID, backupName, backupLoc, backupReason, backupTime, operator) " +
//                "VALUES (?, ?, ?, ?, ?, ?)";
//
//        try (
//                PreparedStatement ps = dao.conn.prepareStatement(sql)) {
//
//            ps.setString(1, backupInfo.getBackupID());
//            ps.setString(2, backupInfo.getBackupName().toString());
//            ps.setString(3, backupInfo.getBackupLoc());
//            ps.setString(4, backupInfo.getBackupReason());
//            ps.setString(5, backupInfo.getBackupTime());
//            ps.setString(6, backupInfo.getOperator());
//
//            ps.executeUpdate();
//            dao.AllClose();
//        } catch (SQLException e) {
//            throw new RuntimeException("添加备份信息数据失败", e);
//        }
//    }
//
//    // 更新备份信息
//    public void updateBackupInfo(BackupInfo backupInfo) {
//        Dao dao = new Dao();
//        String sql = "UPDATE library.backup_info SET backupName = ?, backupLoc = ?, backupReason = ?, backupTime = ?, operator = ? " +
//                "WHERE backupID = ?";
//
//        try (
//                PreparedStatement ps = dao.conn.prepareStatement(sql)) {
//
//            ps.setString(1, backupInfo.getBackupName().toString());
//            ps.setString(2, backupInfo.getBackupLoc());
//            ps.setString(3, backupInfo.getBackupReason());
//            ps.setString(4, backupInfo.getBackupTime());
//            ps.setString(5, backupInfo.getOperator());
//            ps.setString(6, backupInfo.getBackupID());
//
//            ps.executeUpdate();
//            dao.AllClose();
//        } catch (SQLException e) {
//            throw new RuntimeException("更新备份信息数据失败", e);
//        }
//    }
//
//    // 删除备份信息
//    public void deleteBackupInfo(String backupID) {
//        Dao dao = new Dao();
//        String sql = "DELETE FROM library.backup_info WHERE backupID = ?";
//
//        try (
//                PreparedStatement ps = dao.conn.prepareStatement(sql)) {
//
//            ps.setString(1, backupID);
//
//            ps.executeUpdate();
//            dao.AllClose();
//        } catch (SQLException e) {
//            throw new RuntimeException("删除备份信息数据失败", e);
//        }
//    }
}
