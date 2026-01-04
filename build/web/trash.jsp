<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.NoteDTO, java.text.SimpleDateFormat" %>
<%
    List<NoteDTO> deletedNotes = (List<NoteDTO>) request.getAttribute("deletedNotes");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trash - My Notes</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Press Start 2P', cursive;
            background-image: url('images/kawaii-bg-pattern.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            padding: 20px;
            overflow-x: hidden;
        }
        
        /* Added video background styles */
        .video-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            background: repeating-linear-gradient(
                45deg,
                #FFE5E5 0px,
                #FFE5E5 20px,
                white 20px,
                white 40px
            );
            padding: 30px;
            border-radius: 30px;
            border: 5px solid #FFB3BA;
            box-shadow: 0 10px 35px rgba(255, 179, 186, 0.4);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .pixel-heart {
            width: 100px;
            height: auto;
            display: inline-block;
            vertical-align: middle;
            margin-right: 10px;
        }
        
        .header-content {
            display: flex;
            align-items: center;
        }
        
        h1 {
            font-size: 1.5em;
            font-weight: bold;
            color: #FF6B9D;
            text-shadow: 2px 2px 0 #FFE5E5;
        }
        
        .btn {
            padding: 12px 25px;
            border: 4px solid;
            border-radius: 25px;
            font-size: 11px;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
            font-weight: bold;
            font-family: inherit;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #FFB4D9 0%, #FF8FB8 100%);
            color: white;
            border-color: #FF6B9D;
            box-shadow: 0 5px 0 #D97BA0;
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 0 #D97BA0;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #A8E6CF 0%, #7ED4B6 100%);
            color: white;
            border-color: #5BB99A;
            box-shadow: 0 4px 0 #4A9A7F;
        }
        
        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 0 #4A9A7F;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #FFB3BA 0%, #FF8FA3 100%);
            color: white;
            border-color: #FF6B9D;
            box-shadow: 0 4px 0 #D97BA0;
        }
        
        .btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 0 #D97BA0;
        }
        
        .notes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .note-card {
            background: white;
            padding: 25px;
            border-radius: 25px;
            border: 4px solid #FFD4E5;
            box-shadow: 0 5px 0 #FFB4D9,
                        0 10px 25px rgba(255, 180, 217, 0.3);
            opacity: 0.9;
            transition: all 0.3s;
        }
        
        .note-card:hover {
            opacity: 1;
            transform: translateY(-8px) rotate(1deg);
            box-shadow: 0 8px 0 #FFB4D9,
                        0 15px 40px rgba(255, 180, 217, 0.5);
        }
        
        .note-title {
            font-size: 1.1em;
            color: #FF8FB8;
            margin-bottom: 15px;
            font-weight: bold;
        }
        
        .note-content {
            color: #6B4D5E;
            margin-bottom: 15px;
            line-height: 1.8;
            max-height: 150px;
            overflow: hidden;
            font-size: 0.7em;
        }
        
        .note-date {
            font-size: 0.65em;
            color: #C497B2;
            margin-bottom: 15px;
        }
        
        .note-actions {
            display: flex;
            gap: 10px;
        }
        
        .empty-state {
            background: repeating-linear-gradient(
                45deg,
                #FFF5FA 0px,
                #FFF5FA 20px,
                white 20px,
                white 40px
            );
            padding: 60px;
            border-radius: 30px;
            border: 5px dashed #FFB4D9;
            text-align: center;
            box-shadow: 0 10px 35px rgba(255, 180, 217, 0.3);
        }
        
        .empty-state h2 {
            color: #FF8FB8;
            margin-bottom: 20px;
            font-size: 1.5em;
        }
        
        .empty-state p {
            color: #C497B2;
            font-size: 0.8em;
        }
        
        .deleted-badge {
            display: inline-block;
            background: linear-gradient(135deg, #FFB3BA 0%, #FF8FA3 100%);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.6em;
            margin-bottom: 10px;
            font-weight: bold;
            box-shadow: 0 2px 8px rgba(255, 143, 163, 0.3);
        }
    </style>
</head>
<body>
    <!-- Xóa video element -->

    <div class="container">
        <div class="header">
            <div class="header-content">
                <!-- replaced cute-girl image with the new trash bin image -->
                <img src="images/trash-can.jpg" alt="Trash Bin" class="pixel-heart">
                <h1>Trash</h1>
            </div>
            <a href="notes" class="btn btn-primary">Back</a>
        </div>

        <% if (deletedNotes == null || deletedNotes.isEmpty()) { %>
            <div class="empty-state">
                <h2>Trash is empty!</h2>
                <p>No notes have been deleted</p>
            </div>
        <% } else { %>
            <div class="notes-grid">
                <% for (NoteDTO note : deletedNotes) { %>
                    <div class="note-card">
                        <span class="deleted-badge">DELETED</span>
                        <div class="note-title"><%= note.getTitle() %></div>
                        <div class="note-content"><%= note.getContent() %></div>
                        <div class="note-date">
                            Deleted at: <%= note.getDeletedDate() != null ? sdf.format(note.getDeletedDate()) : "N/A" %>
                        </div>
                        <div class="note-actions">
                            <a href="notes?action=restore&id=<%= note.getId() %>" 
                               class="btn btn-success">
                               Restore
                            </a>
                            <a href="notes?action=permanent-delete&id=<%= note.getId() %>" 
                               class="btn btn-danger" 
                               onclick="return confirm('Permanently delete? Cannot be restored!')">
                               Permanent Delete
                            </a>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>
