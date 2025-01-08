package Entity;

// 枚举定义
public enum BorrowStatus {
    BORROWING("借阅中"),
    RETURNED("已还"),
    OVERDUE("超期未还");

    private final String description;

    // 构造函数
    BorrowStatus(String description) {
        this.description = description;
    }

    // 获取描述
    public String getDescription() {
        return description;
    }

    @Override
    public String toString() {
        return description;
    }

    // 根据描述字符串获取枚举值的方法
    public static BorrowStatus fromDescription(String description) {
        for (BorrowStatus status : values()) {
            if (status.getDescription().equals(description)) {
                return status;
            }
        }
        throw new IllegalArgumentException("Invalid borrow status description: " + description);
    }
}
