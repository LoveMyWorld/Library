package Entity;

public class Printery {
    private String name;
    private String addr;
    private String place;

    public Printery() {
    }

    public Printery(String name, String addr, String place) {
        this.name = name;
        this.addr = addr;
        this.place = place;
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

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }
}
