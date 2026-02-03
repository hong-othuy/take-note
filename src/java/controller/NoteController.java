package controller;

import model.NoteDAO;
import model.NoteDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

public class NoteController extends HttpServlet {
    private NoteDAO noteDAO;

    @Override
    public void init() {
        noteDAO = new NoteDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("auth");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response, userId);
                break;
            case "delete":
                deleteNote(request, response, userId);
                break;
            case "trash":
                showTrash(request, response, userId);
                break;
            case "restore":
                restoreNote(request, response, userId);
                break;
            case "permanent-delete":
                permanentDelete(request, response, userId);
                break;
            case "search":
                searchNotes(request, response, userId);
                break;
            default:
                listNotes(request, response, userId);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("auth");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if ("insert".equals(action)) {
            insertNote(request, response, userId);
        } else if ("update".equals(action)) {
            updateNote(request, response, userId);
        }
    }

    private void listNotes(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        List<NoteDTO> notes = noteDAO.getAllNotesByUser(userId);
        request.setAttribute("notes", notes);
        RequestDispatcher dispatcher = request.getRequestDispatcher("notes.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("note-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            NoteDTO note = noteDAO.getNoteById(id, userId);
            
            if (note != null) {
                request.setAttribute("note", note);
                RequestDispatcher dispatcher = request.getRequestDispatcher("note-form.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("notes");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("notes");
        }
    }

    private void insertNote(HttpServletRequest request, HttpServletResponse response, int userId)
            throws IOException, ServletException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        
        // Validation
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("error", "Tiêu đề không được để trống!");
            showNewForm(request, response);
            return;
        }
        
        NoteDTO note = new NoteDTO(userId, title, content);
        if (noteDAO.addNote(note)) {
            response.sendRedirect("notes");
        } else {
            request.setAttribute("error", "Không thể tạo ghi chú. Vui lòng thử lại!");
            showNewForm(request, response);
        }
    }

    private void updateNote(HttpServletRequest request, HttpServletResponse response, int userId)
            throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            
            // Validation
            if (title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "Tiêu đề không được để trống!");
                NoteDTO note = noteDAO.getNoteById(id, userId);
                request.setAttribute("note", note);
                showEditForm(request, response, userId);
                return;
            }
            
            NoteDTO note = new NoteDTO(userId, title, content);
            note.setId(id);
            
            if (noteDAO.updateNote(note)) {
                response.sendRedirect("notes");
            } else {
                request.setAttribute("error", "Không thể cập nhật ghi chú!");
                request.setAttribute("note", note);
                showEditForm(request, response, userId);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("notes");
        }
    }

    private void deleteNote(HttpServletRequest request, HttpServletResponse response, int userId)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            noteDAO.softDeleteNote(id, userId);
        } catch (NumberFormatException e) {
            // Ignore invalid ID
        }
        response.sendRedirect("notes");
    }

    private void showTrash(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        List<NoteDTO> deletedNotes = noteDAO.getDeletedNotes(userId);
        request.setAttribute("deletedNotes", deletedNotes);
        RequestDispatcher dispatcher = request.getRequestDispatcher("trash.jsp");
        dispatcher.forward(request, response);
    }

    private void restoreNote(HttpServletRequest request, HttpServletResponse response, int userId)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            noteDAO.restoreNote(id, userId);
        } catch (NumberFormatException e) {
            // Ignore invalid ID
        }
        response.sendRedirect("notes?action=trash");
    }

    private void permanentDelete(HttpServletRequest request, HttpServletResponse response, int userId)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            noteDAO.hardDeleteNote(id, userId);
        } catch (NumberFormatException e) {
            // Ignore invalid ID
        }
        response.sendRedirect("notes?action=trash");
    }

    private void searchNotes(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            response.sendRedirect("notes");
            return;
        }
        
        List<NoteDTO> notes = noteDAO.searchNotes(userId, keyword);
        request.setAttribute("notes", notes);
        request.setAttribute("keyword", keyword);
        RequestDispatcher dispatcher = request.getRequestDispatcher("notes.jsp");
        dispatcher.forward(request, response);
    }
}
