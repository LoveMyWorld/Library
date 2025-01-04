package Entity;

public enum Gender {
    FEMALE("女"),
    MALE("男");

    private final String description;

    private Gender(String description) {
        this.description = description;
    }

    public String getDescription() {
        return this.description;
    }

    public String toString() {
        return this.description;
    }

    public static Gender fromDescription(String description) {
        for(Gender gender : values()) {
            if (gender.getDescription().equals(description)) {
                return gender;
            }
        }

        throw new IllegalArgumentException("Invalid gender description: " + description);
    }
}

