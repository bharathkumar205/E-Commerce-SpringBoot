<div align="center">

# 🛒 Perishable Shop — E-Commerce Platform

A full-stack e-commerce web application built with **Spring Boot**, **JSP**, **MySQL**, and a modern **Apple-inspired dark UI**.

Manage products, categories, customers, and shopping carts through an elegant admin panel and storefront.

![Java](https://img.shields.io/badge/Java-21-ED8B00?style=flat-square&logo=openjdk&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.4-6DB33F?style=flat-square&logo=springboot&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat-square&logo=mysql&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)

</div>

---

## ✨ Features

### Customer-Facing
- 🏠 **Product Storefront** — Browse products in a responsive card grid
- 🛒 **Shopping Cart** — Add products and manage your cart
- 👤 **User Authentication** — Register, login, and manage your profile
- 📱 **Responsive Design** — Works seamlessly on desktop, tablet, and mobile

### Admin Panel
- 📊 **Dashboard** — Quick access to manage categories, products, and customers
- 📦 **Product Management** — Full CRUD with image preview, categories, pricing
- 🏷️ **Category Management** — Add, update, and delete product categories
- 👥 **Customer Management** — View registered customer accounts

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Backend** | Java 21, Spring Boot 3.3.4, Spring MVC, Spring Security, Spring Data JPA |
| **Frontend** | JSP, JSTL, Vanilla CSS, Inter Font, Font Awesome 6 |
| **Database** | MySQL 8.0, Hibernate ORM |
| **Build Tool** | Maven |
| **Server** | Embedded Apache Tomcat |

---

## 📋 Prerequisites

Before you begin, make sure you have the following installed:

- **Java JDK 21** or higher → [Download](https://adoptium.net/)
- **MySQL 8.0** or higher → [Download](https://dev.mysql.com/downloads/mysql/)
- **Maven 3.6+** (or use the included `mvnw` wrapper)
- **Git** → [Download](https://git-scm.com/)

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/jaygajera17/E-commerce-project-springBoot.git
cd E-commerce-project-springBoot
```

### 2. Set Up the Database

Start your MySQL server, then run the seed script:

```bash
mysql -u root -p < basedata.sql
```

This creates the `ecommjava` database with default tables and sample data:

| Table | Description |
|-------|------------|
| `CATEGORY` | 9 default categories (Fruits, Vegetables, Meat, etc.) |
| `CUSTOMER` | 2 default users (admin + normal user) |
| `PRODUCT` | 2 sample products |

### 3. Configure Database Connection

Open `src/main/resources/application.properties` and update the MySQL credentials if needed:

```properties
db.url= jdbc:mysql://localhost:3306/ecommjava?createDatabaseIfNotExist=true
db.username= root
db.password=
```

> **Note:** The default config uses `root` with no password. Update `db.username` and `db.password` to match your MySQL setup.

### 4. Build & Run

**Using Maven Wrapper (no Maven install needed):**

```bash
# Windows
.\mvnw.cmd spring-boot:run

# macOS / Linux
./mvnw spring-boot:run
```

**Or with Maven installed globally:**

```bash
mvn spring-boot:run
```

### 5. Open in Browser

Once the application starts, navigate to:

| URL | Description |
|-----|------------|
| `http://localhost:8080/` | User Login Page |
| `http://localhost:8080/register` | New User Registration |
| `http://localhost:8080/admin/` | Admin Login Page |

---

## 🔐 Default Credentials

| Role | Username | Password |
|------|----------|----------|
| **Admin** | `admin` | `123` |
| **Customer** | `lisa` | `765` |

> ⚠️ **Change these credentials before deploying to production.**

---

## 📁 Project Structure

```
E-commerce-project-springBoot/
├── src/
│   ├── main/
│   │   ├── java/com/jtspringproject/JtSpringProject/
│   │   │   ├── JtSpringProjectApplication.java   # Main entry point
│   │   │   ├── HibernateConfiguration.java       # DB config
│   │   │   ├── configuration/                    # Security config
│   │   │   ├── controller/
│   │   │   │   ├── AdminController.java          # Admin routes
│   │   │   │   ├── UserController.java           # User routes
│   │   │   │   └── ErrorController.java          # Error handling
│   │   │   ├── models/
│   │   │   │   ├── User.java
│   │   │   │   ├── Product.java
│   │   │   │   ├── Category.java
│   │   │   │   ├── Cart.java
│   │   │   │   ├── CartProduct.java
│   │   │   │   └── CartProductId.java
│   │   │   ├── dao/                              # Data access layer
│   │   │   └── services/                         # Business logic
│   │   ├── resources/
│   │   │   └── application.properties            # App configuration
│   │   └── webapp/views/                         # JSP templates
│   │       ├── index.jsp                         # Product storefront
│   │       ├── userLogin.jsp                     # User sign in
│   │       ├── register.jsp                      # User registration
│   │       ├── adminlogin.jsp                    # Admin sign in
│   │       ├── adminHome.jsp                     # Admin dashboard
│   │       ├── categories.jsp                    # Category management
│   │       ├── products.jsp                      # Product listing (admin)
│   │       ├── productsAdd.jsp                   # Add product form
│   │       ├── productsUpdate.jsp                # Edit product form
│   │       ├── uproduct.jsp                      # Browse products (user)
│   │       ├── cartproduct.jsp                   # Shopping cart
│   │       ├── displayCustomers.jsp              # Customer list (admin)
│   │       ├── updateProfile.jsp                 # Edit user profile
│   │       └── 403.jsp                           # Access denied page
├── basedata.sql                                  # Database seed script
├── pom.xml                                       # Maven dependencies
└── mvnw / mvnw.cmd                               # Maven wrapper
```

---

## 🎨 UI/UX Design

The frontend uses a **modern, Apple-inspired dark minimalist** design system:

- **Dark canvas** — Deep `#0a0a0a` background with glassmorphism cards
- **Inter typography** — Clean sans-serif with tight letter-spacing
- **Semantic colors** — Blue (user actions), Purple (admin), Green (create), Orange (edit), Red (delete)
- **Micro-animations** — Fade-in entrances, staggered reveals, hover lifts
- **Responsive** — Mobile-first breakpoints at 480px and 768px
- **Zero framework dependency** — Pure vanilla CSS (no Bootstrap/Tailwind)

---

## 🗺️ Application Routes

### User Routes

| Method | Endpoint | Description |
|--------|----------|------------|
| GET | `/` | User login page |
| POST | `/userloginvalidate` | Authenticate user |
| GET | `/register` | Registration form |
| POST | `/newuserregister` | Register new user |
| GET | `/user/products` | Browse all products |
| GET | `/user/products/addtocart` | Add product to cart |
| GET | `/cartDisplay` | View shopping cart |
| GET | `/cart/delete` | Remove item from cart |
| GET | `/profileDisplay` | View user profile |
| POST | `/updateuser` | Update user profile |
| GET | `/logout` | Log out |

### Admin Routes

| Method | Endpoint | Description |
|--------|----------|------------|
| GET | `/admin/` | Admin login page |
| POST | `/admin/loginvalidate` | Authenticate admin |
| GET | `/admin/Dashboard` | Admin dashboard |
| GET | `/admin/categories` | List categories |
| POST | `/admin/categories` | Add category |
| POST | `/admin/categories/delete` | Delete category |
| POST | `/admin/categories/update` | Update category |
| GET | `/admin/products` | List products |
| GET | `/admin/products/add` | Add product form |
| POST | `/admin/products/add` | Save new product |
| GET | `/admin/products/update/{id}` | Edit product form |
| POST | `/admin/products/update/{id}` | Save product changes |
| POST | `/admin/products/delete` | Delete product |
| GET | `/admin/customers` | List customers |

---

## 🧪 Running Tests

```bash
# Windows
.\mvnw.cmd test

# macOS / Linux
./mvnw test
```

---

## 🐳 Common Issues & Troubleshooting

| Issue | Solution |
|-------|---------|
| `Communications link failure` | Make sure MySQL is running on port `3306` |
| `Access denied for user 'root'` | Update `db.username` and `db.password` in `application.properties` |
| `Unknown database 'ecommjava'` | Run `basedata.sql` first, or the `createDatabaseIfNotExist=true` flag should handle it |
| Port `8080` already in use | Change `server.port` in `application.properties` or kill the existing process |
| JSP pages not rendering | Make sure `tomcat-embed-jasper` dependency is in `pom.xml` |

---

## 🤝 Contributing

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Commit** your changes: `git commit -m 'Add amazing feature'`
4. **Push** to the branch: `git push origin feature/amazing-feature`
5. **Open** a Pull Request

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

<div align="center">

**Built with ❤️ using Spring Boot**

[⬆ Back to Top](#-perishable-shop--e-commerce-platform)

</div>
