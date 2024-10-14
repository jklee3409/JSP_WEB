package src.comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Set;

public class CommentDAO {

    private Connection conn;
    private ResultSet rs;

    // Docker Container -> MySQL
    // Local DB -> Container DB
    public CommentDAO() {
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
        String SQL = "SELECT commentID FROM comment ORDER BY commentID DESC";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            rs = preparedStatement.executeQuery();

            if (rs.next()) {
                return Integer.parseInt(rs.getString(1)) + 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1; // 데이터베이스 오류

    }

    public int write(int boardID, int bbsID, String userID, String commentText) {
        String SQL = "INSERT INTO comment VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setInt(1, boardID);
            preparedStatement.setInt(2, getNext());
            preparedStatement.setInt(3, bbsID);
            preparedStatement.setString(4, userID);
            preparedStatement.setString(5, getDate());
            preparedStatement.setString(6, commentText);
            preparedStatement.setInt(7, 1);

            preparedStatement.executeUpdate();

            return getNext();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1; // 데이터베이스 오류
    }

    public ArrayList<Comment> getList(int boardID, int bbsID) {
        String SQL = "SELECT * FROM comment WHERE boardID = ? AND bbsID = ? AND commentAvailable = 1 ORDER BY bbsID DESC ";
        ArrayList<Comment> list = new ArrayList<Comment>();
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setInt(1, boardID);
            preparedStatement.setInt(2, bbsID);
            rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Comment comment = new Comment();
                comment.setBoardID(rs.getInt(1));
                comment.setCommentID(rs.getInt(2));
                comment.setBbsID(rs.getInt(3));
                comment.setUserID(rs.getString(4));
                comment.setCommentDate(rs.getString(5));
                comment.setCommentText(rs.getString(6));
                comment.setCommentAvailable(rs.getInt(7));

                list.add(comment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; 
    }

    public Comment getComment(int commentID) {
        String SQL = "SELECT * FROM comment WHERE commentID = ? ORDER BY  commentID DESC";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setInt(1, commentID);
            rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Comment comment = new Comment();

                comment.setBoardID(rs.getInt(1));
                comment.setCommentID(rs.getInt(2));
                comment.setBbsID(rs.getInt(3));
                comment.setUserID(rs.getString(4));
                comment.setCommentDate(rs.getString(5));
                comment.setCommentText(rs.getString(6));
                comment.setCommentAvailable(rs.getInt(7));

                return comment;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public int delete(int commentID) {
        String SQL = "DELETE FROM comment WHERE commentID = ?";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setInt(1, commentID);

            return preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1; // 데이터베이스 오류
    }
}
