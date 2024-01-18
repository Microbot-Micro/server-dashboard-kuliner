/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.4.32-MariaDB : Database - dashboard-kuliner
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`Dashboard-Kuliner` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `dashboard-kuliner`;

/*Table structure for table `keranjangs` */

DROP TABLE IF EXISTS `keranjangs`;

CREATE TABLE `keranjangs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jumlah_pesanan` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  CONSTRAINT `keranjangs_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `keranjangs` */

/*Table structure for table `pesanans` */

DROP TABLE IF EXISTS `pesanans`;

CREATE TABLE `pesanans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) DEFAULT NULL,
  `noMeja` varchar(255) DEFAULT NULL,
  `keranjangId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `keranjangId` (`keranjangId`),
  CONSTRAINT `pesanans_ibfk_1` FOREIGN KEY (`keranjangId`) REFERENCES `keranjangs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pesanans` */

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode` varchar(255) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `is_ready` tinyint(1) DEFAULT NULL,
  `gambar` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `products` */

insert  into `products`(`id`,`kode`,`nama`,`harga`,`is_ready`,`gambar`,`createdAt`,`updatedAt`) values (1,'K-01','Sate Ayam',16000,1,'sate-ayam.jpg','2024-01-18 08:54:14','2024-01-18 08:54:14'),(2,'K-02','Nasi Goreng Telur',14000,1,'nasi-goreng-telor.jpg','2024-01-18 08:54:14','2024-01-18 08:54:14'),(3,'K-03','Nasi Rames',12000,1,'nasi-rames.jpg','2024-01-18 08:54:14','2024-01-18 08:54:14'),(4,'K-04','Mie Ayam Bakso',14000,1,'mie-ayam-bakso.jpg','2024-01-18 08:54:14','2024-01-18 08:54:14'),(5,'K-05','Mie Goreng',13000,1,'mie-goreng.jpg','2024-01-18 08:54:14','2024-01-18 08:54:14'),(6,'K-06','Bakso',10000,1,'bakso.jpg','2024-01-18 08:54:14','2024-01-18 08:54:14'),(7,'K-07','Pangsit 6 pcs',5000,1,'pangsit.jpg','2024-01-18 08:54:14','2024-01-18 08:54:14'),(8,'K-08','Kentang Goreng',5000,1,'kentang-goreng.jpg','2024-01-18 08:54:14','2024-01-18 08:54:14'),(9,'K-09','Lontong Opor Ayam',18000,1,'lontong-opor-ayam.jpg','2024-01-18 08:54:14','2024-01-18 08:54:14');

/*Table structure for table `sequelizemeta` */

DROP TABLE IF EXISTS `sequelizemeta`;

CREATE TABLE `sequelizemeta` (
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `sequelizemeta` */

insert  into `sequelizemeta`(`name`) values ('20240111155557-create-product.js'),('20240111155804-create-keranjang.js'),('20240111160027-create-pesanan.js');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- =========================================================================================

-- Menggunakan skema public
SET search_path = public;

-- Buat database
CREATE DATABASE "Dashboard-Kuliner";

-- Gunakan database "Dashboard-Kuliner"
\c "Dashboard-Kuliner"

-- Table "keranjangs"
DROP TABLE IF EXISTS keranjangs;
CREATE TABLE keranjangs (
  id SERIAL PRIMARY KEY,
  jumlah_pesanan VARCHAR(255),
  keterangan VARCHAR(255),
  productId INT,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  FOREIGN KEY (productId) REFERENCES products (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table "pesanans"
DROP TABLE IF EXISTS pesanans;
CREATE TABLE pesanans (
  id SERIAL PRIMARY KEY,
  nama VARCHAR(255),
  noMeja VARCHAR(255),
  keranjangId INT,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  FOREIGN KEY (keranjangId) REFERENCES keranjangs (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table "products"
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  kode VARCHAR(255),
  nama VARCHAR(255),
  harga INT,
  is_ready BOOLEAN,
  gambar VARCHAR(255),
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL
);

-- Isi tabel "products"
INSERT INTO products (kode, nama, harga, is_ready, gambar, createdAt, updatedAt)
VALUES
  ('K-01', 'Sate Ayam', 16000, true, 'sate-ayam.jpg', '2024-01-18 08:54:14', '2024-01-18 08:54:14'),
  ('K-02', 'Nasi Goreng Telur', 14000, true, 'nasi-goreng-telor.jpg', '2024-01-18 08:54:14', '2024-01-18 08:54:14'),
  ('K-03', 'Nasi Rames', 12000, true, 'nasi-rames.jpg', '2024-01-18 08:54:14', '2024-01-18 08:54:14'),
  ('K-04', 'Mie Ayam Bakso', 14000, true, 'mie-ayam-bakso.jpg', '2024-01-18 08:54:14', '2024-01-18 08:54:14'),
  ('K-05', 'Mie Goreng', 13000, true, 'mie-goreng.jpg', '2024-01-18 08:54:14', '2024-01-18 08:54:14'),
  ('K-06', 'Bakso', 10000, true, 'bakso.jpg', '2024-01-18 08:54:14', '2024-01-18 08:54:14'),
  ('K-07', 'Pangsit 6 pcs', 5000, true, 'pangsit.jpg', '2024-01-18 08:54:14', '2024-01-18 08:54:14'),
  ('K-08', 'Kentang Goreng', 5000, true, 'kentang-goreng.jpg', '2024-01-18 08:54:14', '2024-01-18 08:54:14'),
  ('K-09', 'Lontong Opor Ayam', 18000, true, 'lontong-opor-ayam.jpg', '2024-01-18 08:54:14', '2024-01-18 08:54:14');
 
 
 



