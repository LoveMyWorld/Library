package Dao;

import Entity.DamageList;
import Entity.DocumentType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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
}
