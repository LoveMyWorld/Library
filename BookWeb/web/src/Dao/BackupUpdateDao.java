package Dao;

import Entity.BackupUpdate;
import Entity.OpType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BackupUpdateDao {

    public BackupUpdateDao() {}

    // 添加备份更新
    public void addBackupUpdate(BackupUpdate update) throws SQLException {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.backup_update (backupID, opType, operator) VALUES (?, ?, ?)";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            ps.setString(1, update.getBackupID());
            ps.setString(2, update.getOpType().getDescription());
            ps.setString(3, update.getOperator());
            ps.executeUpdate();
        }
    }

    // 查询所有备份更新
    public List<BackupUpdate> getAllBackupUpdates() throws SQLException {
        Dao dao = new Dao();
        String sql = "SELECT * FROM library.backup_update";
        List<BackupUpdate> updates = new ArrayList<>();
        try (PreparedStatement ps = dao.conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BackupUpdate update = new BackupUpdate();
                update.setBackupID(rs.getString("backupID"));
                update.setOpType(OpType.fromDescription(rs.getString("opType")));
                update.setOperator(rs.getString("operator"));
                updates.add(update);
            }
        }
        return updates;
    }
}
