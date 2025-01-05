package Entity;

public enum OpType {
    MOVE("移动"),
    OVERWRITE("覆盖"),
    DELETE("删除"),
    ADD("增加");

    private final String description;

    private OpType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return this.description;
    }

    @Override
    public String toString() {
        return this.description;
    }

    public static OpType fromDescription(String description) {
        for (OpType type : values()) {
            if (type.getDescription().equals(description)) {
                return type;
            }
        }

        throw new IllegalArgumentException("Invalid operation type description: " + description);
    }
}

