<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.NoteDTO, java.text.SimpleDateFormat" %>
<%
    List<NoteDTO> notes = (List<NoteDTO>) request.getAttribute("notes");
    String keyword = (String) request.getAttribute("keyword");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Notes</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Press Start 2P', cursive;
            /* Thay video background bằng hình nền tĩnh */
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
        
        .top-bar {
            background: linear-gradient(135deg, #FFD4E5 0%, #FFB4D9 100%);
            padding: 15px 30px;
            border-radius: 20px 20px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
            max-width: 1200px;
            margin: 0 auto;
            border: 4px solid #FF8FB8;
            border-bottom: none;
        }
        
        .browser-dots {
            display: flex;
            gap: 8px;
        }
        
        .dot {
            width: 16px;
            height: 16px;
            border-radius: 50%;
            border: 2px solid rgba(255,255,255,0.7);
        }
        
        .dot-yellow { background: #FFF176; }
        .dot-pink { background: #FFB4D9; }
        .dot-red { background: #FF8FB8; }
        
        .site-url {
            flex: 1;
            text-align: center;
            font-size: 0.7em;
            font-weight: 600;
        }
        
        .browser-close {
            width: 22px;
            height: 22px;
            background: #FF8FB8;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            cursor: pointer;
            font-size: 14px;
        }
        
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 0 0 30px 30px;
            border: 4px solid #FF8FB8;
            border-top: none;
            box-shadow: 0 20px 60px rgba(255, 143, 184, 0.3);
            overflow: hidden;
        }
        
        .header-section {
            background: repeating-linear-gradient(
                45deg,
                #FFE5F0 0px,
                #FFE5F0 25px,
                white 25px,
                white 50px
            );
            padding: 30px;
            border-bottom: 5px dotted #FFB4D9;
            /* added flex layout to align larger avatar with info */
            display: flex;
            gap: 30px;
            align-items: center;
        }
        
        .avatar-box {
            /* increased size of the avatar box to 220px */
            width: 220px;
            height: 220px;
            border-radius: 25px;
            background: linear-gradient(135deg, #FFD4E5 0%, #FFB4D9 100%);
            border: 5px solid #FFB4D9;
            box-shadow: 0 8px 30px rgba(255, 180, 217, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            overflow: hidden;
            font-size: 4em;
        }
        
        .avatar-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .header-info {
            flex: 1;
        }
        
        .site-title {
            font-size: 1.8em;
            font-weight: bold;
            color: #FF8FB8;
            margin-bottom: 20px;
            text-align: center;
            text-shadow: 2px 2px 0 #FFE5F0;
        }
        
        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .search-input {
            flex: 1;
            padding: 12px 20px;
            border: 3px solid #FFD4E5;
            background: white;
            border-radius: 20px;
            font-size: 12px;
            font-family: inherit;
        }
        
        .search-input:focus {
            outline: none;
            border-color: #FFB4D9;
            box-shadow: 0 0 0 3px rgba(255, 180, 217, 0.2);
        }
        
        .button-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .btn {
            padding: 10px 20px;
            border: 3px solid;
            border-radius: 18px;
            font-size: 11px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
            font-family: inherit;
            background: white;
        }
        
        .btn-pink {
            border-color: #FFB4D9;
            color: #FF6B9D;
        }
        
        .btn-pink:hover {
            background: #FFB4D9;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 0 #D97BA0;
        }
        
        .btn-green {
            border-color: #A8E6CF;
            color: #5BB99A;
        }
        
        .btn-green:hover {
            background: #A8E6CF;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 0 #7ED4B6;
        }
        
        .btn-blue {
            border-color: #B4D4FF;
            color: #6BA3FF;
        }
        
        .btn-blue:hover {
            background: #B4D4FF;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 0 #8AB8FF;
        }
        
        .btn-yellow {
            border-color: #FFE97F;
            color: #F0C419;
        }
        
        .btn-yellow:hover {
            background: #FFE97F;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 0 #E6D56C;
        }
        
        .content-section {
            padding: 30px;
            background: #FFFDF9;
        }
        
        .section-title {
            font-size: 1.3em;
            font-weight: bold;
            color: #FF8FB8;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 4px dotted #FFD4E5;
            text-align: center;
        }
        
        .notes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        
        .note-card {
            background: white;
            border-radius: 20px;
            border: 4px solid #FFD4E5;
            box-shadow: 0 5px 0 #FFB4D9,
                        0 10px 25px rgba(255, 180, 217, 0.3);
            overflow: hidden;
            transition: all 0.3s;
        }
        
        .note-card:hover {
            transform: translateY(-8px) rotate(1deg);
            box-shadow: 0 8px 0 #FFB4D9,
                        0 15px 35px rgba(255, 180, 217, 0.5);
        }
        
        .note-header {
            background: linear-gradient(135deg, #FFD4E5 0%, #FFB4D9 100%);
            padding: 15px;
            font-weight: bold;
            color: white;
            font-size: 0.9em;
            border-bottom: 3px solid #FF8FB8;
        }
        
        .note-body {
            padding: 20px;
        }
        
        .note-content {
            color: #6B4D5E;
            margin-bottom: 15px;
            line-height: 1.8;
            max-height: 120px;
            overflow: hidden;
            font-size: 0.7em;
        }
        
        .note-date {
            font-size: 0.6em;
            color: #C497B2;
            margin-bottom: 15px;
        }
        
        .note-actions {
            display: flex;
            gap: 8px;
        }
        
        .note-btn {
            flex: 1;
            padding: 8px 12px;
            border: 2px solid;
            border-radius: 12px;
            font-size: 9px;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            transition: all 0.3s;
            font-family: inherit;
            background: white;
        }
        
        .note-btn-edit {
            border-color: #FFE97F;
            color: #F0C419;
        }
        
        .note-btn-edit:hover {
            background: #FFE97F;
            color: white;
        }
        
        .note-btn-delete {
            border-color: #FFB4D9;
            color: #FF6B9D;
        }
        
        .note-btn-delete:hover {
            background: #FFB4D9;
            color: white;
        }
        
        .empty-box {
            background: repeating-linear-gradient(
                45deg,
                #FFF5FA 0px,
                #FFF5FA 20px,
                white 20px,
                white 40px
            );
            padding: 60px;
            border-radius: 25px;
            border: 5px dashed #FFB4D9;
            text-align: center;
        }
        
        .empty-box h2 {
            font-size: 1.5em;
            color: #FF8FB8;
            margin-bottom: 15px;
        }
        
        .empty-box p {
            color: #C497B2;
            font-size: 0.8em;
        }
        
        .footer-section {
            background: linear-gradient(180deg, #FFB4D9 0%, #FFD4E5 100%);
            padding: 20px 30px;
            text-align: center;
            color: white;
            font-size: 0.6em;
            border-top: 3px solid #FFB4D9;
        }
    </style>
</head>
<body>
    <!-- Xóa video element -->

    <div class="top-bar">
        <div class="browser-dots">
            <div class="dot dot-yellow"></div>
            <div class="dot dot-pink"></div>
            <div class="dot dot-red"></div>
        </div>
        <div class="site-url">mynotes.kawaii</div>
        <div class="browser-close">✕</div>
    </div>

    <div class="main-container">
        <div class="header-section">
            <div class="avatar-box">
                <img src="images/socute.jpg" alt="Icon">
            </div>
            <div class="header-info">
                <div class="site-title">My Notes</div>
                <form action="notes" method="get" class="search-box">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="keyword" class="search-input"
                           placeholder="search your notes here!"
                           value="<%= keyword != null ? keyword : "" %>">
                    <button type="submit" class="btn btn-pink">search</button>
                </form>
                <div class="button-group">
                    <a href="notes?action=new" class="btn btn-green">new note</a>
                    <% if (keyword != null && !keyword.isEmpty()) { %>
                        <a href="notes" class="btn btn-yellow">view all</a>
                    <% } %>
                    <a href="notes?action=trash" class="btn btn-blue">trash</a>
                    <a href="auth?action=logout" class="btn btn-pink" 
                       onclick="return confirm('logout?')">logout</a>
                </div>
            </div>
        </div>

        <div class="content-section">
            <div class="section-title">your notes</div>
            
            <% if (notes == null || notes.isEmpty()) { %>
                <div class="empty-box">
                    <h2>no notes yet!</h2>
                    <p>start writing your first note!</p>
                </div>
            <% } else { %>
                <div class="notes-grid">
                    <% for (NoteDTO note : notes) { %>
                        <div class="note-card">
                            <div class="note-header"><%= note.getTitle() %></div>
                            <div class="note-body">
                                <div class="note-content"><%= note.getContent() %></div>
                                <div class="note-date"><%= sdf.format(note.getUpdatedDate()) %></div>
                                <div class="note-actions">
                                    <a href="notes?action=edit&id=<%= note.getId() %>" 
                                       class="note-btn note-btn-edit">edit</a>
                                    <a href="notes?action=delete&id=<%= note.getId() %>" 
                                       class="note-btn note-btn-delete" 
                                       onclick="return confirm('delete this note?')">
                                       delete
                                    </a>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </div>

        <div class="footer-section">
             © 2025 Simple Notes App • made with ♡ 
        </div>
    </div>
</body>
</html>
