<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome - My Notes</title>
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
            overflow: hidden;
        }
        
        /* Browser window container */
        .browser-window {
            background: white;
            border-radius: 25px;
            border: 5px solid #FFB4D9;
            box-shadow: 0 20px 60px rgba(255, 180, 217, 0.5);
            width: 100%;
            max-width: 600px;
            overflow: hidden;
            animation: fadeIn 1s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Browser top bar */
        .browser-top {
            background: linear-gradient(180deg, #FFD4E5 0%, #FFB4D9 100%);
            padding: 15px 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .browser-dots {
            display: flex;
            gap: 8px;
        }
        
        .dot {
            width: 18px;
            height: 18px;
            border-radius: 50%;
            border: 2px solid rgba(255,255,255,0.8);
        }
        
        .dot-yellow { background: #FFF176; }
        .dot-pink { background: #FFB4D9; }
        .dot-red { background: #FF8FB8; }
        
        .browser-url {
            flex: 1;
            background: rgba(255, 255, 255, 0.95);
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
        
        /* Main content with pixel heart */
        .welcome-content {
            background: linear-gradient(180deg, #FFE5F0 0%, #FFF5FA 100%);
            padding: 60px 40px;
            text-align: center;
        }
        
        /* Replaced CSS pixel heart with actual image */
        .pixel-heart {
            width: 250px;
            height: auto;
            margin: 0 auto 30px;
            display: block;
            animation: heartbeat 1.5s ease-in-out infinite;
        }
        
        @keyframes heartbeat {
            0%, 100% { transform: scale(1); }
            25% { transform: scale(1.1); }
            50% { transform: scale(1); }
        }
        
        .welcome-title {
            font-size: 1.5em;
            font-weight: bold;
            color: #FF8FB8;
            margin-bottom: 15px;
            text-shadow: 3px 3px 0 #FFE5F0;
            line-height: 1.4;
        }
        
        .welcome-subtitle {
            font-size: 0.7em;
            color: #C497B2;
            margin-bottom: 40px;
        }
        
        /* Pink gingham pattern button */
        .enter-btn {
            display: inline-block;
            padding: 20px 60px;
            border: 4px solid #FF8FB8;
            border-radius: 30px;
            font-size: 0.8em;
            font-weight: bold;
            background: white;
            color: #FF6B9D;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 0 8px 0 #D97BA0,
                        0 15px 30px rgba(255, 143, 184, 0.4);
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        
        .enter-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 13px 0 #D97BA0,
                        0 20px 40px rgba(255, 143, 184, 0.6);
            background: linear-gradient(135deg, #FFB4D9 0%, #FF8FB8 100%);
            color: white;
        }
        
        .enter-btn:active {
            transform: translateY(4px);
            box-shadow: 0 4px 0 #D97BA0;
        }
        
        /* Video background styles */
        /* .video-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        } */
    </style>
</head>
<body>
    <!-- Xóa video element, dùng hình nền tĩnh thay thế -->

    <div class="browser-window">
        <div class="browser-top">
            <div class="browser-dots">
                <div class="dot dot-yellow"></div>
                <div class="dot dot-pink"></div>
                <div class="dot dot-red"></div>
            </div>
            <div class="browser-url"></div>
            <div class="browser-close">✕</div>
        </div>
        
        <div class="welcome-content">
            <!-- Using image instead of CSS-created heart -->
            <img src="images/cute-girl.jpg" alt="Cute Girl" class="pixel-heart">
            <!-- Đổi "Takes a note?" thành "Write a note?" -->
            <div class="welcome-title">Write a note?</div>
            <div class="welcome-subtitle">let's write something cute!</div>
            <a href="auth" class="enter-btn">ENTER</a>
        </div>
    </div>
</body>
</html>
