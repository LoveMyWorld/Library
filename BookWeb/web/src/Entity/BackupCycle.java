package Entity;

public class BackupCycle {
    private String backupName;
    private int backupCycle;
    private String backupLoc;
    private String operator;

    public BackupCycle(String backupName, int backupCycle, String backupLoc, String operator) {
        this.backupName = backupName;
        this.backupCycle = backupCycle;
        this.backupLoc = backupLoc;
        this.operator = operator;
    }

    public BackupCycle() {
    }

    // Getters and Setters
    public String getBackupName() {
        return backupName;
    }

    public void setBackupName(String backupName) {
        this.backupName = backupName;
    }

    public int getBackupCycle() {
        return backupCycle;
    }

    public void setBackupCycle(int backupCycle) {
        this.backupCycle = backupCycle;
    }

    public String getBackupLoc() {
        return backupLoc;
    }

    public void setBackupLoc(String backupLoc) {
        this.backupLoc = backupLoc;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }
}
