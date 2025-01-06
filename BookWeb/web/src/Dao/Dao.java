package Dao;

import java.sql.*;

public class Dao {
    Connection conn; // 数据库链接接口
    PreparedStatement pst; // 数据库命令传送接口
    ResultSet rs; // 数据读取接口

//    private static final String dburl = "jdbc:mysql://127.0.0.1:3306/library?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
//    private static final String username = "Hcc";
//    private static final String password = "123456";

    private static final String dburl = "jdbc:mysql://127.0.0.1:3306/library?useSSL=false&serverTimezone=UTC";
    private static final String username = "root1";
    private static final String password = "123456";

    public Dao() {
        dbconn();
    }

    public int dbconn(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dburl , username , password) ;
            System.out.println("数据库连接成功");
        } catch (ClassNotFoundException e1) {
//            throw new RuntimeException(e);

            System.out.println(e1+"驱动程序找不到");
            return 1 ;
        } catch (SQLException e2) {
//            throw new RuntimeException(e);

            System.out.println(e2);
            System.out.println("数据库连接失败");
            return 2 ;
        }
        return 0;

    }

    public int dbcmd(String sql){
        int ret = 0 ;

        try {
            pst = conn.prepareStatement(sql);
            ret = pst.execute() == true ? 0 : 1 ;
        } catch (SQLException e) {
            System.out.println(e);
        }

        return ret;
    }

    public ResultSet dbSel(String sql){
        try {
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
            return rs;
        } catch (SQLException e) {

            throw new RuntimeException(e);
        }
    }

    public ResultSet dbsel(PreparedStatement pstmt){
        this.pst = pstmt;
        try {
            rs = pstmt.executeQuery();
            return rs;
        } catch (SQLException e) {

            throw new RuntimeException(e);
        }
    }

    public void AllClose(){
        if(rs!=null){
            try{
                rs.close();
            }catch (Exception e) {
                e.printStackTrace();
            }
            rs = null;
        }
        if(pst!=null){
            try{
                pst.close();
            }catch (Exception e) {
                e.printStackTrace();
            }
        }
        if(conn!=null){
            try{
                conn.close();
            }catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
