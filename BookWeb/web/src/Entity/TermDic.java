package Entity;

public class TermDic {
    private String term;
    private String def;

    public TermDic() {
    }

    public TermDic(String term, String def) {
        this.def = def;
        this.term = term;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getDef() {
        return def;
    }

    public void setDef(String def) {
        this.def = def;
    }
}
