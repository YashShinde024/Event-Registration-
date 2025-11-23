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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root{--main-orange:#ff7b00;--dark-orange:#e06c00;}
        body{background:#fff6ee;}
        .navbar{background:var(--main-orange);}
        .nav-link, .navbar-brand{color:#fff!important;}
        .badge-orange{background:var(--dark-orange);}
.site-footer {
    background: linear-gradient(135deg, #0f172a, #020617);
    padding: 14px 20px;
    color: #e5e7eb;
    font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
    margin-top: 40px;
    box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.4);
}

.footer-content {
    max-width: 1100px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 10px;
    flex-wrap: wrap;
}

.footer-text {
    font-size: 14px;
    opacity: 0.9;
}

/* LinkedIn button style */
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

    /* animation + glow */
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

/* hover effect */
.footer-link:hover {
    transform: translateY(-1px) scale(1.02);
    box-shadow: 0 0 15px rgba(56, 189, 248, 0.45);
    border-color: #0ea5e9;
    background: radial-gradient(circle at top left, rgba(56, 189, 248, 0.35), transparent 60%),
                rgba(15, 23, 42, 1);
}

/* tiny glowing dot / icon */
.footer-link::before {
    content: "●";
    font-size: 10px;
    margin-right: 2px;
    color: #38bdf8;
    animation: footer-pulse 1.4s ease-in-out infinite;
}

/* underline animation on text */
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

/* pulse animation */
@keyframes footer-pulse {
    0% { opacity: 0.4; transform: scale(1); }
    50% { opacity: 1; transform: scale(1.3); }
    100% { opacity: 0.4; transform: scale(1); }
}

/* mobile */
@media (max-width: 600px) {
    .footer-content {
        flex-direction: column;
        align-items: center;
        text-align: center;
    }
}

    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg px-4">
    <a class="navbar-brand fw-bold" href="<%=request.getContextPath()%>/admin">KV Pendharkar – Admin</a>
    <div class="ms-auto d-flex align-items-center gap-3">
        <span class="text-white-50 small">Logged in as <strong><%= adminUser %></strong></span>
        <a href="<%=request.getContextPath()%>/admin/logout" class="btn btn-sm btn-light">Logout</a>
    </div>
</nav>

<div class="container mt-4">
    <h3 class="mb-3">Dashboard</h3>

    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card shadow-sm p-3">
                <h5>Manage Events</h5>
                <p class="text-muted small mb-2">Create or update college events.</p>
                <a href="<%=request.getContextPath()%>/admin/events" class="btn btn-warning btn-sm">
                    View / Add Events
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm p-3">
                <h5>View Registrations</h5>
                <p class="text-muted small mb-2">All students registered for events.</p>
                <a href="<%=request.getContextPath()%>/admin/registrations" class="btn btn-warning btn-sm">
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
        <div class="table-responsive">
            <table class="table table-sm table-striped align-middle">
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
                        <td><%= r.getEventId() %></td>
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
