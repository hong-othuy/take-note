<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - My Notes</title>
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
        }
        
        .browser-top {
            background: linear-gradient(180deg, #FFD4E5 0%, #FFB4D9 100%);
            padding: 15px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            border-bottom: 3px solid #FF8FB8;
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
            font-size: 0.5em;
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
            background-image: url('images/bgg.jpg'); /* updated background image to bgg.jpg */
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-color: #FFF5FA;
            padding: 35px 30px 25px;
            text-align: center;
            border-bottom: 4px dotted #FFB4D9;
        }
        
        .title-text {
            font-size: 1.3em;
            font-weight: bold;
            /* reverted title text color to original pink */
            color: #FF8FB8;
            margin-bottom: 8px;
            text-shadow: 2px 2px 0 rgba(255,255,255,0.8);
        }
        
        .subtitle-text {
            /* kept subtitle text color white as requested */
            color: white;
            font-size: 0.6em;
            text-shadow: 1px 1px 0 rgba(0,0,0,0.2);
        }
        
        .form-section {
            padding: 35px 40px;
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
        
        .input-wrapper {
            margin-bottom: 20px;
        }
        
        .input-label {
            display: block;
            color: #FF8FB8;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.65em;
        }
        
        .input-field {
            width: 100%;
            padding: 12px 18px;
            border: 3px solid #FFD4E5;
            background: white;
            border-radius: 18px;
            font-size: 0.55em;
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
        }
        
        .password-hint {
            font-size: 0.5em;
            color: #C497B2;
            margin-top: 5px;
        }
        
        .submit-btn {
            width: 100%;
            padding: 16px;
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
            margin-top: 10px;
        }
        
        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 9px 0 #D97BA0,
                        0 13px 30px rgba(255, 143, 184, 0.5);
        }
        
        .submit-btn:active {
            transform: translateY(3px);
            box-shadow: 0 3px 0 #D97BA0;
        }
        
        .footer-section {
            background: linear-gradient(180deg, #FFB4D9 0%, #FFD4E5 100%);
            padding: 25px 40px;
            text-align: center;
            color: white;
            font-weight: 600;
            border-top: 3px solid #FFB4D9;
            font-size: 0.55em;
            line-height: 1.6;
        }
        
        .footer-section a {
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
            <div class="browser-url">mynotes.kawaii/register</div>
            <div class="browser-close">✕</div>
        </div>
        
        <div class="pixel-header">
            <div class="title-text">Sign Up</div>
            <div class="subtitle-text">join us!</div>
        </div>

        <div class="form-section">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    ${error}
                </div>
            <% } %>

            <form action="auth" method="post">
                <input type="hidden" name="action" value="register">
                
                <div class="input-wrapper">
                    <label class="input-label" for="fullName">Full Name:</label>
                    <input type="text" id="fullName" name="fullName" class="input-field"
                           placeholder="your name here!" required>
                </div>

                <div class="input-wrapper">
                    <label class="input-label" for="username">Username:</label>
                    <input type="text" id="username" name="username" class="input-field"
                           placeholder="pick a cute username!" 
                           pattern="[a-zA-Z0-9_]{3,20}"
                           title="3-20 characters, letters, numbers and underscores only"
                           required>
                </div>

                <div class="input-wrapper">
                    <label class="input-label" for="email">Email:</label>
                    <input type="email" id="email" name="email" class="input-field"
                           placeholder="your email here!" required>
                </div>

                <div class="input-wrapper">
                    <label class="input-label" for="password">Password:</label>
                    <input type="password" id="password" name="password" class="input-field"
                           placeholder="create a password!" 
                           minlength="6"
                           required>
                    <div class="password-hint">min. 6 characters</div>
                </div>

                <div class="input-wrapper">
                    <label class="input-label" for="confirmPassword">Confirm Password:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="input-field"
                           placeholder="type it again!" required>
                </div>

                <button type="submit" class="submit-btn">
                    Sign Up
                </button>
            </form>
        </div>

        <div class="footer-section">
            Already have an account? <a href="auth">Login here</a>
        </div>
    </div>
</body>
</html>
