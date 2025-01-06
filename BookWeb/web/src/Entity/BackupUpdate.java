package Entity;

public class BackupUpdate {
    private String backupID;
    private OpType opType;
    private String operator;

    public BackupUpdate(String backupID, OpType opType, String operator) {
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

    public OpType getOpType() {
        return opType;
    }

    public void setOpType(OpType opType) {
        this.opType = opType;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }
}
