<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - My Notes</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Varela+Round&family=Fredoka:wght@400;500;600&family=Press+Start+2P&display=swap');
        
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
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
        
        .browser-window {
            background: white;
            border-radius: 25px;
            border: 5px solid #FFB4D9;
            box-shadow: 0 15px 50px rgba(255, 180, 217, 0.4);
            width: 100%;
            max-width: 550px;
            overflow: hidden;
            position: relative;
        }
        
        .browser-top {
            background: linear-gradient(180deg, #FFD4E5 0%, #FFB4D9 100%);
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
            font-size: 0.6em;
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
        
        .pixel-header {
            background-image: url('images/bgg.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-color: #FFF5FA;
            padding: 40px 30px 30px;
            text-align: center;
            border-bottom: 4px dotted #FFB4D9;
        }
        
        .title-text {
            font-size: 1.5em;
            font-weight: bold;
            /* reverted title text color to original pink */
            color: #FF8FB8;
            margin-bottom: 10px;
            text-shadow: 2px 2px 0 rgba(255,255,255,0.8);
        }
        
        .subtitle-text {
            /* kept subtitle text color white as requested */
            color: white;
            font-size: 0.6em;
            text-shadow: 1px 1px 0 rgba(0,0,0,0.2);
        }
        
        .form-section {
            padding: 40px;
            background: #FFFDF9;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            border: 3px solid;
            font-weight: 500;
        }
        
        .alert-error {
            background: #FFE5E5;
            color: #FF6B9D;
            border-color: #FFB4D9;
        }
        
        .alert-success {
            background: #FFF5E5;
            color: #FFB347;
            border-color: #FFD180;
        }
        
        .input-wrapper {
            margin-bottom: 25px;
        }
        
        .input-label {
            display: block;
            color: #FF8FB8;
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 0.7em;
        }
        
        .input-field {
            width: 100%;
            padding: 15px 20px;
            border: 3px solid #FFD4E5;
            background: white;
            border-radius: 20px;
            font-size: 0.6em;
            font-family: inherit;
            transition: all 0.3s;
            color: #6B4D5E;
        }
        
        .input-field::placeholder {
            color: #E5B9D0;
        }
        
        .input-field:focus {
            outline: none;
            border-color: #FFB4D9;
            box-shadow: 0 0 0 4px rgba(255, 180, 217, 0.2);
            transform: translateY(-2px);
        }
        
        .submit-btn {
            width: 100%;
            padding: 18px;
            border: 4px solid #FF8FB8;
            border-radius: 25px;
            font-size: 0.7em;
            font-weight: bold;
            background: linear-gradient(135deg, #FFB4D9 0%, #FF8FB8 100%);
            color: white;
            cursor: pointer;
            box-shadow: 0 6px 0 #D97BA0,
                        0 10px 25px rgba(255, 143, 184, 0.4);
            transition: all 0.2s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 9px 0 #D97BA0,
                        0 13px 30px rgba(255, 143, 184, 0.5);
        }
        
        .submit-btn:active {
            transform: translateY(3px);
            box-shadow: 0 3px 0 #D97BA0,
                        0 5px 15px rgba(255, 143, 184, 0.3);
        }
        
        .footer-section {
            /* Footer ombre giống header - từ hồng nhạt đến hồng đậm hơn một chút */
            background: linear-gradient(180deg, #FFB4D9 0%, #FFD4E5 100%);
            padding: 25px 40px;
            text-align: center;
            /* đổi màu chữ thành trắng */
            color: white;
            font-weight: 600;
            border-top: 3px solid #FFB4D9;
            font-size: 0.55em;
            line-height: 1.6;
        }
        
        .footer-section a {
            /* đổi màu link thành trắng */
            color: white;
            text-decoration: none;
            font-weight: bold;
            border-bottom: 2px dotted white;
        }
        
        .footer-section a:hover {
            color: #FFF5FA;
            border-bottom-color: #FFF5FA;
        }
    </style>
</head>
<body>
    <!-- Xóa video element -->

    <div class="browser-window">
        <div class="browser-top">
            <div class="browser-dots">
                <div class="dot dot-yellow"></div>
                <div class="dot dot-pink"></div>
                <div class="dot dot-red"></div>
            </div>
            <div class="browser-url">mynotes.kawaii</div>
            <div class="browser-close">✕</div>
        </div>
        
        <div class="pixel-header">
            <div class="title-text">My Notes</div>
            <div class="subtitle-text">welcome back!</div>
        </div>

        <div class="form-section">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    ${error}
                </div>
            <% } %>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">
                    ${success}
                </div>
            <% } %>

            <form action="auth" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="input-wrapper">
                    <label class="input-label" for="username">Name:</label>
                    <input type="text" id="username" name="username" class="input-field"
                           placeholder="your username here!" required autofocus>
                </div>

                <div class="input-wrapper">
                    <label class="input-label" for="password">Password:</label>
                    <input type="password" id="password" name="password" class="input-field"
                           placeholder="your password here!" required>
                </div>

                <button type="submit" class="submit-btn">
                    Login
                </button>
            </form>
        </div>

        <div class="footer-section">
            Don't have an account? <a href="auth?action=register">Sign up here</a>
        </div>
    </div>
</body>
</html>
