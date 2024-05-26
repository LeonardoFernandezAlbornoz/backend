-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-05-2024 a las 15:06:24
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `basedatos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id`, `usuario_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `descripcion`) VALUES
(1, 'ordenadores'),
(2, 'smartphones'),
(3, 'componentes'),
(4, 'televisores'),
(5, 'monitores'),
(6, 'cámaras'),
(7, 'audio'),
(8, 'videojuegos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20240403180235', '2024-04-03 20:03:59', 820),
('DoctrineMigrations\\Version20240404233859', '2024-04-05 01:39:15', 89),
('DoctrineMigrations\\Version20240512180137', '2024-05-12 20:01:57', 114),
('DoctrineMigrations\\Version20240517232543', '2024-05-18 01:25:56', 81);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `estado` varchar(255) NOT NULL,
  `gastos_envio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id`, `usuario_id`, `fecha`, `estado`, `gastos_envio`) VALUES
(1, 1, '2024-04-19 10:00:00', 'En proceso', '5.00'),
(2, 3, '2024-04-18 15:30:00', 'Entregado', '5.00'),
(3, 3, '2024-05-12 22:49:28', 'Pendiente', '0.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `descuento` int(11) NOT NULL,
  `imagen` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id`, `id_categoria`, `nombre`, `descripcion`, `precio`, `stock`, `descuento`, `imagen`) VALUES
(1, 1, 'Portátil HP 15.6\" FHD Laptop, Intel Core i5-1135G7', 'Portátil HP con procesador Intel Core i5', '699.99', 50, 0, 'portatil_hp.jpg'),
(2, 1, 'PC Lenovo Legion T5 Gaming Desktop, AMD Ryzen 7 5700G', 'PC Sobremesa Lenovo con procesador AMD Ryzen 7', '899.99', 30, 0, 'pc_lenovo.jpg'),
(3, 1, 'Tablet Samsung Galaxy Tab S7', 'Tablet Samsung Galaxy Tab S7', '549.99', 40, 0, 'tablet_samsung.jpg'),
(4, 2, 'iPhone 13', 'iPhone 13 con pantalla OLED', '999.99', 20, 0, 'iphone_13.jpg'),
(5, 2, 'Samsung Galaxy S22', 'Samsung Galaxy S22 con cámara de 108MP', '1099.99', 25, 0, 'samsung_s22.jpg'),
(6, 2, 'Xiaomi Redmi Note 11', 'Xiaomi Redmi Note 11 con batería de larga duración', '349.99', 30, 0, 'redmi_note_11.jpg'),
(7, 3, 'Tarjeta gráfica NVIDIA RTX 3080', 'Tarjeta gráfica NVIDIA RTX 3080 con 10GB de memoria GDDR6X', '1299.99', 15, 30, 'rtx_3080.jpg'),
(8, 3, 'Procesador AMD Ryzen 9 5900X', 'Procesador AMD Ryzen 9 5900X de 12 núcleos y 24 hilos', '549.99', 20, 0, 'ryzen_5900x.jpg'),
(9, 3, 'Placa base ASUS ROG Strix B550-F', 'Placa base ASUS ROG Strix B550-F con chipset AMD B550', '199.99', 25, 0, 'asus_b550f.jpg'),
(10, 4, 'TV Sony Bravia OLED 4K', 'TV Sony Bravia OLED 4K de 65 pulgadas', '1999.99', 10, 0, 'sony_bravia.jpg'),
(11, 4, 'LG NanoCell TV 8K', 'LG NanoCell TV 8K de 75 pulgadas', '2999.99', 5, 0, 'lg_nanocell.jpg'),
(12, 4, 'Samsung QLED TV', 'Samsung QLED TV de 55 pulgadas con Quantum Dot', '1499.99', 8, 0, 'samsung_qled.jpg'),
(13, 5, 'Monitor gaming ASUS ROG Swift', 'Monitor gaming ASUS ROG Swift de 27 pulgadas y 240Hz', '499.99', 15, 0, 'asus_rog_monitor.jpg'),
(14, 5, 'Monitor Dell Ultrasharp 4K', 'Monitor Dell Ultrasharp 4K de 32 pulgadas con HDR', '799.99', 10, 0, 'dell_ultrasharp.jpg'),
(15, 5, 'Monitor LG UltraWide', 'Monitor LG UltraWide de 34 pulgadas con resolución QHD', '599.99', 12, 0, 'lg_ultrawide.jpg'),
(16, 6, 'Cámara DSLR Canon EOS 90D', 'Cámara DSLR Canon EOS 90D con sensor APS-C de 32.5MP', '1199.99', 8, 0, 'canon_eos_90d.jpg'),
(17, 6, 'Cámara sin espejo Sony Alpha A7 III', 'Cámara sin espejo Sony Alpha A7 III con sensor full-frame de 24.2MP', '1799.99', 6, 0, 'sony_alpha_a7iii.jpg'),
(18, 6, 'Cámara de acción GoPro Hero 10 Black', 'Cámara de acción GoPro Hero 10 Black con grabación en 5.3K', '499.99', 10, 0, 'gopro_hero10.jpg'),
(19, 7, 'Altavoces Bluetooth JBL Charge 5', 'Altavoces Bluetooth JBL Charge 5 resistentes al agua', '129.99', 25, 0, 'jbl_charge5.jpg'),
(20, 7, 'Auriculares inalámbricos Apple AirPods Pro', 'Auriculares inalámbricos Apple AirPods Pro con cancelación de ruido', '249.99', 20, 0, 'airpods_pro.jpg'),
(21, 7, 'Barra de sonido Sonos Beam', 'Barra de sonido Sonos Beam con asistente de voz integrado', '399.99', 15, 0, 'sonos_beam.jpg'),
(22, 8, 'Consola PlayStation 5', 'Consola PlayStation 5 con unidad de disco Blu-ray', '499.99', 10, 0, 'ps5.jpg'),
(23, 8, 'Xbox Series X', 'Consola Xbox Series X con capacidad de hasta 8K', '499.99', 12, 0, 'xbox_seriesx.jpg'),
(24, 8, 'Nintendo Switch OLED', 'Consola Nintendo Switch OLED con pantalla OLED de 7 pulgadas', '349.99', 15, 0, 'nintendo_switch_oled.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productoscarrito`
--

CREATE TABLE `productoscarrito` (
  `producto_id` int(11) NOT NULL,
  `carrito_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productoscarrito`
--

INSERT INTO `productoscarrito` (`producto_id`, `carrito_id`, `cantidad`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 2, 2),
(4, 2, 1),
(12, 3, 3),
(14, 3, 1),
(17, 3, 1),
(18, 3, 1),
(20, 3, 1),
(23, 3, 1),
(24, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productospedido`
--

CREATE TABLE `productospedido` (
  `producto_id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `descuento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productospedido`
--

INSERT INTO `productospedido` (`producto_id`, `pedido_id`, `cantidad`, `precio`, `descuento`) VALUES
(1, 1, 1, '699.99', 0),
(2, 1, 1, '899.99', 0),
(3, 2, 2, '549.99', 10),
(4, 2, 1, '999.99', 0),
(20, 3, 1, '20.00', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resenha`
--

CREATE TABLE `resenha` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `valoracion` decimal(2,1) NOT NULL,
  `opinion` varchar(255) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `resenha`
--

INSERT INTO `resenha` (`id`, `usuario_id`, `producto_id`, `valoracion`, `opinion`, `fecha`) VALUES
(1, 1, 1, '5.0', 'El portátil HP es rápido y tiene una gran pantalla.', '2024-04-20 10:00:00'),
(2, 2, 2, '4.0', 'Buena PC para juegos, pero podría mejorar la refrigeración.', '2024-04-20 10:00:00'),
(3, 1, 3, '4.0', 'La Galaxy Tab S7 tiene una pantalla nítida y una buena duración de la batería.', '2024-04-20 10:00:00'),
(4, 2, 4, '4.0', 'El iPhone 13 tiene una cámara impresionante, pero es un poco caro.', '2024-04-20 10:00:00'),
(5, 1, 5, '5.0', 'El Samsung Galaxy S22 es rápido y tiene una excelente cámara.', '2024-04-20 10:00:00'),
(6, 2, 6, '3.0', 'El Redmi Note 11 tiene una buena relación calidad-precio, pero la batería podría ser mejor.', '2024-04-20 10:00:00'),
(7, 1, 7, '5.0', 'La RTX 3080 ofrece un rendimiento excepcional en juegos.', '2024-04-20 10:00:00'),
(8, 2, 8, '4.0', 'El Ryzen 9 5900X es un procesador potente para tareas de computación intensiva.', '2024-04-20 10:00:00'),
(9, 1, 9, '4.0', 'Buena placa base para construir un PC de alta gama.', '2024-04-20 10:00:00'),
(10, 2, 10, '5.0', 'El Sony Bravia OLED ofrece una calidad de imagen asombrosa.', '2024-04-20 10:00:00'),
(11, 1, 11, '3.0', 'El LG NanoCell TV 8K tiene una gran resolución, pero el sistema operativo es un poco lento.', '2024-04-20 10:00:00'),
(12, 2, 12, '4.0', 'Buena calidad de imagen en el Samsung QLED TV, pero el control remoto es un poco complicado.', '2024-04-20 10:00:00'),
(13, 1, 13, '5.0', 'El ASUS ROG Swift es perfecto para juegos de alta velocidad.', '2024-04-20 10:00:00'),
(14, 2, 14, '4.0', 'El Dell Ultrasharp 4K tiene colores vibrantes y una buena precisión de imagen.', '2024-04-20 10:00:00'),
(15, 1, 15, '4.0', 'El LG UltraWide ofrece una experiencia inmersiva con su pantalla ancha.', '2024-04-20 10:00:00'),
(16, 2, 16, '5.0', 'La Canon EOS 90D ofrece imágenes nítidas y un gran rendimiento en condiciones de poca luz.', '2024-04-20 10:00:00'),
(17, 1, 17, '4.0', 'La Sony Alpha A7 III es fácil de usar y ofrece una calidad de imagen excepcional.', '2024-04-20 10:00:00'),
(18, 2, 18, '3.0', 'La GoPro Hero 10 Black es resistente y fácil de usar, pero el precio es alto.', '2024-04-20 10:00:00'),
(19, 1, 19, '4.0', 'El JBL Charge 5 tiene un sonido claro y potente, perfecto para actividades al aire libre.', '2024-04-20 10:00:00'),
(20, 2, 20, '5.0', 'Los AirPods Pro tienen una excelente cancelación de ruido y una calidad de sonido impresionante.', '2024-04-20 10:00:00'),
(21, 1, 21, '4.0', 'La Sonos Beam ofrece un sonido envolvente y tiene integración perfecta con los asistentes de voz.', '2024-04-20 10:00:00'),
(22, 2, 22, '5.0', 'La PlayStation 5 ofrece una experiencia de juego inmersiva con gráficos impresionantes.', '2024-04-20 10:00:00'),
(23, 1, 23, '4.0', 'La Xbox Series X tiene un diseño elegante y ofrece una amplia biblioteca de juegos.', '2024-04-20 10:00:00'),
(24, 2, 24, '5.0', 'La Nintendo Switch OLED tiene una pantalla brillante y colores vibrantes, perfecta para juegos portátiles.', '2024-04-20 10:00:00'),
(25, 1, 1, '5.0', 'El portátil HP es rápido y tiene una gran pantalla.', '2024-04-20 10:00:00'),
(26, 2, 2, '4.0', 'Buena PC para juegos, pero podría mejorar la refrigeración.', '2024-04-20 10:00:00'),
(27, 1, 3, '4.0', 'La Galaxy Tab S7 tiene una pantalla nítida y una buena duración de la batería.', '2024-04-20 10:00:00'),
(28, 2, 4, '4.0', 'El iPhone 13 tiene una cámara impresionante, pero es un poco caro.', '2024-04-20 10:00:00'),
(29, 1, 5, '5.0', 'El Samsung Galaxy S22 es rápido y tiene una excelente cámara.', '2024-04-20 10:00:00'),
(30, 2, 6, '3.0', 'El Redmi Note 11 tiene una buena relación calidad-precio, pero la batería podría ser mejor.', '2024-04-20 10:00:00'),
(31, 1, 7, '5.0', 'La RTX 3080 ofrece un rendimiento excepcional en juegos.', '2024-04-20 10:00:00'),
(32, 2, 8, '4.0', 'El Ryzen 9 5900X es un procesador potente para tareas de computación intensiva.', '2024-04-20 10:00:00'),
(33, 1, 9, '4.0', 'Buena placa base para construir un PC de alta gama.', '2024-04-20 10:00:00'),
(34, 2, 10, '5.0', 'El Sony Bravia OLED ofrece una calidad de imagen asombrosa.', '2024-04-20 10:00:00'),
(35, 1, 11, '3.0', 'El LG NanoCell TV 8K tiene una gran resolución, pero el sistema operativo es un poco lento.', '2024-04-20 10:00:00'),
(36, 2, 12, '4.0', 'Buena calidad de imagen en el Samsung QLED TV, pero el control remoto es un poco complicado.', '2024-04-20 10:00:00'),
(37, 1, 13, '5.0', 'El ASUS ROG Swift es perfecto para juegos de alta velocidad.', '2024-04-20 10:00:00'),
(38, 2, 14, '4.0', 'El Dell Ultrasharp 4K tiene colores vibrantes y una buena precisión de imagen.', '2024-04-20 10:00:00'),
(39, 1, 15, '4.0', 'El LG UltraWide ofrece una experiencia inmersiva con su pantalla ancha.', '2024-04-20 10:00:00'),
(40, 2, 16, '5.0', 'La Canon EOS 90D ofrece imágenes nítidas y un gran rendimiento en condiciones de poca luz.', '2024-04-20 10:00:00'),
(41, 1, 17, '4.0', 'La Sony Alpha A7 III es fácil de usar y ofrece una calidad de imagen excepcional.', '2024-04-20 10:00:00'),
(42, 2, 18, '3.0', 'La GoPro Hero 10 Black es resistente y fácil de usar, pero el precio es alto.', '2024-04-20 10:00:00'),
(43, 1, 19, '4.0', 'El JBL Charge 5 tiene un sonido claro y potente, perfecto para actividades al aire libre.', '2024-04-20 10:00:00'),
(44, 2, 20, '5.0', 'Los AirPods Pro tienen una excelente cancelación de ruido y una calidad de sonido impresionante.', '2024-04-20 10:00:00'),
(45, 1, 21, '4.0', 'La Sonos Beam ofrece un sonido envolvente y tiene integración perfecta con los asistentes de voz.', '2024-04-20 10:00:00'),
(46, 2, 22, '5.0', 'La PlayStation 5 ofrece una experiencia de juego inmersiva con gráficos impresionantes.', '2024-04-20 10:00:00'),
(47, 1, 23, '4.0', 'La Xbox Series X tiene un diseño elegante y ofrece una amplia biblioteca de juegos.', '2024-04-20 10:00:00'),
(48, 2, 24, '5.0', 'La Nintendo Switch OLED tiene una pantalla brillante y colores vibrantes, perfecta para juegos portátiles.', '2024-04-20 10:00:00'),
(49, 2, 2, '4.0', 'Buena PC para juegos, pero podría mejorar la refrigeración.', '2024-04-20 10:00:00'),
(50, 1, 3, '4.0', 'La Galaxy Tab S7 tiene una pantalla nítida y una buena duración de la batería.', '2024-04-20 10:00:00'),
(51, 2, 4, '4.0', 'El iPhone 13 tiene una cámara impresionante, pero es un poco caro.', '2024-04-20 10:00:00'),
(52, 1, 5, '5.0', 'El Samsung Galaxy S22 es rápido y tiene una excelente cámara.', '2024-04-20 10:00:00'),
(53, 2, 6, '3.0', 'El Redmi Note 11 tiene una buena relación calidad-precio, pero la batería podría ser mejor.', '2024-04-20 10:00:00'),
(54, 1, 7, '5.0', 'La RTX 3080 ofrece un rendimiento excepcional en juegos.', '2024-04-20 10:00:00'),
(55, 2, 8, '4.0', 'El Ryzen 9 5900X es un procesador potente para tareas de computación intensiva.', '2024-04-20 10:00:00'),
(56, 1, 9, '4.0', 'Buena placa base para construir un PC de alta gama.', '2024-04-20 10:00:00'),
(57, 2, 10, '5.0', 'El Sony Bravia OLED ofrece una calidad de imagen asombrosa.', '2024-04-20 10:00:00'),
(58, 1, 11, '3.0', 'El LG NanoCell TV 8K tiene una gran resolución, pero el sistema operativo es un poco lento.', '2024-04-20 10:00:00'),
(59, 2, 12, '4.0', 'Buena calidad de imagen en el Samsung QLED TV, pero el control remoto es un poco complicado.', '2024-04-20 10:00:00'),
(60, 1, 13, '5.0', 'El ASUS ROG Swift es perfecto para juegos de alta velocidad.', '2024-04-20 10:00:00'),
(61, 2, 14, '4.0', 'El Dell Ultrasharp 4K tiene colores vibrantes y una buena precisión de imagen.', '2024-04-20 10:00:00'),
(62, 1, 15, '4.0', 'El LG UltraWide ofrece una experiencia inmersiva con su pantalla ancha.', '2024-04-20 10:00:00'),
(63, 2, 16, '5.0', 'La Canon EOS 90D ofrece imágenes nítidas y un gran rendimiento en condiciones de poca luz.', '2024-04-20 10:00:00'),
(64, 1, 17, '4.0', 'La Sony Alpha A7 III es fácil de usar y ofrece una calidad de imagen excepcional.', '2024-04-20 10:00:00'),
(65, 2, 18, '3.0', 'La GoPro Hero 10 Black es resistente y fácil de usar, pero el precio es alto.', '2024-04-20 10:00:00'),
(66, 3, 8, '3.0', 'DFDFSD', '2024-05-12 00:52:56'),
(67, 3, 8, '1.0', '', '2024-05-12 00:58:45'),
(68, 2, 6, '2.0', 'SDFSDFSD', '2024-05-12 01:13:16'),
(69, 3, 4, '1.0', 'fsdf', '2024-05-12 01:54:01'),
(70, 3, 4, '1.0', 'dsfsdf', '2024-05-12 01:54:46'),
(71, 3, 8, '1.0', 'fsdfsdfs', '2024-05-12 01:56:22'),
(72, 3, 11, '4.0', 'Me gusta esta tele', '2024-05-18 00:21:30'),
(73, 3, 12, '4.0', 'xdfdf', '2024-05-22 00:40:24'),
(74, 3, 14, '4.0', '', '2024-05-23 23:37:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nom_usuario` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `contrasenha` varchar(255) NOT NULL,
  `admin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nom_usuario`, `nombre`, `apellidos`, `correo`, `contrasenha`, `admin`) VALUES
(1, 'usuario1', 'Juan', 'González', 'juan@example.com', 'bba2d1bec283dd3b90add09797a9235b08069064', 0),
(2, 'usuario2', 'María', 'López', 'maria@example.com', 'contrasenha2', 0),
(3, 'leonarfer', 'Leonardo', 'Fernandez', 'leonarfer@hotmail.es', '$2y$13$KVYI18VPSFhLihWryVoFx.9IW23LlvPfkB9k4O9sBHCqiiHlbrJkm', 0),
(4, 'dasdasd', 'sadasdas', 'dasdas', 'dasdasd@sffd.es', '$2y$13$LNAPleHRucD7.dBloYPpbukWMV5cnYLut/pwzx4V118PMkicZQCCS', 0),
(5, 'sdsads', 'adasds@sfsdf', 'fsdfd', 'ssdfsd@fsd.es', '$2y$13$AGndHxO/ltE4f0vVvMa.7.mZIR1Dy3c21vyT77WAZuvIvzP1LCPFW', 0),
(6, 'sdfsdf', 'sdfsdfd', 'dfsdf', 'leorfer@hotmail.es', '$2y$13$UEdiD7/wTdS/KflchtxbpuKyzbOnN0GRTf4aXTD8Jj78olad3xBze', 0),
(7, 'leo', 'leonardo', 'fernández', 'leonarfer932@gmail.es', '$2y$13$rS8hdIUyFS1VGSaXr9LssuSdjISD72VoopgHgJTAjBjt5XUOEqJBS', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_77E6BED5DB38439E` (`usuario_id`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C4EC16CEDB38439E` (`usuario_id`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_A7BB0615CE25AE0A` (`id_categoria`);

--
-- Indices de la tabla `productoscarrito`
--
ALTER TABLE `productoscarrito`
  ADD PRIMARY KEY (`producto_id`,`carrito_id`),
  ADD KEY `IDX_48F682F47645698E` (`producto_id`),
  ADD KEY `IDX_48F682F4DE2CF6E7` (`carrito_id`);

--
-- Indices de la tabla `productospedido`
--
ALTER TABLE `productospedido`
  ADD PRIMARY KEY (`producto_id`,`pedido_id`),
  ADD KEY `IDX_61D6EA687645698E` (`producto_id`),
  ADD KEY `IDX_61D6EA684854653A` (`pedido_id`);

--
-- Indices de la tabla `resenha`
--
ALTER TABLE `resenha`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D9F04BF0DB38439E` (`usuario_id`),
  ADD KEY `IDX_D9F04BF07645698E` (`producto_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `resenha`
--
ALTER TABLE `resenha`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `FK_77E6BED5DB38439E` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `FK_C4EC16CEDB38439E` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `FK_A7BB0615CE25AE0A` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`);

--
-- Filtros para la tabla `productoscarrito`
--
ALTER TABLE `productoscarrito`
  ADD CONSTRAINT `FK_48F682F47645698E` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `FK_48F682F4DE2CF6E7` FOREIGN KEY (`carrito_id`) REFERENCES `carrito` (`id`);

--
-- Filtros para la tabla `productospedido`
--
ALTER TABLE `productospedido`
  ADD CONSTRAINT `FK_61D6EA684854653A` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`),
  ADD CONSTRAINT `FK_61D6EA687645698E` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`);

--
-- Filtros para la tabla `resenha`
--
ALTER TABLE `resenha`
  ADD CONSTRAINT `FK_D9F04BF07645698E` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `FK_D9F04BF0DB38439E` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
