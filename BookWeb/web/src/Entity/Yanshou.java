package Entity;

import java.time.LocalDate;

public class Yanshou {
    private String orderName; // 订单号
    private String supplier;//书商
    private String title; // 书名
    private String publisher; // 出版社
    private String orderPerson; // 订购人
    private String receiver; // 验收人
    private String ISBN; // 国际标准书号
    private DocumentType documentType;//文献类型
    private int currencyID; // 币种编码
    private double price; // 定价
    private String edition; // 版次
    private String printingHouse; // 印刷厂
    private LocalDate publicationDate; // 出版日期
    private int subscribeNum; // 征订册数
    private String author; // 作者
    private boolean isBianmu;
    public Yanshou(){};

    public Yanshou(String supplier, String orderName, String title, String publisher, String orderPerson, String receiver, String ISBN, DocumentType documentType, int currencyID, double price, String edition, String printingHouse, LocalDate publicationDate, int subscribeNum, String author, boolean isBianmu) {
        this.supplier = supplier;
        this.orderName = orderName;
        this.title = title;
        this.publisher = publisher;
        this.orderPerson = orderPerson;
        this.receiver = receiver;
        this.ISBN = ISBN;
        this.documentType = documentType;
        this.currencyID = currencyID;
        this.price = price;
        this.edition = edition;
        this.printingHouse = printingHouse;
        this.publicationDate = publicationDate;
        this.subscribeNum = subscribeNum;
        this.author = author;
        this.isBianmu = isBianmu;
    }

    public boolean isBianmu() {
        return isBianmu;
    }

    public void setBianmu(boolean bianmu) {
        isBianmu = bianmu;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public void setOrderName(String orderName) {
        this.orderName = orderName;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public void setOrderPerson(String orderPerson) {
        this.orderPerson = orderPerson;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public void setDocumentType(DocumentType documentType) {
        this.documentType = documentType;
    }

    public void setCurrencyID(int currencyID) {
        this.currencyID = currencyID;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setEdition(String edition) {
        this.edition = edition;
    }

    public void setPrintingHouse(String printingHouse) {
        this.printingHouse = printingHouse;
    }

    public void setPublicationDate(LocalDate publicationDate) {
        this.publicationDate = publicationDate;
    }

    public void setSubscribeNum(int subscribeNum) {
        this.subscribeNum = subscribeNum;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getSupplier() {
        return supplier;
    }

    public String getOrderName() {
        return orderName;
    }

    public String getTitle() {
        return title;
    }

    public String getPublisher() {
        return publisher;
    }

    public String getOrderPerson() {
        return orderPerson;
    }

    public String getReceiver() {
        return receiver;
    }

    public String getISBN() {
        return ISBN;
    }

    public DocumentType getDocumentType() {
        return documentType;
    }

    public double getPrice() {
        return price;
    }

    public int getCurrencyID() {
        return currencyID;
    }

    public String getEdition() {
        return edition;
    }

    public String getPrintingHouse() {
        return printingHouse;
    }

    public LocalDate getPublicationDate() {
        return publicationDate;
    }

    public int getSubscribeNum() {
        return subscribeNum;
    }

    public String getAuthor() {
        return author;
    }
}

