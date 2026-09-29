<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.*"%>

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product — Admin</title>
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
            --accent: #2997ff;
            --accent-hover: #0077ed;
            --accent-glow: rgba(41, 151, 255, 0.25);
            --input-bg: rgba(255, 255, 255, 0.06);
            --input-border: rgba(255, 255, 255, 0.12);
            --input-focus: rgba(41, 151, 255, 0.4);
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-xl: 20px;
            --radius-xxl: 28px;
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

        .form-wrapper {
            max-width: 720px;
            margin: 0 auto;
            padding: 48px 40px 80px;
            animation: fadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(16px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .form-wrapper h1 {
            font-size: 32px; font-weight: 700;
            letter-spacing: -0.8px; margin-bottom: 8px;
        }

        .form-wrapper .subtitle {
            font-size: 15px; color: var(--text-secondary); margin-bottom: 36px;
        }

        .form-card {
            background: var(--bg-card);
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-xxl);
            padding: 36px 32px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group { display: flex; flex-direction: column; }
        .form-group.full-width { grid-column: 1 / -1; }

        .form-group label {
            font-size: 13px; font-weight: 500;
            color: var(--text-secondary);
            margin-bottom: 8px;
        }

        .form-input, .form-select {
            width: 100%;
            padding: 14px 16px;
            background: var(--input-bg);
            border: 1px solid var(--input-border);
            border-radius: var(--radius-md);
            color: var(--text-primary);
            font-family: inherit; font-size: 15px;
            outline: none;
            transition: all var(--transition-fast);
            -webkit-appearance: none;
        }

        .form-input::placeholder { color: var(--text-tertiary); }

        .form-input:focus, .form-select:focus {
            border-color: var(--accent);
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 0 0 3px var(--input-focus);
        }

        .form-input[readonly] { opacity: 0.5; cursor: not-allowed; }

        textarea.form-input { resize: vertical; min-height: 100px; }

        .form-select {
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%23888' viewBox='0 0 16 16'%3E%3Cpath d='M8 11L3 6h10l-5 5z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            padding-right: 40px;
        }

        .form-select option {
            background: #1a1a1a;
            color: var(--text-primary);
        }

        .image-preview-container {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-top: 8px;
        }

        .image-preview {
            width: 80px; height: 80px;
            border-radius: var(--radius-md);
            border: 1px solid var(--border-subtle);
            object-fit: cover;
            background: rgba(255,255,255,0.03);
        }

        .image-preview-label {
            font-size: 12px;
            color: var(--text-tertiary);
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 32px;
            justify-content: flex-end;
        }

        .btn {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 12px 24px; border: none; border-radius: var(--radius-sm);
            font-family: inherit; font-size: 14px; font-weight: 600;
            cursor: pointer; transition: all var(--transition-fast);
            text-decoration: none;
        }

        .btn i { font-size: 13px; }

        .btn-accent { background: var(--accent); color: #fff; }
        .btn-accent:hover { background: var(--accent-hover); transform: translateY(-1px); box-shadow: 0 6px 20px var(--accent-glow); }

        .btn-ghost {
            background: rgba(255,255,255,0.06); color: var(--text-secondary);
            border: 1px solid var(--border-subtle);
        }
        .btn-ghost:hover { background: rgba(255,255,255,0.1); color: var(--text-primary); }

        @media (max-width: 640px) {
            .form-grid { grid-template-columns: 1fr; }
            .form-wrapper { padding: 32px 20px 60px; }
            .form-card { padding: 28px 24px; }
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
        <li><a href="/adminhome"><i class="fas fa-grid-2"></i> Dashboard</a></li>
        <li><a href="/logout"><i class="fas fa-arrow-right-from-bracket"></i> Logout</a></li>
    </ul>
</nav>

<div class="form-wrapper">
    <h1>Add Product</h1>
    <p class="subtitle">Fill in the details to add a new product to your inventory.</p>

    <div class="form-card">
        <form action="/admin/products/add" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="form-grid">
                <div class="form-group">
                    <label for="id">Product ID</label>
                    <c:forEach var="product" items="${products}">
                        <input type="number" readonly class="form-input" name="id" value="${product.id + 1}">
                    </c:forEach>
                </div>

                <div class="form-group">
                    <label for="name">Product Name</label>
                    <input type="text" class="form-input" required name="name" placeholder="e.g. Organic Bananas">
                </div>

                <div class="form-group">
                    <label for="categoryid">Category</label>
                    <select class="form-select" name="categoryid" required>
                        <option value="" selected disabled>Select a Category</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="price">Price ($)</label>
                    <input type="number" class="form-input" required name="price" min="1" placeholder="0.00">
                </div>

                <div class="form-group">
                    <label for="weight">Weight (grams)</label>
                    <input type="number" class="form-input" required name="weight" min="1" placeholder="500">
                </div>

                <div class="form-group">
                    <label for="quantity">Available Quantity</label>
                    <input type="number" class="form-input" required name="quantity" min="1" placeholder="100">
                </div>

                <div class="form-group full-width">
                    <label for="description">Description</label>
                    <textarea class="form-input" rows="4" name="description" placeholder="Describe the product..."></textarea>
                </div>

                <div class="form-group full-width">
                    <label for="productImage">Image URL</label>
                    <input type="text" class="form-input" required name="productImage" id="imageUrlInput" placeholder="https://example.com/image.jpg" oninput="updatePreview(this.value)">
                    <div class="image-preview-container">
                        <img src="" alt="Preview" id="imgPreview" class="image-preview" style="display:none;">
                        <span class="image-preview-label" id="previewLabel">Paste a URL to see preview</span>
                    </div>
                </div>
            </div>

            <input type="hidden" name="imgName">

            <div class="form-actions">
                <a href="/admin/products" class="btn btn-ghost">Cancel</a>
                <button type="submit" class="btn btn-accent">
                    <i class="fas fa-plus"></i> Add Product
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function updatePreview(url) {
        var img = document.getElementById('imgPreview');
        var label = document.getElementById('previewLabel');
        if (url && url.trim()) {
            img.src = url;
            img.style.display = 'block';
            label.style.display = 'none';
            img.onerror = function() {
                img.style.display = 'none';
                label.style.display = 'inline';
                label.textContent = 'Invalid image URL';
            };
        } else {
            img.style.display = 'none';
            label.style.display = 'inline';
            label.textContent = 'Paste a URL to see preview';
        }
    }
</script>

</body>
</html>