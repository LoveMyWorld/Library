package Dao;

import Entity.DamageList;
import Entity.DocumentType;
import Entity.Gender;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DamageListDao {
    public DamageListDao() {}

    public int InsertDamageList(DamageList damageList) {
        String sql = "INSERT INTO damagelist (bookID, title, edition, readID, name, gender, personInCharge, acceptor) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Dao dao = new Dao();
        int rowsAffected = 0 ;
        try  {
            PreparedStatement ps = dao.conn.prepareStatement(sql , Statement.RETURN_GENERATED_KEYS);
            // 设置PreparedStatement的参数
            ps.setString(1, damageList.getBookID());
            ps.setString(2, damageList.getTitle());
            ps.setString(3, damageList.getEdition());
            ps.setString(4, damageList.getReadID());
            ps.setString(5, damageList.getName());
            ps.setString(6, damageList.getGender().toString()); // 假设Gender是一个枚举类型
            ps.setString(7, damageList.getPersonInCharge());
            ps.setString(8, damageList.getAcceptor());

            // 执行插入操作
            rowsAffected = ps.executeUpdate();

            // 如果插入成功，检索生成的主键（damagelogID）
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        damageList.setDamagelogID(generatedKeys.getInt(1));
                    }
                    generatedKeys.close();
                }
            }

            dao.AllClose();
            ps.close();

            return rowsAffected;
        } catch (SQLException e) {
            throw new RuntimeException(e);
//            return rowsAffected = -1;
        }
    }
    //注意未展示损坏号
    public List<DamageList> findBooksBySearch(String searchField, String searchValue) {
        Dao dao = new Dao();
        List<DamageList> dataList = new ArrayList<>();
        String sql="";
        if(searchField.equals("bookID")) {
            sql="select * from Library.DamageList where ISBN like ?";
        }

        else if(searchField.equals("title")) {
            sql="select * from Library.DamageList where title like ?";
        }

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);
            ps.setString(1, "%"+searchValue+"%");
            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 DamageList 对象并添加到列表
            while (rs.next()) {
                DamageList damageList = new DamageList();
                // 书商
                damageList.setTitle(rs.getString("title"));                                      // 书名
                // 国际标准书号
                String t = rs.getString("gender");
                damageList.setGender(Gender.fromDescription(t));                           // 币种编码
                damageList.setBookID(rs.getString("bookID"));
                damageList.setTitle(rs.getString("title"));
                damageList.setReadID(rs.getString("readID"));
                damageList.setName(rs.getString("name"));
                damageList.setPersonInCharge(rs.getString("personInCharge"));
                damageList.setAcceptor(rs.getString("acceptor"));

                // 根据 DamageList 类的字段继续添加赋值逻辑
                dataList.add(damageList); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }
    // 查询表中的所有数据并返回
    public List<DamageList> getAllData() {
        Dao dao = new Dao();
        List<DamageList> dataList = new ArrayList<>();     // 用于存储查询结果
        String sql = "SELECT * FROM   library.damageList"; // 查询表中的所有数据

        try {
            PreparedStatement ps = dao.conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            // 遍历结果集，将每一行转换为 DamageList 对象并添加到列表
            while (rs.next()) {
                DamageList damageList = new DamageList();
                // 书商
                damageList.setTitle(rs.getString("title"));                                      // 书名
                // 国际标准书号
                String t = rs.getString("gender");
                damageList.setGender(Gender.fromDescription(t));                           // 币种编码
                damageList.setBookID(rs.getString("bookID"));
                damageList.setTitle(rs.getString("title"));
                damageList.setReadID(rs.getString("readID"));
                damageList.setName(rs.getString("name"));
                damageList.setPersonInCharge(rs.getString("personInCharge"));
                damageList.setAcceptor(rs.getString("acceptor"));
                // 根据 DamageList 类的字段继续添加赋值逻辑
                dataList.add(damageList); // 将对象添加到列表
            }
            dao.AllClose();
            return dataList; // 返回查询结果
        } catch (SQLException e) {
            throw new RuntimeException("查询数据失败", e);
        }
    }
}
