package src.bbs;

import sun.security.util.Password;

import java.sql.*;

public class BbsDAO {

    private Connection conn;
    private ResultSet rs;

    public BbsDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/BBS?useUnicode=true&characterEncoding=UTF-8";
            String dbID = "root";
            String dbPassword = "3409";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getDate() {
        String SQL = "SELECT NOW()";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            rs = preparedStatement.executeQuery();

            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ""; // 데이터베이스 오류
    }

    public int getNext() {
        String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC ";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            rs = preparedStatement.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
            return 1; // 첫 번째 게시물인 경우
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public int write(String bbsTitle, String userID, String bbsContent) {
        String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setInt(1, getNext());
            preparedStatement.setString(2, bbsTitle);
            preparedStatement.setString(3, userID);
            preparedStatement.setString(4, getDate());
            preparedStatement.setString(5, bbsContent);
            preparedStatement.setInt(6, 1); // 처음 글을 작성했을 때는 삭제되지 않은 상태이므로, available = 1

            rs = preparedStatement.executeQuery();

            return preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
}
