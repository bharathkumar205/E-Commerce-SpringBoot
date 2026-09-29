<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign In — Perishable Shop</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --bg-primary: #0a0a0a;
            --bg-card: rgba(255, 255, 255, 0.05);
            --bg-card-hover: rgba(255, 255, 255, 0.08);
            --border-subtle: rgba(255, 255, 255, 0.1);
            --text-primary: #f5f5f7;
            --text-secondary: rgba(255, 255, 255, 0.6);
            --text-tertiary: rgba(255, 255, 255, 0.4);
            --accent: #2997ff;
            --accent-hover: #0077ed;
            --accent-glow: rgba(41, 151, 255, 0.3);
            --danger: #ff453a;
            --input-bg: rgba(255, 255, 255, 0.06);
            --input-border: rgba(255, 255, 255, 0.12);
            --input-focus: rgba(41, 151, 255, 0.4);
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 20px;
            --radius-xl: 28px;
            --transition-fast: 0.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            --transition-smooth: 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        /* Ambient background glow */
        body::before {
            content: '';
            position: fixed;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(ellipse at 30% 20%, rgba(41, 151, 255, 0.08) 0%, transparent 50%),
                        radial-gradient(ellipse at 70% 80%, rgba(168, 85, 247, 0.06) 0%, transparent 50%);
            animation: ambientShift 20s ease-in-out infinite alternate;
            z-index: 0;
        }

        @keyframes ambientShift {
            0%   { transform: translate(0, 0) rotate(0deg); }
            100% { transform: translate(-5%, 3%) rotate(3deg); }
        }

        .login-wrapper {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 420px;
            padding: 0 24px;
            animation: fadeInUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) both;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px) scale(0.98); }
            to   { opacity: 1; transform: translateY(0) scale(1); }
        }

        .brand {
            text-align: center;
            margin-bottom: 40px;
        }

        .brand-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, var(--accent), #a855f7);
            border-radius: var(--radius-md);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 16px;
            font-size: 22px;
            color: #fff;
            box-shadow: 0 8px 32px rgba(41, 151, 255, 0.25);
        }

        .brand h1 {
            font-size: 24px;
            font-weight: 600;
            letter-spacing: -0.5px;
            color: var(--text-primary);
        }

        .brand p {
            font-size: 15px;
            color: var(--text-secondary);
            margin-top: 6px;
            font-weight: 400;
        }

        .login-card {
            background: var(--bg-card);
            backdrop-filter: blur(40px) saturate(150%);
            -webkit-backdrop-filter: blur(40px) saturate(150%);
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-xl);
            padding: 36px 32px;
            box-shadow: 0 24px 80px rgba(0, 0, 0, 0.4),
                        inset 0 1px 0 rgba(255, 255, 255, 0.05);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 500;
            color: var(--text-secondary);
            margin-bottom: 8px;
            letter-spacing: 0.01em;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-tertiary);
            font-size: 14px;
            transition: color var(--transition-fast);
            pointer-events: none;
        }

        .form-input {
            width: 100%;
            padding: 14px 16px 14px 44px;
            background: var(--input-bg);
            border: 1px solid var(--input-border);
            border-radius: var(--radius-md);
            color: var(--text-primary);
            font-family: inherit;
            font-size: 15px;
            font-weight: 400;
            outline: none;
            transition: all var(--transition-fast);
        }

        .form-input::placeholder {
            color: var(--text-tertiary);
        }

        .form-input:focus {
            border-color: var(--accent);
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 0 0 3px var(--input-focus);
        }

        .form-input:focus + i,
        .input-wrapper:focus-within i {
            color: var(--accent);
        }

        .btn-primary {
            width: 100%;
            padding: 14px 24px;
            background: var(--accent);
            color: #fff;
            border: none;
            border-radius: var(--radius-md);
            font-family: inherit;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-fast);
            margin-top: 8px;
            letter-spacing: 0.01em;
        }

        .btn-primary:hover {
            background: var(--accent-hover);
            transform: translateY(-1px);
            box-shadow: 0 8px 24px var(--accent-glow);
        }

        .btn-primary:active {
            transform: translateY(0);
            box-shadow: 0 4px 12px var(--accent-glow);
        }

        .form-footer {
            text-align: center;
            margin-top: 24px;
            font-size: 14px;
            color: var(--text-secondary);
        }

        .form-footer a {
            color: var(--accent);
            text-decoration: none;
            font-weight: 500;
            transition: color var(--transition-fast);
        }

        .form-footer a:hover {
            color: var(--text-primary);
        }

        .error-msg {
            text-align: center;
            color: var(--danger);
            font-size: 14px;
            font-weight: 500;
            margin-top: 16px;
            padding: 10px 16px;
            background: rgba(255, 69, 58, 0.1);
            border-radius: var(--radius-sm);
            border: 1px solid rgba(255, 69, 58, 0.2);
            display: ${not empty msg ? 'block' : 'none'};
        }

        /* Subtle grid pattern */
        .grid-bg {
            position: fixed;
            inset: 0;
            background-image: linear-gradient(rgba(255,255,255,0.02) 1px, transparent 1px),
                              linear-gradient(90deg, rgba(255,255,255,0.02) 1px, transparent 1px);
            background-size: 64px 64px;
            z-index: 0;
        }

        @media (max-width: 480px) {
            .login-card { padding: 28px 24px; }
            .brand h1 { font-size: 22px; }
        }
    </style>
</head>
<body>

<div class="grid-bg"></div>

<div class="login-wrapper">
    <div class="brand">
        <div class="brand-icon">
            <i class="fas fa-store"></i>
        </div>
        <h1>Welcome back</h1>
        <p>Sign in to your account</p>
    </div>

    <div class="login-card">
        <form action="/userloginvalidate" method="post" id="loginForm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-wrapper">
                    <input type="text" name="username" id="username" placeholder="Enter your username" required class="form-input" autocomplete="username">
                    <i class="fas fa-user"></i>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <input type="password" name="password" id="password" placeholder="Enter your password" required class="form-input" autocomplete="current-password">
                    <i class="fas fa-lock"></i>
                </div>
            </div>

            <button type="submit" class="btn-primary">Sign In</button>

            <div class="error-msg">${msg}</div>
        </form>

        <div class="form-footer">
            Don't have an account? <a href="/register">Create one</a>
        </div>
    </div>
</div>

</body>
</html>
