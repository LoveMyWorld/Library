package Entity;

public class Collection {
    private  String name;
    private  String add;
    private  String contact;
    private  String phoneNum;
    private  String postcode;

    public Collection() {
    }

    public Collection(String name, String add, String contact, String phoneNum, String postcode) {
        this.name = name;
        this.add = add;
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

    public String getAdd() {
        return add;
    }

    public void setAdd(String add) {
        this.add = add;
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
