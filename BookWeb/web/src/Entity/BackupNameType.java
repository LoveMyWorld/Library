package Entity;

public enum BackupNameType {
    BOOK_CIRCULATION_TABLE("图书流通库表"),
    READER_INFO_TABLE("读者信息表"),
    READER_LEVEL_RULES_TABLE("读者级别规则表");

    private final String description;

    private BackupNameType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return this.description;
    }

    @Override
    public String toString() {
        return this.description;
    }

    public static BackupNameType fromDescription(String description) {
        for (BackupNameType type : values()) {
            if (type.getDescription().equals(description)) {
                return type;
            }
        }

        throw new IllegalArgumentException("Invalid backup name description: " + description);
    }
}
