<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 — Access Denied</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #0a0a0a;
            color: #f5f5f7;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            -webkit-font-smoothing: antialiased;
        }

        body::before {
            content: '';
            position: fixed;
            top: -50%; left: -50%;
            width: 200%; height: 200%;
            background: radial-gradient(ellipse at 50% 40%, rgba(255, 69, 58, 0.08) 0%, transparent 50%);
            z-index: 0;
        }

        .grid-bg {
            position: fixed; inset: 0;
            background-image: linear-gradient(rgba(255,255,255,0.02) 1px, transparent 1px),
                              linear-gradient(90deg, rgba(255,255,255,0.02) 1px, transparent 1px);
            background-size: 64px 64px; z-index: 0;
        }

        .error-wrapper {
            position: relative;
            z-index: 1;
            text-align: center;
            max-width: 480px;
            padding: 0 24px;
            animation: fadeInUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) both;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px) scale(0.98); }
            to   { opacity: 1; transform: translateY(0) scale(1); }
        }

        .error-icon {
            width: 80px; height: 80px;
            background: rgba(255, 69, 58, 0.12);
            border: 1px solid rgba(255, 69, 58, 0.25);
            border-radius: 24px;
            display: inline-flex;
            align-items: center; justify-content: center;
            font-size: 36px;
            color: #ff453a;
            margin-bottom: 28px;
        }

        .error-code {
            font-size: 72px;
            font-weight: 800;
            letter-spacing: -3px;
            line-height: 1;
            background: linear-gradient(135deg, #ff453a 0%, #ff6b6b 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 12px;
        }

        .error-title {
            font-size: 24px;
            font-weight: 600;
            letter-spacing: -0.5px;
            margin-bottom: 12px;
        }

        .error-message {
            font-size: 16px;
            color: rgba(255, 255, 255, 0.5);
            line-height: 1.6;
            margin-bottom: 36px;
        }

        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 14px 28px;
            background: rgba(255, 255, 255, 0.06);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            color: #f5f5f7;
            text-decoration: none;
            font-family: inherit;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }

        .btn-home:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.2);
            transform: translateY(-1px);
        }

        .btn-home i { font-size: 14px; }
    </style>
</head>
<body>

<div class="grid-bg"></div>

<div class="error-wrapper">
    <div class="error-icon">
        <i class="fas fa-shield-halved"></i>
    </div>
    <div class="error-code">403</div>
    <h1 class="error-title">Access Denied</h1>
    <p class="error-message">
        You don't have permission to access this page. 
        If you believe this is an error, please contact your administrator.
    </p>
    <a href="/" class="btn-home">
        <i class="fas fa-arrow-left"></i> Go Home
    </a>
</div>

</body>
</html>
