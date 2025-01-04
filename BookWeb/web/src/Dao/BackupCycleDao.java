package Dao;

import Entity.BackupCycle;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BackupCycleDao {

    public BackupCycleDao() {}

    // 添加备份周期
    public void addBackupCycle(BackupCycle cycle) throws SQLException {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.backup_cycle (backupName, backupCycle, backupLoc, operator) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            ps.setString(1, cycle.getBackupName());
            ps.setInt(2, cycle.getBackupCycle());
            ps.setString(3, cycle.getBackupLoc());
            ps.setString(4, cycle.getOperator());
            ps.executeUpdate();
        }
    }

    // 查询所有备份周期
    public List<BackupCycle> getAllBackupCycles() throws SQLException {
        Dao dao = new Dao();
        String sql = "SELECT * FROM library.backup_cycle";
        List<BackupCycle> cycles = new ArrayList<>();
        try (PreparedStatement ps = dao.conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BackupCycle cycle = new BackupCycle();
                cycle.setBackupName(rs.getString("backupName"));
                cycle.setBackupCycle(rs.getInt("backupCycle"));
                cycle.setBackupLoc(rs.getString("backupLoc"));
                cycle.setOperator(rs.getString("operator"));
                cycles.add(cycle);
            }
        }
        return cycles;
    }
}
