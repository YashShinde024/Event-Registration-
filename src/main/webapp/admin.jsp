<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Simple login check
    Object adminUser = session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    // Get registrations list (set by AdminServlet for /admin/registrations)
    java.util.List<com.kvpendharkar.model.Registration> regs =
        (java.util.List<com.kvpendharkar.model.Registration>) request.getAttribute("registrations");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard – KV Pendharkar</title>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root{
            --main-orange:#ff7b00;
            --dark-orange:#e06c00;
            --light-orange:#ff9f4d;
        }

        body{
            background:#fff6ee;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
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
        }

        .navbar-admin .info-text{
            color:rgba(255,255,255,0.8);
            font-size:0.85rem;
        }

        .navbar-admin .btn-logout{
            font-size:0.8rem;
            padding:4px 10px;
        }

        /* CARDS / DASHBOARD */
        .page-heading{
            color:var(--dark-orange);
            font-weight:600;
        }

        .card-dashboard{
            border-radius:12px;
            border:1px solid rgba(0,0,0,0.04);
            box-shadow:0 6px 18px rgba(0,0,0,0.06);
            transition:transform 0.15s ease, box-shadow 0.15s ease;
        }

        .card-dashboard:hover{
            transform:translateY(-2px);
            box-shadow:0 10px 24px rgba(0,0,0,0.12);
        }

        .card-dashboard h5{
            font-weight:600;
        }

        .btn-dashboard{
            background:var(--main-orange);
            border-color:var(--main-orange);
            font-size:0.85rem;
            font-weight:500;
        }

        .btn-dashboard:hover{
            background:#ff8b1f;
            border-color:#ff8b1f;
        }

        /* TABLE */
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

        .badge-orange{
            background:var(--dark-orange);
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

            .navbar-admin .info-text{
                font-size:0.78rem;
            }

            .btn-logout{
                padding:3px 8px;
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

            .navbar-admin .info-text{
                order:1;
            }

            .btn-logout{
                order:2;
            }

            .page-heading{
                font-size:1.25rem;
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
        <a class="navbar-brand" href="<%=request.getContextPath()%>/admin">
            KV Pendharkar – Admin
        </a>
    </div>
    <div class="ms-auto d-flex align-items-center gap-3 right-wrapper">
        <span class="info-text">
            Logged in as <strong><%= adminUser %></strong>
        </span>
        <a href="<%=request.getContextPath()%>/admin/logout" class="btn btn-sm btn-light btn-logout">
            Logout
        </a>
    </div>
</nav>

<div class="container mt-4 mb-4">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
        <h3 class="page-heading mb-0">Dashboard</h3>
        <a href="<%=request.getContextPath()%>/" class="btn btn-outline-secondary btn-sm">
            ← View Public Events
        </a>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card card-dashboard p-3 h-100">
                <h5>Manage Events</h5>
                <p class="text-muted small mb-2">Create, edit or delete college events.</p>
                <a href="<%=request.getContextPath()%>/admin/events" class="btn btn-dashboard btn-sm">
                    View / Add Events
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-dashboard p-3 h-100">
                <h5>View Registrations</h5>
                <p class="text-muted small mb-2">See all students registered for events.</p>
                <a href="<%=request.getContextPath()%>/admin/registrations" class="btn btn-dashboard btn-sm">
                    Open Registrations
                </a>
            </div>
        </div>
    </div>

    <hr/>

    <h4 class="mb-3">Registrations</h4>

    <%
        if (regs == null) {
    %>
        <p class="text-muted">
            No list loaded yet. Click
            <strong>“Open Registrations”</strong> above to see all registrations.
        </p>
    <%
        } else if (regs.isEmpty()) {
    %>
        <p class="text-muted">No students have registered yet.</p>
    <%
        } else {
    %>
        <div class="table-wrapper table-responsive">
            <table class="table table-sm table-striped align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th>#</th>
                    <th>Event ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Remarks</th>
                    <th>Registered At</th>
                </tr>
                </thead>
                <tbody>
                <%
                    int i = 1;
                    for (com.kvpendharkar.model.Registration r : regs) {
                %>
                    <tr>
                        <td><%= i++ %></td>
                        <td><span class="badge bg-secondary"><%= r.getEventId() %></span></td>
                        <td><%= r.getName() %></td>
                        <td><%= r.getEmail() %></td>
                        <td><%= r.getPhone() %></td>
                        <td><%= r.getRemarks() %></td>
                        <td><%= r.getCreatedAt() %></td>
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
