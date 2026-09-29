<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.FileOutputStream" %>    
<%@page import=" java.io.ObjectOutputStream" %>    

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart — Perishable Shop</title>
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
            background: linear-gradient(135deg, var(--accent), #a855f7);
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

        .btn-accent { background: var(--accent); color: #fff; }
        .btn-accent:hover { background: var(--accent-hover); transform: translateY(-1px); box-shadow: 0 6px 20px var(--accent-glow); }

        .btn-danger {
            background: rgba(255,69,58,0.12); color: var(--danger);
            border: 1px solid rgba(255,69,58,0.2);
        }
        .btn-danger:hover { background: var(--danger); color: #fff; border-color: var(--danger); }

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

        .id-badge {
            display: inline-flex; padding: 2px 10px;
            background: rgba(255,255,255,0.06); border-radius: 100px;
            font-size: 12px; font-weight: 600; color: var(--text-tertiary);
        }

        .price-cell { font-weight: 600; color: var(--green); }

        .empty-state {
            text-align: center; padding: 80px 20px; color: var(--text-tertiary);
        }
        .empty-state i { font-size: 48px; margin-bottom: 16px; display: block; }
        .empty-state p { font-size: 16px; margin-bottom: 24px; }

        @media (max-width: 768px) {
            .navbar, .page-header, .table-container { padding-left: 20px; padding-right: 20px; }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="#" class="nav-brand">
        <div class="nav-logo"><i class="fas fa-store"></i></div>
        <span>Perishable Shop</span>
    </a>
    <ul class="nav-links">
        <li><a href="/adminhome"><i class="fas fa-home"></i> Home</a></li>
        <li><a href="/logout"><i class="fas fa-arrow-right-from-bracket"></i> Logout</a></li>
    </ul>
</nav>

<div class="page-header">
    <div>
        <h1><i class="fas fa-bag-shopping" style="font-size: 28px; margin-right: 8px;"></i> Your Cart</h1>
        <p>Review your items before checkout</p>
    </div>
    <a href="/user/products" class="btn btn-accent">
        <i class="fas fa-plus"></i> Continue Shopping
    </a>
</div>

<div class="table-container">
    <%
    try {
        String url = "jdbc:mysql://localhost:3306/springproject";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "root", "");
        Statement stmt = con.createStatement();
        Statement stmt2 = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from cart");
        
        boolean hasItems = false;
    %>
    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Description</th>
                <th style="text-align: right;">Action</th>
            </tr>
        </thead>
        <tbody>
            <%
            while (rs.next()) {
                hasItems = true;
            %>
            <tr>
                <td><span class="id-badge">#<%= rs.getInt(1) %></span></td>
                <td style="color: var(--text-primary); font-weight: 500;"><%= rs.getString(2) %></td>
                <td class="price-cell">$<%= rs.getString(3) %></td>
                <td><%= rs.getString(4) %></td>
                <td style="text-align: right;">
                    <form action="cart/delete" method="get" style="margin: 0;">
                        <input type="hidden" name="id" value="<%=rs.getInt(1)%>">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Remove from cart?')">
                            <i class="fas fa-trash"></i> Remove
                        </button>
                    </form>
                </td>
            </tr>
            <%
            }
            if (!hasItems) {
            %>
            <tr>
                <td colspan="5">
                    <div class="empty-state">
                        <i class="fas fa-cart-shopping"></i>
                        <p>Your cart is empty</p>
                        <a href="/user/products" class="btn btn-accent">
                            <i class="fas fa-shopping-bag"></i> Browse Products
                        </a>
                    </div>
                </td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
    <%
    } catch (Exception ex) {
        out.println("<div class='empty-state'><i class='fas fa-exclamation-triangle'></i><p>Unable to load cart: " + ex.getMessage() + "</p></div>");
    }
    %>
</div>

</body>
</html>