<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products — Admin</title>
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
            --border-hover: rgba(255, 255, 255, 0.15);
            --text-primary: #f5f5f7;
            --text-secondary: rgba(255, 255, 255, 0.6);
            --text-tertiary: rgba(255, 255, 255, 0.4);
            --accent: #2997ff;
            --accent-hover: #0077ed;
            --accent-glow: rgba(41, 151, 255, 0.25);
            --danger: #ff453a;
            --warning: #ff9f0a;
            --green: #30d158;
            --radius-sm: 8px;
            --radius-md: 12px;
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
            max-width: 1200px; margin: 0 auto;
            padding: 48px 40px 32px;
            display: flex; align-items: center; justify-content: space-between;
        }

        .page-header h1 { font-size: 32px; font-weight: 700; letter-spacing: -0.8px; }
        .page-header p { font-size: 15px; color: var(--text-secondary); margin-top: 4px; }

        .btn {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 10px 18px; border: none; border-radius: var(--radius-sm);
            font-family: inherit; font-size: 13px; font-weight: 600;
            cursor: pointer; transition: all var(--transition-fast);
            text-decoration: none;
        }

        .btn i { font-size: 12px; }
        .btn:active { transform: translateY(0); }

        .btn-accent { background: var(--accent); color: #fff; }
        .btn-accent:hover { background: var(--accent-hover); transform: translateY(-1px); box-shadow: 0 6px 20px var(--accent-glow); }

        .btn-danger {
            background: rgba(255,69,58,0.12); color: var(--danger);
            border: 1px solid rgba(255,69,58,0.2);
        }
        .btn-danger:hover { background: var(--danger); color: #fff; border-color: var(--danger); }

        .btn-warning {
            background: rgba(255,159,10,0.12); color: var(--warning);
            border: 1px solid rgba(255,159,10,0.2);
        }
        .btn-warning:hover { background: var(--warning); color: #000; border-color: var(--warning); }

        .table-container {
            max-width: 1200px; margin: 0 auto;
            padding: 0 40px 80px;
            overflow-x: auto;
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
            padding: 14px 16px; text-align: left;
            font-size: 11px; font-weight: 600;
            color: var(--text-tertiary); text-transform: uppercase;
            letter-spacing: 0.05em;
            background: rgba(255,255,255,0.03);
            border-bottom: 1px solid var(--border-subtle);
            white-space: nowrap;
        }

        .data-table tbody td {
            padding: 14px 16px; font-size: 14px;
            color: var(--text-secondary);
            border-bottom: 1px solid rgba(255,255,255,0.04);
            vertical-align: middle;
        }

        .data-table tbody tr { transition: background var(--transition-fast); }
        .data-table tbody tr:hover { background: rgba(255,255,255,0.03); }
        .data-table tbody tr:last-child td { border-bottom: none; }

        .id-badge {
            display: inline-flex; padding: 2px 10px;
            background: rgba(255,255,255,0.06); border-radius: 100px;
            font-size: 12px; font-weight: 600; color: var(--text-tertiary);
            font-variant-numeric: tabular-nums;
        }

        .product-preview {
            width: 48px; height: 48px;
            object-fit: cover;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border-subtle);
        }

        .category-tag {
            display: inline-flex; padding: 3px 10px;
            background: rgba(41,151,255,0.1);
            border: 1px solid rgba(41,151,255,0.2);
            border-radius: 100px; font-size: 11px;
            font-weight: 600; color: var(--accent);
        }

        .price-cell {
            font-weight: 600; color: var(--green);
            font-variant-numeric: tabular-nums;
        }

        .actions-cell { display: flex; gap: 8px; }

        @media (max-width: 768px) {
            .navbar, .page-header, .table-container { padding-left: 20px; padding-right: 20px; }
            .page-header { flex-direction: column; gap: 16px; align-items: flex-start; }
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
    <div>
        <h1>Products</h1>
        <p>Manage your product inventory</p>
    </div>
    <a href="/admin/products/add" class="btn btn-accent">
        <i class="fas fa-plus"></i> Add Product
    </a>
</div>

<div class="table-container">
    <c:choose>
        <c:when test="${not empty products}">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Preview</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Qty</th>
                        <th>Price</th>
                        <th>Weight</th>
                        <th>Description</th>
                        <th style="text-align: right;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td><span class="id-badge">#${product.id}</span></td>
                            <td><img src="${product.image}" alt="${product.name}" class="product-preview"></td>
                            <td style="color: var(--text-primary); font-weight: 500;">${product.name}</td>
                            <td><span class="category-tag">${product.category.name}</span></td>
                            <td>${product.quantity}</td>
                            <td class="price-cell">$${product.price}</td>
                            <td>${product.weight}g</td>
                            <td style="max-width: 180px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${product.description}</td>
                            <td>
                                <div class="actions-cell" style="justify-content: flex-end;">
                                    <form action="products/update/${product.id}" method="get" style="margin: 0;">
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-pen"></i> Edit
                                        </button>
                                    </form>
                                    <form action="products/delete" method="post" style="margin: 0;">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <input type="hidden" name="id" value="${product.id}">
                                        <button type="submit" class="btn btn-danger" onclick="return confirm('Delete this product?')">
                                            <i class="fas fa-trash"></i>
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
            <div style="text-align:center; padding:60px 20px; color:var(--text-tertiary);">
                <i class="fas fa-cube" style="font-size:40px; margin-bottom:12px; display:block;"></i>
                <p>No products yet. Add your first product above.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>