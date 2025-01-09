package Entity;

public class DisplayBorrowBookMsg {
    private String readID; // 对应 readID 字段
    private String name; // 对应 name 字段
    private Gender gender;
    private String phoneNum; // 对应 phoneNum 字段
    private String bookID; // 对应 bookID 字段
    private String title; // 对应 title 字段
    private String author;
    private String edition;
    private int msg;
    public DisplayBorrowBookMsg() {};

    public DisplayBorrowBookMsg(String readID, String name, Gender gender, String phoneNum, String bookID, String title, String author, String edition, int msg) {
        this.readID = readID;
        this.name = name;
        this.gender = gender;
        this.phoneNum = phoneNum;
        this.bookID = bookID;
        this.title = title;
        this.author = author;
        this.edition = edition;
        this.msg = msg;
    }

    public int getMsg() {
        return msg;
    }

    public void setMsg(int msg) {
        this.msg = msg;
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

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
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

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getEdition() {
        return edition;
    }

    public void setEdition(String edition) {
        this.edition = edition;
    }
}
