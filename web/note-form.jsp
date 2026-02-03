<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.NoteDTO" %>
<%
    NoteDTO note = (NoteDTO) request.getAttribute("note");
    boolean isEdit = (note != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Refine" : "Create" %> Thought - Notes.</title>
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: white;
            width: 100%;
            max-width: 600px;
            padding: 2.5rem;
            border-radius: var(--radius);
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.05), 0 2px 4px -2px rgba(79, 70, 229, 0.05);
            border: 1px solid var(--border);
        }

        .header {
            margin-bottom: 32px;
            text-align: center;
        }

        h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--foreground);
            margin-bottom: 8px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--foreground);
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            font-size: 0.875rem;
            font-family: inherit;
            transition: all 0.2s;
            outline: none;
            background: white;
            color: var(--foreground);
        }

        input[type="text"]:focus,
        textarea:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.05);
        }

        textarea {
            min-height: 200px;
            resize: vertical;
        }

        .actions {
            display: flex;
            gap: 12px;
            margin-top: 32px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border-radius: var(--radius);
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            text-align: center;
            text-decoration: none;
            border: none;
        }

        .btn-primary {
            background-color: var(--primary);
            color: var(--primary-foreground);
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.1);
        }

        .btn-primary:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .btn-secondary {
            background-color: white;
            color: var(--foreground);
            border: 1px solid var(--border);
        }

        .btn-secondary:hover {
            background-color: var(--accent);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><%= isEdit ? "Refine Thought" : "Create New Thought" %></h1>
        </div>
        
        <form action="notes" method="post">
            <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>">
            <% if (isEdit) { %>
                <input type="hidden" name="id" value="<%= note.getId() %>">
            <% } %>
            
            <div class="form-group">
                <label for="title">Title</label>
                <input type="text" id="title" name="title" 
                       value="<%= isEdit ? note.getTitle() : "" %>" 
                       placeholder="Thought title" required>
            </div>
            
            <div class="form-group">
                <label for="content">Content</label>
                <textarea id="content" name="content" 
                          placeholder="Write your thought here..." required><%= isEdit ? note.getContent() : "" %></textarea>
            </div>
            
            <div class="actions">
                <button type="submit" class="btn btn-primary">
                    <%= isEdit ? "Update Thought" : "Save Thought" %>
                </button>
                <a href="notes" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
