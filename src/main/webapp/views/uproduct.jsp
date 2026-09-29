<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Products — Perishable Shop</title>
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
            --green: #30d158;
            --warning: #ff9f0a;
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-xl: 20px;
            --transition-fast: 0.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            --transition-smooth: 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
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
            max-width: 1280px; margin: 0 auto;
            padding: 48px 40px 32px;
        }

        .page-header h1 { font-size: 32px; font-weight: 700; letter-spacing: -0.8px; }
        .page-header p { font-size: 15px; color: var(--text-secondary); margin-top: 4px; }

        .section-container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 40px 80px;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        .product-card {
            background: var(--bg-card);
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-xl);
            overflow: hidden;
            transition: all var(--transition-smooth);
            animation: cardFadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1) both;
        }

        .product-card:hover {
            background: var(--bg-card-hover);
            border-color: var(--border-hover);
            transform: translateY(-4px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
        }

        @keyframes cardFadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .product-image-wrap {
            position: relative;
            padding: 20px 20px 0;
        }

        .product-image-wrap img {
            width: 100%; height: 180px;
            object-fit: contain;
            border-radius: var(--radius-md);
            transition: transform var(--transition-smooth);
        }

        .product-card:hover .product-image-wrap img { transform: scale(1.05); }

        .product-category-badge {
            position: absolute; top: 28px; right: 28px;
            padding: 4px 10px;
            background: rgba(41,151,255,0.15);
            border: 1px solid rgba(41,151,255,0.25);
            border-radius: 100px;
            font-size: 11px; font-weight: 600; color: var(--accent);
            text-transform: uppercase;
        }

        .product-details { padding: 16px 20px 20px; }

        .product-name {
            font-size: 16px; font-weight: 600;
            letter-spacing: -0.3px; margin-bottom: 4px;
        }

        .product-meta {
            display: flex; gap: 12px;
            font-size: 12px; color: var(--text-tertiary);
            margin-bottom: 4px;
        }

        .product-description {
            font-size: 13px; color: var(--text-tertiary);
            line-height: 1.5; margin-bottom: 16px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-footer {
            display: flex; align-items: center; justify-content: space-between;
        }

        .product-price {
            font-size: 22px; font-weight: 700;
            letter-spacing: -0.5px; color: var(--green);
        }

        .product-price::before {
            content: '$'; font-size: 14px; font-weight: 600;
            vertical-align: super; margin-right: 2px;
        }

        .btn-add-cart {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 10px 16px;
            background: var(--warning); color: #000;
            border: none; border-radius: var(--radius-sm);
            font-family: inherit; font-size: 13px; font-weight: 600;
            cursor: pointer; transition: all var(--transition-fast);
            text-decoration: none;
        }

        .btn-add-cart:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(255,159,10,0.3);
        }

        .btn-add-cart i { font-size: 12px; }

        .empty-state {
            text-align: center; padding: 80px 20px; color: var(--text-tertiary);
        }
        .empty-state i { font-size: 48px; margin-bottom: 16px; display: block; }

        @media (max-width: 768px) {
            .navbar, .page-header, .section-container { padding-left: 20px; padding-right: 20px; }
            .products-grid { grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 16px; }
        }

        @media (max-width: 480px) {
            .products-grid { grid-template-columns: 1fr; }
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
    <h1>Browse Products</h1>
    <p>Discover fresh items and add them to your cart</p>
</div>

<section class="section-container">
    <c:choose>
        <c:when test="${not empty products}">
            <div class="products-grid">
                <c:forEach var="product" items="${products}" varStatus="status">
                    <div class="product-card" data-index="${status.index}">
                        <div class="product-image-wrap">
                            <img src="${product.image}" alt="${product.name}" loading="lazy">
                            <span class="product-category-badge">${product.category.name}</span>
                        </div>
                        <div class="product-details">
                            <div class="product-name">${product.name}</div>
                            <div class="product-meta">
                                <span><i class="fas fa-weight-hanging"></i> ${product.weight}g</span>
                                <span><i class="fas fa-box"></i> ${product.quantity} in stock</span>
                            </div>
                            <div class="product-description">${product.description}</div>
                            <div class="product-footer">
                                <div class="product-price">${product.price}</div>
                                <form action="products/addtocart" method="get" style="margin: 0;">
                                    <input type="hidden" name="id" value="${product.id}">
                                    <button type="submit" class="btn-add-cart">
                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-box-open"></i>
                <p>No products available at the moment.</p>
            </div>
        </c:otherwise>
    </c:choose>
</section>


<script>
document.querySelectorAll('.product-card[data-index]').forEach(function(card) {
    card.style.animationDelay = (card.dataset.index * 0.06) + 's';
});
</script>

</body>
</html>