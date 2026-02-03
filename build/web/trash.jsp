<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.NoteDTO, java.text.SimpleDateFormat" %>
<%
    List<NoteDTO> deletedNotes = (List<NoteDTO>) request.getAttribute("deletedNotes");
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trash - My Notes</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap');
        
        :root {
            /* switched from dark to unified light theme */
            --primary: #4f46e5;
            --primary-foreground: #ffffff;
            --background: #ffffff;
            --foreground: #0f172a;
            --muted: #f8fafc;
            --muted-foreground: #64748b;
            --border: #e2e8f0;
            --accent: #f1f5f9;
            --radius: 0.75rem;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--background);
            color: var(--foreground);
            /* Removed padding to accommodate the new sidebar layout */
        }

        /* Added layout and sidebar styles to match notes.jsp */
        .layout { display: flex; min-height: 100vh; }

        .sidebar {
            width: 260px;
            background: var(--muted);
            border-right: 1px solid var(--border);
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
            position: sticky;
            top: 0;
            height: 100vh;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 800;
            font-size: 1.25rem;
            letter-spacing: -0.05em;
            color: var(--foreground);
            margin-bottom: 3rem;
            text-decoration: none;
        }

        .nav { flex: 1; }
        .nav-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.625rem 0.875rem;
            color: var(--muted-foreground);
            text-decoration: none;
            border-radius: var(--radius);
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 0.25rem;
            transition: all 0.2s;
        }
        .nav-item:hover, .nav-item.active { 
            background: var(--accent); 
            color: var(--primary); 
        }

        .main { 
            flex: 1; 
            padding: 3rem; 
            background: #fafafa;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        h1 {
            font-size: 28px;
            font-weight: 700;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            border: 1px solid transparent;
        }

        .btn-secondary {
            background-color: white;
            color: var(--foreground);
            border-color: var(--border);
        }

        .btn-secondary:hover {
            background-color: var(--accent);
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .card {
            background: white;
            padding: 1.75rem;
            border-radius: var(--radius);
            border: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            transition: all 0.2s;
        }

        .card:hover {
            border-color: var(--primary);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 12px;
            color: var(--foreground);
        }

        .card-content {
            font-size: 15px;
            color: var(--muted-foreground);
            margin-bottom: 20px;
            line-height: 1.6;
            flex-grow: 1;
        }

        .card-footer {
            font-size: 13px;
            color: var(--muted-foreground);
            padding-top: 16px;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            text-decoration: none;
            color: var(--foreground);
        }

        .restore-btn {
            color: #22c55e;
        }

        .delete-btn {
            color: #ef4444;
        }

        .empty {
            text-align: center;
            padding: 80px 0;
            color: var(--muted-foreground);
        }
    </style>
</head>
<body>
    <!-- Wrapped content in a unified layout with the shared sidebar -->
    <div class="layout">
        <aside class="sidebar">
            <a href="." class="logo">Notes.</a>
            <nav class="nav">
                <a href="notes" class="nav-item">All Notes</a>
                <a href="notes?action=trash" class="nav-item active">Trash</a>
            </nav>
            <a href="auth?action=logout" class="nav-item" style="margin-top: auto;">Logout</a>
        </aside>

        <main class="main">
            <div class="header">
                <h1>Trash</h1>
                <div class="actions">
                    <a href="notes" class="btn btn-secondary">
                        <i data-lucide="arrow-left" style="width: 16px; height: 16px; margin-right: 8px;"></i>
                        Back to Notes
                    </a>
                </div>
            </div>

            <% if (deletedNotes == null || deletedNotes.isEmpty()) { %>
                <div class="empty">
                    <p>Trash is empty</p>
                </div>
            <% } else { %>
                <div class="grid">
                    <% for (NoteDTO note : deletedNotes) { %>
                        <div class="card">
                            <div class="card-title"><%= note.getTitle() %></div>
                            <div class="card-content"><%= note.getContent() %></div>
                            <div class="card-footer">
                                <span>Deleted on <%= note.getDeletedDate() != null ? sdf.format(note.getDeletedDate()) : "N/A" %></span>
                                <div class="actions">
                                    <a href="notes?action=restore&id=<%= note.getId() %>" class="action-btn restore-btn">Restore</a>
                                    <a href="notes?action=permanent-delete&id=<%= note.getId() %>" 
                                       class="action-btn delete-btn" 
                                       onclick="return confirm('Permanently delete this note?')">Delete</a>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </main>
    </div>
    <script>
        lucide.createIcons();
    </script>
</body>
</html>
