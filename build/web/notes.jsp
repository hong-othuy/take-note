<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.NoteDTO, java.text.SimpleDateFormat" %>
<%
    List<NoteDTO> notes = (List<NoteDTO>) request.getAttribute("notes");
    String keyword = (String) request.getAttribute("keyword");
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Dashboard - Notes.</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap');
        
        :root {
            /* switched dashboard from dark to unified light theme */
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

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--background);
            color: var(--foreground);
            -webkit-font-smoothing: antialiased;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        .layout { display: flex; min-height: 100vh; }

        .sidebar {
            width: 260px;
            background: var(--muted);
            border-right: 1px solid var(--border);
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
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

        .main { flex: 1; padding: 3rem; background: #fafafa; }

        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; }
        .search-bar { width: 300px; position: relative; }
        .search-input {
            width: 100%;
            padding: 0.625rem 1rem;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            font-size: 0.875rem;
            background: white;
            transition: all 0.2s;
        }
        .search-input:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.05); }

        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1.5rem; }

        .card {
            background: white;
            padding: 1.75rem;
            border-radius: var(--radius);
            border: 1px solid var(--border);
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            flex-direction: column;
        }
        .card:hover { 
            transform: translateY(-2px);
            border-color: var(--primary); 
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
        }

        .card-title { 
            font-weight: 700; 
            font-size: 1.125rem; 
            margin-bottom: 0.5rem; 
            color: var(--foreground);
            word-wrap: break-word;
            overflow-wrap: break-word;
        }
        .card-preview { 
            font-size: 0.875rem; 
            color: var(--muted-foreground); 
            line-height: 1.6; 
            margin-bottom: 1rem;
            white-space: pre-wrap;
            word-wrap: break-word;
            overflow-wrap: break-word;
            max-height: 150px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 6;
            -webkit-box-orient: vertical;
        }
        .card-footer { display: flex; justify-content: space-between; align-items: center; font-size: 0.75rem; color: var(--muted-foreground); }

        .btn-primary { 
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: var(--primary); 
            border-radius: var(--radius);
            padding: 0.75rem 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.1);
            color: var(--primary-foreground);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 600;
            transition: all 0.2s;
        }
        .btn-primary:hover { opacity: 0.9; transform: translateY(-1px); }

        .actions { display: flex; gap: 0.5rem; }
        .action-link { text-decoration: none; color: var(--muted-foreground); font-size: 0.75rem; font-weight: 500; }
        .action-link:hover { color: var(--foreground); }
    </style>
</head>
<body>
    <div class="layout">
        <aside class="sidebar">
            <a href="." class="logo">Notes.</a>
            <nav class="nav">
                <a href="notes" class="nav-item active">All Notes</a>
                <a href="notes?action=trash" class="nav-item">Trash</a>
            </nav>
            <a href="auth?action=logout" class="nav-item" style="margin-top: auto;">Logout</a>
        </aside>

        <main class="main">
            <div class="header">
                <form action="notes" method="get" class="search-bar">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="keyword" class="search-input" placeholder="Search notes..." value="<%= keyword != null ? keyword : "" %>">
                </form>
                <a href="notes?action=new" class="btn-primary">New Note <i data-lucide="plus"></i></a>
            </div>

            <div class="grid">
                <% if (notes != null) { for (NoteDTO note : notes) { %>
                    <div class="card">
                        <h3 class="card-title"><%= note.getTitle() %></h3>
                        <p class="card-preview"><%= note.getContent() %></p>
                        <div class="card-footer">
                            <span><%= sdf.format(note.getUpdatedDate()) %></span>
                            <div class="actions">
                                <a href="notes?action=edit&id=<%= note.getId() %>" class="action-link">Edit</a>
                                <a href="notes?action=delete&id=<%= note.getId() %>" class="action-link" onclick="return confirm('Delete note?')">Delete</a>
                            </div>
                        </div>
                    </div>
                <% }} %>
            </div>
        </main>
    </div>
    <script>
        lucide.createIcons();
    </script>
</body>
</html>
