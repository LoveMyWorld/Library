package Service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.atomic.AtomicInteger;

public class BackupService {
    // 用于记录备份次数
    private static AtomicInteger[] backupCounters = new AtomicInteger[3];

    static {
        // 初始化备份次数计数器
        for (int i = 0; i < 3; i++) {
            backupCounters[i] = new AtomicInteger(0); // 每个表从0开始
        }
    }

    public static String generateBackupId(int tableIndex) {
        // 获取当前日期
        String currentDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

        // 获取当天备份次数
        int count = backupCounters[tableIndex].incrementAndGet(); // 递增备份次数

        // 生成备份编号
        String backupId = currentDate + (tableIndex + 1) + String.format("%02d", count);

        return backupId;
    }

    // 获取备份路径
    public static String generateBackupPath(String tableName, String webAppPath, int tableIndex) throws IOException {
        // 获取当前日期
        String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

        // 确定备份文件夹路径
        String backupDirPath = webAppPath + File.separator + "backups" + File.separator + currentDate;

        // 确保目录存在（如果不存在则创建）
        File backupDir = new File(backupDirPath);
        if (!backupDir.exists()) {
            if (!backupDir.mkdirs()) {
                throw new IOException("无法创建备份目录: " + backupDirPath);
            }
        }

        // 确定文件名前缀
        String filePrefix;
        switch (tableName) {
            case "图书流通库表":
                filePrefix = "liutonglist_bu";
                break;
            case "读者信息表":
                filePrefix = "reader_bu";
                break;
            case "读者级别规则表":
                filePrefix = "rlevel_bu";
                break;
            default:
                throw new IllegalArgumentException("未知的表名: " + tableName);
        }

        // 获取当天备份次数

//        // 获取当前日期已有的备份文件数量
//        int backupCount = 1;
//        File[] files = backupDir.listFiles();
//        if (files != null) {
//            for (File file : files) {
//                if (file.getName().startsWith(filePrefix)) {
//                    backupCount++;
//                }
//            }
//        }

//        int count = Integer.parseInt(String.valueOf(backupCounters[tableIndex]));

        // 获取备份编号（确保编号和文件名后两位一致）
        String backupId = generateBackupId(tableIndex); // 生成备份编号

        // 确保文件名的后两位和备份编号的后两位一致
        String fileName = filePrefix + "_" + String.format("%02d",Integer.parseInt(backupId.substring(9)));

        backupCounters[tableIndex].decrementAndGet();
//        String fileName = filePrefix + "_" + String.format("%02d",count);

        // 返回完整备份路径
        return backupDirPath + File.separator + fileName;
    }
}

