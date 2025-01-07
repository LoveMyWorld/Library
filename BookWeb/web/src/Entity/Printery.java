package Entity;

public class Printery {
    private String name;
    private String add;
    private String place;

    public Printery() {
    }

    public Printery(String name, String add, String place) {
        this.name = name;
        this.add = add;
        this.place = place;
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

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }
}
