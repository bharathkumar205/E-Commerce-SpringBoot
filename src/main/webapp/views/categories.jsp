<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.*"%>

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories — Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            --accent: #2997ff;
            --accent-hover: #0077ed;
            --accent-glow: rgba(41, 151, 255, 0.25);
            --danger: #ff453a;
            --danger-hover: #e03e35;
            --warning: #ff9f0a;
            --warning-hover: #e68f09;
            --input-bg: rgba(255, 255, 255, 0.06);
            --input-border: rgba(255, 255, 255, 0.12);
            --input-focus: rgba(41, 151, 255, 0.4);
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-xl: 20px;
            --transition-fast: 0.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);
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

        .nav-links {
            display: flex; align-items: center; gap: 4px; list-style: none;
        }

        .nav-links a {
            display: flex; align-items: center; gap: 6px;
            padding: 8px 16px; color: var(--text-secondary);
            text-decoration: none; font-size: 13px; font-weight: 500;
            border-radius: var(--radius-sm); transition: all var(--transition-fast);
        }

        .nav-links a:hover {
            color: var(--text-primary);
            background: rgba(255, 255, 255, 0.06);
        }

        /* ─── PAGE HEADER ─── */
        .page-header {
            max-width: 960px;
            margin: 0 auto;
            padding: 48px 40px 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .page-header h1 {
            font-size: 32px; font-weight: 700;
            letter-spacing: -0.8px;
        }

        .page-header p {
            font-size: 15px; color: var(--text-secondary);
            margin-top: 4px;
        }

        /* ─── BUTTONS ─── */
        .btn {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 10px 18px;
            border: none; border-radius: var(--radius-sm);
            font-family: inherit; font-size: 13px; font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-fast);
            text-decoration: none;
        }

        .btn:active { transform: translateY(0); }
        .btn i { font-size: 12px; }

        .btn-accent {
            background: var(--accent); color: #fff;
        }

        .btn-accent:hover {
            background: var(--accent-hover);
            transform: translateY(-1px);
            box-shadow: 0 6px 20px var(--accent-glow);
        }

        .btn-danger {
            background: rgba(255, 69, 58, 0.12);
            color: var(--danger);
            border: 1px solid rgba(255, 69, 58, 0.2);
        }

        .btn-danger:hover {
            background: var(--danger);
            color: #fff;
            border-color: var(--danger);
        }

        .btn-warning {
            background: rgba(255, 159, 10, 0.12);
            color: var(--warning);
            border: 1px solid rgba(255, 159, 10, 0.2);
        }

        .btn-warning:hover {
            background: var(--warning);
            color: #000;
            border-color: var(--warning);
        }

        .btn-ghost {
            background: rgba(255, 255, 255, 0.06);
            color: var(--text-secondary);
            border: 1px solid var(--border-subtle);
        }

        .btn-ghost:hover {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
        }

        /* ─── TABLE ─── */
        .table-container {
            max-width: 960px;
            margin: 0 auto;
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
            padding: 14px 20px;
            text-align: left;
            font-size: 12px;
            font-weight: 600;
            color: var(--text-tertiary);
            text-transform: uppercase;
            letter-spacing: 0.05em;
            background: rgba(255, 255, 255, 0.03);
            border-bottom: 1px solid var(--border-subtle);
        }

        .data-table tbody td {
            padding: 16px 20px;
            font-size: 14px;
            color: var(--text-secondary);
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            vertical-align: middle;
        }

        .data-table tbody tr {
            transition: background var(--transition-fast);
        }

        .data-table tbody tr:hover {
            background: rgba(255, 255, 255, 0.03);
        }

        .data-table tbody tr:last-child td {
            border-bottom: none;
        }

        .id-badge {
            display: inline-flex;
            padding: 2px 10px;
            background: rgba(255, 255, 255, 0.06);
            border-radius: 100px;
            font-size: 12px;
            font-weight: 600;
            color: var(--text-tertiary);
            font-variant-numeric: tabular-nums;
        }

        .actions-cell {
            display: flex;
            gap: 8px;
        }

        /* ─── MODAL ─── */
        .modal-overlay {
            display: none;
            position: fixed; inset: 0;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(8px);
            z-index: 200;
            align-items: center;
            justify-content: center;
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal-card {
            background: #1a1a1a;
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-xl);
            padding: 32px;
            width: 100%;
            max-width: 440px;
            box-shadow: 0 32px 100px rgba(0, 0, 0, 0.6);
            animation: modalFadeIn 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes modalFadeIn {
            from { opacity: 0; transform: scale(0.95) translateY(10px); }
            to   { opacity: 1; transform: scale(1) translateY(0); }
        }

        .modal-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }

        .modal-header h3 {
            font-size: 18px; font-weight: 600;
            letter-spacing: -0.3px;
        }

        .modal-close {
            width: 32px; height: 32px;
            background: rgba(255, 255, 255, 0.06);
            border: none;
            border-radius: 50%;
            color: var(--text-tertiary);
            font-size: 14px;
            cursor: pointer;
            display: flex; align-items: center; justify-content: center;
            transition: all var(--transition-fast);
        }

        .modal-close:hover {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
        }

        .form-input {
            width: 100%;
            padding: 14px 16px;
            background: var(--input-bg);
            border: 1px solid var(--input-border);
            border-radius: var(--radius-md);
            color: var(--text-primary);
            font-family: inherit; font-size: 15px;
            outline: none;
            transition: all var(--transition-fast);
        }

        .form-input::placeholder { color: var(--text-tertiary); }

        .form-input:focus {
            border-color: var(--accent);
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 0 0 3px var(--input-focus);
        }

        .form-input[readonly] {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .modal-actions {
            display: flex;
            gap: 10px;
            margin-top: 24px;
            justify-content: flex-end;
        }

        /* ─── EMPTY STATE ─── */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-tertiary);
        }

        .empty-state i { font-size: 40px; margin-bottom: 12px; }

        @media (max-width: 768px) {
            .navbar, .page-header, .table-container { padding-left: 20px; padding-right: 20px; }
            .page-header { flex-direction: column; gap: 16px; align-items: flex-start; }
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
        <li><a href="Dashboard"><i class="fas fa-grid-2"></i> Dashboard</a></li>
        <li><a href="logout"><i class="fas fa-arrow-right-from-bracket"></i> Logout</a></li>
    </ul>
</nav>

<!-- ─── PAGE HEADER ─── -->
<div class="page-header">
    <div>
        <h1>Categories</h1>
        <p>Manage your product categories</p>
    </div>
    <button class="btn btn-accent" onclick="openAddModal()">
        <i class="fas fa-plus"></i> Add Category
    </button>
</div>

<!-- ─── TABLE ─── -->
<div class="table-container">
    <c:choose>
        <c:when test="${not empty categories}">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Category Name</th>
                        <th style="text-align: right;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="category" items="${categories}">
                        <tr>
                            <td><span class="id-badge">#${category.id}</span></td>
                            <td style="color: var(--text-primary); font-weight: 500;">${category.name}</td>
                            <td>
                                <div class="actions-cell" style="justify-content: flex-end;">
                                    <button class="btn btn-warning" onclick="openUpdateModal('${category.id}', '${category.name}')">
                                        <i class="fas fa-pen"></i> Edit
                                    </button>
                                    <form action="categories/delete" method="post" style="margin: 0;">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <input type="hidden" name="id" value="${category.id}">
                                        <button type="submit" class="btn btn-danger" onclick="return confirm('Delete this category?')">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-layer-group"></i>
                <p>No categories yet. Add your first one above.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- ─── ADD MODAL ─── -->
<div class="modal-overlay" id="addModal">
    <div class="modal-card">
        <div class="modal-header">
            <h3>New Category</h3>
            <button class="modal-close" onclick="closeAddModal()"><i class="fas fa-xmark"></i></button>
        </div>
        <form action="categories" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="text" name="categoryname" class="form-input" required placeholder="Enter category name" autofocus>
            <div class="modal-actions">
                <button type="button" class="btn btn-ghost" onclick="closeAddModal()">Cancel</button>
                <button type="submit" class="btn btn-accent">Save Category</button>
            </div>
        </form>
    </div>
</div>

<!-- ─── UPDATE MODAL ─── -->
<div class="modal-overlay" id="updateModal">
    <div class="modal-card">
        <div class="modal-header">
            <h3>Edit Category</h3>
            <button class="modal-close" onclick="closeUpdateModal()"><i class="fas fa-xmark"></i></button>
        </div>
        <form action="categories/update" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="categoryid" id="updateCategoryId" value="">
            <div style="margin-bottom: 16px;">
                <label style="font-size: 12px; color: var(--text-tertiary); display: block; margin-bottom: 6px;">ID</label>
                <input type="text" id="updateCategoryIdDisplay" class="form-input" readonly>
            </div>
            <div>
                <label style="font-size: 12px; color: var(--text-tertiary); display: block; margin-bottom: 6px;">Name</label>
                <input type="text" name="categoryname" id="updateCategoryName" class="form-input" required>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn btn-ghost" onclick="closeUpdateModal()">Cancel</button>
                <button type="submit" class="btn btn-accent">Update</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openAddModal() {
        document.getElementById('addModal').classList.add('active');
    }
    function closeAddModal() {
        document.getElementById('addModal').classList.remove('active');
    }
    function openUpdateModal(id, name) {
        document.getElementById('updateCategoryId').value = id;
        document.getElementById('updateCategoryIdDisplay').value = '#' + id;
        document.getElementById('updateCategoryName').value = name;
        document.getElementById('updateModal').classList.add('active');
    }
    function closeUpdateModal() {
        document.getElementById('updateModal').classList.remove('active');
    }

    // Close modal on overlay click
    document.querySelectorAll('.modal-overlay').forEach(overlay => {
        overlay.addEventListener('click', function(e) {
            if (e.target === this) {
                this.classList.remove('active');
            }
        });
    });

    // Close modal on Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            document.querySelectorAll('.modal-overlay').forEach(m => m.classList.remove('active'));
        }
    });
</script>

</body>
</html>