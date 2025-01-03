package Entity;
//Yanshou里的文献类型是枚举，所以单拎出来了
// 枚举定义
public enum DocumentType {
    JOURNAL("期刊[J]"),
    MONOGRAPH("专著[M]"),
    COLLECTION("论文集[C]"),
    DISSERTATION("学位论文[D]"),
    PATENT("专利[P]"),
    TECHNICAL_STANDARD("技术标准[S]"),
    NEWSPAPER("报纸[N]"),
    TECHNICAL_REPORT("科技报告[R]"),
    CONFERENCE_PAPER("会议文献[C]");


    private final String description;

    // 构造函数
    DocumentType(String description) {
        this.description = description;
    }

    // 获取枚举的描述
    public String getDescription() {
        return description;
    }

    @Override
    public String toString() {
        return description;
    }

    // 根据描述字符串获取枚举值的方法
    public static DocumentType fromDescription(String description) {
        for (DocumentType type : values()) {
            if (type.getDescription().equals(description)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid document type description: " + description);
    }
}
