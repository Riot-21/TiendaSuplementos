<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Panel de Administración</title>
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    /* Estilos para el layout */
    body {
      display: flex;
      min-height: 100vh;
    }

    /* Sidebar a la izquierda */
    .admin-sidebar {
      width: 250px;
      background-color: #343a40;
      color: white;
      position: fixed;
      height: 100%;
      padding-top: 20px;
    }

    .admin-sidebar a {
      padding: 15px;
      text-decoration: none;
      color: white;
      display: block;
    }

    .admin-sidebar a:hover {
      background-color: #007bff;
      color: white;
    }

    /* Contenido principal */
    .admin-content {
      margin-left: 250px;
      padding: 20px;
      width: 100%;
    }

    .header {
      padding: 10px;
      background-color: #007bff;
      color: white;
      text-align: center;
    }

    .metric-card {
      background-color: #f8f9fa;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .metric-card h5 {
      margin-bottom: 10px;
    }

    .metric-card p {
      font-size: 1.2rem;
      font-weight: bold;
    }

    /* Gráficos */
    .chart-container {
      position: relative;
      height: 300px;
    }
  </style>
</head>

<body>

  <!-- Sidebar del administrador -->
  <nav class="admin-sidebar">
    <h5 class="text-center">Administrador</h5>
    <a href="#">Dashboard</a>
    <a href="#">Gestión de inventario</a>
    <a href="#">Gestión de usuarios</a>
    <a href="#">Órdenes</a>
    <a href="#">Reportes</a>
    <a href="#">Configuración</a>
    <a href="#">Cerrar sesión</a>
  </nav>

  <!-- Contenido principal -->
  <div class="admin-content">
    <!-- Encabezado -->
    <div class="header">
      <h2>Panel de Administración</h2>
    </div>

    <!-- Métricas principales -->
    <div class="container mt-4">
      <div class="row">
        <!-- Métrica 1 -->
        <div class="col-md-3 mb-4">
          <div class="metric-card">
            <h5>Total de Ventas</h5>
            <p>$12,500</p>
          </div>
        </div>
        <!-- Métrica 2 -->
        <div class="col-md-3 mb-4">
          <div class="metric-card">
            <h5>Usuarios Registrados</h5>
            <p>1,320</p>
          </div>
        </div>
        <!-- Métrica 3 -->
        <div class="col-md-3 mb-4">
          <div class="metric-card">
            <h5>Pedidos Pendientes</h5>
            <p>24</p>
          </div>
        </div>
        <!-- Métrica 4 -->
        <div class="col-md-3 mb-4">
          <div class="metric-card">
            <h5>Productos en Inventario</h5>
            <p>578</p>
          </div>
        </div>
      </div>

      <!-- Gráfico de Ventas por Mes -->
      <div class="card mt-4">
        <div class="card-header">
          Gráfico de Ventas por Mes
        </div>
        <div class="card-body">
          <div class="chart-container">
            <canvas id="salesChart"></canvas>
          </div>
        </div>
      </div>

      <!-- Gráfico de Usuarios Activos -->
      <div class="card mt-4">
        <div class="card-header">
          Gráfico de Usuarios Activos
        </div>
        <div class="card-body">
          <div class="chart-container">
            <canvas id="usersChart"></canvas>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

  <!-- Scripts para los gráficos -->
  <script>
    // Gráfico de Ventas por Mes
    const ctx = document.getElementById('salesChart').getContext('2d');
    const salesChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio'],
        datasets: [{
          label: 'Ventas ($)',
          data: [1200, 1900, 3000, 5000, 2400, 3200],
          backgroundColor: 'rgba(0, 123, 255, 0.2)',
          borderColor: 'rgba(0, 123, 255, 1)',
          borderWidth: 2
        }]
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    });

    // Gráfico de Usuarios Activos
    const ctx2 = document.getElementById('usersChart').getContext('2d');
    const usersChart = new Chart(ctx2, {
      type: 'bar',
      data: {
        labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio'],
        datasets: [{
          label: 'Usuarios Activos',
          data: [300, 450, 700, 600, 500, 800],
          backgroundColor: 'rgba(40, 167, 69, 0.2)',
          borderColor: 'rgba(40, 167, 69, 1)',
          borderWidth: 2
        }]
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    });
  </script>

</body>

</html>
