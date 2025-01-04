package Entity;

public enum ReaderLevelType {
    ADVANCED("高级读者"),
    INTERMEDIATE("中级读者"),
    BEGINNER("低级读者"),
    BLACKLISTED("黑名单读者");

    private final String description;

    private ReaderLevelType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return this.description;
    }

    public String toString() {
        return this.description;
    }

    public static ReaderLevelType fromDescription(String description) {
        for(ReaderLevelType level : values()) {
            if (level.getDescription().equals(description)) {
                return level;
            }
        }

        throw new IllegalArgumentException("Invalid reader level description: " + description);
    }
}
