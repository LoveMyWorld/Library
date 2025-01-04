package Entity;

public class BackupUpdate {
    private String backupID;
    private String opType;
    private String operator;

    public BackupUpdate(String backupID, String opType, String operator) {
        this.backupID = backupID;
        this.opType = opType;
        this.operator = operator;
    }

    public BackupUpdate() {
    }

    // Getters and Setters
    public String getBackupID() {
        return backupID;
    }

    public void setBackupID(String backupID) {
        this.backupID = backupID;
    }

    public String getOpType() {
        return opType;
    }

    public void setOpType(String opType) {
        this.opType = opType;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }
}
