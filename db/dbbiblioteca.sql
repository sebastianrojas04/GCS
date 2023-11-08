-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-11-2020 a las 02:39:19
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbbiblioteca`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `NroCarnetBibliotecario` ()  BEGIN

   SET @cantidad = CONVERT((SELECT COUNT(*) FROM bibliotecario), SIGNED);

   IF @cantidad = 0 THEN
		SET @Numero = 1;
   ELSE
		SET @AntiguoCodigo = SUBSTRING((SELECT Nro_Carnet from bibliotecario ORDER BY CodBibliotecario DESC LIMIT 1),2);
		SET @Numero =  CONVERT(@AntiguoCodigo , SIGNED) + 1;
   END IF;
   
	SET @NuevoCodigo =CONCAT('B', LPAD(@Numero,5,'0'));
	SELECT @NuevoCodigo;
  

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `NroCarnetLector` ()  BEGIN

   SET @cantidad = CONVERT((SELECT COUNT(*) FROM lector), SIGNED);

   IF @cantidad = 0 THEN
		SET @Numero = 1;
   ELSE
		SET @AntiguoCodigo = SUBSTRING((SELECT Nro_Carnet from lector ORDER BY CodLector DESC LIMIT 1),2);
		SET @Numero =  CONVERT(@AntiguoCodigo , SIGNED) + 1;
   END IF;
   
	SET @NuevoCodigo =CONCAT('L', LPAD(@Numero,5,'0'));
	SELECT @NuevoCodigo;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autor`
--

CREATE TABLE `autor` (
  `CodAutor` int(11) NOT NULL,
  `Descripcion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bibliotecario`
--

CREATE TABLE `bibliotecario` (
  `CodBibliotecario` int(11) NOT NULL,
  `Nombres` varchar(50) DEFAULT NULL,
  `Apellidos` varchar(50) DEFAULT NULL,
  `Direccion` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Telefono` int(11) DEFAULT NULL,
  `Dni` int(11) DEFAULT NULL,
  `Nro_Carnet` varchar(6) DEFAULT NULL,
  `Contrasena` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bibliotecario`
--

INSERT INTO `bibliotecario` (`CodBibliotecario`, `Nombres`, `Apellidos`, `Direccion`, `Email`, `Telefono`, `Dni`, `Nro_Carnet`, `Contrasena`) VALUES
(1, 'Miguel', 'Infante', 'trasversal 75i#60a-12 sur', 'miguelgo01994@gmail.com', 9211651, 102457337, 'B00001', 'admin1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_prestamo`
--

CREATE TABLE `detalle_prestamo` (
  `Cod_Det_Prestamo` int(11) NOT NULL,
  `CodLibro` int(11) DEFAULT NULL,
  `CodPrestamo` int(11) DEFAULT NULL,
  `CodEstado` int(11) DEFAULT NULL,
  `Fec_Retorno` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Disparadores `detalle_prestamo`
--
DELIMITER $$
CREATE TRIGGER `AumentarStock` AFTER UPDATE ON `detalle_prestamo` FOR EACH ROW BEGIN
    UPDATE stocklibros SET Descripcion = (Descripcion) + 1 WHERE codlibro = NEW.codlibro;
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `DisminuirStock` AFTER INSERT ON `detalle_prestamo` FOR EACH ROW BEGIN
    UPDATE stocklibros SET Descripcion = (Descripcion) - 1 WHERE CodLibro = NEW.CodLibro;
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `editorial`
--

CREATE TABLE `editorial` (
  `CodEditorial` int(11) NOT NULL,
  `Descripcion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `CodEstado` int(11) NOT NULL,
  `Descripcion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`CodEstado`, `Descripcion`) VALUES
(1, 'Pendiente'),
(2, 'Devuelto'),
(3, 'Registrado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

CREATE TABLE `genero` (
  `CodGenero` int(11) NOT NULL,
  `Descripcion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `genero`
--

INSERT INTO `genero` (`CodGenero`, `Descripcion`) VALUES
(1, 'Novela'),
(2, 'Cuento'),
(4, 'Literatura Infantil'),
(5, 'Pensamiento y Debates'),
(6, 'FicciÃ³n y Literatura'),
(7, 'Poema y Ã©pica'),
(8, 'ProgramaciÃ³n'),
(9, 'DiseÃ±o'),
(10, 'Novela indigenista');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lector`
--

CREATE TABLE `lector` (
  `CodLector` int(11) NOT NULL,
  `Nombres` varchar(50) DEFAULT NULL,
  `Apellidos` varchar(50) DEFAULT NULL,
  `Direccion` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Telefono` int(11) DEFAULT NULL,
  `Nro_Carnet` varchar(6) DEFAULT NULL,
  `Contrasena` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

CREATE TABLE `libros` (
  `CodLibro` int(11) NOT NULL,
  `Titulo` varchar(100) DEFAULT NULL,
  `Portada` longblob DEFAULT NULL,
  `CodAutor` int(11) DEFAULT NULL,
  `CodGenero` int(11) DEFAULT NULL,
  `CodEditorial` int(11) DEFAULT NULL,
  `Ubicacion` varchar(50) DEFAULT NULL,
  `Ejemplar` int(11) DEFAULT NULL,
  `link` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Disparadores `libros`
--
DELIMITER $$
CREATE TRIGGER `AgregarStock` AFTER INSERT ON `libros` FOR EACH ROW BEGIN
    INSERT INTO stocklibros(CodLibro,Descripcion) VALUES ((SELECT CodLibro FROM libros ORDER BY CodLibro DESC LIMIT 1),NEW.Ejemplar); 
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `CodPrestamo` int(11) NOT NULL,
  `CodBibliotecario` int(11) DEFAULT NULL,
  `CodLector` int(11) DEFAULT NULL,
  `Fec_Entrega` date DEFAULT NULL,
  `Fec_Devolucion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `CodReserva` int(11) NOT NULL,
  `CodLector` int(11) DEFAULT NULL,
  `CodLibro` int(11) DEFAULT NULL,
  `Fec_Reserva` date DEFAULT NULL,
  `CodEstado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stocklibros`
--

CREATE TABLE `stocklibros` (
  `CodStock` int(11) NOT NULL,
  `CodLibro` int(11) DEFAULT NULL,
  `Descripcion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`CodAutor`);

--
-- Indices de la tabla `bibliotecario`
--
ALTER TABLE `bibliotecario`
  ADD PRIMARY KEY (`CodBibliotecario`);

--
-- Indices de la tabla `detalle_prestamo`
--
ALTER TABLE `detalle_prestamo`
  ADD PRIMARY KEY (`Cod_Det_Prestamo`),
  ADD KEY `CodLibro` (`CodLibro`),
  ADD KEY `CodPrestamo` (`CodPrestamo`),
  ADD KEY `CodEstado` (`CodEstado`);

--
-- Indices de la tabla `editorial`
--
ALTER TABLE `editorial`
  ADD PRIMARY KEY (`CodEditorial`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`CodEstado`);

--
-- Indices de la tabla `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`CodGenero`);

--
-- Indices de la tabla `lector`
--
ALTER TABLE `lector`
  ADD PRIMARY KEY (`CodLector`);

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`CodLibro`),
  ADD KEY `CodAutor` (`CodAutor`),
  ADD KEY `CodGenero` (`CodGenero`),
  ADD KEY `CodEditorial` (`CodEditorial`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`CodPrestamo`),
  ADD KEY `CodBibliotecario` (`CodBibliotecario`),
  ADD KEY `CodLector` (`CodLector`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`CodReserva`),
  ADD KEY `CodLector` (`CodLector`),
  ADD KEY `CodLibro` (`CodLibro`),
  ADD KEY `CodEstado` (`CodEstado`);

--
-- Indices de la tabla `stocklibros`
--
ALTER TABLE `stocklibros`
  ADD PRIMARY KEY (`CodStock`),
  ADD KEY `CodLibro` (`CodLibro`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autor`
--
ALTER TABLE `autor`
  MODIFY `CodAutor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `bibliotecario`
--
ALTER TABLE `bibliotecario`
  MODIFY `CodBibliotecario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalle_prestamo`
--
ALTER TABLE `detalle_prestamo`
  MODIFY `Cod_Det_Prestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `editorial`
--
ALTER TABLE `editorial`
  MODIFY `CodEditorial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `CodEstado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `genero`
--
ALTER TABLE `genero`
  MODIFY `CodGenero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `lector`
--
ALTER TABLE `lector`
  MODIFY `CodLector` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `libros`
--
ALTER TABLE `libros`
  MODIFY `CodLibro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  MODIFY `CodPrestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `CodReserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `stocklibros`
--
ALTER TABLE `stocklibros`
  MODIFY `CodStock` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_prestamo`
--
ALTER TABLE `detalle_prestamo`
  ADD CONSTRAINT `detalle_prestamo_ibfk_1` FOREIGN KEY (`CodLibro`) REFERENCES `libros` (`CodLibro`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_prestamo_ibfk_2` FOREIGN KEY (`CodPrestamo`) REFERENCES `prestamo` (`CodPrestamo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_prestamo_ibfk_3` FOREIGN KEY (`CodEstado`) REFERENCES `estado` (`CodEstado`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `libros`
--
ALTER TABLE `libros`
  ADD CONSTRAINT `libros_ibfk_1` FOREIGN KEY (`CodAutor`) REFERENCES `autor` (`CodAutor`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `libros_ibfk_2` FOREIGN KEY (`CodGenero`) REFERENCES `genero` (`CodGenero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `libros_ibfk_3` FOREIGN KEY (`CodEditorial`) REFERENCES `editorial` (`CodEditorial`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`CodBibliotecario`) REFERENCES `bibliotecario` (`CodBibliotecario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prestamo_ibfk_2` FOREIGN KEY (`CodLector`) REFERENCES `lector` (`CodLector`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`CodLector`) REFERENCES `lector` (`CodLector`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`CodLibro`) REFERENCES `libros` (`CodLibro`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`CodEstado`) REFERENCES `estado` (`CodEstado`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `stocklibros`
--
ALTER TABLE `stocklibros`
  ADD CONSTRAINT `stocklibros_ibfk_1` FOREIGN KEY (`CodLibro`) REFERENCES `libros` (`CodLibro`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
