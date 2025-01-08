package Entity;

import java.time.LocalDate;

public class Tongbao
{
    private int  tongbaoID;
    private LocalDate tongbaoDate;//日期
    private String publisher;//发布人
    private String tongbaoKey;//公告内容
    private String tongbaoText;


    public Tongbao(int tongbaoID, LocalDate tongbaoDate, String publisher, String tongbaoKey, String tongbaoText) {
        this.tongbaoID = tongbaoID;
        this.tongbaoDate = tongbaoDate;
        this.publisher = publisher;
        this.tongbaoKey = tongbaoKey;
        this.tongbaoText = tongbaoText;
    }

    public Tongbao() {
    }

    public int getTongbaoID() {
        return tongbaoID;
    }

    public void setTongbaoID(int tongbaoID) {
        this.tongbaoID = tongbaoID;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public LocalDate getTongbaoDate() {
        return tongbaoDate;
    }

    public void setTongbaoDate(LocalDate tongbaoDate) {
        this.tongbaoDate = tongbaoDate;
    }

    public String getTongbaoKey() {
        return tongbaoKey;
    }

    public void setTongbaoKey(String tongbaoKey) {
        this.tongbaoKey = tongbaoKey;
    }

    public String getTongbaoText() {
        return tongbaoText;
    }

    public void setTongbaoText(String tongbaoText) {
        this.tongbaoText = tongbaoText;
    }
}
