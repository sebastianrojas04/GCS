<?php

	include('../dbconexion.php');
	session_start();
	$id = $_SESSION["idl"];

	$query= "SELECT Nro_Carnet FROM lector wHERE CodLector = '$id'";

	$resultado = $cnmysql->query($query);

	$fila = mysqli_fetch_array($resultado);

	$carnet  = $fila['Nro_Carnet'];



?>
<script type="text/javascript">
	
	var	msj = <?php echo $carnet ?>;
	alert(msj);


</script>

<!DOCTYPE html>
<html>
<head>

	<link rel="stylesheet" type="text/css" href="css_l/hoja_reservarlibros.css">
	<title></title>
</head>

<script type="text/javascript">
	
	$(function VistaDefault(){

		var parametros = {
			"dbusqueda": $("#txtbusqueda").val()
		};

		$.ajax({
			data: parametros,
			url: 'listarStockLibros.php',
			type: 'POST',
			beforeSend: function(){
				$("#listLibros").html("Procesando")
			},
			success: function(datos){
				$("#listLibros").html(datos);
			}
		});
		}
	)




</script>

<body>
	<div id="ContRlibro">
		
		<div id="Reserva">
			<h1>Reserva de Libros</h1>
			<div id="datosReserva">
				<label for="txtCodLector">Nro Carnet:</label>
				<input type="hidden" id="txtCodLector" value="<?php echo $id ?>">
				<input type="text" id="txtNroCarnetLector" readonly value="<?php echo $carnet ?>">

				<label for="txtCodLibro">Codigo Libro:</label>
				<input type="text" id="txtCodLibro">
				<button type="button" onclick="ReservarLibro();">Reservar</button><br>
			</div>
			<div id="MsjReserva"></div>
		</div>

		<div id="busqueda">
			<div id="datosBusqueda">
				<input type="text" id= "txtbusqueda" placeholder="Titulo,Autor,Editorial,Genero" style="width: 200px;">
				<button type="button" onclick="ListarReservaLibro();">Buscar</button>
			</div>
		</div>

		<div id="listLibros"></div>
	</div>
</body>
</html>