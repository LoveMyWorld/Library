package Entity;

import java.time.LocalDate;

public class Announcement {
    public Announcement() {}
    private int announcementID; //公告编号
    private LocalDate announcementDate;//日期
    private String publisher;//发布人
    private String announcementText;//公告内容
    private String announcementKey;

    public Announcement(int announcementID, LocalDate announcementDate, String publisher, String announcementText, String announcementKey) {
        this.announcementID = announcementID;
        this.announcementDate = announcementDate;
        this.publisher = publisher;
        this.announcementText = announcementText;
        this.announcementKey = announcementKey;
    }

    public String getAnnouncementKey() {
        return announcementKey;
    }

    public void setAnnouncementKey(String announcementKey) {
        this.announcementKey = announcementKey;
    }

    public int getAnnouncementID() {
        return announcementID;
    }

    public void setAnnouncementID(int announcementID) {
        this.announcementID = announcementID;
    }

    public LocalDate getAnnouncementDate() {
        return announcementDate;
    }

    public void setAnnouncementDate(LocalDate announcementDate) {
        this.announcementDate = announcementDate;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getAnnouncementText() {
        return announcementText;
    }

    public void setAnnouncementText(String announcementText) {
        this.announcementText = announcementText;
    }
}