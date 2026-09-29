<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — Perishable Shop</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --bg-primary: #0a0a0a;
            --bg-card: rgba(255, 255, 255, 0.04);
            --bg-card-hover: rgba(255, 255, 255, 0.07);
            --border-subtle: rgba(255, 255, 255, 0.08);
            --border-hover: rgba(255, 255, 255, 0.15);
            --text-primary: #f5f5f7;
            --text-secondary: rgba(255, 255, 255, 0.6);
            --text-tertiary: rgba(255, 255, 255, 0.4);
            --accent: #bf5af2;
            --accent-hover: #a63de8;
            --accent-glow: rgba(191, 90, 242, 0.25);
            --blue: #2997ff;
            --green: #30d158;
            --orange: #ff9f0a;
            --radius-md: 12px;
            --radius-lg: 16px;
            --radius-xl: 20px;
            --transition-fast: 0.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            --transition-smooth: 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            min-height: 100vh;
            -webkit-font-smoothing: antialiased;
        }

        /* ─── NAVBAR ─── */
        .navbar {
            position: sticky; top: 0; z-index: 100;
            background: rgba(10, 10, 10, 0.72);
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            border-bottom: 1px solid var(--border-subtle);
            padding: 0 40px; height: 56px;
            display: flex; align-items: center; justify-content: space-between;
        }

        .nav-brand {
            display: flex; align-items: center; gap: 10px;
            text-decoration: none; color: var(--text-primary);
        }

        .nav-logo {
            width: 28px; height: 28px;
            background: linear-gradient(135deg, var(--accent), #ff6b6b);
            border-radius: 7px;
            display: flex; align-items: center; justify-content: center;
            font-size: 14px; color: #fff;
        }

        .nav-brand span { font-size: 15px; font-weight: 600; letter-spacing: -0.3px; }

        .nav-links {
            display: flex; align-items: center; gap: 4px; list-style: none;
        }

        .nav-links a {
            display: flex; align-items: center; gap: 6px;
            padding: 8px 16px; color: var(--text-secondary);
            text-decoration: none; font-size: 13px; font-weight: 500;
            border-radius: 8px; transition: all var(--transition-fast);
        }

        .nav-links a:hover {
            color: var(--text-primary);
            background: rgba(255, 255, 255, 0.06);
        }

        /* ─── HERO ─── */
        .admin-hero {
            padding: 72px 40px 56px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .admin-hero::before {
            content: '';
            position: absolute;
            top: -100px; left: 50%;
            transform: translateX(-50%);
            width: 600px; height: 500px;
            background: radial-gradient(circle, rgba(191, 90, 242, 0.12) 0%, transparent 60%);
            z-index: 0;
        }

        .hero-content {
            position: relative; z-index: 1;
        }

        .admin-badge {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 4px 14px;
            background: rgba(191, 90, 242, 0.12);
            border: 1px solid rgba(191, 90, 242, 0.25);
            border-radius: 100px;
            font-size: 11px; font-weight: 600; color: var(--accent);
            letter-spacing: 0.05em; text-transform: uppercase;
            margin-bottom: 20px;
        }

        .admin-hero h1 {
            font-size: 44px; font-weight: 800;
            letter-spacing: -1.5px; line-height: 1.1;
            background: linear-gradient(135deg, var(--text-primary) 0%, rgba(255,255,255,0.7) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 12px;
        }

        .admin-hero p {
            font-size: 17px; color: var(--text-secondary);
            max-width: 480px; margin: 0 auto;
        }

        /* ─── DASHBOARD CARDS ─── */
        .dashboard-grid {
            max-width: 960px;
            margin: 0 auto;
            padding: 0 40px 80px;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .dash-card {
            background: var(--bg-card);
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-xl);
            padding: 32px 28px;
            text-align: center;
            transition: all var(--transition-smooth);
            animation: cardFadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1) both;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .dash-card:nth-child(1) { animation-delay: 0.1s; }
        .dash-card:nth-child(2) { animation-delay: 0.2s; }
        .dash-card:nth-child(3) { animation-delay: 0.3s; }

        .dash-card:hover {
            background: var(--bg-card-hover);
            border-color: var(--border-hover);
            transform: translateY(-6px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
        }

        @keyframes cardFadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .dash-icon {
            width: 56px; height: 56px;
            border-radius: var(--radius-md);
            display: inline-flex;
            align-items: center; justify-content: center;
            font-size: 24px; color: #fff;
            margin-bottom: 20px;
        }

        .dash-icon.categories {
            background: linear-gradient(135deg, var(--blue), #64d2ff);
            box-shadow: 0 8px 24px rgba(41, 151, 255, 0.25);
        }

        .dash-icon.products {
            background: linear-gradient(135deg, var(--accent), #ff6b6b);
            box-shadow: 0 8px 24px rgba(191, 90, 242, 0.25);
        }

        .dash-icon.customers {
            background: linear-gradient(135deg, var(--green), #64d2ff);
            box-shadow: 0 8px 24px rgba(48, 209, 88, 0.25);
        }

        .dash-card h3 {
            font-size: 18px; font-weight: 600;
            letter-spacing: -0.3px; margin-bottom: 8px;
        }

        .dash-card p {
            font-size: 14px; color: var(--text-secondary);
            margin-bottom: 20px; line-height: 1.5;
        }

        .dash-card .card-action {
            display: inline-flex; align-items: center; gap: 6px;
            font-size: 13px; font-weight: 600;
            color: var(--accent);
            transition: gap var(--transition-fast);
        }

        .dash-card:hover .card-action {
            gap: 10px;
        }

        .dash-card .card-action i { font-size: 11px; }

        @media (max-width: 768px) {
            .dashboard-grid { grid-template-columns: 1fr; padding: 0 20px 60px; }
            .admin-hero { padding: 48px 20px 40px; }
            .admin-hero h1 { font-size: 32px; }
            .navbar { padding: 0 20px; }
        }
    </style>
</head>
<body>

<!-- ─── NAVBAR ─── -->
<nav class="navbar">
    <a href="/admin/" class="nav-brand">
        <div class="nav-logo"><i class="fas fa-gear"></i></div>
        <span>Admin Console</span>
    </a>
    <ul class="nav-links">
        <li><a href="/admin/"><i class="fas fa-grid-2"></i> Dashboard</a></li>
        <li><a href="/admin/logout"><i class="fas fa-arrow-right-from-bracket"></i> Logout</a></li>
    </ul>
</nav>

<!-- ─── HERO ─── -->
<section class="admin-hero">
    <div class="hero-content">
        <div class="admin-badge">
            <i class="fas fa-shield-halved"></i> Admin Panel
        </div>
        <h1>Welcome Back,<br>Admin.</h1>
        <p>Manage your store's categories, products, and customers from one place.</p>
    </div>
</section>

<!-- ─── DASHBOARD CARDS ─── -->
<div class="dashboard-grid">
    <a href="/admin/categories" class="dash-card">
        <div class="dash-icon categories">
            <i class="fas fa-layer-group"></i>
        </div>
        <h3>Categories</h3>
        <p>Organize and manage product categories for your store.</p>
        <div class="card-action">
            Manage <i class="fas fa-arrow-right"></i>
        </div>
    </a>

    <a href="/admin/products" class="dash-card">
        <div class="dash-icon products">
            <i class="fas fa-cube"></i>
        </div>
        <h3>Products</h3>
        <p>Add, update, or remove products from your inventory.</p>
        <div class="card-action">
            Manage <i class="fas fa-arrow-right"></i>
        </div>
    </a>

    <a href="/admin/customers" class="dash-card">
        <div class="dash-icon customers">
            <i class="fas fa-users"></i>
        </div>
        <h3>Customers</h3>
        <p>View and manage your customer accounts and data.</p>
        <div class="card-action">
            Manage <i class="fas fa-arrow-right"></i>
        </div>
    </a>
</div>

</body>
</html>