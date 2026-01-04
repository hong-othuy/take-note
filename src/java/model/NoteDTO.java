package model;

import java.sql.Timestamp;

public class NoteDTO {
    private int id;
    private int userId;
    private String title;
    private String content;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    private boolean isDeleted;
    private Timestamp deletedDate;

    public NoteDTO() {}

    public NoteDTO(int userId, String title, String content) {
        this.userId = userId;
        this.title = title;
        this.content = content;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }

    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }

    public boolean isDeleted() { return isDeleted; }
    public void setDeleted(boolean deleted) { isDeleted = deleted; }

    public Timestamp getDeletedDate() { return deletedDate; }
    public void setDeletedDate(Timestamp deletedDate) { this.deletedDate = deletedDate; }
}
