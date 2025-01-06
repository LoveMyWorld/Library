package Dao;

import Entity.BackupInfo;
import Entity.BackupNameType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BackupInfoDao {

    public BackupInfoDao() {}

    // 添加备份信息
    public void addBackupInfo(BackupInfo info) throws SQLException {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.backup_info (backupID, backupName, backupLoc, backupReason, backupTime, operator) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            ps.setString(1, info.getBackupID());
            ps.setString(2, info.getBackupName().getDescription());
            ps.setString(3, info.getBackupLoc());
            ps.setString(4, info.getBackupReason());
            ps.setString(5, info.getBackupTime());
            ps.setString(6, info.getOperator());
            ps.executeUpdate();
        }
    }

    // 查询所有备份信息
    public List<BackupInfo> getAllBackupInfos() throws SQLException {
        Dao dao = new Dao();
        String sql = "SELECT * FROM library.backup_info";
        List<BackupInfo> infos = new ArrayList<>();
        try (PreparedStatement ps = dao.conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BackupInfo info = new BackupInfo();
                info.setBackupID(rs.getString("backupID"));
                info.setBackupName(BackupNameType.fromDescription(rs.getString("backupName")));
                info.setBackupLoc(rs.getString("backupLoc"));
                info.setBackupReason(rs.getString("backupReason"));
                info.setBackupTime(rs.getString("backupTime"));
                info.setOperator(rs.getString("operator"));
                infos.add(info);
            }
        }
        return infos;
    }
}