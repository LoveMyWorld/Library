package Dao;

import Entity.BackupCycle;
import Entity.BackupNameType;

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

    // 添加备份周期
    public void addBackupCycle(BackupCycle backupCycle) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.backup_cycle (backupName, backupCycle, backupLoc, operator) VALUES (?, ?, ?, ?)";

        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, backupCycle.getBackupName().toString());
            ps.setInt(2, backupCycle.getBackupCycle());
            ps.setString(3, backupCycle.getBackupLoc());
            ps.setString(4, backupCycle.getOperator());

            ps.executeUpdate();
            dao.AllClose();
        } catch (SQLException e) {
            throw new RuntimeException("添加备份周期数据失败", e);
        }
    }

    // 更新备份周期
    public void updateBackupCycle(BackupCycle backupCycle) {
        Dao dao = new Dao();
        String sql = "UPDATE library.backup_cycle SET backupCycle = ?, backupLoc = ?, operator = ? WHERE backupName = ?";

        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setInt(1, backupCycle.getBackupCycle());
            ps.setString(2, backupCycle.getBackupLoc());
            ps.setString(3, backupCycle.getOperator());
            ps.setString(4, backupCycle.getBackupName().toString());

            ps.executeUpdate();
            dao.AllClose();
        } catch (SQLException e) {
            throw new RuntimeException("更新备份周期数据失败", e);
        }
    }

    // 删除备份周期
    public void deleteBackupCycle(String backupName) {
        Dao dao = new Dao();
        String sql = "DELETE FROM library.backup_cycle WHERE backupName = ?";

        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, backupName);

            ps.executeUpdate();
            dao.AllClose();
        } catch (SQLException e) {
            throw new RuntimeException("删除备份周期数据失败", e);
        }
    }
}
