# 🎓 Campus Recruitment Portal

A **web-based campus recruitment management system** developed using **Java, JSP, Servlets, JDBC, and MySQL**.
This portal simulates a campus placement environment where **students can view opportunities** and **recruiters can manage recruitment activities**.

The project demonstrates core **Java web development concepts**, including server-side processing, database connectivity, and role-based access.

---

# 🚀 Features

### 👨‍🎓 Student Portal

* Student login authentication
* View available job opportunities
* Access recruiter postings
* Simple dashboard interface

### 🏢 Recruiter Portal

* Recruiter login
* Post and manage job opportunities
* View student applications

### ⚙ Backend Functionality

* Role-based login system
* Database integration using **JDBC**
* Dynamic content rendering using **JSP**
* Request handling with **Servlets**

---

# 🛠 Tech Stack

### Frontend

* JSP
* HTML
* CSS

### Backend

* Java Servlets
* JDBC

### Database

* MySQL

### Server

* Apache Tomcat

---

# 🔐 Demo Login Credentials

### 👨‍🎓 Student Login

```
Username: student1
Password: stud123
```

### 🏢 Recruiter Login

```
Username: recruiter1
Password: pass123
```

⚠️ Note: Credentials are **hardcoded for demonstration purposes**.

---

# 📂 Project Structure

```
campus-recruitment-portal
│
├── src
│   └── servlets and java classes
│
├── WebContent
│   ├── login.jsp
│   ├── student_dashboard.jsp
│   ├── recruiter_dashboard.jsp
│   └── css / js / assets
│
├── WEB-INF
│   └── web.xml
│
├── database
│   └── campus_portal.sql
│
└── README.md
```

---

# ⚙️ Installation & Setup

### 1️⃣ Clone the Repository

```
git clone https://github.com/lat255/campus-recruitment-portal.git
```

### 2️⃣ Import Project into IDE

Import the project into:

* **Eclipse IDE**
* **IntelliJ IDEA**

as a **Dynamic Web Project**.

### 3️⃣ Configure Apache Tomcat

Add **Apache Tomcat Server** in your IDE and deploy the project.

### 4️⃣ Setup Database

1. Create a MySQL database.
2. Import the SQL file located in:

```
database/campus_portal.sql
```

### 5️⃣ Update Database Connection

Modify database credentials in the JDBC connection file if required.

### 6️⃣ Run the Project

Start the Tomcat server and open:

```
http://localhost:8080/campus-recruitment-portal
```

---

# 📸 Screenshots

(Add screenshots here for better visualization)

Example:

```
screenshots/login-page.png
screenshots/student-dashboard.png
screenshots/recruiter-dashboard.png
```

---

# 🎯 Learning Outcomes

This project demonstrates:

* Java Web Development
* JSP and Servlet Architecture
* Database connectivity using JDBC
* Role-based authentication
* MVC-like web application structure

---

# 🔮 Future Improvements

* Student registration and signup functionality
* Resume upload system
* Job application tracking
* Admin dashboard
* Email notifications for job updates

---

# 👨‍💻 Author

**Liya**

GitHub:
https://github.com/lat255
