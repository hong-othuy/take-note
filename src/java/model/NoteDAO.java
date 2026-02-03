package model;

import utils.DBUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NoteDAO {

    private String processContent(String content) {
        if (content == null) {
            return null;
        }
        // Giữ nguyên các ký tự xuống dòng
        return content;
    }

    // Thêm note mới
    public boolean addNote(NoteDTO note) {
        String sql = "INSERT INTO Notes (user_id, title, content) VALUES (?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBUtils.getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setInt(1, note.getUserId());
            stmt.setString(2, note.getTitle());
            stmt.setString(3, processContent(note.getContent())); // Xử lý content

            return stmt.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }

    // Lấy tất cả notes của user
    public List<NoteDTO> getAllNotesByUser(int userId) {
        List<NoteDTO> notes = new ArrayList<>();
        String sql = "SELECT * FROM Notes WHERE user_id = ? AND is_deleted = 0 ORDER BY updated_date DESC";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                NoteDTO note = mapResultSetToNote(rs);
                notes.add(note);
            }

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, stmt, rs);
        }
        return notes;
    }

    // Lấy note theo ID
    public NoteDTO getNoteById(int id, int userId) {
        String sql = "SELECT * FROM Notes WHERE id = ? AND user_id = ? AND is_deleted = 0";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.setInt(2, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToNote(rs);
            }

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, stmt, rs);
        }
        return null;
    }

    // Update note
    public boolean updateNote(NoteDTO note) {
        String sql = "UPDATE Notes SET title = ?, content = ?, updated_date = GETDATE() "
                + "WHERE id = ? AND user_id = ? AND is_deleted = 0";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBUtils.getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setString(1, note.getTitle());
            stmt.setString(2, processContent(note.getContent())); // Xử lý content
            stmt.setInt(3, note.getId());
            stmt.setInt(4, note.getUserId());

            return stmt.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }

    // Soft delete note
    public boolean softDeleteNote(int id, int userId) {
        String sql = "UPDATE Notes SET is_deleted = 1, deleted_date = GETDATE() WHERE id = ? AND user_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBUtils.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }

    // Lấy notes đã xóa
    public List<NoteDTO> getDeletedNotes(int userId) {
        List<NoteDTO> notes = new ArrayList<>();
        String sql = "SELECT * FROM Notes WHERE user_id = ? AND is_deleted = 1 ORDER BY deleted_date DESC";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                NoteDTO note = mapResultSetToNote(rs);
                notes.add(note);
            }

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, stmt, rs);
        }
        return notes;
    }

    // Khôi phục note
    public boolean restoreNote(int id, int userId) {
        String sql = "UPDATE Notes SET is_deleted = 0, deleted_date = NULL WHERE id = ? AND user_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBUtils.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }

    // Hard delete note
    public boolean hardDeleteNote(int id, int userId) {
        String sql = "DELETE FROM Notes WHERE id = ? AND user_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBUtils.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }

    // Tìm kiếm notes
    public List<NoteDTO> searchNotes(int userId, String keyword) {
        List<NoteDTO> notes = new ArrayList<>();
        String sql = "SELECT * FROM Notes WHERE user_id = ? AND is_deleted = 0 "
                + "AND (title LIKE ? OR content LIKE ?) ORDER BY updated_date DESC";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            stmt = conn.prepareStatement(sql);

            String searchPattern = "%" + keyword + "%";
            stmt.setInt(1, userId);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            rs = stmt.executeQuery();

            while (rs.next()) {
                NoteDTO note = mapResultSetToNote(rs);
                notes.add(note);
            }

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, stmt, rs);
        }
        return notes;
    }

    // Helper method to map ResultSet to NoteDTO
    private NoteDTO mapResultSetToNote(ResultSet rs) throws SQLException {
        NoteDTO note = new NoteDTO();
        note.setId(rs.getInt("id"));
        note.setUserId(rs.getInt("user_id"));
        note.setTitle(rs.getString("title"));
        note.setContent(rs.getString("content"));
        note.setCreatedDate(rs.getTimestamp("created_date"));
        note.setUpdatedDate(rs.getTimestamp("updated_date"));
        note.setDeleted(rs.getBoolean("is_deleted"));
        note.setDeletedDate(rs.getTimestamp("deleted_date"));
        return note;
    }

    // Helper method to close resources
    private void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
