-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 17-05-2019 a las 17:54:05
-- Versión del servidor: 5.7.24
-- Versión de PHP: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `webstore`
--
CREATE DATABASE IF NOT EXISTS `MakeUpVD` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `MakeUpVD`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `CrudUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrudUsuario` (IN `v_idUsuario` DECIMAL(10,0), IN `v_idTipoUsua` INT, IN `v_NombUsua` VARCHAR(255), IN `v_ApelUsua` VARCHAR(255), IN `v_GeneUsua` VARCHAR(1), IN `v_NickUsua` VARCHAR(255), IN `v_PassUsua` VARCHAR(255), IN `boton` VARCHAR(45))  BEGIN
-- Procedimiento Almacenado para gestionar los datos del usuario:
-- Autor = @Eder Lara 2019
-- Declaracion de constantes:
set @estausua = 'Activo';

-- condicionamos el tipo de operacion con la tabla:
case
when boton = 'guardar' then
-- Insertamos los datos a la tabla:
insert into usuario values (v_idUsuario, v_idTipoUsua, v_NombUsua, v_ApelUsua, v_GeneUsua, @estausua, v_NickUsua, v_PassUsua);

when boton = 'modificar' then
-- Modificamos los datos de la tabla, en este caso podemos modificar todo excepto el id del usuario, el tipo del usuario y el estado:
update usuario
set NombUsua = v_NombUsua, ApelUsua = v_ApelUsua, GeneUsua = v_GeneUsua, NickUsua = v_NickUsua, PassUsua = v_PassUsua
where idUsuario = v_idUsuario and idTipoUsua= v_idTipoUsua;

when boton = 'eliminar' then
set  @estausua = 'Inactivo';
update usuario
set estausua =  @estausua 
where idUsuario = v_idUsuario and idTipoUsua= v_idTipoUsua;

end case;
END$$

DROP PROCEDURE IF EXISTS `login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (`usuario` VARCHAR(255), `passusua` VARCHAR(255))  BEGIN 
-- Procedimiento Alamacenado para iniciar sesion 
-- Autor : @Eder Lara -2019

SELECT idUsuario, idTipoUsua, concat(NombUsua, ' ', ApelUsua) as usuario 
from usuario
where NickUsua = usuario  and PassUsua = sha(passusua) and EstaUsua = 'Activo';

-- Fin de procedimiento almacenado para Iniciar Sesion

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `cuentausr`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `cuentausr`;
CREATE TABLE IF NOT EXISTS `cuentausr` (
`(select count(*) from usuario where idtipousua =1)` int(1)
,`(select count(*) from usuario where idtipousua =2)` int(1)
,`(select count(*) from usuario where idtipousua =3)` int(1)
,`(select count(*) from usuario where idtipousua =4)` int(1)
,`(select count(*) from usuario where idtipousua =5)` int(1)
,`(select count(*) from usuario where EstaUsua = 'Activo')` int(1)
,`(select count(*) from usuario where EstaUsua = 'Inactivo')` int(1)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datocont`
--

DROP TABLE IF EXISTS `datocont`;
CREATE TABLE IF NOT EXISTS `datocont` (
  `idDatoCont` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla para indicar a que usuario pertenece',
  `idTipoDocu` varchar(4) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Identificacion de tipo de Documento',
  `idEmpresa` int(11) NOT NULL COMMENT 'Numero de Identificacion de la Empresa',
  `idTipoUsua` int(11) NOT NULL COMMENT 'Identificacion de Tipo de Usuario',
  `idUsuario` decimal(10,0) NOT NULL COMMENT 'Identificacion del Usuario (puede Ser el Numero de Cedula)',
  `Direccion` varchar(200) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Direccion postal o ubicacion fisica de la persona, usuario o provedor',
  `TeleFijo` decimal(10,0) DEFAULT NULL COMMENT 'Numero telefonico de contacto',
  `Fax` decimal(10,0) DEFAULT NULL COMMENT 'Numero de Fax de la persona, usuario o proveedor',
  `Celular` decimal(10,0) DEFAULT NULL COMMENT 'Numero de Celular persona, usuario o proveedor',
  `Email` varchar(100) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Correo Electronico de persona, usuario o proveedor',
  `EstaDato` varchar(15) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Estao de los datos de contacto',
  PRIMARY KEY (`idDatoCont`,`idTipoDocu`,`idEmpresa`,`idTipoUsua`,`idUsuario`),
  KEY `fk_DatoCont_Empresa_idx` (`idEmpresa`),
  KEY `fk_DatoCont_TipoDocu1_idx` (`idTipoDocu`),
  KEY `fk_DatoCont_Usuario1_idx` (`idUsuario`,`idTipoUsua`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='Tabla para los datos de Contacto';

--
-- Truncar tablas antes de insertar `datocont`
--

TRUNCATE TABLE `datocont`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detafopa`
--

DROP TABLE IF EXISTS `detafopa`;
CREATE TABLE IF NOT EXISTS `detafopa` (
  `idDetaFoPa` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de detalle de Forma de Pago',
  `idFormPago` varchar(2) COLLATE latin1_spanish_ci NOT NULL,
  `idTipoTran` varchar(3) COLLATE latin1_spanish_ci NOT NULL,
  `idTransaccion` int(11) NOT NULL,
  `VaFoPago` decimal(20,2) DEFAULT NULL COMMENT 'Valor de Cada Forma de Pago',
  PRIMARY KEY (`idDetaFoPa`,`idFormPago`,`idTipoTran`,`idTransaccion`),
  KEY `fk_DetaFoPa_Transaccion1_idx` (`idTransaccion`,`idTipoTran`),
  KEY `fk_DetaFoPa_FormPago1_idx` (`idFormPago`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='Tabla de detalle de Forma de Pago';

--
-- Truncar tablas antes de insertar `detafopa`
--

TRUNCATE TABLE `detafopa`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detatran`
--

DROP TABLE IF EXISTS `detatran`;
CREATE TABLE IF NOT EXISTS `detatran` (
  `idDetaTran` int(11) NOT NULL AUTO_INCREMENT,
  `idTipoTran` varchar(3) COLLATE latin1_spanish_ci NOT NULL,
  `idTransaccion` int(11) NOT NULL,
  `idProductos` int(11) NOT NULL,
  `Cantidad` decimal(10,0) NOT NULL,
  `ValoCant` decimal(20,2) NOT NULL,
  PRIMARY KEY (`idDetaTran`,`idTipoTran`,`idTransaccion`,`idProductos`),
  KEY `fk_DetaTran_Transaccion1_idx` (`idTransaccion`,`idTipoTran`),
  KEY `fk_DetaTran_Productos1_idx` (`idProductos`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Truncar tablas antes de insertar `detatran`
--

TRUNCATE TABLE `detatran`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

DROP TABLE IF EXISTS `empresa`;
CREATE TABLE IF NOT EXISTS `empresa` (
  `idEmpresa` int(11) NOT NULL COMMENT 'Número de NIT (Numero de Identificación Tributario) de la Empresa',
  `DigiVeri` decimal(10,0) NOT NULL COMMENT 'Digito de Verificacion del NIT Ej (900555630-9) -9',
  `NombEmpr` varchar(200) NOT NULL COMMENT 'Nombre de la empresa',
  `WebEmpresa` varchar(50) NOT NULL COMMENT 'Direccion de página WEB de la Empresa',
  `RepreLegal` varchar(45) NOT NULL COMMENT 'Nombre del Representante legal',
  PRIMARY KEY (`idEmpresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla para los datos de la empresa';

--
-- Truncar tablas antes de insertar `empresa`
--

TRUNCATE TABLE `empresa`;
--
-- Volcado de datos para la tabla `empresa`
--


-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `enterprice`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `enterprice`;
CREATE TABLE IF NOT EXISTS `enterprice` (
`empresa` int(1)
,`nombempr` int(1)
,`Direccion` int(1)
,`telefonos` int(1)
,`fax` int(1)
,`Email` int(1)
,`webempresa` int(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `factura`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `factura`;
CREATE TABLE IF NOT EXISTS `factura` (
`numefact` int(1)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formpago`
--

DROP TABLE IF EXISTS `formpago`;
CREATE TABLE IF NOT EXISTS `formpago` (
  `idFormPago` varchar(2) COLLATE latin1_spanish_ci NOT NULL,
  `NombFoPa` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`idFormPago`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Truncar tablas antes de insertar `formpago`
--

TRUNCATE TABLE `formpago`;
--
-- Volcado de datos para la tabla `formpago`
--

INSERT INTO `formpago` (`idFormPago`, `NombFoPa`) VALUES
('BN', 'BONO'),
('CH', 'CHEQUE'),
('CR', 'CREDITO'),
('EF', 'EFECTIVO'),
('TC', 'TARJETA CREDITO'),
('TD', 'TARJETA DEBITO');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `listusr`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `listusr`;
CREATE TABLE IF NOT EXISTS `listusr` (
`idtipousua` int(1)
,`idtipodocu` int(1)
,`idUsuario` int(1)
,`NombreUser` int(1)
,`email` int(1)
,`telefonos` int(1)
,`estausua` int(1)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

DROP TABLE IF EXISTS `productos`;
CREATE TABLE IF NOT EXISTS `productos` (
  `idProductos` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificacion del Producto ',
  `idTipoProd` int(11) NOT NULL,
  `NombProd` varchar(100) NOT NULL COMMENT 'Nombre del Producto',
  `ValorComp` decimal(20,2) NOT NULL COMMENT 'Valor de compra al proveedor',
  `ValorVent` decimal(20,2) NOT NULL COMMENT 'Valor de Venta al Cliente',
  `CantProd` decimal(20,0) NOT NULL,
  `EstaProd` varchar(45) NOT NULL COMMENT 'Estado del Producto',
  PRIMARY KEY (`idProductos`,`idTipoProd`),
  KEY `fk_Productos_TipoProd1_idx` (`idTipoProd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla para la Discriminacion de los Productos';

--
-- Truncar tablas antes de insertar `productos`
--

TRUNCATE TABLE `productos`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipodocu`
--

DROP TABLE IF EXISTS `tipodocu`;
CREATE TABLE IF NOT EXISTS `tipodocu` (
  `idTipoDocu` varchar(4) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Tipo de Documento de Identificacion, C.C. , R.C. , T.I. , etc.',
  `NombTiDo` varchar(45) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Nombre de tipo de Documento de Identificacion Ej: Cedula de Ciudadania, Registro Civil, etc.',
  PRIMARY KEY (`idTipoDocu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Truncar tablas antes de insertar `tipodocu`
--

TRUNCATE TABLE `tipodocu`;
--
-- Volcado de datos para la tabla `tipodocu`
--

INSERT INTO `tipodocu` (`idTipoDocu`, `NombTiDo`) VALUES
('CC', 'Cedula de Ciudadania'),
('CE', 'Cedula Extrranjeria'),
('MS', 'Menor sin Idenfiicacion'),
('NIT', 'Numero Tributario'),
('NN', 'NO Identificado'),
('PS', 'Pasaporte'),
('RC', 'Registro Civil'),
('TI', 'Tarjeta de Identidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoprod`
--

DROP TABLE IF EXISTS `tipoprod`;
CREATE TABLE IF NOT EXISTS `tipoprod` (
  `idTipoProd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificacion de tipo de producto',
  `NoTiProd` varchar(100) NOT NULL COMMENT 'Nombre de tipo de Producto',
  PRIMARY KEY (`idTipoProd`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Tabla para los tipos de Producto';

--
-- Truncar tablas antes de insertar `tipoprod`
--

TRUNCATE TABLE `tipoprod`;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipotran`
--

DROP TABLE IF EXISTS `tipotran`;
CREATE TABLE IF NOT EXISTS `tipotran` (
  `idTipoTran` varchar(3) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Llave primaria de la tabla tipo de transaccion',
  `NoTiTran` varchar(45) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Nombre de Tipo de Transaccion',
  PRIMARY KEY (`idTipoTran`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='Tabla que muestra los documentos que puedo generar en la tienda';

--
-- Truncar tablas antes de insertar `tipotran`
--

TRUNCATE TABLE `tipotran`;
--
-- Volcado de datos para la tabla `tipotran`
--

INSERT INTO `tipotran` (`idTipoTran`, `NoTiTran`) VALUES
('ABN', 'ABONOS'),
('COM', 'COMPRAS'),
('COT', 'COTIZACIONES'),
('PED', 'PEDIDOS'),
('VEN', 'VENTAS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipousua`
--

DROP TABLE IF EXISTS `tipousua`;
CREATE TABLE IF NOT EXISTS `tipousua` (
  `idTipoUsua` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificacion de tipo de Usuario',
  `NombTiUs` varchar(45) NOT NULL COMMENT 'Nombre de Tipo de Usuario (Clientes, Proveedores, Empleados y Administradores)',
  PRIMARY KEY (`idTipoUsua`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Tabla de Tipos de Usuarios, Clientes, Proveedores, Empleados y Administradores';

--
-- Truncar tablas antes de insertar `tipousua`
--

TRUNCATE TABLE `tipousua`;
--
-- Volcado de datos para la tabla `tipousua`
--

INSERT INTO `tipousua` (`idTipoUsua`, `NombTiUs`) VALUES
(1, 'Administrador'),
(2, 'Empleado'),
(3, 'Proveedor'),
(4, 'Cliente'),
(5, 'Usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaccion`
--

DROP TABLE IF EXISTS `transaccion`;
CREATE TABLE IF NOT EXISTS `transaccion` (
  `idTransaccion` int(11) NOT NULL AUTO_INCREMENT COMMENT 'LLave primaria de la transaccion, indica cual es el  numero de transacccion que llevamos',
  `idTipoTran` varchar(3) COLLATE latin1_spanish_ci NOT NULL,
  `idTipoUsua` int(11) NOT NULL,
  `idUsuario` decimal(10,0) NOT NULL,
  `idFormPago` varchar(2) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Forma de Pago de la Transaccion',
  `NumeTran` decimal(10,0) NOT NULL COMMENT 'Es el numero de documento segun el tipo de transaccion',
  `FechTran` date NOT NULL COMMENT 'Fecha de elaboracion de la transaccion',
  `NotaTran` varchar(250) COLLATE latin1_spanish_ci NOT NULL,
  `ValoTran` decimal(20,2) NOT NULL COMMENT 'Total o costo de la transaccion',
  `SubToTran` decimal(20,2) NOT NULL,
  `IvaTran` decimal(20,2) NOT NULL,
  `SaldTran` decimal(20,2) NOT NULL,
  `EstaTran` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`idTransaccion`,`idTipoTran`,`idTipoUsua`,`idUsuario`,`idFormPago`),
  KEY `fk_Transaccion_TipoTran1_idx` (`idTipoTran`),
  KEY `fk_Transaccion_Usuario1_idx` (`idUsuario`,`idTipoUsua`),
  KEY `fk_Transaccion_FormPago1_idx` (`idFormPago`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='Tabla que detalla todas las transacciones de la tienda';

--
-- Truncar tablas antes de insertar `transaccion`
--

TRUNCATE TABLE `transaccion`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` decimal(10,0) NOT NULL COMMENT 'Numero de idenficacion del Usuario',
  `idTipoUsua` int(11) NOT NULL COMMENT 'Tipo de Usuario ej 1.Cliente',
  `NombUsua` varchar(50) NOT NULL COMMENT 'Nombres del Usuario',
  `ApelUsua` varchar(50) NOT NULL COMMENT 'Apellidos del Usuario',
  `GeneUsua` varchar(1) NOT NULL COMMENT 'Genero Sexual con el que Nació El Usuario',
  `EstaUsua` varchar(15) NOT NULL COMMENT 'Estado del Usuario Ej  (Activo o Inactivo)',
  `NickUsua` varchar(50) NOT NULL DEFAULT 'elara',
  `PassUsua` varchar(100) DEFAULT NULL COMMENT 'Password del usuario',
  PRIMARY KEY (`idUsuario`,`idTipoUsua`),
  KEY `fk_Usuario_TipoUsua1_idx` (`idTipoUsua`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla para la discriminacion de los usuarios del sistema';

--
-- Truncar tablas antes de insertar `usuario`
--

TRUNCATE TABLE `usuario`;
--
-- Volcado de datos para la tabla `usuario`
--



-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `usuarios`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
`Admin` int(1)
,`Empleado` int(1)
,`Proveedor` int(1)
,`Cliente` int(1)
,`Aprendiz` int(1)
,`Activos` int(1)
,`InActivos` int(1)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `cuentausr`
--
DROP TABLE IF EXISTS `cuentausr`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cuentausr`  AS  select 1 AS `(select count(*) from usuario where idtipousua =1)`,1 AS `(select count(*) from usuario where idtipousua =2)`,1 AS `(select count(*) from usuario where idtipousua =3)`,1 AS `(select count(*) from usuario where idtipousua =4)`,1 AS `(select count(*) from usuario where idtipousua =5)`,1 AS `(select count(*) from usuario where EstaUsua = 'Activo')`,1 AS `(select count(*) from usuario where EstaUsua = 'Inactivo')` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `enterprice`
--
DROP TABLE IF EXISTS `enterprice`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `enterprice`  AS  select 1 AS `empresa`,1 AS `nombempr`,1 AS `Direccion`,1 AS `telefonos`,1 AS `fax`,1 AS `Email`,1 AS `webempresa` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `factura`
--
DROP TABLE IF EXISTS `factura`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `factura`  AS  select 1 AS `numefact` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `listusr`
--
DROP TABLE IF EXISTS `listusr`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listusr`  AS  select 1 AS `idtipousua`,1 AS `idtipodocu`,1 AS `idUsuario`,1 AS `NombreUser`,1 AS `email`,1 AS `telefonos`,1 AS `estausua` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `usuarios`
--
DROP TABLE IF EXISTS `usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `usuarios`  AS  select 1 AS `Admin`,1 AS `Empleado`,1 AS `Proveedor`,1 AS `Cliente`,1 AS `Aprendiz`,1 AS `Activos`,1 AS `InActivos` ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `datocont`
--
ALTER TABLE `datocont`
  ADD CONSTRAINT `fk_DatoCont_Empresa` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DatoCont_TipoDocu1` FOREIGN KEY (`idTipoDocu`) REFERENCES `tipodocu` (`idTipoDocu`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DatoCont_Usuario1` FOREIGN KEY (`idUsuario`,`idTipoUsua`) REFERENCES `usuario` (`idUsuario`, `idTipoUsua`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detafopa`
--
ALTER TABLE `detafopa`
  ADD CONSTRAINT `fk_DetaFoPa_FormPago1` FOREIGN KEY (`idFormPago`) REFERENCES `formpago` (`idFormPago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetaFoPa_Transaccion1` FOREIGN KEY (`idTransaccion`,`idTipoTran`) REFERENCES `transaccion` (`idTransaccion`, `idTipoTran`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detatran`
--
ALTER TABLE `detatran`
  ADD CONSTRAINT `fk_DetaTran_Productos1` FOREIGN KEY (`idProductos`) REFERENCES `productos` (`idProductos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetaTran_Transaccion1` FOREIGN KEY (`idTransaccion`,`idTipoTran`) REFERENCES `transaccion` (`idTransaccion`, `idTipoTran`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_Productos_TipoProd1` FOREIGN KEY (`idTipoProd`) REFERENCES `tipoprod` (`idTipoProd`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `transaccion`
--
ALTER TABLE `transaccion`
  ADD CONSTRAINT `fk_Transaccion_FormPago1` FOREIGN KEY (`idFormPago`) REFERENCES `formpago` (`idFormPago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Transaccion_TipoTran1` FOREIGN KEY (`idTipoTran`) REFERENCES `tipotran` (`idTipoTran`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Transaccion_Usuario1` FOREIGN KEY (`idUsuario`,`idTipoUsua`) REFERENCES `usuario` (`idUsuario`, `idTipoUsua`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_Usuario_TipoUsua1` FOREIGN KEY (`idTipoUsua`) REFERENCES `tipousua` (`idTipoUsua`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
