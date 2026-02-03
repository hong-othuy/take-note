<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modern Notes - Simple & Secure</title>
    <!-- Added Lucide icons for Zap/Lucide style vibrancy -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap');
        
        :root {
            /* Updated to a modern, clean light theme palette */
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

        html, body {
            height: 100%;
            overflow: hidden;
        }

        body {
            font-family: 'Plus Jakarta Sans', -apple-system, sans-serif;
            background-color: var(--background);
            color: var(--foreground);
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
        }

        .page-wrapper {
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 1.5rem;
            width: 100%;
        }

        header {
            height: 4.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid var(--border);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--foreground);
            text-decoration: none;
            letter-spacing: -0.03em;
        }

        .logo i {
            color: var(--primary);
        }

        .nav-links {
            display: flex;
            gap: 1.25rem;
            align-items: center;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.625rem 1.25rem;
            border-radius: var(--radius);
            font-size: 0.875rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            border: 1px solid transparent;
        }

        .btn-primary {
            background-color: var(--primary);
            color: var(--primary-foreground);
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.1), 0 2px 4px -2px rgba(79, 70, 229, 0.1);
        }

        .btn-primary:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .btn-ghost {
            color: var(--muted-foreground);
        }

        .btn-ghost:hover {
            background-color: var(--accent);
            color: var(--foreground);
        }

        main {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
            padding: 2rem 0;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background-color: var(--accent);
            color: var(--primary);
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            border: 1px solid var(--border);
        }

        .hero-title {
            font-size: clamp(2.5rem, 6vw, 4.5rem);
            font-weight: 800;
            letter-spacing: -0.05em;
            line-height: 1.1;
            margin-bottom: 1.5rem;
            color: var(--foreground);
        }

        .hero-subtitle {
            font-size: 1.125rem;
            color: var(--muted-foreground);
            max-width: 600px;
            margin: 0 auto 2.5rem;
            line-height: 1.6;
        }

        .cta-group {
            margin-bottom: 3rem;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
            max-width: 900px;
            margin: 0 auto;
        }

        .feature-card {
            padding: 1.5rem;
            background: white;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            text-align: left;
            transition: all 0.2s;
        }

        .feature-card:hover {
            border-color: var(--primary);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
        }

        .feature-icon {
            width: 2.5rem;
            height: 2.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--accent);
            color: var(--primary);
            border-radius: 0.75rem;
            margin-bottom: 1rem;
        }

        .feature-title {
            font-size: 1rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--foreground);
        }

        .feature-desc {
            font-size: 0.875rem;
            color: var(--muted-foreground);
            line-height: 1.6;
        }

        @media (max-width: 768px) {
            .hero-title { font-size: 2.25rem; }
            .feature-grid { grid-template-columns: 1fr; }
            main { padding: 1.5rem 0; }
        }
    </style>
</head>
<body>
    <div class="page-wrapper">
        <div class="container">
            <header>
                <a href="." class="logo">
                    Notes.
                </a>
                <nav class="nav-links">
                    <a href="auth" class="btn btn-ghost">Sign In</a>
                    <a href="auth?action=register" class="btn btn-primary">Get Started</a>
                </nav>
            </header>
        </div>

        <main>
            <div class="container">
                <h1 class="hero-title">Your thoughts, effortlessly organized.</h1>
                <p class="hero-subtitle">Experience a clean, modern workspace designed to capture your ideas instantly and keep your productivity flowing.</p>
                
                <div class="cta-group">
                    <a href="auth?action=register" class="btn btn-primary" style="padding: 0.875rem 2.5rem; font-size: 1rem;">
                        Start Writing Now
                    </a>
                </div>

                <div class="feature-grid">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i data-lucide="feather"></i>
                        </div>
                        <h3 class="feature-title">Lightweight Experience</h3>
                        <p class="feature-desc">A minimal interface that stays out of your way, so you can focus on what matters most.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i data-lucide="shield-check"></i>
                        </div>
                        <h3 class="feature-title">Encrypted Sync</h3>
                        <p class="feature-desc">Your thoughts are private. Everything is securely synced across all your devices in real-time.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i data-lucide="search"></i>
                        </div>
                        <h3 class="feature-title">Lightning Search</h3>
                        <p class="feature-desc">Instantly find any snippet of information with our optimized search engine.</p>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <script>
        lucide.createIcons();
    </script>
</body>
</html>