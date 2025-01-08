package Entity;

public class WeiGui {

    public int weiguiID;
    public String name ;
    public Gender gender;
    public String readID;
    public String badContent ;

    public WeiGui(){}

    public WeiGui(int weiguiID, String name, Gender gender, String readID, String badContent) {
        this.weiguiID = weiguiID;
        this.name = name;
        this.gender = gender;
        this.readID = readID;
        this.badContent = badContent;
    }

    public int getWeiguiID() {
        return weiguiID;
    }

    public void setWeiguiID(int weiguiID) {
        this.weiguiID = weiguiID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getReadID() {
        return readID;
    }

    public void setReadID(String readID) {
        this.readID = readID;
    }

    public String getBadContent() {
        return badContent;
    }

    public void setBadContent(String badContent) {
        this.badContent = badContent;
    }
}
