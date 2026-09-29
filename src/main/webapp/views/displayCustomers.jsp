<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers — Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --bg-primary: #0a0a0a;
            --bg-card: rgba(255, 255, 255, 0.04);
            --border-subtle: rgba(255, 255, 255, 0.08);
            --text-primary: #f5f5f7;
            --text-secondary: rgba(255, 255, 255, 0.6);
            --text-tertiary: rgba(255, 255, 255, 0.4);
            --accent: #30d158;
            --radius-sm: 8px;
            --radius-xl: 20px;
            --transition-fast: 0.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            min-height: 100vh;
            -webkit-font-smoothing: antialiased;
        }

        .navbar {
            position: sticky; top: 0; z-index: 100;
            background: rgba(10, 10, 10, 0.72);
            backdrop-filter: blur(20px) saturate(180%);
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
            background: linear-gradient(135deg, #bf5af2, #ff6b6b);
            border-radius: 7px;
            display: flex; align-items: center; justify-content: center;
            font-size: 14px; color: #fff;
        }

        .nav-brand span { font-size: 15px; font-weight: 600; }

        .nav-links { display: flex; align-items: center; gap: 4px; list-style: none; }

        .nav-links a {
            display: flex; align-items: center; gap: 6px;
            padding: 8px 16px; color: var(--text-secondary);
            text-decoration: none; font-size: 13px; font-weight: 500;
            border-radius: var(--radius-sm); transition: all var(--transition-fast);
        }

        .nav-links a:hover { color: var(--text-primary); background: rgba(255,255,255,0.06); }

        .page-header {
            max-width: 960px; margin: 0 auto;
            padding: 48px 40px 32px;
        }

        .page-header h1 { font-size: 32px; font-weight: 700; letter-spacing: -0.8px; }
        .page-header p { font-size: 15px; color: var(--text-secondary); margin-top: 4px; }

        .table-container {
            max-width: 960px; margin: 0 auto;
            padding: 0 40px 80px;
        }

        .data-table {
            width: 100%;
            background: var(--bg-card);
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-xl);
            overflow: hidden;
            border-collapse: separate;
            border-spacing: 0;
        }

        .data-table thead th {
            padding: 14px 20px; text-align: left;
            font-size: 11px; font-weight: 600;
            color: var(--text-tertiary); text-transform: uppercase;
            letter-spacing: 0.05em;
            background: rgba(255,255,255,0.03);
            border-bottom: 1px solid var(--border-subtle);
        }

        .data-table tbody td {
            padding: 16px 20px; font-size: 14px;
            color: var(--text-secondary);
            border-bottom: 1px solid rgba(255,255,255,0.04);
            vertical-align: middle;
        }

        .data-table tbody tr { transition: background var(--transition-fast); }
        .data-table tbody tr:hover { background: rgba(255,255,255,0.03); }
        .data-table tbody tr:last-child td { border-bottom: none; }

        .user-info {
            display: flex; align-items: center; gap: 12px;
        }

        .user-avatar {
            width: 36px; height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent), #2997ff);
            display: flex; align-items: center; justify-content: center;
            font-size: 14px; font-weight: 700; color: #fff;
            flex-shrink: 0;
        }

        .user-name { color: var(--text-primary); font-weight: 500; }

        .email-cell {
            color: var(--text-secondary);
            font-size: 13px;
        }

        .address-cell {
            max-width: 240px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .empty-state {
            text-align: center; padding: 60px 20px; color: var(--text-tertiary);
        }
        .empty-state i { font-size: 40px; margin-bottom: 12px; display: block; }

        @media (max-width: 768px) {
            .navbar, .page-header, .table-container { padding-left: 20px; padding-right: 20px; }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="/admin/" class="nav-brand">
        <div class="nav-logo"><i class="fas fa-gear"></i></div>
        <span>Admin Console</span>
    </a>
    <ul class="nav-links">
        <li><a href="Dashboard"><i class="fas fa-grid-2"></i> Dashboard</a></li>
        <li><a href="logout"><i class="fas fa-arrow-right-from-bracket"></i> Logout</a></li>
    </ul>
</nav>

<div class="page-header">
    <h1>Customers</h1>
    <p>View registered customer accounts</p>
</div>

<div class="table-container">
    <c:choose>
        <c:when test="${not empty customers}">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Customer</th>
                        <th>Email</th>
                        <th>Address</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="customer" items="${customers}">
                        <tr>
                            <td>
                                <div class="user-info">
                                    <div class="user-avatar">${customer.username.substring(0,1).toUpperCase()}</div>
                                    <span class="user-name">${customer.username}</span>
                                </div>
                            </td>
                            <td class="email-cell">${customer.email}</td>
                            <td class="address-cell">${customer.address}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-users"></i>
                <p>No customers registered yet.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>