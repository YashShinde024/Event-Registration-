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

    /* === LAYOUT FIX FOR FOOTER === */
    html, body {
      height: 100%;
    }

    body{
      margin:0;
      padding-top:70px;
      background:#fff6ee;
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;

      display:flex;
      flex-direction:column;
      min-height:100vh;
    }

    main {
      flex:1;
    }

    .navbar-orange{
      background-color:var(--main-orange)!important;
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

    .footer-link:hover::after {
      content: "✨";
      position: absolute;
      right: 10px;
      top: -8px;
      font-size: 12px;
      opacity: 0.8;
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
  </style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-orange fixed-top">
  <div class="container d-flex align-items-center">
    <a class="navbar-brand d-flex align-items-center fw-bold" href="/">
      <img src="assets/logo.jpg" alt="logo" style="height:40px;margin-right:10px;border-radius:6px;">
      K.V. Pendharkar College – Events
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="nav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link active" href="/">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="/admin/login">Admin</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- MAIN CONTENT -->
<main>

<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2 class="fw-semibold" style="color:var(--dark-orange)">Upcoming Events</h2>
    <button id="btn-refresh" class="btn btn-outline-primary">Refresh</button>
  </div>

  <div id="events-grid" class="row g-3"></div>
</div>

<!-- Event Modal -->
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

          <div class="mb-2">
            <label class="form-label">Full name</label>
            <input id="name" class="form-control" required/>
          </div>

          <div class="mb-2">
            <label class="form-label">Email</label>
            <input id="email" class="form-control" type="email" required/>
          </div>

          <div class="mb-2">
            <label class="form-label">Phone</label>
            <input id="phone" class="form-control"/>
          </div>

          <div class="mb-2">
            <label class="form-label">remark</label>
            <textarea id="remark" class="form-control"></textarea>
          </div>

          <button class="btn btn-primary"
                  type="submit"
                  style="background:var(--main-orange);border-color:var(--main-orange);">
            Register
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

</main>

<!-- SCRIPTS -->
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

      data.forEach(evt=>{
        const col = document.createElement('div');
        col.className='col-sm-6 col-lg-4';

        col.innerHTML = `
          <div class="card event-card h-100">
            <div class="card-body">
              <h5 class="card-title">${escapeHtml(evt.title)}</h5>
              <p class="small-muted">
                ${escapeHtml(evt.location)} • ${evt.datetime}
              </p>
              <p class="text-truncate">${escapeHtml(evt.description||'')}</p>
              <button class="btn btn-sm btn-outline-primary viewBtn">View</button>
            </div>
          </div>`;

        grid.appendChild(col);
        col.querySelector('.viewBtn').addEventListener('click', ()=>openModal(evt));
      });

    } catch (e) { 
      grid.innerHTML = '<div class="col-12 text-danger text-center py-4">Failed to load</div>'; 
      console.error(e); 
    }
  }

  function escapeHtml(s){ 
    if(!s) return ''; 
    return String(s).replaceAll('&','&amp;')
                    .replaceAll('<','&lt;')
                    .replaceAll('>','&gt;'); 
  }

  function openModal(evt){
    document.getElementById('modalTitle').innerText = evt.title;
    document.getElementById('modalDetails').innerText =
      `${evt.location} • ${new Date(evt.datetime).toLocaleString()}\n\n${evt.description||''}`;
    document.getElementById('eventId').value = evt.id;
    new bootstrap.Modal(document.getElementById('eventModal')).show();
  }

  document.getElementById('registerForm').addEventListener('submit', async (e)=>{
    e.preventDefault();
    const payload = {
      eventId: parseInt(document.getElementById('eventId').value),
      name: document.getElementById('name').value,
      email: document.getElementById('email').value,
      phone: document.getElementById('phone').value,
      remarks: document.getElementById('remark').value
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

<!-- FOOTER -->
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
