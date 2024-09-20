package src.user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    private Connection conn;
    private PreparedStatement preparedStatement;
    private ResultSet rs;

    public UserDAO() {
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

    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?";

        try {
            preparedStatement = conn.prepareStatement(SQL);
            // SQL 쿼리의 ? 에 userID 값 설정
            preparedStatement.setString(1, userID);
            // SQL 쿼리를 실행하고 결과를 ResultSet 객체로 반환
            rs = preparedStatement.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    return 1; // 로그인 성공
                } else {
                    return 0; // 비밀번호 불일치
                }
            }
            return  -1; // 아이디가 없음
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -2; //데이터베이스 오류
    }

    public int join(User user) {
        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";

        try {
            preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setString(1, user.getUserID());
            preparedStatement.setString(2, user.getUserPassword());
            preparedStatement.setString(3, user.getUserName());
            preparedStatement.setString(4, user.getUserGender());
            preparedStatement.setString(5, user.getUserEmail());

            // INSERT 문장을 실행한 경우는 반드시 0 이상의 숫자를 반환
            // 따라서 -1이 아닌 경우에는 회원가입이 성공적으로 이루어진 것.
            return preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  -1;
    }

}
