<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
  <meta charset="utf-8"/><meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>Admin Login — K.V. Pendharkar College</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style> body{background:#fff6ee;} .card{border-radius:8px;} </style>
</head>
<body>
  <div class="container" style="max-width:420px;margin-top:120px;">
    <div class="card p-4 shadow-sm">
      <h4 class="mb-3" style="color:#e06c00;">Admin Login</h4>
      <form method="post" action="/admin/login">
        <div class="mb-2"><label>Username</label><input name="username" class="form-control" required></div>
        <div class="mb-2"><label>Password</label><input name="password" type="password" class="form-control" required></div>
        <%
          String err = (String) request.getAttribute("error");
          if (err != null) {
        %>
          <div class="text-danger mb-2"><%= err %></div>
        <%
          }
        %>
        <button class="btn btn-primary" style="background:#ff7b00;border-color:#ff7b00;">Login</button>
      </form>
    </div>
  </div>
</body>
</html>
