<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>KV Pendharkar College – Event Registration</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    :root{
      --main-orange:#ff7b00;
      --dark-orange:#e06c00;
      --light-orange:#ff9f4d;
    }

    /* Sticky footer layout */
    html, body {
      height: 100%;
    }

    body{
      margin:0;
      padding-top:70px;
      background:#fff6ee;
      font-family:system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;
      display:flex;
      flex-direction:column;
      min-height:100vh;
    }

    main{
      flex:1;
    }

    .navbar-orange{
      background-color:var(--main-orange)!important;
      box-shadow:0 2px 8px rgba(0,0,0,0.18);
    }

    .btn-outline-primary{
      color:var(--main-orange);
      border-color:var(--main-orange);
    }

    .event-card{
      cursor:pointer;
      transition:transform .12s ease, box-shadow .12s ease;
      border-left:4px solid var(--light-orange);
      box-shadow:0 2px 4px rgba(0,0,0,0.06);
    }

    .event-card:hover{
      transform:translateY(-4px);
      box-shadow:0 6px 14px rgba(0,0,0,0.12);
    }

    .small-muted{
      font-size:.9rem;
      color:#666;
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

    /* ===== RESPONSIVE ===== */
    @media (max-width: 768px) {
      body{
        padding-top:64px;
      }

      .navbar-brand{
        font-size:0.95rem;
      }

      .event-card .card-body{
        padding:0.9rem 1rem;
      }
    }

    @media (max-width: 600px) {
      body{
        padding-top:60px;
      }

      .container{
        padding:0 1rem 1.5rem;
      }

      .d-flex.justify-content-between.align-items-center.mb-3{
        flex-direction:column;
        align-items:stretch;
        gap:0.5rem;
      }

      #btn-refresh{
        width:100%;
      }

      .navbar-brand{
        font-size:0.9rem;
      }

      .navbar-brand img{
        height:32px;
        margin-right:8px;
      }

      .event-card .card-body{
        padding:0.85rem 0.95rem;
      }

      .small-muted{
        font-size:0.8rem;
      }

      .footer-content {
        flex-direction: column;
        align-items: center;
        text-align: center;
        gap: 8px;
      }

      .footer-link{
        width: 100%;
        justify-content: center;
      }

      .site-footer{
        padding: 16px 14px;
      }
    }
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark navbar-orange fixed-top">
  <div class="container d-flex align-items-center">
    <a class="navbar-brand d-flex align-items-center fw-bold" href="<%= request.getContextPath() %>/">
      <img src="<%= request.getContextPath() %>/assets/logo.jpg" alt="logo" style="height:40px;margin-right:10px;border-radius:6px;">
      K.V. Pendharkar College – Events
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="nav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link active" href="<%= request.getContextPath() %>/">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/admin/login">Admin</a></li>
      </ul>
    </div>
  </div>
</nav>

<main>
  <div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h2 class="fw-semibold" style="color:var(--dark-orange)">Upcoming Events</h2>
      <button id="btn-refresh" class="btn btn-outline-primary">Refresh</button>
    </div>

    <div id="events-grid" class="row g-3"></div>
  </div>

  <!-- Event modal -->
  <div class="modal fade" id="eventModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header" style="background:var(--light-orange);">
          <h5 class="modal-title" id="modalTitle"></h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <p id="modalDetails"></p>
          <hr/>
          <form id="registerForm">
            <input type="hidden" id="eventId"/>
            <div class="mb-2"><label class="form-label">Full name</label><input id="name" class="form-control" required/></div>
            <div class="mb-2"><label class="form-label">Email</label><input id="email" class="form-control" type="email" required/></div>
            <div class="mb-2"><label class="form-label">Phone</label><input id="phone" class="form-control"/></div>
            <div class="mb-2"><label class="form-label">Remarks</label><textarea id="remarks" class="form-control"></textarea></div>
            <button class="btn btn-primary" type="submit" style="background:var(--main-orange);border-color:var(--main-orange);">Register</button>
          </form>
        </div>
      </div>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const baseUrl = '<%= request.getContextPath() %>';

  async function fetchEvents(){
    const grid = document.getElementById('events-grid');
    grid.innerHTML = '<div class="col-12 text-center py-4 small-muted">Loading...</div>';
    try {
      const res = await fetch(baseUrl + '/events');
      if (!res.ok) throw new Error('Network error');
      const data = await res.json();
      grid.innerHTML = '';
      data.forEach(function(evt){
        const col = document.createElement('div');
        col.className='col-sm-6 col-lg-4';

        col.innerHTML =
          '<div class="card event-card h-100"><div class="card-body">' +
            '<h5 class="card-title">' + escapeHtml(evt.title) + '</h5>' +
            '<p class="small-muted">' + escapeHtml(evt.location) + ' • ' + new Date(evt.datetime).toLocaleString() + '</p>' +
            '<p class="text-truncate">' + escapeHtml(evt.description || '') + '</p>' +
            '<button class="btn btn-sm btn-outline-primary viewBtn">View</button>' +
          '</div></div>';

        grid.appendChild(col);
        col.querySelector('.viewBtn').addEventListener('click', function(){ openModal(evt); });
      });
    } catch (e) {
      grid.innerHTML = '<div class="col-12 text-danger text-center py-4">Failed to load</div>';
      console.error(e);
    }
  }

  function escapeHtml(s){
    if(!s) return '';
    return String(s)
      .replace(/&/g,'&amp;')
      .replace(/</g,'&lt;')
      .replace(/>/g,'&gt;');
  }

  function openModal(evt){
    document.getElementById('modalTitle').innerText = evt.title;
    document.getElementById('modalDetails').innerText =
      evt.location + ' • ' + new Date(evt.datetime).toLocaleString() +
      '\\n\\n' + (evt.description || '');
    document.getElementById('eventId').value = evt.id;
    var myModal = new bootstrap.Modal(document.getElementById('eventModal'));
    myModal.show();
  }

  document.getElementById('registerForm').addEventListener('submit', async function(e){
    e.preventDefault();
    const payload = {
      eventId: parseInt(document.getElementById('eventId').value),
      name: document.getElementById('name').value,
      email: document.getElementById('email').value,
      phone: document.getElementById('phone').value,
      remarks: document.getElementById('remarks').value
    };
    try {
      const res = await fetch(baseUrl + '/events/register', {
        method:'POST',
        headers:{'Content-Type':'application/json'},
        body:JSON.stringify(payload)
      });
      if (res.ok) {
        alert('Registered');
        location.reload();
      } else {
        const txt = await res.text();
        alert('Failed to register: ' + txt);
      }
    } catch (err) {
      alert('Request failed');
      console.error(err);
    }
  });

  document.getElementById('btn-refresh').addEventListener('click', fetchEvents);
  fetchEvents();
</script>
</body>
</html>
