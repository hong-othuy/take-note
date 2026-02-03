<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - Notes.</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap');
        
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

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Plus Jakarta Sans', -apple-system, sans-serif;
            background-color: var(--background);
            color: var(--foreground);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }

        .auth-card {
            background: white;
            padding: 2.5rem;
            border-radius: var(--radius);
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.05), 0 2px 4px -2px rgba(79, 70, 229, 0.05);
            width: 100%;
            max-width: 400px;
            border: 1px solid var(--border);
        }

        .auth-header { text-align: center; margin-bottom: 2rem; }
        .logo { font-weight: 700; color: var(--primary); font-size: 1.5rem; margin-bottom: 0.5rem; display: block; text-decoration: none; }
        .auth-title { font-size: 1.25rem; font-weight: 600; }
        .auth-subtitle { color: var(--muted-foreground); font-size: 0.875rem; margin-top: 0.25rem; }

        .form-group { margin-bottom: 1.25rem; }
        .label { display: block; font-size: 0.875rem; font-weight: 500; margin-bottom: 0.5rem; }
        .input {
            width: 100%;
            padding: 0.625rem 0.875rem;
            border: 1px solid var(--border);
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-family: inherit;
            transition: border-color 0.2s;
        }
        .input:focus { outline: none; border-color: var(--primary); }

        .btn {
            width: 100%;
            padding: 0.75rem;
            background: var(--primary);
            color: var(--primary-foreground);
            border: none;
            border-radius: var(--radius);
            font-weight: 600;
            font-size: 0.875rem;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.1);
        }
        .btn:hover { 
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .auth-footer { margin-top: 1.5rem; text-align: center; font-size: 0.875rem; color: var(--muted-foreground); }
        .auth-footer a { color: var(--primary); }
        .link { color: var(--primary); text-decoration: none; font-weight: 500; transition: color 0.2s; }
        .link:hover { color: #4338ca; }

        .alert {
            padding: 0.75rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
            font-size: 0.875rem;
        }
        .alert-error { background: #fee2e2; color: #991b1b; }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-header">
            <a href="." class="logo">Notes.</a>
            <h1 class="auth-title">Welcome back</h1>
            <p class="auth-subtitle">Enter your credentials to continue</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">${error}</div>
        <% } %>

        <form action="auth" method="post">
            <input type="hidden" name="action" value="login">
            <div class="form-group">
                <label class="label">Username</label>
                <input type="text" name="username" class="input" required autofocus>
            </div>
            <div class="form-group">
                <label class="label">Password</label>
                <input type="password" name="password" class="input" required>
            </div>
            <button type="submit" class="btn">Sign In</button>
        </form>

        <div class="auth-footer">
            Don't have an account? <a href="register.jsp" class="link">Sign up</a>
        </div>
    </div>
</body>
</html>
