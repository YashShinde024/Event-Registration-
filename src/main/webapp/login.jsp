<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>Admin Login — K.V. Pendharkar College</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    :root{
      --main-orange:#ff7b00;
      --dark-orange:#e06c00;
      --light-orange:#ff9f4d;
    }

    /* === LAYOUT FOR STICKY FOOTER === */
    html, body {
      height: 100%;
    }

    body{
      margin:0;
      background:#fff6ee;
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
      display:flex;
      flex-direction:column;
      min-height:100vh;
    }

    main{
      flex:1;
      display:flex;
      align-items:flex-start;
      justify-content:center;
    }

    .login-wrapper{
      max-width:420px;
      width:100%;
      margin:120px auto 40px;
      padding:0 1rem;
    }

    .login-card{
      border-radius:12px;
      border:1px solid rgba(0,0,0,0.04);
      box-shadow:0 8px 20px rgba(0,0,0,0.06);
      background:#ffffff;
    }

    .login-title{
      color:var(--dark-orange);
      font-weight:600;
    }

    .login-subtitle{
      font-size:0.9rem;
      color:#6b7280;
    }

    .form-label{
      font-weight:500;
      font-size:0.9rem;
    }

    .form-control:focus{
      border-color:var(--main-orange);
      box-shadow:0 0 0 0.15rem rgba(255,123,0,0.25);
    }

    .btn-login{
      background:var(--main-orange);
      border-color:var(--main-orange);
      font-weight:500;
      width:100%;
      transition:transform 0.15s ease, box-shadow 0.15s ease, background 0.15s ease;
    }

    .btn-login:hover{
      background:#ff8b1f;
      border-color:#ff8b1f;
      transform:translateY(-1px);
      box-shadow:0 6px 14px rgba(0,0,0,0.15);
    }

    .back-link{
      font-size:0.85rem;
      text-decoration:none;
      color:#6b7280;
    }

    .back-link:hover{
      color:var(--dark-orange);
      text-decoration:underline;
    }

    /* Logo above login */
    .login-logo{
      display:flex;
      flex-direction:column;
      align-items:center;
      justify-content:center;
      margin-bottom:1rem;
    }

    .login-logo img{
      height:60px;
      width:auto;
      border-radius:8px;
      margin-bottom:0.5rem;
      background:#fff;
      padding:3px;
      box-shadow:0 4px 12px rgba(0,0,0,0.08);
    }

    .login-logo span{
      font-size:0.85rem;
      font-weight:600;
      color:#374151;
      text-transform:uppercase;
      letter-spacing:0.06em;
    }

    /* ===== UPDATED ORANGE THEME FOOTER ===== */
.site-footer {
    background: linear-gradient(135deg, #ff7b00, #e06c00);
    padding: 16px 20px;
    color: #fff;
    margin-top: 40px;
    box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.15);
    position: relative;
    overflow: hidden;
}

/* subtle animated shine */
.site-footer::before {
    content: "";
    position: absolute;
    inset: 0;
    background: linear-gradient(
        120deg,
        rgba(255,255,255,0.15),
        rgba(255,255,255,0.05),
        rgba(255,255,255,0.15)
    );
    background-size: 200% 200%;
    animation: footer-shine 6s ease infinite;
}

.footer-content {
    max-width: 1100px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 10px;
    position: relative;
    z-index: 2;
}

.footer-text {
    font-size: 14px;
    font-weight: 500;
    opacity: 0.95;
}

/* Name highlight */
.footer-text strong {
    color: #fff;
    text-decoration: underline;
    text-underline-offset: 3px;
}

/* LinkedIn button – white + orange hover */
.footer-link {
    text-decoration: none;
    font-size: 13px;
    font-weight: 600;
    background: #ffffff;
    color: #e06c00;
    padding: 8px 18px;
    border-radius: 999px;
    transition: all 0.25s ease;
    box-shadow: 0 3px 8px rgba(0,0,0,0.15);
}

.footer-link:hover {
    background: #fff3e6;
    color: #ff7b00;
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(0,0,0,0.25);
}

@keyframes footer-shine {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

/* Mobile friendly */
@media (max-width: 600px) {
    .footer-content {
        flex-direction: column;
        align-items: center;
        text-align: center;
        gap: 10px;
    }

    .footer-link {
        width: 100%;
        text-align: center;
    }
}

    /* ===== MOBILE OPTIMIZATION ===== */
    @media (max-width: 768px){
      .login-wrapper{
        margin-top:90px;
        padding:0 1.25rem;
      }
    }

    @media (max-width: 576px){
      main{
        align-items:flex-start;
      }

      .login-wrapper{
        margin-top:70px;
        padding:0 1rem;
      }

      .login-title{
        font-size:1.25rem;
      }

      .site-footer{
        padding:16px 14px;
      }

      .footer-content{
        flex-direction:column;
        align-items:center;
        text-align:center;
        gap:8px;
      }

      .footer-link{
        width:100%;
        justify-content:center;
      }
    }
  </style>
</head>
<body>

  <main>
    <div class="login-wrapper">
      <div class="text-center mb-3">
        <a href="<%= request.getContextPath() %>/" class="back-link">
          ← Back to Events
        </a>
      </div>

      <!-- Logo block -->
      <div class="login-logo">
        <img src="<%= request.getContextPath() %>/assets/logo.jpg" alt="KV Pendharkar logo">
        <span>K.V. Pendharkar College – Admin</span>
      </div>

      <div class="card p-4 shadow-sm login-card">
        <h4 class="mb-1 login-title">Admin Login</h4>
        <p class="login-subtitle mb-3">Only authorized staff can access this panel.</p>

        <form method="post" action="<%= request.getContextPath() %>/admin/login">
          <div class="mb-2">
            <label class="form-label">Username</label>
            <input name="username" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label">Password</label>
            <input name="password" type="password" class="form-control" required>
          </div>

          <%
            String err = (String) request.getAttribute("error");
            if (err != null) {
          %>
          <div class="text-danger mb-3"><%= err %></div>
          <%
            }
          %>

          <button class="btn btn-login" type="submit">Login</button>
        </form>
      </div>
    </div>
  </main>

  <footer class="site-footer">
    <div class="footer-content">
      <span class="footer-text">
        © 2025 Created by <strong>Yash Shinde</strong>
      </span>
      <a href="https://www.linkedin.com/in/yash-shinde-393159309"
         class="footer-link"
         target="_blank">
        <span class="footer-link-text">Connect on LinkedIn</span>
      </a>
    </div>
  </footer>

</body>
</html>
