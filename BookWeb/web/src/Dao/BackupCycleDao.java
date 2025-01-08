package Dao;

import Entity.*;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BackupCycleDao {
    public BackupCycleDao() {}

    // 获取所有备份周期
    public List<BackupCycle> getAllBackupCycles() {
        Dao dao = new Dao();
        List<BackupCycle> backupCycleList = new ArrayList<>();
        String sql = "SELECT * FROM library.backup_cycle"; // 假设表名是backup_cycle
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BackupCycle backupCycle = new BackupCycle();
                backupCycle.setBackupName(BackupNameType.fromDescription(rs.getString("backupName")));
                backupCycle.setBackupCycle(rs.getInt("backupCycle"));
                backupCycle.setBackupLoc(rs.getString("backupLoc"));
                backupCycle.setOperator(rs.getString("operator"));
                backupCycleList.add(backupCycle);
            }

            dao.AllClose();
            return backupCycleList;
        } catch (SQLException e) {
            throw new RuntimeException("查询备份周期数据失败", e);
        }
    }

    // 根据备份名称查询备份周期
    public List<BackupCycle> findBackupCyclesBySearch(String searchField, String searchValue) {
        Dao dao = new Dao();
        List<BackupCycle> backupCycleList = new ArrayList<>();
        String sql = "";

        // 根据 searchField 决定查询条件
        switch (searchField) {
            case "backupName":
                sql = "SELECT * FROM library.backup_cycle WHERE backupName LIKE ?";
                break;
            default:
                throw new IllegalArgumentException("不支持的查询字段: " + searchField);
        }

        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, "%" + searchValue + "%");  // 使用模糊匹配
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BackupCycle backupCycle = new BackupCycle();
                backupCycle.setBackupName(BackupNameType.fromDescription(rs.getString("backupName")));
                backupCycle.setBackupCycle(rs.getInt("backupCycle"));
                backupCycle.setBackupLoc(rs.getString("backupLoc"));
                backupCycle.setOperator(rs.getString("operator"));
                backupCycleList.add(backupCycle);
            }

            dao.AllClose();
            return backupCycleList;
        } catch (SQLException e) {
            throw new RuntimeException("查询备份周期数据失败", e);
        }
    }

    // 查看
    public BackupCycle getBackupCycleByName(String backupName) {
        Dao dao = new Dao();
        BackupCycle backupCycle1 = new BackupCycle();
        String sql = "SELECT * FROM library.backup_cycle WHERE backupName = ? LIMIT 1";
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, backupName);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String t = rs.getString("backupName");
                backupCycle1.setBackupName(BackupNameType.fromDescription(t));
                backupCycle1.setBackupCycle(rs.getInt("backupCycle"));
                backupCycle1.setBackupLoc(rs.getString("backupLoc"));
                backupCycle1.setOperator(rs.getString("operator"));

            }
            dao.AllClose();
            return backupCycle1; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查看数据失败", e);
        }
    }

    // 更新
    public boolean updateBackupCycle(BackupCycle backupCycle1) {
        Dao dao = new Dao();
        String sql = "UPDATE library.backup_cycle SET " +
                "backupCycle = ?, backupLoc = ?, operator = ? " +
                "WHERE backupName = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setInt(1, backupCycle1.getBackupCycle());
            ps.setString(2, backupCycle1.getBackupLoc());
            ps.setString(3, backupCycle1.getOperator());
            ps.setString(4, backupCycle1.getBackupName().getDescription());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {
            throw new RuntimeException("修改备份周期信息数据失败", e);
        }
    }

}
