package src.comment;

public class Comment {
    private int boardID;
    private int commentID;
    private int bbsID;
    private String userID;
    private String commentDate;
    private String commentText;
    private int commentAvailable;

    public int getBoardID() {
        return boardID;
    }

    public void setBoardID(int boardID) {
        this.boardID = boardID;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public int getBbsID() {
        return bbsID;
    }

    public void setBbsID(int bbsID) {
        this.bbsID = bbsID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(String commentDate) {
        this.commentDate = commentDate;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public int getCommentAvailable() {
        return commentAvailable;
    }

    public void setCommentAvailable(int commentAvailable) {
        this.commentAvailable = commentAvailable;
    }
}
