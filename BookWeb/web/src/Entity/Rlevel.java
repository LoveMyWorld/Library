package Entity;

public class Rlevel {
    private ReaderLevelType readerLevel;
    private String creditPointRange;
    private int borrowNum;
    private int borrowDay;
    private int orderNum;
    private int orderDay;
    private float fineEveryday;

    // 构造函数
    public Rlevel(ReaderLevelType readerLevel, String creditPointRange, int borrowNum, int borrowDay, int orderNum, int orderDay, float fineEveryday) {
        this.readerLevel = readerLevel;
        this.creditPointRange = creditPointRange;
        this.borrowNum = borrowNum;
        this.borrowDay = borrowDay;
        this.orderNum = orderNum;
        this.orderDay = orderDay;
        this.fineEveryday = fineEveryday;
    }

    public Rlevel() {

    }

    public ReaderLevelType getReaderLevel() {
        return readerLevel;
    }

    public void setReaderLevel(ReaderLevelType readerLevel) {
        this.readerLevel = readerLevel;
    }

    public String getCreditPointRange() {
        return creditPointRange;
    }

    public void setCreditPointRange(String creditPointRange) {
        this.creditPointRange = creditPointRange;
    }

    public int getBorrowNum() {
        return borrowNum;
    }

    public void setBorrowNum(int borrowNum) {
        this.borrowNum = borrowNum;
    }

    public int getBorrowDay() {
        return borrowDay;
    }

    public void setBorrowDay(int borrowDay) {
        this.borrowDay = borrowDay;
    }

    public int getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(int orderNum) {
        this.orderNum = orderNum;
    }

    public int getOrderDay() {
        return orderDay;
    }

    public void setOrderDay(int orderDay) {
        this.orderDay = orderDay;
    }

    public float getFineEveryday() {
        return fineEveryday;
    }

    public void setFineEveryday(float fineEveryday) {
        this.fineEveryday = fineEveryday;
    }
}
