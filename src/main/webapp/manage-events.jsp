<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Object adminUser = session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    java.util.List<com.kvpendharkar.model.Event> events =
        (java.util.List<com.kvpendharkar.model.Event>) request.getAttribute("events");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Manage Events – K.V. Pendharkar College</title>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
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
    }

    /* NAVBAR */
    .navbar-admin{
      background:var(--main-orange);
      box-shadow:0 2px 8px rgba(0,0,0,0.18);
    }

    .navbar-admin .navbar-brand,
    .navbar-admin .nav-link{
      color:#fff!important;
    }

    .navbar-admin .navbar-brand{
      font-weight:700;
      letter-spacing:0.3px;
      display:flex;
      align-items:center;
    }

    .navbar-admin .navbar-brand img{
      height:40px;
      margin-right:10px;
      border-radius:6px;
      background:#fff;
      padding:2px;
    }

    .navbar-admin .info-text{
      color:rgba(255,255,255,0.8);
      font-size:0.85rem;
    }

    .navbar-admin .btn-logout{
      font-size:0.8rem;
      padding:4px 10px;
    }

    /* PAGE HEADING / BUTTONS */
    .page-heading{
      color:var(--dark-orange);
      font-weight:600;
    }

    .btn-outline-secondary{
      border-color:#d1d5db;
      color:#4b5563;
    }

    .btn-outline-secondary:hover{
      background:#e5e7eb;
      color:#111827;
    }

    /* CREATE EVENT CARD */
    .card-create{
      border-radius:12px;
      border:1px solid rgba(0,0,0,0.04);
      box-shadow:0 8px 20px rgba(0,0,0,0.06);
    }

    .card-create .card-title{
      font-weight:600;
      color:var(--dark-orange);
    }

    .form-label{
      font-weight:500;
      font-size:0.9rem;
    }

    .form-control:focus,
    textarea:focus{
      border-color:var(--main-orange);
      box-shadow:0 0 0 0.15rem rgba(255,123,0,0.25);
    }

    .btn-save{
      background:var(--main-orange);
      border-color:var(--main-orange);
      font-weight:500;
      padding-inline:1.4rem;
      transition:transform 0.15s ease, box-shadow 0.15s ease, background 0.15s ease;
    }

    .btn-save:hover{
      background:#ff8b1f;
      border-color:#ff8b1f;
      transform:translateY(-1px);
      box-shadow:0 6px 14px rgba(0,0,0,0.15);
    }

    /* TABLE */
    .section-title{
      font-weight:600;
      margin-bottom:0.5rem;
    }

    .table-wrapper{
      border-radius:12px;
      border:1px solid rgba(0,0,0,0.04);
      background:#ffffff;
      box-shadow:0 4px 14px rgba(0,0,0,0.05);
      padding:0.75rem;
    }

    .table thead th{
      font-size:0.82rem;
      text-transform:uppercase;
      letter-spacing:0.03em;
    }

    .table tbody td{
      font-size:0.85rem;
    }

    .badge-count{
      background:var(--dark-orange);
    }

    .btn-delete{
      font-size:0.78rem;
    }

    /* ===== FOOTER ===== */
    .site-footer {
      background: linear-gradient(135deg, #0f172a, #020617);
      padding: 14px 20px;
      color: #e5e7eb;
      margin-top: 40px;
      box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.4);
      position: relative;
      overflow: hidden;
      animation: footer-float 3s ease-in-out infinite alternate;
      width:100%;
    }

    .footer-content {
      max-width: 1100px;
      margin: 0 auto;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 10px;
      flex-wrap: wrap;
      position: relative;
      z-index: 2;
    }

    .footer-text {
      font-size: 14px;
      opacity: 0.9;
    }

    .site-footer::before {
      content: "";
      position: absolute;
      inset: 0;
      background: linear-gradient(
        120deg,
        rgba(56,189,248,0.15),
        rgba(14,165,233,0.05),
        rgba(56,189,248,0.15)
      );
      background-size: 200% 200%;
      animation: footer-glow 6s ease infinite;
      z-index: 0;
    }

    .footer-text strong {
      color: #38bdf8;
      transition: text-shadow 0.3s ease, color 0.3s ease;
    }

    .footer-text strong:hover {
      color: #7dd3fc;
      text-shadow: 0 0 12px rgba(56,189,248,0.6);
    }

    .footer-link {
      position: relative;
      padding: 8px 16px;
      border-radius: 999px;
      border: 1px solid #38bdf8;
      text-decoration: none;
      font-size: 13px;
      letter-spacing: 0.3px;
      text-transform: uppercase;
      overflow: hidden;
      cursor: pointer;

      background: radial-gradient(circle at top left, rgba(56, 189, 248, 0.25), transparent 55%),
                  rgba(15, 23, 42, 0.9);
      color: #e0f2fe;

      display: inline-flex;
      align-items: center;
      gap: 6px;

      transition:
        transform 0.2s ease-out,
        box-shadow 0.25s ease-out,
        border-color 0.25s ease-out,
        background 0.25s ease-out;
    }

    .footer-link:hover {
      transform: translateY(-1px) scale(1.02);
      box-shadow: 0 0 15px rgba(56, 189, 248, 0.45);
      border-color: #0ea5e9;
      background: radial-gradient(circle at top left, rgba(56, 189, 248, 0.35), transparent 60%),
                  rgba(15, 23, 42, 1);
    }

    .footer-link::before {
      content: "●";
      font-size: 10px;
      margin-right: 2px;
      color: #38bdf8;
      animation: footer-pulse 1.4s ease-in-out infinite;
    }

    .footer-link-text {
      position: relative;
    }

    .footer-link-text::after {
      content: "";
      position: absolute;
      left: 0;
      bottom: -2px;
      height: 2px;
      width: 0;
      background: linear-gradient(90deg, #38bdf8, #0ea5e9);
      transition: width 0.25s ease-out;
    }

    .footer-link:hover .footer-link-text::after {
      width: 100%;
    }

    @keyframes footer-pulse {
      0% { opacity: 0.4; transform: scale(1); }
      50% { opacity: 1; transform: scale(1.3); }
      100% { opacity: 0.4; transform: scale(1); }
    }

    @keyframes footer-glow {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }

    @keyframes footer-float {
      from { transform: translateY(0); }
      to { transform: translateY(-2px); }
    }

    /* ===== RESPONSIVE / MOBILE ===== */
    @media (max-width: 768px){
      .navbar-admin{
        padding-inline:1rem;
      }

      .navbar-admin .navbar-brand{
        font-size:0.95rem;
      }

      .navbar-admin .navbar-brand img{
        height:34px;
      }

      .navbar-admin .info-text{
        font-size:0.78rem;
      }

      .navbar-admin .btn-logout{
        padding:3px 8px;
      }

      .card-create .card-body{
        padding:1rem 1.1rem;
      }
    }

    @media (max-width: 576px){
      .navbar-admin{
        flex-wrap:wrap;
        row-gap:0.25rem;
        padding-top:0.6rem;
        padding-bottom:0.6rem;
      }

      .navbar-admin .brand-wrapper{
        width:100%;
        display:flex;
        justify-content:space-between;
        align-items:center;
      }

      .navbar-admin .right-wrapper{
        width:100%;
        display:flex;
        justify-content:space-between;
        align-items:center;
      }

      .page-heading{
        font-size:1.25rem;
      }

      .btn-save{
        width:100%;
      }

      .table-wrapper{
        padding:0.5rem;
      }

      .table thead th,
      .table tbody td{
        font-size:0.78rem;
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

<nav class="navbar navbar-admin px-4">
  <div class="brand-wrapper">
    <a class="navbar-brand fw-bold" href="<%=ctx%>/admin">
      <img src="<%=ctx%>/assets/logo.jpg" alt="logo">
      K.V. Pendharkar – Admin
    </a>
  </div>
  <div class="ms-auto d-flex align-items-center gap-3 right-wrapper">
    <span class="info-text">Logged in as <strong><%= adminUser %></strong></span>
    <a href="<%=ctx%>/admin/logout" class="btn btn-sm btn-light btn-logout">Logout</a>
  </div>
</nav>

<main>
<div class="container mt-4 mb-4">

  <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
    <h3 class="page-heading mb-0">Manage Events</h3>
    <div class="d-flex gap-2">
      <a href="<%=ctx%>/admin" class="btn btn-outline-secondary btn-sm">
        ← Back to Dashboard
      </a>
      <a href="<%=ctx%>/" class="btn btn-outline-secondary btn-sm">
        View Public Events
      </a>
    </div>
  </div>

  <!-- Event creation form -->
  <div class="card mb-4 shadow-sm card-create">
    <div class="card-body">
      <h5 class="card-title">Create New Event</h5>
      <p class="text-muted small mb-3">
        Add upcoming college events. Students will see these on the public events page.
      </p>
      <form method="post" action="<%=ctx%>/admin/events" class="row g-2">
        <div class="col-md-6">
          <label class="form-label">Title</label>
          <input type="text" name="title" class="form-control" required/>
        </div>
        <div class="col-md-6">
          <label class="form-label">Location</label>
          <input type="text" name="location" class="form-control" required/>
        </div>
        <div class="col-md-4">
          <label class="form-label">Date &amp; Time</label>
          <input type="datetime-local" name="datetime" class="form-control" required/>
        </div>
        <div class="col-md-2">
          <label class="form-label">Seats</label>
          <input type="number" name="seats" class="form-control" min="0"/>
        </div>
        <div class="col-md-12">
          <label class="form-label">Description</label>
          <textarea name="description" class="form-control" rows="2"></textarea>
        </div>
        <div class="col-12">
          <button class="btn btn-save mt-2" type="submit">Save Event</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Existing events table -->
  <h5 class="section-title">Existing Events</h5>
  <%
    if (events == null || events.isEmpty()) {
  %>
      <p class="text-muted">No events created yet.</p>
  <%
    } else {
  %>
    <div class="table-wrapper table-responsive">
      <table class="table table-sm table-striped align-middle mb-0">
        <thead class="table-light">
          <tr>
            <th>#</th>
            <th>Title</th>
            <th>When</th>
            <th>Location</th>
            <th>Seats</th>
            <th>Registered</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
        <%
          int i = 1;
          for (com.kvpendharkar.model.Event e : events) {
        %>
          <tr>
            <td><%= i++ %></td>
            <td><%= e.getTitle() %></td>
            <td><%= e.getDatetime() %></td>
            <td><%= e.getLocation() %></td>
            <td><%= e.getSeats() %></td>
            <td><span class="badge bg-secondary"><%= e.getRegisteredCount() %></span></td>
            <td>
              <a href="<%=ctx%>/admin/events/delete?id=<%= e.getId() %>"
                 class="btn btn-sm btn-outline-danger btn-delete"
                 onclick="return confirm('Are you sure you want to delete this event?');">
                 Delete
              </a>
            </td>
          </tr>
        <%
          }
        %>
        </tbody>
      </table>
    </div>
  <%
    }
  %>
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
