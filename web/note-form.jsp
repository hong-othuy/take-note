<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.NoteDTO" %>
<%
    NoteDTO note = (NoteDTO) request.getAttribute("note");
    boolean isEdit = (note != null);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= isEdit ? "Edit" : "Create" %> Note</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Varela+Round&family=Fredoka:wght@400;500;600&family=Press+Start+2P&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Press Start 2P', 'Varela Round', 'Fredoka', sans-serif;
            /* Thay video background bằng hình nền tĩnh */
            background-image: url('images/kawaii-bg-pattern.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
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
        
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-25px) rotate(3deg); }
        }
        @keyframes bounce {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
        }
        @keyframes wiggle {
            0%, 100% { transform: rotate(-2deg); }
            50% { transform: rotate(2deg); }
        }
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }
        
        .form-container {
            background: white;
            border-radius: 25px;
            border: 5px solid #FFB4D9;
            box-shadow: 0 15px 50px rgba(255, 180, 217, 0.4);
            width: 100%;
            max-width: 700px;
            overflow: hidden;
        }
        
        .browser-top {
            background: linear-gradient(180deg, #FFD4E5 0px, #FFB4D9 100%);
            padding: 15px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .browser-dots {
            display: flex;
            gap: 8px;
        }
        
        .dot {
            width: 18px;
            height: 18px;
            border-radius: 50%;
            border: 2px solid rgba(255,255,255,0.7);
        }
        
        .dot-yellow { background: #FFF176; }
        .dot-pink { background: #FFB4D9; }
        .dot-red { background: #FF8FB8; }
        
        .browser-url {
            flex: 1;
            background: rgba(255, 255, 255, 0.9);
            padding: 8px 15px;
            border-radius: 15px;
            font-size: 0.65em;
            color: #A06A8A;
            text-align: center;
            font-weight: 500;
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
        
        .form-header {
            background: repeating-linear-gradient(
                45deg,
                #FFE5F0 0px,
                #FFE5F0 20px,
                white 20px,
                white 40px
            );
            padding: 30px;
            border-bottom: 4px dotted #FFB4D9;
            text-align: center;
            position: relative;
        }
        
        .pixel-heart {
            width: 120px;
            height: auto;
            margin: 0 auto 15px;
            display: block;
            animation: wiggle 2s ease-in-out infinite;
        }
        
        h1 {
            font-size: 1.4em;
            font-weight: bold;
            color: #FF8FB8;
            text-shadow: 2px 2px 0 #FFE5F0;
        }
        
        .form-body {
            padding: 40px;
            background: #FFFDF9;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 10px;
            color: #FF8FB8;
            font-weight: bold;
            font-size: 0.8em;
        }
        
        input[type="text"],
        textarea {
            width: 100%;
            padding: 15px 20px;
            background: white;
            border: 3px solid #FFD4E5;
            border-radius: 20px;
            font-size: 11px;
            transition: all 0.3s;
            font-family: inherit;
            color: #6B4D5E;
        }
        
        input[type="text"]::placeholder,
        textarea::placeholder {
            color: #E5B9D0;
        }
        
        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #FFB4D9;
            box-shadow: 0 0 0 4px rgba(255, 180, 217, 0.2);
        }
        
        textarea {
            min-height: 300px;
            resize: vertical;
            line-height: 1.8;
        }
        
        .btn-group {
            display: flex;
            gap: 15px;
        }
        
        .btn {
            padding: 15px 30px;
            border: 4px solid;
            border-radius: 25px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            font-weight: bold;
            font-family: inherit;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #FFB4D9 0%, #FF8FB8 100%);
            color: white;
            flex: 1;
            border-color: #FF8FB8;
            box-shadow: 0 6px 0 #D97BA0,
                        0 10px 25px rgba(255, 143, 184, 0.4);
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 9px 0 #D97BA0,
                        0 13px 30px rgba(255, 143, 184, 0.5);
        }
        
        .btn-primary:active {
            transform: translateY(3px);
            box-shadow: 0 3px 0 #D97BA0;
        }
        
        .btn-secondary {
            background: #F5F5F5;
            color: #888;
            border-color: #DDD;
            box-shadow: 0 4px 0 #BBB;
        }
        
        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 0 #BBB;
            background: #EEE;
        }
    </style>
</head>
<body>
    <!-- Xóa video element -->

    <div class="form-container">
        <div class="browser-top">
            <div class="browser-dots">
                <div class="dot dot-yellow"></div>
                <div class="dot dot-pink"></div>
                <div class="dot dot-red"></div>
            </div>
            <div class="browser-url">mynotes.kawaii/note</div>
            <div class="browser-close">✕</div>
        </div>
        
        <div class="form-header">
            <!-- updated image source to the transparent png version -->
            <img src="images/notes.png" alt="Pixel Notes" class="pixel-heart">
            <h1>
                <%= isEdit ? "Edit Note" : "New Note" %>
            </h1>
        </div>
        
        <div class="form-body">
            <form action="notes" method="post">
                <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>">
                <% if (isEdit) { %>
                    <input type="hidden" name="id" value="<%= note.getId() %>">
                <% } %>
                
                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" id="title" name="title" 
                           value="<%= isEdit ? note.getTitle() : "" %>" 
                           placeholder="Enter note title..." 
                           required>
                </div>
                
                <div class="form-group">
                    <label for="content">Content</label>
                    <textarea id="content" name="content" 
                              placeholder="Enter note content..." 
                              required><%= isEdit ? note.getContent() : "" %></textarea>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <%= isEdit ? "Update" : "Save" %>
                    </button>
                    <a href="notes" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
