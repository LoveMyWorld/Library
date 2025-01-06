package Entity;

public class BackupInfo {
    private String backupID;
    private BackupNameType backupName;
    private String backupLoc;
    private String backupReason;
    private String backupTime;
    private String operator;

    public BackupInfo(String backupID, BackupNameType backupName, String backupLoc, String backupReason, String backupTime, String operator) {
        this.backupID = backupID;
        this.backupName = backupName;
        this.backupLoc = backupLoc;
        this.backupReason = backupReason;
        this.backupTime = backupTime;
        this.operator = operator;
    }

    public BackupInfo() {
    }

    // Getters and Setters
    public String getBackupID() {
        return backupID;
    }

    public void setBackupID(String backupID) {
        this.backupID = backupID;
    }

    public BackupNameType getBackupName() {
        return backupName;
    }

    public void setBackupName(BackupNameType backupName) {
        this.backupName = backupName;
    }

    public String getBackupLoc() {
        return backupLoc;
    }

    public void setBackupLoc(String backupLoc) {
        this.backupLoc = backupLoc;
    }

    public String getBackupReason() {
        return backupReason;
    }

    public void setBackupReason(String backupReason) {
        this.backupReason = backupReason;
    }

    public String getBackupTime() {
        return backupTime;
    }

    public void setBackupTime(String backupTime) {
        this.backupTime = backupTime;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }
}
