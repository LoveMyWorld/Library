package Entity;

import java.time.LocalDate;

public class Caifang {
    private String title; // 书名
    private String author;//作者
    private LocalDate publicationDate; // 出版日期
    private String ISBN; // 国际标准书号
    private double price; // 定价
   private String referrer;//推荐人
    private String phoneNum;//电话


    public Caifang() {};

    public Caifang(String title, String author, LocalDate publicationDate, String ISBN, double price, String referrer, String phoneNum) {
        this.title = title;
        this.author = author;
        this.publicationDate = publicationDate;
        this.ISBN = ISBN;
        this.price = price;
        this.referrer = referrer;
        this.phoneNum = phoneNum;
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

    public LocalDate getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(LocalDate publicationDate) {
        this.publicationDate = publicationDate;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getReferrer() {
        return referrer;
    }

    public void setReferrer(String referrer) {
        this.referrer = referrer;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }
}

