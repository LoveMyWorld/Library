package Entity;

import java.time.LocalDate;

public class Reader {
    private String readID;
    private String name;
    private Gender gender;
    private LocalDate birthDay;
    private String unit;
    private String homeAdd;
    private String phoneNum;
    private String emailAdd;
    private ReaderLevelType readerLevel;
    private int creditPoint;

    public Reader(String readID, String name, Gender gender, LocalDate birthDay, String unit, String homeAdd, String phoneNum, String emailAdd, ReaderLevelType readerLevel, int creditPoint) {
        this.readID = readID;
        this.name = name;
        this.gender = gender;
        this.birthDay = birthDay;
        this.unit = unit;
        this.homeAdd = homeAdd;
        this.phoneNum = phoneNum;
        this.emailAdd = emailAdd;
        this.readerLevel = readerLevel;
        this.creditPoint = creditPoint;
    }

    public  Reader(){   }

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

    public LocalDate getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(LocalDate birthDay) {
        this.birthDay = birthDay;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getHomeAdd() {
        return homeAdd;
    }

    public void setHomeAdd(String homeAdd) {
        this.homeAdd = homeAdd;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getEmailAdd() {
        return emailAdd;
    }

    public void setEmailAdd(String emailAdd) {
        this.emailAdd = emailAdd;
    }

    public ReaderLevelType getReaderLevel() {
        return readerLevel;
    }

    public void setReaderLevel(ReaderLevelType readerLevel) {
        this.readerLevel = readerLevel;
    }

    public int getCreditPoint() {
        return creditPoint;
    }

    public void setCreditPoint(int creditPoint) {
        this.creditPoint = creditPoint;
    }
}
