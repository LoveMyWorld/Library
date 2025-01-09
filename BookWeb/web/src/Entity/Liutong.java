package Entity;

import java.time.LocalDate;

public class Liutong {
    private String bookID; // 图书编号
    private String title; // 书名
    private String author; // 作者
    private String ISBN; // 国际标准书号
    private LocalDate publicationDate; // 出版日期
    private String publisher; // 出版社
    private String edition; // 版次
    private String supplier;//书商
    private int currencyID; // 币种编码
    private double price; // 定价
    private String orderPerson; // 订购人
//    private String receiver; // 验收人
    private int bookNum; // 征订册数
    private DocumentType documentType;//文献类型
    private String categoryName;
    public Liutong(){};

    public String getOrderPerson() {
        return orderPerson;
    }

    public void setOrderPerson(String orderPerson) {
        this.orderPerson = orderPerson;
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

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getEdition() {
        return edition;
    }

    public void setEdition(String edition) {
        this.edition = edition;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public DocumentType getDocumentType() {
        return documentType;
    }

    public void setDocumentType(DocumentType documentType) {
        this.documentType = documentType;
    }

    public int getBookNum() {
        return bookNum;
    }

    public void setBookNum(int bookNum) {
        this.bookNum = bookNum;
    }

    public int getCurrencyID() {
        return currencyID;
    }

    public void setCurrencyID(int currencyID) {
        this.currencyID = currencyID;
    }

    public LocalDate getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(LocalDate publicationDate) {
        this.publicationDate = publicationDate;
    }

    public Liutong(String bookID, String title, String author, String ISBN, LocalDate publicationDate, String edition, String publisher, String supplier, int currencyID, double price, DocumentType documentType, int bookNum, String categoryName) {
        this.bookID = bookID;
        this.title = title;
        this.author = author;
        this.ISBN = ISBN;
        this.publicationDate = publicationDate;
        this.edition = edition;
        this.publisher = publisher;
        this.supplier = supplier;
        this.currencyID = currencyID;
        this.price = price;
        this.documentType = documentType;
        this.bookNum = bookNum;
        this.categoryName = categoryName;
    }
}
