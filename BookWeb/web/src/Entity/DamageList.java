package Entity;

public class DamageList {
    private int damagelogID; // 损坏记录ID，自动递增
    private String bookID;   // 图书编号
    private String title;    // 书名
    private String edition;  // 版次
    private String readID;   // 读者编号
    private String name;     // 读者姓名
    private Gender gender;   // 读者性别
    private String personInCharge; // 负责人
    private String acceptor;  // 验收人

    // 构造函数
    public DamageList() {}

    public DamageList(String bookID, String title, String edition, String readID, String name, Gender gender, String personInCharge, String acceptor) {
        this.bookID = bookID;
        this.title = title;
        this.edition = edition;
        this.readID = readID;
        this.name = name;
        this.gender = gender;
        this.personInCharge = personInCharge;
        this.acceptor = acceptor;
    }

    public int getDamagelogID() {
        return damagelogID;
    }

    public void setDamagelogID(int damagelogID) {
        this.damagelogID = damagelogID;
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

    public String getEdition() {
        return edition;
    }

    public void setEdition(String edition) {
        this.edition = edition;
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

    public String getPersonInCharge() {
        return personInCharge;
    }

    public void setPersonInCharge(String personInCharge) {
        this.personInCharge = personInCharge;
    }

    public String getAcceptor() {
        return acceptor;
    }

    public void setAcceptor(String acceptor) {
        this.acceptor = acceptor;
    }
}