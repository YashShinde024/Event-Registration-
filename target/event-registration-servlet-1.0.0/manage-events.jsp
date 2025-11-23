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
  <title>Manage Events – KV Pendharkar</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    :root{--main-orange:#ff7b00;--dark-orange:#e06c00;}
    body{background:#fff6ee;}
    .navbar{background:var(--main-orange);}
    .nav-link,.navbar-brand{color:#fff!important;}
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg px-4">
  <a class="navbar-brand fw-bold" href="<%=ctx%>/admin">K.V. Pendharkar – Admin</a>
  <div class="ms-auto d-flex align-items-center gap-3">
    <span class="text-white-50 small">Logged in as <strong><%= adminUser %></strong></span>
    <a href="<%=ctx%>/admin/logout" class="btn btn-sm btn-light">Logout</a>
  </div>
</nav>

<div class="container mt-4">
  <h3 class="mb-3">Manage Events</h3>

  <!-- Event creation form -->
  <div class="card mb-4 shadow-sm">
    <div class="card-body">
      <h5 class="card-title">Create New Event</h5>
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
          <button class="btn btn-warning mt-2">Save Event</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Existing events table -->
  <h5>Existing Events</h5>
  <%
    if (events == null || events.isEmpty()) {
  %>
      <p class="text-muted">No events created yet.</p>
  <%
    } else {
  %>
    <div class="table-responsive">
      <table class="table table-sm table-striped align-middle">
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
            <td><%= e.getRegisteredCount() %></td>
            <td>
              <a href="<%=ctx%>/admin/events/delete?id=<%= e.getId() %>"
                 class="btn btn-sm btn-outline-danger"
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
</body>
</html>
