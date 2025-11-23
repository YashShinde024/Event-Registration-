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
</body>
</html>
