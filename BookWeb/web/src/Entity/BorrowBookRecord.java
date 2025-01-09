package Entity;

import java.time.LocalDate;

public class BorrowBookRecord {
    private long bbrID; // 对应 apID 字段，使用 long 类型
    private String readID; // 对应 readID 字段
    private String name; // 对应 name 字段
    private String phoneNum; // 对应 phoneNum 字段
    private String bookID; // 对应 bookID 字段
    private String title; // 对应 title 字段
    private LocalDate borrowStart;
    private LocalDate borrowEnd;
    private BorrowStatus borrowStatus;

    public BorrowBookRecord(long bbrID, String readID, String name, String phoneNum, String bookID, String title, LocalDate borrowStart, LocalDate borrowEnd, BorrowStatus borrowStatus) {
        this.bbrID = bbrID;
        this.readID = readID;
        this.name = name;
        this.phoneNum = phoneNum;
        this.bookID = bookID;
        this.title = title;
        this.borrowStart = borrowStart;
        this.borrowEnd = borrowEnd;
        this.borrowStatus = borrowStatus;
    }

    public BorrowBookRecord() {

    };

    public BorrowStatus getBorrowStatus() {
        return borrowStatus;
    }

    public void setBorrowStatus(BorrowStatus borrowStatus) {
        this.borrowStatus = borrowStatus;
    }

    public long getBbrID() {
        return bbrID;
    }

    public void setBbrID(long bbrID) {
        this.bbrID = bbrID;
    }

    public String getReadID() {
        return readID;
    }

    public void setReadID(String readID) {
        this.readID = readID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public LocalDate getBorrowStart() {
        return borrowStart;
    }

    public void setBorrowStart(LocalDate borrowStart) {
        this.borrowStart = borrowStart;
    }

    public LocalDate getBorrowEnd() {
        return borrowEnd;
    }

    public void setBorrowEnd(LocalDate borrowEnd) {
        this.borrowEnd = borrowEnd;
    }
}


