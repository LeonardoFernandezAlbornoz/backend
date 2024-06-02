-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-06-2024 a las 21:41:52
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
(2, 2);

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
(1, 1, '2024-06-02 21:01:16', 'En proceso', '5.99'),
(2, 2, '2024-06-02 21:01:16', 'Entregado', '4.99');

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
(3, 1, 2),
(4, 2, 1),
(5, 2, 2),
(6, 2, 1);

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
(3, 1, 2, '549.99', 0),
(4, 2, 1, '999.99', 0),
(5, 2, 2, '1099.99', 0),
(6, 2, 1, '349.99', 0);

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
(1, 1, 1, '4.5', 'Excelente portátil, rápido y ligero.', '2024-06-02 21:29:51'),
(2, 2, 4, '5.0', 'El iPhone 13 es espectacular, la cámara toma fotos increíbles.', '2024-06-02 21:29:51'),
(3, 1, 1, '5.0', 'Me encanta este portátil, es rápido y tiene una gran pantalla.', '2024-06-02 21:33:50'),
(4, 2, 1, '4.0', 'Buen rendimiento general, pero la duración de la batería podría ser mejor.', '2024-06-02 21:33:50'),
(5, 1, 2, '4.5', 'Excelente PC para juegos, corre todos mis juegos favoritos sin problemas.', '2024-06-02 21:33:50'),
(6, 2, 2, '5.0', 'Estoy muy impresionado con el rendimiento de este PC, lo recomiendo.', '2024-06-02 21:33:50'),
(7, 1, 3, '4.0', 'Buena tablet en general, pero el precio es un poco alto para lo que ofrece.', '2024-06-02 21:33:50'),
(8, 2, 3, '4.5', 'Gran pantalla y buen rendimiento, me gusta mucho esta tablet.', '2024-06-02 21:33:50'),
(9, 1, 4, '5.0', 'El iPhone 13 es simplemente increíble, la calidad de construcción y la cámara son impresionantes.', '2024-06-02 21:33:50'),
(10, 2, 4, '4.5', 'Gran teléfono, pero el precio es un poco elevado en comparación con otras opciones.', '2024-06-02 21:33:50'),
(11, 1, 5, '4.5', 'Gran teléfono con una cámara excelente, el rendimiento es rápido y fluido.', '2024-06-02 21:33:50'),
(12, 2, 5, '5.0', 'El Galaxy S22 superó mis expectativas, es genial en todos los aspectos.', '2024-06-02 21:33:50'),
(13, 1, 6, '4.0', 'Buen teléfono por su precio, pero la duración de la batería podría ser mejor.', '2024-06-02 21:33:50'),
(14, 2, 6, '4.5', 'Muy satisfecho con este teléfono, ofrece un buen rendimiento a un precio asequible.', '2024-06-02 21:33:50'),
(15, 1, 7, '5.0', 'Increíble tarjeta gráfica, excelente rendimiento en juegos y aplicaciones de diseño.', '2024-06-02 21:33:50'),
(16, 2, 7, '4.5', 'Gran tarjeta gráfica, pero el precio es un poco alto en este momento debido a la demanda.', '2024-06-02 21:33:50'),
(17, 1, 8, '4.5', 'Excelente procesador, potente y eficiente, perfecto para gaming y multitarea.', '2024-06-02 21:33:50'),
(18, 2, 8, '5.0', 'El Ryzen 9 5900X es simplemente increíble, el rendimiento es excepcional en todas las tareas.', '2024-06-02 21:33:50'),
(19, 1, 9, '4.0', 'Buena placa base con muchas características, pero el precio es un poco alto.', '2024-06-02 21:33:50'),
(20, 2, 9, '4.5', 'Excelente placa base, ofrece un rendimiento confiable y muchas opciones de personalización.', '2024-06-02 21:33:50'),
(21, 1, 10, '5.0', 'La calidad de imagen de esta TV es impresionante, los colores son vibrantes y el contraste es excelente.', '2024-06-02 21:33:50'),
(22, 2, 10, '4.5', 'Excelente TV, pero el precio es un poco alto en comparación con otras opciones.', '2024-06-02 21:33:50'),
(23, 1, 11, '4.5', 'Gran TV con una calidad de imagen excepcional, el upscaling a 8K es impresionante.', '2024-06-02 21:33:50'),
(24, 2, 11, '5.0', 'La LG NanoCell TV ofrece una experiencia visual increíble, estoy muy satisfecho con esta compra.', '2024-06-02 21:33:50'),
(25, 1, 12, '4.0', 'Buena TV con colores vibrantes, pero el sistema operativo es un poco lento a veces.', '2024-06-02 21:33:50'),
(26, 2, 12, '4.5', 'Muy buena TV, la calidad de imagen es excelente y el precio es razonable.', '2024-06-02 21:33:50'),
(27, 1, 13, '5.0', 'El ASUS ROG Swift es perfecto para gaming, la tasa de refresco de 240Hz hace que los juegos sean suaves y fluidos.', '2024-06-02 21:33:50'),
(28, 2, 13, '4.5', 'Gran monitor para gaming, pero el precio es un poco alto en comparación con otras opciones.', '2024-06-02 21:33:50'),
(29, 1, 14, '4.5', 'Excelente monitor para trabajo y edición de fotos, la resolución 4K y el HDR hacen que las imágenes se vean increíbles.', '2024-06-02 21:33:50'),
(30, 2, 14, '5.0', 'Muy impresionado con este monitor, la calidad de construcción y la precisión del color son excepcionales.', '2024-06-02 21:33:50'),
(31, 1, 15, '4.0', 'Buen monitor con una pantalla amplia, pero el brillo podría ser mejor.', '2024-06-02 21:33:50'),
(32, 2, 15, '4.5', 'Gran monitor para multitarea, el tamaño y la resolución son perfectos para mi flujo de trabajo.', '2024-06-02 21:33:50'),
(33, 1, 16, '5.0', 'La Canon EOS 90D es una excelente cámara para fotografía y vídeo, la calidad de imagen es excepcional.', '2024-06-02 21:33:50'),
(34, 2, 16, '4.5', 'Muy satisfecho con esta cámara, ofrece un rendimiento excelente en diversas condiciones de iluminación.', '2024-06-02 21:33:50'),
(35, 1, 17, '4.5', 'Excelente cámara para fotografía de paisajes y retratos, el enfoque automático es rápido y preciso.', '2024-06-02 21:33:50'),
(36, 2, 17, '5.0', 'La Sony Alpha A7 III es simplemente increíble, la calidad de imagen y la ergonomía son fantásticas.', '2024-06-02 21:33:50'),
(37, 1, 18, '5.0', 'La GoPro Hero 10 Black es perfecta para capturar momentos emocionantes, la calidad de video es impresionante.', '2024-06-02 21:33:50'),
(38, 2, 18, '4.5', 'Excelente cámara de acción, la estabilización de imagen es muy efectiva incluso en condiciones extremas.', '2024-06-02 21:33:50'),
(39, 1, 19, '4.5', 'Muy buenos altavoces, el sonido es potente y los graves son profundos.', '2024-06-02 21:33:50'),
(40, 2, 19, '5.0', 'Los JBL Charge 5 son increíbles, el sonido es claro y tienen una duración de batería impresionante.', '2024-06-02 21:33:50'),
(41, 1, 20, '5.0', 'Los AirPods Pro son geniales, la cancelación de ruido es efectiva y la calidad de sonido es excelente.', '2024-06-02 21:33:50'),
(42, 2, 20, '4.5', 'Excelentes auriculares, pero el precio es un poco alto en comparación con otras opciones.', '2024-06-02 21:33:50'),
(43, 1, 21, '4.0', 'Buena calidad de sonido y fácil de configurar, pero el precio es un poco elevado.', '2024-06-02 21:33:50'),
(44, 2, 21, '4.5', 'La Sonos Beam ofrece un sonido impresionante y se integra perfectamente con mi sistema de entretenimiento.', '2024-06-02 21:33:50'),
(45, 1, 22, '5.0', 'La PlayStation 5 es una consola excelente, el rendimiento es increíble y los tiempos de carga son rápidos.', '2024-06-02 21:33:50'),
(46, 2, 22, '4.5', 'Gran consola para gaming, pero la disponibilidad es un problema debido a la alta demanda.', '2024-06-02 21:33:50'),
(47, 1, 23, '4.5', 'Excelente consola con un potente hardware, disfruto mucho jugando en la Xbox Series X.', '2024-06-02 21:33:50'),
(48, 2, 23, '5.0', 'La Xbox Series X ofrece una experiencia de juego de próxima generación, estoy muy impresionado.', '2024-06-02 21:33:50'),
(49, 1, 24, '4.0', 'Buena consola para juegos portátiles, la pantalla OLED es impresionante, pero el precio es un poco alto.', '2024-06-02 21:33:50'),
(50, 2, 24, '4.5', 'La Nintendo Switch OLED ofrece una experiencia de juego mejorada, me encanta la calidad de la pantalla.', '2024-06-02 21:33:50');

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
(1, 'Juan', 'Juan', 'Fernández', 'juan@gmail.com', 'password123', 0),
(2, 'María', 'María', 'Pérez', 'maria@gmail.com', 'password123', 0),
(3, 'admin', 'Admin', 'User', 'admin@gmail.com', 'adminpassword', 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `resenha`
--
ALTER TABLE `resenha`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
