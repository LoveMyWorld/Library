package Entity;

import java.time.LocalDate;

public class Appointment {

    private long apID; // 对应 apID 字段，使用 long 类型
    private String readID; // 对应 readID 字段
    private String name; // 对应 name 字段
    private String phoneNum; // 对应 phoneNum 字段
    private String bookID; // 对应 bookID 字段
    private String title; // 对应 title 字段
    private LocalDate appointmentStart;
    private LocalDate appointmentEnd;

    public Appointment(long apID, String readID, String name, String phoneNum, String bookID, String title, LocalDate appointmentStart, LocalDate appointmentEnd) {
        this.apID = apID;
        this.readID = readID;
        this.name = name;
        this.phoneNum = phoneNum;
        this.bookID = bookID;
        this.title = title;
        this.appointmentStart = appointmentStart;
        this.appointmentEnd = appointmentEnd;
    }

    public Appointment() {

    };

    public long getApID() {
        return apID;
    }

    public void setApID(long apID) {
        this.apID = apID;
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

    public LocalDate getAppointmentStart() {
        return appointmentStart;
    }

    public void setAppointmentStart(LocalDate appointmentStart) {
        this.appointmentStart = appointmentStart;
    }

    public LocalDate getAppointmentEnd() {
        return appointmentEnd;
    }

    public void setAppointmentEnd(LocalDate appointmentEnd) {
        this.appointmentEnd = appointmentEnd;
    }
}
