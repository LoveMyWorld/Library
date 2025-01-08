package Dao;

import Entity.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TermDicDao {
    public TermDicDao() {
    }

    public List<TermDic> getAllTermDics() {
        Dao dao = new Dao();
        List<TermDic> termDicList = new ArrayList<>();
        String sql = "SELECT * FROM library.term_dic"; // 表名是term_dic
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                TermDic termDic = new TermDic();
                termDic.setTerm(rs.getString("term"));
                termDic.setDef(rs.getString("def"));
                termDicList.add(termDic);
            }

            dao.AllClose();
            return termDicList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    public List<TermDic> findTermDicsBySearch(String searchField, String searchValue) {
        Dao dao = new Dao();
        List<TermDic> termDicList = new ArrayList<>();
        String sql = "";

        // 根据 searchField 决定查询条件
        if (searchField.equals("term")) {
            sql = "SELECT * FROM library.term_dic WHERE term LIKE ?";
        }

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%" + searchValue + "%");  // 使用模糊匹配
            ResultSet rs = ps.executeQuery();

            // 遍历查询结果，构建 TermDic 对象列表
            while (rs.next()) {
                TermDic termDic = new TermDic();
                termDic.setTerm(rs.getString("term"));
                termDic.setDef(rs.getString("def"));
                termDicList.add(termDic);
            }

            dao.AllClose();
            return termDicList;
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }

    // 添加
    public boolean addTermDic(TermDic termDic) {
        Dao dao = new Dao();
        String sql = "INSERT INTO library.term_dic (term, def) " +
                "VALUES (?, ?)";
        try (
                PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, termDic.getTerm());
            ps.setString(2, termDic.getDef());
           
            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {

            throw new RuntimeException("添加术语信息失败", e);
        }
    }

    // 查看
    public TermDic getTermDicByName(String term) {
        Dao dao = new Dao();
        TermDic termDic = new TermDic();
        String sql = "SELECT * FROM library.term_dic WHERE term = ? LIMIT 1";
        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, term);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                termDic.setTerm(rs.getString("term"));
                termDic.setDef(rs.getString("def"));

            }
            dao.AllClose();
            return termDic; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查看数据失败", e);
        }
    }

    // 更新
    public boolean updateTermDic(TermDic termDic) {
        Dao dao = new Dao();
        String sql = "UPDATE library.term_dic SET " +
                "def = ?" +
                "WHERE term = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {

            ps.setString(1, termDic.getTerm());
            ps.setString(2, termDic.getDef());

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;
        } catch (SQLException e) {
            throw new RuntimeException("修改术语信息数据失败", e);
        }
    }

    // 删除
    public boolean deleteTermDic(String term) {
        Dao dao = new Dao();
        String sql = "DELETE FROM library.term_dic WHERE term = ?";
        try (PreparedStatement ps = dao.conn.prepareStatement(sql)) {
            ps.setString(1, term);  // 设置要删除的读者ID

            int result = ps.executeUpdate();
            dao.AllClose();
            return result > 0;  // 如果删除的行数大于0，表示删除成功
        } catch (SQLException e) {
            throw new RuntimeException("删除术语信息数据失败", e);
        }
    }
}
