<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join Us - Notes.</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        :root {
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
            max-width: 440px;
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
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: -0.04em;
            color: var(--foreground);
            margin-bottom: 2rem;
        }

        .error-msg {
            background-color: #fef2f2;
            color: var(--primary);
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 24px;
            border: 1px solid #fee2e2;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--foreground);
        }

        input {
            width: 100%;
            background: white;
            border: 1px solid var(--border);
            color: var(--foreground);
            padding: 0.75rem 1rem;
            border-radius: var(--radius);
            font-size: 0.875rem;
            font-family: inherit;
            transition: all 0.2s;
            outline: none;
        }

        input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.1);
        }

        .btn {
            width: 100%;
            background-color: var(--primary);
            color: var(--primary-foreground);
            padding: 0.75rem;
            border: none;
            border-radius: var(--radius);
            font-size: 0.875rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            margin-top: 12px;
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.1);
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .footer {
            margin-top: 32px;
            text-align: center;
            font-size: 14px;
            color: var(--muted-foreground);
        }

        .footer a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Join Us</h1>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-msg">
                ${error}
            </div>
        <% } %>

        <form action="auth" method="post">
            <input type="hidden" name="action" value="register">
            
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" placeholder="John Doe" required>
            </div>

            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="johndoe" required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="john@example.com" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="••••••••" required minlength="6">
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn">Create Account</button>
        </form>

        <div class="footer">
            Already have an account? <a href="auth">Log in</a>
        </div>
    </div>
</body>
</html>
