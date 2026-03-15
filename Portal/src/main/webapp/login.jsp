<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Campus Portal - Login</title>
<style>
    body {
      font-family: "Poppins", sans-serif;
      background: linear-gradient(135deg, #2e86de, #54a0ff, #00a8ff);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 0;
    }
    .card {
      background: #ffffff;
      padding: 40px 35px;
      border-radius: 16px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
      text-align: center;
      width: 340px;
      transition: all 0.3s ease-in-out;
    }
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
    }
    .card h2 {
      color: #2e86de;
      margin-bottom: 25px;
      font-size: 26px;
      letter-spacing: 1px;
    }
    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 8px;
      outline: none;
      font-size: 15px;
      transition: border 0.3s ease;
    }
    input[type="text"]:focus,
    input[type="password"]:focus {
      border-color: #2e86de;
      box-shadow: 0 0 5px rgba(46, 134, 222, 0.3);
    }
    button {
      width: 100%;
      padding: 12px;
      background: #2e86de;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      cursor: pointer;
      transition: background 0.3s ease;
    }
    button:hover {
      background: #1e5bb8;
    }
    .sample {
      margin-top: 12px;
      font-size: 13px;
      color: #555;
      background: #f1f1f1;
      padding: 8px;
      border-radius: 6px;
      font-style: italic;
    }
  </style>
</head>
<body>
  <div class="card">
    <h2>Campus Recruitment Portal</h2>
    <h4>Login</h4>
    <form method="post" action="login">
      <input type="text" name="username" placeholder="Username" required><br>
      <input type="password" name="password" placeholder="Password" required><br>
      <button type="submit">Login</button>
    </form>
    <p style="color:red">${requestScope.error}</p>
  </div>
</body>
</html>

  