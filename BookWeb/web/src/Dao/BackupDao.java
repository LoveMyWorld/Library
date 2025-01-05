package Dao;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class BackupDao {
    public BackupDao() {
    }

    public static boolean performDatabaseBackup(String tableName, String backupFilePath) {
        Dao dao = new Dao();
        String realTableName = getRealTableName(tableName);
        String sql = "SELECT * FROM " + realTableName;
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            // 打开文件流进行写入
            BufferedWriter writer = new BufferedWriter(new FileWriter(backupFilePath));

            // 获取表头（列名）
            ResultSetMetaData rsMeta = rs.getMetaData();
            int columnCount = rsMeta.getColumnCount();

            // 写入表头
            for (int i = 1; i <= columnCount; i++) {
                writer.write(rsMeta.getColumnLabel(i));
                if (i < columnCount) {
                    writer.write("\t");
                }
            }
            writer.newLine();

            // 写入数据行
            while (rs.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    writer.write(rs.getString(i));
                    if (i < columnCount) {
                        writer.write("\t");
                    }
                }
                writer.newLine();
            }
            writer.close();
            dao.AllClose();
            return true;

        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static String getRealTableName(String tableName) {
        switch (tableName) {
            case "图书流通库表":
                return "liutonglist";
            case "读者信息表":
                return "reader";
            case "读者级别规则表":
                return "rlevel_rule";
            default:
                return ""; // 不支持的表
        }
    }
}

