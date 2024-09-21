package src.bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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

            return preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public ArrayList<Bbs> getList(int pageNumber) {
        // LIMIT 10 : 한번에 최대 10개의 결과만 가져옴. 페이징
        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            // page 1 : getNext() - 0 -> 가장 최신 글부터 10개
            // page 2 : getNext() - 10 -> 최신 게시글에서 10개를 건너뛰고 다음 10개를 가져옴.
            preparedStatement.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Bbs bbs = new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean nextPage(int pageNumber) {
        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";

        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = preparedStatement.executeQuery();

            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Bbs getBBS(int bbsID) {
        String SQL = "SELECT * FROM BBS WHERE bbsID = ?";

        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setInt(1, bbsID);
            rs = preparedStatement.executeQuery();

            if (rs.next()) {
                Bbs bbs = new Bbs();

                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));

                return bbs;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public int update(int bbsID, String bbsTitle, String bbsContent) {
        String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setString(1, bbsTitle);
            preparedStatement.setString(2, bbsContent);
            preparedStatement.setInt(3, bbsID);

            return preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public int delete(int bbsID) {
        String SQL = "DELETE FROM BBS WHERE bbsID = ?";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setInt(1, bbsID);

            return preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }
}
