package Entity;

public class Bookman {
    private  String name;
    private  String addr;
    private  String contact;
    private  String phoneNum;
    private  String postcode;

    public Bookman() {
    }

    public Bookman(String name, String addr, String contact, String phoneNum, String postcode) {
        this.name = name;
        this.addr = addr;
        this.contact = contact;
        this.phoneNum = phoneNum;
        this.postcode = postcode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }
}
