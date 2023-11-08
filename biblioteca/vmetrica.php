<?php
// Establecer la conexión a la base de datos (reemplaza con tus propios datos)
$servername = "localhost";
$username = "root";
$password = "";
$database = "dbbiblioteca";

$conn = new mysqli($servername, $username, $password, $database);

// Verificar la conexión
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Consulta para contar los registros en la tabla "bibliotecario"
$query = "SELECT COUNT(*) as total FROM bibliotecario";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $totalRegistros = $row["total"];
} else {
    $totalRegistros = 0;
}

// Consulta para contar los registros en la tabla "lector"
$query = "SELECT COUNT(*) as total FROM lector";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $totalRegistroslector = $row["total"];
} else {
    $totalRegistroslector = 0;
}

// Cerrar la conexión
$conn->close();
?>

<!DOCTYPE html>
<html>

</head>
<body>

    <!-- Botón "Volver" -->
    <a href="javascript:history.go(-1)">Volver</a>
</body>
<p>



<?php

// Configuración de la conexión a la base de datos (reemplaza con tus propios datos)
$servername = "localhost";
$username = "root";
$password = "";
$database = "dbbiblioteca";

// Crear una conexión a la base de datos
$conn = new mysqli($servername, $username, $password, $database);

// Verificar la conexión
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Consulta para obtener el tamaño de la base de datos
$query = "SELECT table_schema 'Database', SUM(data_length + index_length) 'Size' 
          FROM information_schema.tables 
          WHERE table_schema = '$database'";

$result = $conn->query($query);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $databaseSize = $row['Size'];
    echo "El tamaño de la base de datos es de aproximadamente $databaseSize bytes.";
} else {
    echo "No se pudo obtener el tamaño de la base de datos.";
}

// Cerrar la conexión
$conn->close();
?>
<head>
    <title>Cantidad de Registros en la Tabla Bibliotecario</title>
</head>
<body>
    <h1>Cantidad de bibliotecarios</h1>
    <p>Hay <?php echo $totalRegistros; ?> bibliotecarios</p>
	<h1>Cantidad de lectores</h1>
    <p>Hay <?php echo $totalRegistroslector; ?> lectores</p>
</body>


<head>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

    <canvas id="myChart" width="400" height="400"></canvas>

    <?php
    // Datos
    $etiqueta1 = "Bibliotecarios";
    $valor1 = $totalRegistros;
    $etiqueta2 = "Lectores";
    $valor2 = $totalRegistroslector;
    ?>

    <script>
        // Datos para el gráfico de barras
        var etiquetas = ["<?php echo $etiqueta1; ?>", "<?php echo $etiqueta2; ?>"];
        var valores = [<?php echo $valor1; ?>, <?php echo $valor2; ?>];

        var ctx = document.getElementById('myChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: etiquetas,
                datasets: [{
                    label: '',
                    data: valores,
                    backgroundColor: ['rgba(75, 192, 192, 0.2)', 'rgba(192, 75, 75, 0.2)'],
                    borderColor: ['rgba(75, 192, 192, 1)', 'rgba(192, 75, 75, 1)'],
                    borderWidth: 1
                }]
            },
            options: {
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

