package model;

import java.sql.Timestamp;

public class UserDTO {
    private int id;
    private String username;
    private String email;
    private String password;
    private String fullName;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    private boolean isActive;
    private boolean isDeleted;
    private Timestamp deletedDate;

    public UserDTO() {}

    public UserDTO(String username, String email, String password, String fullName) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }

    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public boolean isDeleted() { return isDeleted; }
    public void setDeleted(boolean deleted) { isDeleted = deleted; }

    public Timestamp getDeletedDate() { return deletedDate; }
    public void setDeletedDate(Timestamp deletedDate) { this.deletedDate = deletedDate; }
}
