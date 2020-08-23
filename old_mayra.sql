-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 30, 2020 at 02:37 PM
-- Server version: 5.7.31-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mayra`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int(191) NOT NULL DEFAULT '0',
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `shop_name` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `phone`, `role_id`, `photo`, `password`, `api_token`, `status`, `remember_token`, `created_at`, `updated_at`, `shop_name`) VALUES
(1, 'Admin', 'daniel@waterbot.xyz', '01629552892', 0, '1556780563user.png', '$2y$10$exGozYUkvvnfScErNvg5weki6DujTMABgO3RPqWBfIIVnmyMxnLc6', '9PwWzW2Al8boW9qBXc6aDNhLdoXQsAyaNC528U61w1yu9ZPAALQNIav5bWxR', 1, '6euvcSK8vdNhGXTxFWvZ6ghWjiqQJNWa5KiRKQRATJolDakBQQQQmcAiDEbF', '2018-02-28 23:27:08', '2020-06-15 01:29:40', 'Open Market');

-- --------------------------------------------------------

--
-- Table structure for table `admin_languages`
--

CREATE TABLE `admin_languages` (
  `id` int(191) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `language` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rtl` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin_languages`
--

INSERT INTO `admin_languages` (`id`, `is_default`, `language`, `file`, `name`, `rtl`) VALUES
(1, 1, 'English', '1567232745AoOcvCtY.json', '1567232745AoOcvCtY', 0);

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` int(11) NOT NULL,
  `attributable_id` int(11) DEFAULT NULL,
  `attributable_type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `input_name` varchar(255) DEFAULT NULL,
  `price_status` int(3) NOT NULL DEFAULT '1' COMMENT '0 - hide, 1- show	',
  `details_status` int(3) NOT NULL DEFAULT '1' COMMENT '0 - hide, 1- show	',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `attribute_options`
--

CREATE TABLE `attribute_options` (
  `id` int(11) NOT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` int(191) NOT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('Large','TopSmall','BottomSmall') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(191) NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `status`, `photo`, `is_featured`, `image`) VALUES
(20, 'Women\'s clothing', 'Ladies-fashion-and-wear', 1, '1592897157ladies-western-wear-500x500.jpg', 0, NULL),
(21, 'Men\'s Fashion', 'Fashion-for-real-man', 1, '159289881025662-gtwgzu.jpg', 0, NULL),
(22, 'Phones and Telecommunications', 'Best-phone-and-telecommunications', 1, '1592900692gsmarena_006.jpg', 0, NULL),
(23, 'Computer, Office & Security', 'Computer-office-and-Security', 1, '1592902679180907-N-BK152-003.jpg', 0, NULL),
(24, 'Consumer Electronics', 'Consumer-Electronics', 1, '1592903819images.jpg', 0, NULL),
(25, 'Jewellery & Watches', 'Jewellery-and-Watches', 1, '1592904726costume-jewellery-Diamond.jpg', 0, NULL),
(26, 'Home, pet & Appliances', 'Home-pet-and-Appliances', 1, '15929064271800x1200_dog_breed_health_issues_slideshow.jpg', 0, NULL),
(27, 'Bags & Shoes', 'Bags-and-Shoes', 1, '1592907413p754503.jpg', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `childcategories`
--

CREATE TABLE `childcategories` (
  `id` int(191) NOT NULL,
  `subcategory_id` int(191) NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `childcategories`
--

INSERT INTO `childcategories` (`id`, `subcategory_id`, `name`, `slug`, `status`) VALUES
(17, 18, 'Summer Dresses', 'Dress-in-summer', 1),
(18, 18, 'Hoodies and Sweatshirts', 'Hoodies-and-Sweatshirts-fashion', 1),
(19, 18, 'Blouses & Shirts', 'Awesome-blouses-and-shirts', 1),
(20, 18, 'Jackets', 'Fashional-jacket-to-keep-you-warm-and-beautiful', 1),
(21, 18, 'Skirts', 'Beautiful-skirts', 1),
(22, 18, 'Wedding Dresses', 'Making-your-wedding-day-special', 1),
(23, 18, 'Sweaters', 'Cool-looking-sweaters', 1),
(24, 19, 'Jeans', 'New-jeans', 1),
(25, 19, 'Pants and Capris', 'Most-comfortable-pants', 1),
(26, 19, 'Women\'s Socks', 'Inside-shoes-but-not-ugly', 1),
(27, 19, 'Shorts', 'Be-comfortable-when-inside-and-outside', 1),
(28, 19, 'Panties', 'No-one-will-see-it-but-quality-matters', 1),
(29, 20, 'Blazers', 'Look-smart-and-be-comfortable', 1),
(30, 20, 'Trench Coats', 'Most-comfortable-ever', 1),
(31, 20, 'Faux Leather', 'Real-leather-is-hard-to-find-but-not-here', 1),
(32, 20, 'Denim Jackets', 'No-compramise-in-jackets', 1),
(33, 20, 'Wool and Blends', 'Real-wool-from-real-sheeps', 1),
(34, 20, 'Faux Fur', 'So-soft-even-silkworm-will-be-jealous', 1),
(35, 21, 'T-shirt & Tops', 'Comfort-is-the-first-priority', 1),
(36, 21, 'Cover-ups', 'No-compramise-in-cover-ups', 1),
(37, 21, 'Selected Crop Top', 'Select-what-you-want-to-wear', 1),
(38, 21, 'Jumpsuits', 'Professional-jumpsuits', 1),
(39, 21, 'Shirts', 'We-bet-you-will-look-cool-with-our-shirts', 1),
(40, 21, 'Intimates', 'Awsome-intimates', 1),
(41, 21, 'Sleep & Longue', 'Sleep-comfortalbe', 1),
(42, 22, 'Hoodies & Sweatshirts', 'Premium-hoodies', 1),
(43, 22, 'T-shirts', 'Tshirt-lasting-forever', 1),
(44, 22, 'Shirts', 'Shirts-so-nicely-finished', 1),
(45, 22, 'Casual Shorts', 'Casual-Shorts', 1),
(46, 22, 'Men\'s Sets', 'Set-for-man', 1),
(47, 22, 'Jackets', 'Yes-jackets-also-look-cool', 1),
(48, 23, 'Casual Pants', 'Casual-but-fancy', 1),
(49, 23, 'Sweatpants', 'Pants-looking-cool', 1),
(50, 23, 'Cargo Pants', 'Most-comfortable-ever', 1),
(51, 23, 'Jeans', 'Most-comfortable-pants', 1),
(52, 23, 'Harem Pants', 'Just-awesome', 1),
(53, 23, 'Shorts', 'So-short-and-comfortable', 1),
(54, 24, 'Jackets', 'Jackets-look-cool', 1),
(55, 24, 'Sweaters', 'Casual-but-fancy', 1),
(56, 24, 'Casual Faux Leather', 'Real-leather-is-hard-to-find-but-not-here', 1),
(57, 24, 'Genuine Leather', 'Real-leather-is-hard-to-find-but-not-here', 1),
(58, 24, 'Parkas', 'Soft-and-smooth', 1),
(59, 24, 'Down Jackets', 'Jackets-look-cool', 1),
(60, 24, 'Suits & Blazer', 'Formal-but-fancy', 1),
(61, 25, 'Boxer', 'Feel-like-a-real-boxer', 1),
(62, 25, 'Briefs', 'Underwear-but-it-needs-to-be-cool', 1),
(63, 25, 'Long Johns', 'Long-but-comfortable', 1),
(64, 25, 'Men\'s sleep and lounge', 'Protect-privacy-in-sleepover', 1),
(65, 25, 'Pajama Sets', 'Pajama-is-important-wherever-you-go', 1),
(66, 26, 'Scarves', 'Look-like-a-hero', 1),
(67, 26, 'Skullies & Beanies', 'Awesome-accessories', 1),
(68, 26, 'Presciption Glasses', 'See-sharp-and-look-fashionable', 1),
(69, 26, 'Gloves and Mittens', 'Cold-hand-is-really-not-cool', 1),
(70, 26, 'Belts', 'Belts-that-donot-break', 1),
(71, 26, 'Bomber Hats', 'Classical', 1),
(72, 26, 'Fedoras', 'Awesome-accessories', 1),
(73, 26, 'Berets', 'Awesome-accessories', 1),
(74, 26, 'Baseball Caps', 'Play-baseball', 1),
(75, 27, 'Cosplay Costumes', 'It-is-special', 1),
(76, 27, 'Stage & Dance Wear', 'Perform-whatever-you-like', 1),
(77, 27, 'Exotic Apparel', 'Exotic-Apparel', 1),
(78, 28, 'Android Phones', 'Android-Phones', 1),
(79, 28, 'iPhones', 'iPhones', 1),
(80, 34, 'Feature Phones', 'Feature-phones', 1),
(81, 34, 'Refurbished Phones', 'Refurbished-Phones', 1),
(82, 28, '8GB RAM', '8-gb', 1),
(83, 28, '5G Phones', '5G', 1),
(84, 29, 'lenovo', 'lenovo', 1),
(85, 29, 'OnePlus', 'Oneplus', 1),
(86, 29, 'HUAWAI', 'Huawai', 1),
(87, 29, 'Galaxy', 'Galaxy', 1),
(88, 29, 'MEIZU', 'Meizu', 1),
(89, 29, 'UMIDIGI', 'Umidigi', 1),
(90, 30, 'Cases & covers', 'Cases', 1),
(91, 30, 'Cables', 'Cables', 1),
(92, 30, 'Power bank', 'Power-Bank', 1),
(93, 30, 'Holders & Stands', 'Holders', 1),
(94, 30, 'Screen Protectors', 'Protect-screen', 1),
(95, 31, 'Cases For iPhone', 'Cases-For-iphone', 1),
(96, 31, 'Cases For Samsung', 'Cases-For-samsung', 1),
(97, 31, 'Cases For Huawei', 'Cases-For-huawei', 1),
(98, 31, 'Cases For Xiaomi', 'Cases-For-Xiaomi', 1),
(99, 31, 'Cases For Meizu', 'Cases-For-Meizu', 1),
(100, 31, 'Cases For Oppo', 'Cases-For-Oppo', 1),
(101, 32, 'Wireless Chargers', 'Wireless-Chargers', 1),
(102, 32, 'Car Chargers', 'Chargers', 1),
(103, 32, 'Lenses', 'Lenses', 1),
(104, 32, 'Adapters & Converters', 'Adapters', 1),
(105, 33, 'Phone LCDs', 'LCDs-for-phone', 1),
(106, 33, 'Phone Batteries', 'Batteries-for-phone', 1),
(107, 33, 'Housing & Frames', 'Housing-for-phones', 1),
(108, 34, 'Walkie Talkie', 'Walkie-Talkie', 1),
(109, 34, 'Fiber Optic Equipment', 'Fiber-optics-equipments', 1),
(110, 34, 'Communications Antennas', 'Antennas', 1),
(111, 35, 'CPUs', 'CPUs', 1),
(112, 35, 'Motherboards', 'Motherboards', 1),
(113, 35, 'Graphics card', 'Graphics-card', 1),
(114, 35, 'Mice', 'Mouse', 1),
(115, 35, 'Keyboards', 'Keyboard', 1),
(116, 36, 'Gaming Laptops', 'Best-performing-laptop', 1),
(117, 36, 'Ultraslim Laptops', 'Ultraslim', 1),
(118, 36, 'Tablets', 'Tablets', 1),
(119, 36, 'Tablet Accessories', 'Tablet', 1),
(120, 36, 'Laptop Bags & Cases', 'Laptop-bags', 1),
(121, 37, 'Surveillance Items', 'Surveillance', 1),
(122, 37, 'Access Control System', 'Access-Control-System', 1),
(123, 37, 'Smoke Detectors', 'Smoke-Detectors', 1),
(124, 37, 'Safety Equipment', 'Safety-equipments', 1),
(125, 37, 'Alarms and Sensors', 'Alarms-and-Sensors', 1),
(126, 37, 'Door Intercom System', 'Door-Intercom-System', 1),
(127, 38, 'USB Flash Drives', 'USB-Flash-Drives', 1),
(128, 38, 'Memory Cards', 'Memory-Cards', 1),
(129, 38, 'External Hard Drives', 'External-Hard-Drives', 1),
(130, 38, 'HDD Box Enclousers', 'HDD-Box-Enclousers', 1),
(131, 38, 'SSDs', 'SSD', 1),
(132, 39, '3D Printers', '3D-Printers', 1),
(133, 39, '3D Printers Parts & Accessories', '3D-Printers-Parts-and-Accessories', 1),
(134, 39, 'Printers', 'Printers', 1),
(135, 39, 'Printers parts', 'Printers-parts', 1),
(136, 39, 'Scanners', 'Scanners', 1),
(137, 39, 'Ink Cartridges', 'Ink-Cartridges', 1),
(138, 39, '3D printing Materials', '3D-printing-Materials', 1),
(139, 40, 'Wireless Routers', 'Wireless-Routers', 1),
(140, 40, 'Network Cards', 'Network-Cards', 1),
(141, 40, '3D Modems', '3D-Modems', 1),
(142, 40, 'Modem-Router Combos', 'Modem-Router', 1),
(143, 40, 'Networking Tools', 'Networking-Tools', 1),
(144, 41, 'Cables & adapters', 'Cables-and-adapters', 1),
(145, 41, 'Electronics Cigrettes', 'Electronics-Cigrettes', 1),
(146, 41, 'Chargers', 'Charger', 1),
(147, 41, 'Home Electronics Accessories', 'Home-Electronics-Accessories', 1),
(148, 41, 'Bags & Cases', 'Bags-and-Cases', 1),
(149, 42, 'Televisions', 'Televisions', 1),
(150, 42, 'TV Receivers', 'TV-Receivers', 1),
(151, 42, 'Projectors', 'Projectors', 1),
(152, 42, 'Audio Amplifier Boards', 'Audio-Amplifier-Boards', 1),
(153, 42, 'TV Sticks', 'TV-Sticks', 1),
(154, 43, 'Digital Cameras', 'Digital-Cameras', 1),
(155, 43, 'Camera Drones', 'Camera-Drones', 1),
(156, 43, 'Camcorders', 'Camcorders', 1),
(157, 43, 'Action Cameras', 'Action-Cameras', 1),
(158, 43, 'Photo Studio Supplies', 'Photo-Studio-Supplies', 1),
(159, 43, 'Camera & Photo Accessories', 'Camera-and-Photo-Accessories', 1),
(160, 44, 'Earphones & Headphones', 'Earphones-and-Headphones', 1),
(161, 44, 'Speakers', 'Speakers', 1),
(162, 44, 'MP3 players', 'MP3-players', 1),
(163, 44, 'Microphones', 'Microphones', 1),
(164, 44, 'VR/AR Devices', 'VR-AR-Devices', 1),
(165, 45, 'Wearable Devices', 'Wearable-Devices', 1),
(166, 45, 'Smart Home Appliances', 'Smart-Home-Appliances', 1),
(167, 45, 'Smart Remote Controls', 'Smart-Remote-Controls', 1),
(168, 45, 'Smart Wearable Accessiories', 'Smart-Wearable-Accessiories', 1),
(169, 45, 'Smart Watches', 'Smart-Watches', 1),
(170, 45, 'Smart Wristbands', 'Smart-Wristbands', 1),
(171, 46, 'Handheld Game Players', 'Handheld-Game-Players', 1),
(172, 46, 'Game Controllers', 'Game-Controllers', 1),
(173, 46, 'Joysticks', 'Joysticks', 1),
(174, 46, 'Stickers', 'Stickers', 1),
(175, 47, '925 Silver Jewelry', '925-Silver-Jewelry', 1),
(176, 47, 'Diamond jwelry', 'Diamond-jwelry', 1),
(177, 47, 'Pearl', 'Pearl', 1),
(178, 47, 'Gemstones', 'Gemstones', 1),
(179, 47, 'K-Gold', 'k-gold', 1),
(180, 47, 'Fine earrings', 'Fine-earrings', 1),
(181, 47, 'Fine Jewelry set', 'Fine-Jewelry-set', 1),
(182, 47, 'Men\'s Fine Jewelry', 'Men-Fine-Jewelry', 1),
(183, 48, 'Bridal Jewelry Sets', 'Bridal-Jewelry-Sets', 1),
(184, 48, 'Engagement Rings', 'Engagement-Rings', 1),
(185, 48, 'Wedding Hair jewelry', 'Wedding-Hair-jewelry', 1),
(186, 49, 'Mechanical Watches', 'Mechanical-Watches', 1),
(187, 49, 'Quartz Watches', 'Quartz-Watches', 1),
(188, 49, 'Digital Watches', 'Digital-Watches', 1),
(189, 49, 'Dual Display Watches', 'Dual-Display-Watches', 1),
(190, 49, 'Sports Watches', 'Sports-Watches', 1),
(191, 50, 'Women\'s Bracelet watches', 'Women-Bracelet-watches', 1),
(192, 50, 'Elegant Watches', 'Elegant-Watches', 1),
(193, 50, 'Romantic Watches', 'Romantic-Watches', 1),
(194, 50, 'Sports Watches', 'Sports-Watches', 1),
(195, 50, 'Innovative Watches', 'Innovative-Watches', 1),
(196, 51, 'Necklaces & Pendants', 'Necklaces-and-Pendants', 1),
(197, 51, 'Trendy Rings', 'Trendy-Rings', 1),
(198, 51, 'Trendy Earrings', 'Trendy-Earrings', 1),
(199, 51, 'Men\'s Cuff Links', 'Men-Cuff-Links', 1),
(200, 51, 'Fashion Jerelry Sets', 'Fashion-Jerelry-Sets', 1),
(201, 51, 'Charms', 'Charms', 1),
(202, 51, 'Body Jewelry', 'Body-Jewelry', 1),
(203, 52, 'Beads', 'Beads', 1),
(204, 52, 'Jwelry Findings & Components', 'Jwelry-Findings-and-Components', 1),
(205, 52, 'Jwelry packaging & Displays', 'Jwelry-packaging-and-Displays', 1),
(206, 53, 'Sweing', 'Sweing', 1),
(207, 53, 'Needle Arts', 'Needle-Arts', 1),
(208, 53, 'Scrapbooking and stamps', 'Scrapbooking-and-stamps', 1),
(209, 53, '5D DIY Diamond Painting', '5D-DIY-Diamond-Painting', 1),
(210, 54, 'Paintings', 'Paintings', 1),
(211, 54, 'Wall stickers', 'Wall-stickers', 1),
(212, 54, 'Wall clocks', 'Wall-clocks', 1),
(213, 55, 'Cushions', 'Cushions', 1),
(214, 55, 'Curtains', 'Curtains', 1),
(215, 55, 'Bedding Sets', 'Bedding-Sets', 1),
(216, 55, 'Beach Towels', 'Beach-Towels', 1),
(217, 56, 'Events', 'Beach-Towels', 1),
(218, 56, 'Ballons', 'Ballons', 1),
(219, 56, 'Artificial flowers', 'Artificial-flowers', 1),
(220, 56, 'Gift bags', 'Gift-bags', 1),
(221, 57, 'Storage boxes', 'Storage-boxes', 1),
(222, 57, 'Drawer Organizers', 'Drawer-Organizers', 1),
(223, 57, 'Makeup Organizers', 'Makeup-Organizers', 1),
(224, 58, 'Umbrellas', 'Umbrellas', 1),
(225, 58, 'Bathroom Scales', 'Bathroom-Scales', 1),
(226, 58, 'Sweepers', 'sweepers', 1),
(227, 59, 'Bakeware', 'Bakeware', 1),
(228, 59, 'Drinkware', 'Drinkware', 1),
(229, 59, 'Kitchen tools', 'Kitchen-tools', 1),
(230, 59, 'Knifes', 'Knifes', 1),
(231, 60, 'Irrigating kits', 'Irrigating-kits', 1),
(232, 60, 'Flowers pots and planters', 'Flowers-pots-and-planters', 1),
(233, 60, 'Repellents', 'Repellents', 1),
(234, 60, 'Garden Water Timers', 'Garden-Water-Timers', 1),
(235, 61, 'Home furniture', 'Home-furniture', 1),
(236, 61, 'Office furniture', 'Office-furniture', 1),
(237, 61, 'Outdoor furniture', 'Office-furniture', 1),
(238, 61, 'Top furniture stores', 'Top-furniture-stores', 1),
(239, 62, 'Stylish backpacks', 'stylish-backpacks', 1),
(240, 62, 'Totes', 'totes', 1),
(241, 62, 'Shoulder bags', 'shoulder-bags', 1),
(242, 62, 'Wallets', 'wallets', 1),
(243, 62, 'Evening Bags', 'Evening-bags', 1),
(244, 62, 'Clutches', 'clutches', 1),
(245, 63, 'Women Sandals', 'Women-Sandals', 1),
(246, 63, 'Flats', 'flats', 1),
(247, 63, 'High Heels', 'High-heels', 1),
(248, 62, 'Sneakers', 'Sneakers', 1),
(249, 63, 'Boots', 'boots', 1),
(250, 64, 'Men Backpacks', 'Men-Backpacks', 1),
(251, 67, 'Crossbody Bags', 'Crossbody-Bags', 1),
(252, 64, 'Luggages', 'Luggages', 1),
(253, 64, 'Wallets', 'wallet', 1),
(254, 65, 'Casual', 'causal', 1),
(255, 65, 'Sneakers', 'Sneaker', 1),
(256, 65, 'Sandals', 'sandals', 1),
(257, 65, 'Loafers', 'loafers', 1),
(258, 65, 'Flip Flop', 'flipflop', 1),
(259, 65, 'Boots', 'boot', 1),
(260, 66, 'Kids bags', 'kids-bag', 1),
(261, 66, 'Cosmetic bags', 'Cosmetic-bags', 1),
(262, 67, 'Wallet and card holders', 'Wallet-and-card-holders', 1),
(263, 66, 'Luggage Covers', 'luggage-covers', 1),
(264, 66, 'Passport Covers', 'passport-covers', 1),
(265, 66, 'Bag Parts and Accessories', 'Bag-Parts-and-Accessories', 1),
(266, 67, 'Wedge Sandals', 'Wedge-Sandals', 1),
(267, 67, 'Heels', 'heels', 1),
(268, 67, 'Large-Sized Flats', 'large-size-flats', 1),
(269, 67, 'Trendy Sneakers', 'trendy-sneakers', 1),
(270, 67, 'Comfortable Sandals', 'confortable-sandals', 1);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(191) NOT NULL,
  `user_id` int(191) UNSIGNED NOT NULL,
  `product_id` int(191) UNSIGNED NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `broadcasted` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` int(191) NOT NULL,
  `subject` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sent_user` int(191) NOT NULL,
  `recieved_user` int(191) NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_dispute` tinyint(1) NOT NULL DEFAULT '0',
  `closed` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`id`, `subject`, `sent_user`, `recieved_user`, `message`, `created_at`, `updated_at`, `is_dispute`, `closed`) VALUES
(1, 'OPN-1592966607-6AY2', 1, 1, 'Order #OPN-1592966607-6AY2 has been paid', '2020-06-24 02:43:48', '2020-06-24 02:43:48', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `country_code` varchar(2) NOT NULL DEFAULT '',
  `country_name` varchar(100) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `country_code`, `country_name`) VALUES
(1, 'AF', 'Afghanistan'),
(2, 'AL', 'Albania'),
(3, 'DZ', 'Algeria'),
(4, 'DS', 'American Samoa'),
(5, 'AD', 'Andorra'),
(6, 'AO', 'Angola'),
(7, 'AI', 'Anguilla'),
(8, 'AQ', 'Antarctica'),
(9, 'AG', 'Antigua and Barbuda'),
(10, 'AR', 'Argentina'),
(11, 'AM', 'Armenia'),
(12, 'AW', 'Aruba'),
(13, 'AU', 'Australia'),
(14, 'AT', 'Austria'),
(15, 'AZ', 'Azerbaijan'),
(16, 'BS', 'Bahamas'),
(17, 'BH', 'Bahrain'),
(18, 'BD', 'Bangladesh'),
(19, 'BB', 'Barbados'),
(20, 'BY', 'Belarus'),
(21, 'BE', 'Belgium'),
(22, 'BZ', 'Belize'),
(23, 'BJ', 'Benin'),
(24, 'BM', 'Bermuda'),
(25, 'BT', 'Bhutan'),
(26, 'BO', 'Bolivia'),
(27, 'BA', 'Bosnia and Herzegovina'),
(28, 'BW', 'Botswana'),
(29, 'BV', 'Bouvet Island'),
(30, 'BR', 'Brazil'),
(31, 'IO', 'British Indian Ocean Territory'),
(32, 'BN', 'Brunei Darussalam'),
(33, 'BG', 'Bulgaria'),
(34, 'BF', 'Burkina Faso'),
(35, 'BI', 'Burundi'),
(36, 'KH', 'Cambodia'),
(37, 'CM', 'Cameroon'),
(38, 'CA', 'Canada'),
(39, 'CV', 'Cape Verde'),
(40, 'KY', 'Cayman Islands'),
(41, 'CF', 'Central African Republic'),
(42, 'TD', 'Chad'),
(43, 'CL', 'Chile'),
(44, 'CN', 'China'),
(45, 'CX', 'Christmas Island'),
(46, 'CC', 'Cocos (Keeling) Islands'),
(47, 'CO', 'Colombia'),
(48, 'KM', 'Comoros'),
(49, 'CD', 'Democratic Republic of the Congo'),
(50, 'CG', 'Republic of Congo'),
(51, 'CK', 'Cook Islands'),
(52, 'CR', 'Costa Rica'),
(53, 'HR', 'Croatia (Hrvatska)'),
(54, 'CU', 'Cuba'),
(55, 'CY', 'Cyprus'),
(56, 'CZ', 'Czech Republic'),
(57, 'DK', 'Denmark'),
(58, 'DJ', 'Djibouti'),
(59, 'DM', 'Dominica'),
(60, 'DO', 'Dominican Republic'),
(61, 'TP', 'East Timor'),
(62, 'EC', 'Ecuador'),
(63, 'EG', 'Egypt'),
(64, 'SV', 'El Salvador'),
(65, 'GQ', 'Equatorial Guinea'),
(66, 'ER', 'Eritrea'),
(67, 'EE', 'Estonia'),
(68, 'ET', 'Ethiopia'),
(69, 'FK', 'Falkland Islands (Malvinas)'),
(70, 'FO', 'Faroe Islands'),
(71, 'FJ', 'Fiji'),
(72, 'FI', 'Finland'),
(73, 'FR', 'France'),
(74, 'FX', 'France, Metropolitan'),
(75, 'GF', 'French Guiana'),
(76, 'PF', 'French Polynesia'),
(77, 'TF', 'French Southern Territories'),
(78, 'GA', 'Gabon'),
(79, 'GM', 'Gambia'),
(80, 'GE', 'Georgia'),
(81, 'DE', 'Germany'),
(82, 'GH', 'Ghana'),
(83, 'GI', 'Gibraltar'),
(84, 'GK', 'Guernsey'),
(85, 'GR', 'Greece'),
(86, 'GL', 'Greenland'),
(87, 'GD', 'Grenada'),
(88, 'GP', 'Guadeloupe'),
(89, 'GU', 'Guam'),
(90, 'GT', 'Guatemala'),
(91, 'GN', 'Guinea'),
(92, 'GW', 'Guinea-Bissau'),
(93, 'GY', 'Guyana'),
(94, 'HT', 'Haiti'),
(95, 'HM', 'Heard and Mc Donald Islands'),
(96, 'HN', 'Honduras'),
(97, 'HK', 'Hong Kong'),
(98, 'HU', 'Hungary'),
(99, 'IS', 'Iceland'),
(100, 'IN', 'India'),
(101, 'IM', 'Isle of Man'),
(102, 'ID', 'Indonesia'),
(103, 'IR', 'Iran (Islamic Republic of)'),
(104, 'IQ', 'Iraq'),
(105, 'IE', 'Ireland'),
(106, 'IL', 'Israel'),
(107, 'IT', 'Italy'),
(108, 'CI', 'Ivory Coast'),
(109, 'JE', 'Jersey'),
(110, 'JM', 'Jamaica'),
(111, 'JP', 'Japan'),
(112, 'JO', 'Jordan'),
(113, 'KZ', 'Kazakhstan'),
(114, 'KE', 'Kenya'),
(115, 'KI', 'Kiribati'),
(116, 'KP', 'Korea, Democratic People\'s Republic of'),
(117, 'KR', 'Korea, Republic of'),
(118, 'XK', 'Kosovo'),
(119, 'KW', 'Kuwait'),
(120, 'KG', 'Kyrgyzstan'),
(121, 'LA', 'Lao People\'s Democratic Republic'),
(122, 'LV', 'Latvia'),
(123, 'LB', 'Lebanon'),
(124, 'LS', 'Lesotho'),
(125, 'LR', 'Liberia'),
(126, 'LY', 'Libyan Arab Jamahiriya'),
(127, 'LI', 'Liechtenstein'),
(128, 'LT', 'Lithuania'),
(129, 'LU', 'Luxembourg'),
(130, 'MO', 'Macau'),
(131, 'MK', 'North Macedonia'),
(132, 'MG', 'Madagascar'),
(133, 'MW', 'Malawi'),
(134, 'MY', 'Malaysia'),
(135, 'MV', 'Maldives'),
(136, 'ML', 'Mali'),
(137, 'MT', 'Malta'),
(138, 'MH', 'Marshall Islands'),
(139, 'MQ', 'Martinique'),
(140, 'MR', 'Mauritania'),
(141, 'MU', 'Mauritius'),
(142, 'TY', 'Mayotte'),
(143, 'MX', 'Mexico'),
(144, 'FM', 'Micronesia, Federated States of'),
(145, 'MD', 'Moldova, Republic of'),
(146, 'MC', 'Monaco'),
(147, 'MN', 'Mongolia'),
(148, 'ME', 'Montenegro'),
(149, 'MS', 'Montserrat'),
(150, 'MA', 'Morocco'),
(151, 'MZ', 'Mozambique'),
(152, 'MM', 'Myanmar'),
(153, 'NA', 'Namibia'),
(154, 'NR', 'Nauru'),
(155, 'NP', 'Nepal'),
(156, 'NL', 'Netherlands'),
(157, 'AN', 'Netherlands Antilles'),
(158, 'NC', 'New Caledonia'),
(159, 'NZ', 'New Zealand'),
(160, 'NI', 'Nicaragua'),
(161, 'NE', 'Niger'),
(162, 'NG', 'Nigeria'),
(163, 'NU', 'Niue'),
(164, 'NF', 'Norfolk Island'),
(165, 'MP', 'Northern Mariana Islands'),
(166, 'NO', 'Norway'),
(167, 'OM', 'Oman'),
(168, 'PK', 'Pakistan'),
(169, 'PW', 'Palau'),
(170, 'PS', 'Palestine'),
(171, 'PA', 'Panama'),
(172, 'PG', 'Papua New Guinea'),
(173, 'PY', 'Paraguay'),
(174, 'PE', 'Peru'),
(175, 'PH', 'Philippines'),
(176, 'PN', 'Pitcairn'),
(177, 'PL', 'Poland'),
(178, 'PT', 'Portugal'),
(179, 'PR', 'Puerto Rico'),
(180, 'QA', 'Qatar'),
(181, 'RE', 'Reunion'),
(182, 'RO', 'Romania'),
(183, 'RU', 'Russian Federation'),
(184, 'RW', 'Rwanda'),
(185, 'KN', 'Saint Kitts and Nevis'),
(186, 'LC', 'Saint Lucia'),
(187, 'VC', 'Saint Vincent and the Grenadines'),
(188, 'WS', 'Samoa'),
(189, 'SM', 'San Marino'),
(190, 'ST', 'Sao Tome and Principe'),
(191, 'SA', 'Saudi Arabia'),
(192, 'SN', 'Senegal'),
(193, 'RS', 'Serbia'),
(194, 'SC', 'Seychelles'),
(195, 'SL', 'Sierra Leone'),
(196, 'SG', 'Singapore'),
(197, 'SK', 'Slovakia'),
(198, 'SI', 'Slovenia'),
(199, 'SB', 'Solomon Islands'),
(200, 'SO', 'Somalia'),
(201, 'ZA', 'South Africa'),
(202, 'GS', 'South Georgia South Sandwich Islands'),
(203, 'SS', 'South Sudan'),
(204, 'ES', 'Spain'),
(205, 'LK', 'Sri Lanka'),
(206, 'SH', 'St. Helena'),
(207, 'PM', 'St. Pierre and Miquelon'),
(208, 'SD', 'Sudan'),
(209, 'SR', 'Suriname'),
(210, 'SJ', 'Svalbard and Jan Mayen Islands'),
(211, 'SZ', 'Swaziland'),
(212, 'SE', 'Sweden'),
(213, 'CH', 'Switzerland'),
(214, 'SY', 'Syrian Arab Republic'),
(215, 'TW', 'Taiwan'),
(216, 'TJ', 'Tajikistan'),
(217, 'TZ', 'Tanzania, United Republic of'),
(218, 'TH', 'Thailand'),
(219, 'TG', 'Togo'),
(220, 'TK', 'Tokelau'),
(221, 'TO', 'Tonga'),
(222, 'TT', 'Trinidad and Tobago'),
(223, 'TN', 'Tunisia'),
(224, 'TR', 'Turkey'),
(225, 'TM', 'Turkmenistan'),
(226, 'TC', 'Turks and Caicos Islands'),
(227, 'TV', 'Tuvalu'),
(228, 'UG', 'Uganda'),
(229, 'UA', 'Ukraine'),
(230, 'AE', 'United Arab Emirates'),
(231, 'GB', 'United Kingdom'),
(232, 'US', 'United States'),
(233, 'UM', 'United States minor outlying islands'),
(234, 'UY', 'Uruguay'),
(235, 'UZ', 'Uzbekistan'),
(236, 'VU', 'Vanuatu'),
(237, 'VA', 'Vatican City State'),
(238, 'VE', 'Venezuela'),
(239, 'VN', 'Vietnam'),
(240, 'VG', 'Virgin Islands (British)'),
(241, 'VI', 'Virgin Islands (U.S.)'),
(242, 'WF', 'Wallis and Futuna Islands'),
(243, 'EH', 'Western Sahara'),
(244, 'YE', 'Yemen'),
(245, 'ZM', 'Zambia'),
(246, 'ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(11) NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint(4) NOT NULL,
  `price` double NOT NULL,
  `times` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `used` int(191) UNSIGNED NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(191) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sign` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` double NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `sign`, `value`, `is_default`) VALUES
(10, 'Rupees', 'Nrs', 120, 1);

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `title`, `details`, `status`) VALUES
(1, 'How does it work?', '<span style=\"color: rgb(70, 85, 65); font-family: \" open=\"\" sans\",=\"\" sans-serif;=\"\" font-size:=\"\" 16px;\"=\"\">Nam enim risus, molestie et, porta ac, aliquam ac, risus. Quisque lobortis. Phasellus pellentesque purus in massa. Aenean in pede. Phasellus ac libero ac tellus pellentesque semper. Sed ac felis. Sed commodo, magna quis lacinia ornare, quam ante aliquam nisi, eu iaculis leo purus venenatis dui.</span><br>', 1);

-- --------------------------------------------------------

--
-- Table structure for table `favorite_sellers`
--

CREATE TABLE `favorite_sellers` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL,
  `vendor_id` int(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `galleries`
--

CREATE TABLE `galleries` (
  `id` int(191) UNSIGNED NOT NULL,
  `product_id` int(191) UNSIGNED NOT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `galleries`
--

INSERT INTO `galleries` (`id`, `product_id`, `photo`) VALUES
(6, 93, '156801646314-min.jpg'),
(7, 93, '156801646315-min.jpg'),
(8, 93, '156801646316-min.jpg'),
(22, 129, '15680254328Ei8T0MB.jpg'),
(23, 129, '1568025432wRmpve8d.jpg'),
(24, 129, '1568025432kkRYzLsF.jpg'),
(25, 129, '1568025432zxQBe6Gk.jpg'),
(26, 128, '1568025537sJbDPnFk.jpg'),
(27, 128, '1568025537NBmHxJOz.jpg'),
(28, 128, '1568025537hxqeFbS8.jpg'),
(29, 128, '1568025538zK3tJpmL.jpg'),
(34, 126, '1568025693kKLReNYO.jpg'),
(35, 126, '1568025694Iv3pkz1q.jpg'),
(36, 126, '1568025694T8HhdLVS.jpg'),
(37, 126, '1568025695vTdg7ndt.jpg'),
(38, 125, '15680257894Waz2tuN.jpg'),
(39, 125, '1568025789vd0P4TBv.jpg'),
(40, 125, '15680257899bih5sGh.jpg'),
(41, 125, '156802578924sLIgzl.jpg'),
(42, 124, '1568025825cC2Pmuit.jpg'),
(43, 124, '1568025825EACzLFld.jpg'),
(44, 124, '1568025825MfCyCqtD.jpg'),
(45, 124, '15680258252yabMeAz.jpg'),
(46, 123, '15680258512fKQla5g.jpg'),
(47, 123, '1568025851pIjl0mWp.jpg'),
(48, 123, '1568025851tQw7JXXG.jpg'),
(49, 123, '1568025851ewjtSDkZ.jpg'),
(50, 96, '1568025891wWAAbOjc.jpg'),
(51, 96, '1568025891fyMNeXRy.jpg'),
(52, 96, '1568025891OdV64Tw1.jpg'),
(53, 96, '1568025891xQF7Zufe.jpg'),
(58, 102, '1568026307THs0VQQU.jpg'),
(59, 102, '1568026307jvCscHth.jpg'),
(60, 102, '1568026307g5xMFdx3.jpg'),
(61, 102, '1568026307Z3at0HEM.jpg'),
(62, 101, '1568026331Y6UMgMcI.jpg'),
(63, 101, '1568026331xZbT4OWG.jpg'),
(64, 101, '1568026331y7eIFJXZ.jpg'),
(65, 101, '1568026331i2wH8RI0.jpg'),
(66, 100, '1568026374xCTjQYZ8.jpg'),
(67, 100, '1568026374DzmvqA9d.jpg'),
(68, 100, '1568026374OEH73u5X.jpg'),
(69, 100, '1568026374vZhqRv8c.jpg'),
(70, 99, '15680264120LdBSU1v.jpg'),
(71, 99, '1568026412eMjsI940.jpg'),
(72, 99, '1568026412GFjvHiZv.jpg'),
(73, 99, '15680264122fwGi20d.jpg'),
(78, 97, '1568026469hSlmBpzE.jpg'),
(79, 97, '15680264697AI8LicQ.jpg'),
(80, 97, '15680264691xyFt5Y6.jpg'),
(81, 97, '1568026469dC3hrMz0.jpg'),
(86, 109, '1568026737EBGSE78G.jpg'),
(87, 109, '1568026737B8hO1RRr.jpg'),
(88, 109, '1568026737tf0rwVoz.jpg'),
(89, 109, '1568026737GGIPSqYo.jpg'),
(95, 107, '1568026797FFNrNPxK.jpg'),
(96, 107, '1568026797UwY9ZLfQ.jpg'),
(97, 107, '1568026797Kl6eZLx5.jpg'),
(98, 107, '1568026797h3R48VaO.jpg'),
(99, 107, '15680267989kXwH40I.jpg'),
(100, 106, '1568026836ErM5FJxg.jpg'),
(101, 106, '1568026836VLrxIk0u.jpg'),
(102, 106, '1568026836lgLuMV6p.jpg'),
(103, 106, '1568026836JBUTQX8v.jpg'),
(104, 105, '1568026861YorsLvUa.jpg'),
(105, 105, '1568026861PikoX1Qb.jpg'),
(106, 105, '1568026861SBJqjw66.jpg'),
(107, 105, '1568026861WYh54Arp.jpg'),
(108, 104, '1568026885rmo0LDoo.jpg'),
(109, 104, '15680268851m939o7O.jpg'),
(110, 104, '1568026885fVXYCGKu.jpg'),
(111, 104, '1568026885GDRL3thY.jpg'),
(112, 103, '1568026903LbVQUxIr.jpg'),
(113, 103, '1568026914IpRVYDV4.jpg'),
(114, 103, '15680269141gKO8x5X.jpg'),
(115, 103, '1568026914Q938xXM2.jpg'),
(116, 93, '1568026950y7ihS4wE.jpg'),
(125, 122, '1568027503rFK94cnU.jpg'),
(126, 122, '1568027503i1X2FtIi.jpg'),
(127, 122, '156802750316jxawoZ.jpg'),
(128, 122, '1568027503QRBf290F.jpg'),
(129, 121, '1568027539SQqUc8Bu.jpg'),
(130, 121, '1568027539Zs5OTzjq.jpg'),
(131, 121, '1568027539C45VRZq1.jpg'),
(132, 121, '15680275398ovCzFnJ.jpg'),
(133, 120, '1568027565bJgX744G.jpg'),
(134, 120, '1568027565j0RPFUgX.jpg'),
(135, 120, '1568027565QGi6Lhyo.jpg'),
(136, 120, '15680275658MAY3VKp.jpg'),
(137, 119, '1568027610p9R6ivC6.jpg'),
(138, 119, '1568027610t2Aq7E5D.jpg'),
(139, 119, '1568027611ikz4n0fx.jpg'),
(140, 119, '15680276117BLgrCub.jpg'),
(141, 118, '156802763634t0c8tG.jpg'),
(142, 118, '1568027636fuJplSf3.jpg'),
(143, 118, '1568027636MXcgCQHU.jpg'),
(144, 118, '1568027636lfexGTpt.jpg'),
(145, 117, '1568027665rFHWlsAJ.jpg'),
(146, 117, '15680276655LPktA9k.jpg'),
(147, 117, '1568027665vcNWWq3u.jpg'),
(148, 117, '1568027665gQnqKhCw.jpg'),
(149, 116, '1568027692FPQpwtWN.jpg'),
(150, 116, '1568027692zBaGjOIC.jpg'),
(151, 116, '1568027692UXpDx63F.jpg'),
(152, 116, '1568027692KdIWbIGK.jpg'),
(153, 95, '1568027743xS8gHocM.jpg'),
(154, 95, '1568027743aVUOljdD.jpg'),
(155, 95, '156802774327OOA1Zj.jpg'),
(156, 95, '1568027743kGBx6mxa.jpg'),
(172, 130, '1568029084hQT5ZO0j.jpg'),
(173, 130, '1568029084ncGXxQzN.jpg'),
(174, 130, '1568029084b0OonKFy.jpg'),
(175, 130, '15680290857TD4iOWP.jpg'),
(180, 114, '1568029158brS7xQCe.jpg'),
(181, 114, '1568029158QlC0tg5a.jpg'),
(182, 114, '1568029158RrN4AEtQ.jpg'),
(187, 112, '1568029210JSAwjRPr.jpg'),
(188, 112, '1568029210EiVUkcK6.jpg'),
(189, 112, '1568029210fJSo5hya.jpg'),
(190, 112, '15680292101vCcGfq8.jpg'),
(191, 111, '1568029272lB0JETcn.jpg'),
(192, 111, '1568029272wF3ldKgv.jpg'),
(193, 111, '1568029272NI33ExCu.jpg'),
(194, 111, '15680292724TXrpokz.jpg'),
(197, 134, '15693932021.jpg'),
(198, 134, '15693932022.jpg'),
(199, 135, '15698200931.jpg'),
(217, 159, '1570085246audi-automobile-car-909907.jpg'),
(218, 159, '1570085246automobile-automotive-car-112460.jpg'),
(219, 160, '1570085654asphalt-auto-automobile-575386.jpg'),
(220, 160, '1570085654asphalt-auto-automobile-831475.jpg'),
(221, 161, '1570086479audi-automobile-car-909907.jpg'),
(222, 162, '1570255905asphalt-auto-automobile-831475.jpg'),
(223, 162, '1570255905audi-automobile-car-909907.jpg'),
(224, 167, '1570874976asphalt-auto-automobile-831475.jpg'),
(225, 167, '1570874976audi-automobile-car-909907.jpg'),
(226, 167, '1570874976automobile-automotive-car-112460.jpg'),
(227, 168, '1570875445automobile-automotive-car-112460.jpg'),
(228, 168, '1570875445automobile-automotive-car-358070.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `generalsettings`
--

CREATE TABLE `generalsettings` (
  `id` int(191) NOT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favicon` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `header_email` text COLLATE utf8mb4_unicode_ci,
  `header_phone` text COLLATE utf8mb4_unicode_ci,
  `footer` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `copyright` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `colors` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loader` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_loader` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_talkto` tinyint(1) NOT NULL DEFAULT '1',
  `talkto` text COLLATE utf8mb4_unicode_ci,
  `is_language` tinyint(1) NOT NULL DEFAULT '1',
  `is_loader` tinyint(1) NOT NULL DEFAULT '1',
  `map_key` text COLLATE utf8mb4_unicode_ci,
  `is_disqus` tinyint(1) NOT NULL DEFAULT '0',
  `disqus` longtext COLLATE utf8mb4_unicode_ci,
  `is_contact` tinyint(1) NOT NULL DEFAULT '0',
  `is_faq` tinyint(1) NOT NULL DEFAULT '0',
  `guest_checkout` tinyint(1) NOT NULL DEFAULT '0',
  `stripe_check` tinyint(1) NOT NULL DEFAULT '0',
  `cod_check` tinyint(1) NOT NULL DEFAULT '0',
  `stripe_key` text COLLATE utf8mb4_unicode_ci,
  `stripe_secret` text COLLATE utf8mb4_unicode_ci,
  `currency_format` tinyint(1) NOT NULL DEFAULT '0',
  `withdraw_fee` double NOT NULL DEFAULT '0',
  `withdraw_charge` double NOT NULL DEFAULT '0',
  `tax` double NOT NULL DEFAULT '0',
  `shipping_cost` double NOT NULL DEFAULT '0',
  `smtp_host` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `smtp_port` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `smtp_user` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `smtp_pass` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_smtp` tinyint(1) NOT NULL DEFAULT '0',
  `is_comment` tinyint(1) NOT NULL DEFAULT '1',
  `is_currency` tinyint(1) NOT NULL DEFAULT '1',
  `add_cart` text COLLATE utf8mb4_unicode_ci,
  `out_stock` text COLLATE utf8mb4_unicode_ci,
  `add_wish` text COLLATE utf8mb4_unicode_ci,
  `already_wish` text COLLATE utf8mb4_unicode_ci,
  `wish_remove` text COLLATE utf8mb4_unicode_ci,
  `add_compare` text COLLATE utf8mb4_unicode_ci,
  `already_compare` text COLLATE utf8mb4_unicode_ci,
  `compare_remove` text COLLATE utf8mb4_unicode_ci,
  `color_change` text COLLATE utf8mb4_unicode_ci,
  `coupon_found` text COLLATE utf8mb4_unicode_ci,
  `no_coupon` text COLLATE utf8mb4_unicode_ci,
  `already_coupon` text COLLATE utf8mb4_unicode_ci,
  `order_title` text COLLATE utf8mb4_unicode_ci,
  `order_text` text COLLATE utf8mb4_unicode_ci,
  `is_affilate` tinyint(1) NOT NULL DEFAULT '1',
  `affilate_charge` int(100) NOT NULL DEFAULT '0',
  `affilate_banner` text COLLATE utf8mb4_unicode_ci,
  `already_cart` text COLLATE utf8mb4_unicode_ci,
  `fixed_commission` double NOT NULL DEFAULT '0',
  `percentage_commission` double NOT NULL DEFAULT '0',
  `multiple_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `multiple_packaging` tinyint(4) NOT NULL DEFAULT '0',
  `vendor_ship_info` tinyint(1) NOT NULL DEFAULT '0',
  `reg_vendor` tinyint(1) NOT NULL DEFAULT '0',
  `cod_text` text COLLATE utf8mb4_unicode_ci,
  `paypal_text` text COLLATE utf8mb4_unicode_ci,
  `stripe_text` text COLLATE utf8mb4_unicode_ci,
  `header_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `copyright_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_admin_loader` tinyint(1) NOT NULL DEFAULT '0',
  `menu_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu_hover_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_home` tinyint(1) NOT NULL DEFAULT '0',
  `is_verification_email` tinyint(1) NOT NULL DEFAULT '0',
  `instamojo_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instamojo_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instamojo_text` text COLLATE utf8mb4_unicode_ci,
  `is_instamojo` tinyint(1) NOT NULL DEFAULT '0',
  `instamojo_sandbox` tinyint(1) NOT NULL DEFAULT '0',
  `is_paystack` tinyint(1) NOT NULL DEFAULT '0',
  `paystack_key` text COLLATE utf8mb4_unicode_ci,
  `paystack_email` text COLLATE utf8mb4_unicode_ci,
  `paystack_text` text COLLATE utf8mb4_unicode_ci,
  `wholesell` int(191) NOT NULL DEFAULT '0',
  `is_capcha` tinyint(1) NOT NULL DEFAULT '0',
  `error_banner` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_popup` tinyint(1) NOT NULL DEFAULT '0',
  `popup_title` text COLLATE utf8mb4_unicode_ci,
  `popup_text` text COLLATE utf8mb4_unicode_ci,
  `popup_background` text COLLATE utf8mb4_unicode_ci,
  `invoice_logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendor_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_secure` tinyint(1) NOT NULL DEFAULT '0',
  `is_report` tinyint(1) NOT NULL,
  `paypal_check` tinyint(1) DEFAULT '0',
  `paypal_business` text COLLATE utf8mb4_unicode_ci,
  `footer_logo` text COLLATE utf8mb4_unicode_ci,
  `email_encryption` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paytm_merchant` text COLLATE utf8mb4_unicode_ci,
  `paytm_secret` text COLLATE utf8mb4_unicode_ci,
  `paytm_website` text COLLATE utf8mb4_unicode_ci,
  `paytm_industry` text COLLATE utf8mb4_unicode_ci,
  `is_paytm` int(11) NOT NULL DEFAULT '1',
  `paytm_text` text COLLATE utf8mb4_unicode_ci,
  `paytm_mode` enum('sandbox','live') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `is_molly` tinyint(1) NOT NULL DEFAULT '0',
  `molly_key` text COLLATE utf8mb4_unicode_ci,
  `molly_text` text COLLATE utf8mb4_unicode_ci,
  `is_razorpay` int(11) NOT NULL DEFAULT '1',
  `razorpay_key` text COLLATE utf8mb4_unicode_ci,
  `razorpay_secret` text COLLATE utf8mb4_unicode_ci,
  `razorpay_text` text COLLATE utf8mb4_unicode_ci,
  `show_stock` tinyint(1) NOT NULL DEFAULT '0',
  `is_maintain` tinyint(1) NOT NULL DEFAULT '0',
  `maintain_text` text COLLATE utf8mb4_unicode_ci
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `generalsettings`
--

INSERT INTO `generalsettings` (`id`, `logo`, `favicon`, `title`, `header_email`, `header_phone`, `footer`, `copyright`, `colors`, `loader`, `admin_loader`, `is_talkto`, `talkto`, `is_language`, `is_loader`, `map_key`, `is_disqus`, `disqus`, `is_contact`, `is_faq`, `guest_checkout`, `stripe_check`, `cod_check`, `stripe_key`, `stripe_secret`, `currency_format`, `withdraw_fee`, `withdraw_charge`, `tax`, `shipping_cost`, `smtp_host`, `smtp_port`, `smtp_user`, `smtp_pass`, `from_email`, `from_name`, `is_smtp`, `is_comment`, `is_currency`, `add_cart`, `out_stock`, `add_wish`, `already_wish`, `wish_remove`, `add_compare`, `already_compare`, `compare_remove`, `color_change`, `coupon_found`, `no_coupon`, `already_coupon`, `order_title`, `order_text`, `is_affilate`, `affilate_charge`, `affilate_banner`, `already_cart`, `fixed_commission`, `percentage_commission`, `multiple_shipping`, `multiple_packaging`, `vendor_ship_info`, `reg_vendor`, `cod_text`, `paypal_text`, `stripe_text`, `header_color`, `footer_color`, `copyright_color`, `is_admin_loader`, `menu_color`, `menu_hover_color`, `is_home`, `is_verification_email`, `instamojo_key`, `instamojo_token`, `instamojo_text`, `is_instamojo`, `instamojo_sandbox`, `is_paystack`, `paystack_key`, `paystack_email`, `paystack_text`, `wholesell`, `is_capcha`, `error_banner`, `is_popup`, `popup_title`, `popup_text`, `popup_background`, `invoice_logo`, `user_image`, `vendor_color`, `is_secure`, `is_report`, `paypal_check`, `paypal_business`, `footer_logo`, `email_encryption`, `paytm_merchant`, `paytm_secret`, `paytm_website`, `paytm_industry`, `is_paytm`, `paytm_text`, `paytm_mode`, `is_molly`, `molly_key`, `molly_text`, `is_razorpay`, `razorpay_key`, `razorpay_secret`, `razorpay_text`, `show_stock`, `is_maintain`, `maintain_text`) VALUES
(1, '1596094837logo_mayra.png', '1596094683mayra_fav.jpg', 'MayraSales', 'Info@example.com', '0123 456789', 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae', 'COPYRIGHT © 2020 <a href=\"http://opnmarket.com/\" class=\"steem-keychain-checked\">opnmarket.com</a>', '#0f78f2', '1564224328loading3.gif', '1564224329loading3.gif', 0, '<script type=\"text/javascript\">\r\nvar Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();\r\n(function(){\r\nvar s1=document.createElement(\"script\"),s0=document.getElementsByTagName(\"script\")[0];\r\ns1.async=true;\r\ns1.src=\'https://embed.tawk.to/5bc2019c61d0b77092512d03/default\';\r\ns1.charset=\'UTF-8\';\r\ns1.setAttribute(\'crossorigin\',\'*\');\r\ns0.parentNode.insertBefore(s1,s0);\r\n})();\r\n</script>', 0, 1, 'AIzaSyB1GpE4qeoJ__70UZxvX9CTMUTZRZNHcu8', 0, '<div id=\"disqus_thread\">         \r\n    <script>\r\n    /**\r\n    *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.\r\n    *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/\r\n    /*\r\n    var disqus_config = function () {\r\n    this.page.url = PAGE_URL;  // Replace PAGE_URL with your page\'s canonical URL variable\r\n    this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page\'s unique identifier variable\r\n    };\r\n    */\r\n    (function() { // DON\'T EDIT BELOW THIS LINE\r\n    var d = document, s = d.createElement(\'script\');\r\n    s.src = \'https://junnun.disqus.com/embed.js\';\r\n    s.setAttribute(\'data-timestamp\', +new Date());\r\n    (d.head || d.body).appendChild(s);\r\n    })();\r\n    </script>\r\n    <noscript>Please enable JavaScript to view the <a href=\"https://disqus.com/?ref_noscript\">comments powered by Disqus.</a></noscript>\r\n    </div>', 0, 1, 0, 0, 0, 'pk_test_UnU1Coi1p5qFGwtpjZMRMgJM', 'sk_test_QQcg3vGsKRPlW6T3dXcNJsor', 0, 0, 0, 0, 5, 'in-v3.mailjet.com', '587', '0e05029e2dc70da691aa2223aa53c5be', '5df1b6242e86bce602c3fd9adc178460', 'admin@geniusocean.com', 'GeniusOcean', 1, 1, 1, 'Successfully Added To Cart', 'Out Of Stock', 'Add To Wishlist', 'Already Added To Wishlist', 'Successfully Removed From The Wishlist', 'Successfully Added To Compare', 'Already Added To Compare', 'Successfully Removed From The Compare', 'Successfully Changed The Color', 'Coupon Found', 'No Coupon Found', 'Coupon Already Applied', 'THANK YOU FOR YOUR PURCHASE.', 'We\'ll email you an order confirmation with details and tracking info.', 1, 8, '15587771131554048228onepiece.jpeg', 'Already Added To Cart', 0, 0, 1, 1, 1, 1, 'Pay with cash upon delivery.', 'Pay via your PayPal account.', 'Pay via your Credit Card.', '#ffffff', '#143250', '#02020c', 1, '#ff5500', '#02020c', 0, 0, 'test_172371aa837ae5cad6047dc3052', 'test_4ac5a785e25fc596b67dbc5c267', 'Pay via your Instamojo account.', 0, 1, 0, 'pk_test_162a56d42131cbb01932ed0d2c48f9cb99d8e8e2', 'junnuns@gmail.com', 'Pay via your Paystack account.', 6, 0, '1566878455404.png', 0, 'NEWSLETTER', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Expedita porro ipsa nulla, alias, ab minus.', '1567488562subscribe.jpg', '1596094848logo_mayra.png', '1567655174profile.jpg', '#666666', 0, 1, 1, 'shaon143-facilitator-1@gmail.com', '1596094843logo_mayra.png', 'tls', 'tkogux49985047638244', 'LhNGUUKE9xCQ9xY8', 'WEBSTAGING', 'Retail', 1, 'Pay via your Paytm account.', 'live', 0, 'test_5HcWVs9qc5pzy36H9Tu9mwAyats33J', 'Pay with Molly Payment.', 0, 'rzp_test_xDH74d48cwl8DF', 'cr0H1BiQ20hVzhpHfHuNbGri', 'Pay via your Razorpay account.', 0, 0, '<div style=\"text-align: center;\"><font size=\"5\"><br></font></div><h1 style=\"text-align: center;\"><font size=\"6\">UNDER MAINTENANCE</font></h1>');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(191) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `language` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `is_default`, `language`, `file`) VALUES
(1, 1, 'English', '1570967282kjZ4U7oI.json'),
(2, 0, 'RTL English', '1571461774YqGWmWmv.json');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(191) NOT NULL,
  `conversation_id` int(191) NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sent_user` int(191) DEFAULT NULL,
  `recieved_user` int(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `conversation_id`, `message`, `sent_user`, `recieved_user`, `created_at`, `updated_at`) VALUES
(1, 1, 'Order OPN-1592966607-6AY2 has been paid. This message is for discussing the order', 0, NULL, '2020-06-24 02:43:48', '2020-06-24 02:43:48');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(191) NOT NULL,
  `order_id` int(191) UNSIGNED DEFAULT NULL,
  `user_id` int(191) DEFAULT NULL,
  `vendor_id` int(191) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `product_id` int(191) DEFAULT NULL,
  `conversation_id` int(191) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `order_id`, `user_id`, `vendor_id`, `admin_id`, `product_id`, `conversation_id`, `type`, `is_read`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, '2020-06-23 20:56:57', '2020-06-23 20:57:14'),
(2, 1, NULL, 1, NULL, NULL, NULL, 'vendor', 1, '2020-06-24 02:43:48', '2020-06-25 00:51:37'),
(3, NULL, 1, NULL, NULL, NULL, 1, 'user', 1, '2020-06-24 02:43:48', '2020-06-23 22:06:45'),
(4, NULL, 2, NULL, NULL, NULL, NULL, NULL, 0, '2020-06-24 00:24:25', '2020-06-24 00:24:25'),
(5, NULL, 2, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-14 01:56:09', '2020-07-14 01:56:09'),
(6, NULL, 3, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-14 09:28:21', '2020-07-14 09:28:21'),
(7, NULL, 4, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-15 00:29:35', '2020-07-15 00:29:35'),
(8, NULL, 5, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-15 06:08:31', '2020-07-15 06:08:31'),
(9, NULL, 6, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-15 23:05:37', '2020-07-15 23:05:37'),
(10, NULL, 7, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-16 02:46:05', '2020-07-16 02:46:05'),
(11, NULL, 8, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-16 02:47:42', '2020-07-16 02:47:42'),
(12, NULL, 9, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-23 22:38:22', '2020-07-23 22:38:22'),
(13, NULL, 9, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-25 02:57:32', '2020-07-25 02:57:32'),
(14, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-25 03:21:46', '2020-07-25 03:21:46'),
(15, NULL, 11, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-30 01:44:39', '2020-07-30 01:44:39'),
(16, NULL, 12, NULL, NULL, NULL, NULL, NULL, 0, '2020-07-30 03:07:14', '2020-07-30 03:07:14');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(191) DEFAULT NULL,
  `vendor_id` int(191) NOT NULL,
  `cart` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `totalQty` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pay_amount` float NOT NULL,
  `txnid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_number` varchar(255) NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `customer_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `shipping_name` varchar(255) NOT NULL,
  `shipping_country` varchar(191) NOT NULL,
  `shipping_phone` varchar(255) NOT NULL,
  `shipping_address` varchar(255) NOT NULL,
  `shipping_city` varchar(255) NOT NULL,
  `shipping_zip` varchar(255) NOT NULL,
  `order_note` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `coupon_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_discount` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','processing','completed','declined','on delivery') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `affilate_user` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `affilate_charge` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_sign` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_value` double NOT NULL,
  `shipping_cost` double NOT NULL,
  `packing_cost` double NOT NULL DEFAULT '0',
  `dp` tinyint(1) NOT NULL DEFAULT '0',
  `pay_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `vendor_shipping_id` int(191) NOT NULL DEFAULT '0',
  `vendor_packing_id` int(191) NOT NULL DEFAULT '0',
  `paid` int(11) NOT NULL DEFAULT '0',
  `broadcasted` tinyint(1) NOT NULL DEFAULT '0',
  `permalink` varchar(255) DEFAULT NULL,
  `expired` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `vendor_id`, `cart`, `method`, `shipping`, `totalQty`, `pay_amount`, `txnid`, `charge_id`, `order_number`, `payment_status`, `customer_username`, `shipping_name`, `shipping_country`, `shipping_phone`, `shipping_address`, `shipping_city`, `shipping_zip`, `order_note`, `coupon_code`, `coupon_discount`, `status`, `created_at`, `updated_at`, `affilate_user`, `affilate_charge`, `currency_sign`, `currency_value`, `shipping_cost`, `packing_cost`, `dp`, `pay_id`, `vendor_shipping_id`, `vendor_packing_id`, `paid`, `broadcasted`, `permalink`, `expired`) VALUES
(1, 1, 1, 'BZh91AY&SY\nÛC\0ß@\0Pø++ü¿ïÿúP{ÝhÔ²ÄP\0hC\0\0\0 \0\0\0(jj¦¨@\0\0\0\0BTÓFLÕ\0\Z\n42\0\0\0 \0\0\0\" Ò0JFÐM\n6¦L4<\'é³â1Ä]$h}õ?\'GD*2ZùGÈvtÉ¨¥ 4¡t·öS¹:U-^¹¢&[?\nqT©· ëY¦âÎÇe,YâS¹\0 Hænfq¸²bÛbk®m\nÂì¨4ÐÒ³/{Ê*Ïè?2D¡aLdE6ÄÜÒiÄeBÃÚÁ©M¥~¡*tXÊúK¸6Nï~Bª¢UHwxFj*æjµê rH*\\±! ã\"J1\"H¶×»¹Ó\n$@[ÚÔØJB2EÔ\"£;¸E\\È PH°bHY%]ZÔ1UUô%Ü¾ü	@@Ø\n .iÂ¬ÀÉ)ÑÇX0ÐU<8Ö),¤:à@P(Qjj÷ö\Zï$ªÐ|3} Â+B´;,ç)8á]ÎNõ¢ø³n@¶6mÃhÈs)Y°)GM#MÜÌÍP§¦²MÎ¤Xá(=>£Ær=Å#D{@òú<ªò.Ú?qµIx+{¹j£Òµãêh $*}Óôï?ÒÝ¨ â{ÏûüO3#U$r=ÙRNÀÌu7v¸¡Åd5ò!,\nìè#µ²6kPýIÙC´Ñ\n¨Áv8637ÓHÀeV&5>ä>£\'t;»öñ¥ñ±A%±TmÜV²¹±ö73!I280ÈK]6;éS=i M¹w¨ÔlÑÇ¡ÎÛÈI$¡°MËæ.¥å\"ÝÍxâÚI9!D ñX¸ëÈÚå$\\$àu0 Û0U\ZËÖè ÏÁ\'hNô.åÐlØáÌÃÖ_~Ú{ü\nºahê)\"ÀKZXT-TDæ|s°Ë,U\nI1(J³+BÄB©xGÉpÆk_gÉ!¦^¡×ÚOä±°Ó0<±õëwÊ¥óyÌæGÓl©¬Ï*¥F´ÀïZÙ\Z)ÙgK!2F9ÃJçq\ZÄ9çéémGêAûoÝK31!4«H¹,\n	µ&¦G~|¡àAUzKXÐpbP\\÷Áxspo¼ÝÜÃÒ27(ÈO©C]f>H©@²2kôKîÂûÆyt0ËCeÈ!**(ºäâOÜ|»H>Ã¬¸$ÃxÝ#w5Äkë6ò£ÖrrlAcÿrE8P\nÛC', NULL, 'shipto', '1', 25, NULL, NULL, 'OPN-1592966607-6AY2', 'Completed', 'steembestseller', 'Daniel Sapkota', 'Barbados', '343535', 'Pasang Lahmu', 'BOudha', '4500', NULL, NULL, NULL, 'pending', '2020-06-23 20:58:27', '2020-06-23 20:58:27', NULL, NULL, 'STEEM', 1, 0, 0, 0, NULL, 0, 0, 0, 1, NULL, 0),
(2, 1, 1, 'BZh91AY&SYÅ_ö?\0¢ß@\0Pø;;ô¿ïÿúP{ÝL±t5OÔOPÚHÐÐ\0\0\0\0É¡(\r\0\0\0\0\0\0RR\r\0ÐÑ È4\0h4õ\0\0\0\0\0\0\0\0\0$BBi¦M\r	=!4mJ	Ù	.\'ÙÚDLÂ7	cÖñîgÏ&E-|#öÝIÈdÄCÙP££eì¥è0gUÙÐg»¥Þ\Zÿ\nb°©3I©³iY{L¨åÙnÂ¸\0â	|0ÚW@ I4 Iy³Ê«Î\0ÀÐ\Z»)«2îÌÁây%è2Á\0ÛË:ÎXØª=Q,µìÐatÁ6°iÛª@àA¥T*A°³´Z¨h±aS4µ¦Õà2ÄZ»¾9q.@ã\nIA*T qÄ\nMQe§BAf-BÁdwI¤­ceJbô\n¾-a_ aR«v%gÆ,R²·\\ÍA(h´+TÁe¥¢n±j	## ÀZ(\n@@T÷OwQ;a!f	-ìHGè1²ªMôDq%êY(_XÔd «\ZwV/v±¨^XeÁT&)D»2¶1i¦S&¹gªel38³.äX§ÑëÐqâ§	cÜ©c°\0õ#ï³ÔÀþøV%ä¯ïfäyÞÆ\r¥£ÉL`\nÊØBÑ°x£°2qdÖn9p&)Ìâ½Ö)IÀ8\ZÆÞÀ6rZ\r~d#°feÊHì`l>f\rM¦zGÒÆÄh<,Í4Ø\'P[,}ËìÙ²ÌÌÈgYõ  !ù\rO$b1Ãc;2Ä¶+\r¼\n÷X<O¡´ë4,4Í$ÈàÊu!,Æt$Â0tÂE%¬açO1E&FJ<A¨ØÈ9$£À\'# ||E³µ{Uä	6;ðqC\ZD òÞtäx`©\\gC\"\rBITÖâØEõ$à¹±s6ù^ÕÀ®Þgw!/â.µ­ÅEìt\\Iì°Ë,A$Æ aD©Ë7µ.@X,¤p,×3yÿþbÙØPÓ1`ÈÏÞ[_ÑfQúv«¹Ð\\?FñX*¬Aöéd©­ÍÙÞºÇN³o3ÚÀÔe¡L£!AÐi`âA\\A¾}×èû¢àD¹R #\"0(H´m	CIBl$ÞhwëËý%®	w¡H@A	FT\ZNnÍäwsdFÕsCIå(ÉdZµ(.\Zö¥õaÃ=ÝÆZl:.Ð©R$G~£åÀýÉVBmqj\rL\Z½/Q÷ÎôOÀ\'$\"j¹\"(Hb¯û', NULL, 'shipto', '1', 6.3, NULL, NULL, 'OPN-1592991287-TTOB', 'Pending', 'steembestseller', 'Daniel Sapkota', 'Bangladesh', '343535', 'Pasang Lahmu', 'BOudha', '4500', NULL, NULL, NULL, 'pending', '2020-06-24 03:49:47', '2020-06-24 03:49:47', NULL, NULL, 'STEEM', 1, 0, 0, 0, NULL, 0, 0, 0, 0, NULL, 1),
(3, 1, 1, 'BZh91AY&SYåu\0¡_@\0Pø;;ô¿ïÿúP{Ý\02É JÀ\0\0\0\0\0\0\0BbdT\00M@Ði¦@\0I©$M\0\Z\04@`\0\0\0\0\0\0\0\"I¡4Â§¦¦IêÓS@=\'£j	\r£\0e&s¸ÊT±íqò{ûØÉEK_Aÿc/RIô!§ëöÔ#n¨þÆ&ua´ê*f`ãmT¥Y\'àÅ¯@£¦¦ÝÅhho:î2\\ßD.Ër+`ÐÉ´ ô;e&$!)~;Xô²@\Z@ÓCXtÕ{Aàyõ`ÁmçJÒXØª µqú.&Ð6\r;bõAí*ÔQ ;Eª6«0c@ËZmW;±%Q{ÕVð£B4,Q0I$=I!+(4µbéâ1»\0ñlÉÊª18w¶Ê*Åé52|ZÂ¾AJ¬)Ø¦V1b»¥â¿Eû M lÐL@FP­PSr!Eûm±j	##À]u¢¤dóÁïð\'t$-%Áÿ#¿0Ub¸X<oamA6\r²á\n¬è7äÐK¥Eâ]àY¡JÂ¼CÍ¢*RÁL]$B¹^,iFóõ?_êq?Ásâdý?°ìþfOÆÏSüó<ìKÊ¿ÉÑéxW63øÜ@,æÅ²ï6Ë\ZÎÒ\'qâzä8MC±]NkåbC¨ìnäâ`×÷!hXùí¤L\r§è`ÔÜi¨4}lmFÁáhl`Ó`|\0¶r.\\ÔÞ_nØÉ0Ë-\rñ>Ä?1©ãÌF8ô¬irXÅa·^ëÀúaa¦l#3©	h3¹&¸öð­xVÐôä}?q©$îÑÏ©È×ÖI(ò	ÉÈ |þÛî_ÙyM¤lÐÆ<Ã#Lìwèy`©\'s$Z©­bØEö$â½ê6n8t3zfp½ÝOA/$\\	k[Ù$ì\\ÉåaYTQ¦,ÞJÔ¹`²^BÀ´]Nòm\\:o$jM?\"{-4&fUúÅ®n¤£`ÝÃÂV!ËÅ®Ë%Mm¨ýÍËÄxÔñ8×C½Q2Fq¥1ºú{ïÝûßªÌ\ZTdcF	HBPÒ`Ð	8Úôþ	Eë]ÔÅÍÄ  £aDBëáÀïÕÀY¼ÚNå4åsa²zE2²ZÜFÆ¾ô¾Ì1¼gËÞgfÓº÷%J`:\"9öN\'ü$	Y|Ú ÔÉW¥ì2¿ãÙù°\nJA©þ.äp¡!Ê*ë', NULL, 'shipto', '3', 60, NULL, NULL, 'OPN-1593072120-IjO4', 'Pending', 'steembestseller', 'Daniel Sapkota', 'Afghanistan', '343535', '343535', 'BOudha', '4500', NULL, NULL, NULL, 'pending', '2020-06-25 02:17:00', '2020-06-25 02:17:00', NULL, NULL, 'STEEM', 1, 0, 0, 0, NULL, 0, 0, 0, 0, NULL, 1),
(4, 1, 1, 'BZh91AY&SYöèF£\0¢ß@\0Pø;;ô¿ïÿúP{Ý1Ë (h#\0\0\0\0\0\0\0\0	@	Ê2\0h4\Zh\0\0&¤%À!\0ÄÀ\0\0\0\0\0\0\0\0\0HL\Zh##CM4m!§¡©A!`Õ5\0ÈçI;|±ßsÌððòFK^CýçI ò!÷ó¤#:Y)ÛýÓ¢Ü\r^pMD¶¿\nmR©»sYÂMvhAqs+Ä§\0\"\"ó2{ÃÄì%zM\"HB^-±øR\nxÕ$À10f\'	n¥8DÀf\nss¯pR^ªÕ|^\"`(1ÆY\\»4@¦ö¹liUAâIT&^bÎð¤J*5TDq40ÀÆ aKbJ(pèdIF52)tm|,çÀÄK{Z	HFHºTgw«°!Ò,GX^­jUUìôó_èJÚÀmÄ\0éeK\nÕ0YyF¢k1j	## ÀZ  ,wÏoq;!!^	-ÌHGÄc6ß)&ê&úÚIzYs[êGjcJÆ©¬ßaDA´£¦°zÌ|Û2ÅD)»hÈ¤ß6fof5¬Sô}zN÷xÌ>å{\0òõyåw,_H½G<¸Ò§<ÉBª%ã~NB§ÔÛ?àÎ¼âIµÏØø/ØÄÞ¤NKÝRNÀÈu6qaCE×ÀqSõÎX2ÆFÃ£Î¦hÄvX°i°9Î°N`uè£s\\\r²4`§)ý !ø\rODZ-ÃJ[©-£nÂºåcÔy\ræ%F¤ÎD%ÎÄEÃÌgpðzÔËu3	»N\'ÐjI;4rÔâeÈ³·qÖI(wÞX/¨Yó^³ÑxM ¶9!\"xãLêvÐï±Iù7È;ò	%Q¬pµlô$àµÔlØnÐ¾ê£7Nz4Âèê)\"à%¬®ªq\\ãQILH aÇkaBGa]N#¦å¼R8Sqö3[µ|Q\Zeª~õX\\4ËÏhÖèé°ÐªPm41ùÈè4ÛU öcT¨Öaª>U¼vÈÞp¦èC=VÉd2Do,kK»>ñAïHÆÄaBE&Ð44&ÂMÆ\'\\´ú©Á.¢ø¸ØB°J1(D-{ Ä;jà*ÝçSfbûÓHÄØ c .11\"¥Õáeù¢¥äb×±/»mîè_geÌ!**(°häOÜzp>D*ñ6¹5Eä\r]Eè2ëêöÛÛð\nJA©ö.äp¡!íÐF', NULL, 'shipto', '1', 150, NULL, NULL, 'OPN-1593085217-LerI', 'Pending', 'steembestseller', 'Daniel Sapkota', 'Barbados', '343535', '343535', 'BOudha', '4500', NULL, NULL, NULL, 'pending', '2020-06-25 05:55:17', '2020-06-25 05:55:17', NULL, NULL, 'STEEM', 1, 0, 0, 0, NULL, 0, 0, 0, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_tracks`
--

CREATE TABLE `order_tracks` (
  `id` int(191) NOT NULL,
  `order_id` int(191) NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(191) NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_tag` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `header` tinyint(1) NOT NULL DEFAULT '0',
  `footer` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pagesettings`
--

CREATE TABLE `pagesettings` (
  `id` int(10) UNSIGNED NOT NULL,
  `contact_success` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_title` text COLLATE utf8mb4_unicode_ci,
  `contact_text` text COLLATE utf8mb4_unicode_ci,
  `side_title` text COLLATE utf8mb4_unicode_ci,
  `side_text` text COLLATE utf8mb4_unicode_ci,
  `street` text COLLATE utf8mb4_unicode_ci,
  `phone` text COLLATE utf8mb4_unicode_ci,
  `fax` text COLLATE utf8mb4_unicode_ci,
  `email` text COLLATE utf8mb4_unicode_ci,
  `site` text COLLATE utf8mb4_unicode_ci,
  `slider` tinyint(1) NOT NULL DEFAULT '1',
  `service` tinyint(1) NOT NULL DEFAULT '1',
  `featured` tinyint(1) NOT NULL DEFAULT '1',
  `small_banner` tinyint(1) NOT NULL DEFAULT '1',
  `best` tinyint(1) NOT NULL DEFAULT '1',
  `top_rated` tinyint(1) NOT NULL DEFAULT '1',
  `large_banner` tinyint(1) NOT NULL DEFAULT '1',
  `big` tinyint(1) NOT NULL DEFAULT '1',
  `hot_sale` tinyint(1) NOT NULL DEFAULT '1',
  `partners` tinyint(1) NOT NULL DEFAULT '0',
  `review_blog` tinyint(1) NOT NULL DEFAULT '1',
  `best_seller_banner` text COLLATE utf8mb4_unicode_ci,
  `best_seller_banner_link` text COLLATE utf8mb4_unicode_ci,
  `big_save_banner` text COLLATE utf8mb4_unicode_ci,
  `big_save_banner_link` text COLLATE utf8mb4_unicode_ci,
  `bottom_small` tinyint(1) NOT NULL DEFAULT '0',
  `flash_deal` tinyint(1) NOT NULL DEFAULT '0',
  `best_seller_banner1` text COLLATE utf8mb4_unicode_ci,
  `best_seller_banner_link1` text COLLATE utf8mb4_unicode_ci,
  `big_save_banner1` text COLLATE utf8mb4_unicode_ci,
  `big_save_banner_link1` text COLLATE utf8mb4_unicode_ci,
  `featured_category` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pagesettings`
--

INSERT INTO `pagesettings` (`id`, `contact_success`, `contact_email`, `contact_title`, `contact_text`, `side_title`, `side_text`, `street`, `phone`, `fax`, `email`, `site`, `slider`, `service`, `featured`, `small_banner`, `best`, `top_rated`, `large_banner`, `big`, `hot_sale`, `partners`, `review_blog`, `best_seller_banner`, `best_seller_banner_link`, `big_save_banner`, `big_save_banner_link`, `bottom_small`, `flash_deal`, `best_seller_banner1`, `best_seller_banner_link1`, `big_save_banner1`, `big_save_banner_link1`, `featured_category`) VALUES
(1, 'Success! Thanks for contacting us, we will get back to you shortly.', 'admin@geniusocean.com', '<h4 class=\"subtitle\" style=\"margin-bottom: 6px; font-weight: 600; line-height: 28px; font-size: 28px; text-transform: uppercase;\">WE\'D LOVE TO</h4><h2 class=\"title\" style=\"margin-bottom: 13px;font-weight: 600;line-height: 50px;font-size: 40px;color: #0f78f2;text-transform: uppercase;\">HEAR FROM YOU</h2>', '<span style=\"color: rgb(119, 119, 119);\">Send us a message and we\' ll respond as soon as possible</span><br>', '<h4 class=\"title\" style=\"margin-bottom: 10px; font-weight: 600; line-height: 28px; font-size: 28px;\">Let\'s Connect</h4>', '<span style=\"color: rgb(51, 51, 51);\">Get in touch with us</span>', '3584 Hickory Heights Drive ,Hanover MD 21076, USA', '00 000 000 000', '00 000 000 000', 'admin@geniusocean.com', 'https://geniusocean.com/', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, '1568889138banner1.jpg', 'http://google.com', '1565150264banner3.jpg', 'http://google.com', 1, 1, '1568889138banner2.jpg', 'http://google.com', '1565150264banner4.jpg', 'http://google.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `prices`
--

CREATE TABLE `prices` (
  `id` int(11) NOT NULL DEFAULT '1',
  `steem` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prices`
--

INSERT INTO `prices` (`id`, `steem`) VALUES
(1, 0.2);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(191) UNSIGNED NOT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `product_type` enum('normal','affiliate') NOT NULL DEFAULT 'normal',
  `affiliate_link` text,
  `user_id` int(191) NOT NULL DEFAULT '0',
  `category_id` int(191) UNSIGNED NOT NULL,
  `subcategory_id` int(191) UNSIGNED DEFAULT NULL,
  `childcategory_id` int(191) UNSIGNED DEFAULT NULL,
  `attributes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size_qty` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size_price` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `price` double NOT NULL,
  `usd_price` double NOT NULL,
  `previous_price` double DEFAULT NULL,
  `usd_previous_price` double DEFAULT NULL,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `stock` int(191) DEFAULT NULL,
  `policy` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` tinyint(2) UNSIGNED NOT NULL DEFAULT '1',
  `views` int(191) UNSIGNED NOT NULL DEFAULT '0',
  `tags` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `features` text,
  `colors` text,
  `product_condition` tinyint(1) NOT NULL DEFAULT '0',
  `ship` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_meta` tinyint(1) NOT NULL DEFAULT '0',
  `meta_tag` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `youtube` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('Physical','Digital','License') NOT NULL,
  `license` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `license_qty` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `link` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `platform` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `licence_type` varchar(255) DEFAULT NULL,
  `measure` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `best` tinyint(10) UNSIGNED NOT NULL DEFAULT '0',
  `top` tinyint(10) UNSIGNED NOT NULL DEFAULT '0',
  `hot` tinyint(10) UNSIGNED NOT NULL DEFAULT '0',
  `latest` tinyint(10) UNSIGNED NOT NULL DEFAULT '0',
  `big` tinyint(10) UNSIGNED NOT NULL DEFAULT '0',
  `trending` tinyint(1) NOT NULL DEFAULT '0',
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_discount` tinyint(1) NOT NULL DEFAULT '0',
  `discount_date` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `whole_sell_qty` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `whole_sell_discount` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_catalog` tinyint(1) NOT NULL DEFAULT '0',
  `catalog_id` int(191) NOT NULL DEFAULT '0',
  `broadcasted` tinyint(1) NOT NULL DEFAULT '0',
  `permalink` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `sku`, `product_type`, `affiliate_link`, `user_id`, `category_id`, `subcategory_id`, `childcategory_id`, `attributes`, `name`, `slug`, `photo`, `thumbnail`, `file`, `size`, `size_qty`, `size_price`, `color`, `price`, `usd_price`, `previous_price`, `usd_previous_price`, `details`, `stock`, `policy`, `status`, `views`, `tags`, `features`, `colors`, `product_condition`, `ship`, `is_meta`, `meta_tag`, `meta_description`, `youtube`, `type`, `license`, `license_qty`, `link`, `platform`, `region`, `licence_type`, `measure`, `featured`, `best`, `top`, `hot`, `latest`, `big`, `trending`, `sale`, `created_at`, `updated_at`, `is_discount`, `discount_date`, `whole_sell_qty`, `whole_sell_discount`, `is_catalog`, `catalog_id`, `broadcasted`, `permalink`) VALUES
(2, 'RD945961Ak', 'normal', NULL, 1, 20, NULL, NULL, NULL, 'FIFA 20', 'fifa-20-rd945961ak', '1592984609wBscJcfo.png', '1592984609Ug4Q8Ejg.jpg', NULL, NULL, NULL, NULL, NULL, 150, 30, 4.62, NULL, 'desc<br>', NULL, 'policty<br>', 1, 14, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 'Physical', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2020-06-24 01:58:29', '2020-06-25 00:41:14', 0, NULL, NULL, NULL, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL,
  `product_id` int(191) NOT NULL,
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `rating` tinyint(2) NOT NULL,
  `review_date` datetime NOT NULL,
  `broadcasted` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `replies`
--

CREATE TABLE `replies` (
  `id` int(11) NOT NULL,
  `user_id` int(191) UNSIGNED NOT NULL,
  `comment_id` int(191) UNSIGNED NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(10) UNSIGNED NOT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle` text COLLATE utf8mb4_unicode_ci,
  `details` text COLLATE utf8mb4_unicode_ci,
  `broadcasted` tinyint(1) NOT NULL DEFAULT '0',
  `permalink` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(191) NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `section` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `section`) VALUES
(16, 'Manager', 'orders , products , affilate_products , customers , vendors , vendor_subscription_plans , categories , bulk_product_upload , product_discussion , set_coupons , blog , messages , general_settings , home_page_settings , menu_page_settings , emails_settings , payment_settings , social_settings , language_settings , seo_tools , subscribers'),
(17, 'Moderator', 'orders , products , customers , vendors , categories , blog , messages , home_page_settings , payment_settings , social_settings , language_settings , seo_tools , subscribers'),
(18, 'Staff', 'orders , products , vendors , vendor_subscription_plans , categories , blog , home_page_settings , menu_page_settings , language_settings , seo_tools , subscribers');

-- --------------------------------------------------------

--
-- Table structure for table `seotools`
--

CREATE TABLE `seotools` (
  `id` int(10) UNSIGNED NOT NULL,
  `google_analytics` text COLLATE utf8mb4_unicode_ci,
  `meta_keys` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seotools`
--

INSERT INTO `seotools` (`id`, `google_analytics`, `meta_keys`) VALUES
(1, '<script>//Google Analytics Scriptfffffffffffffffffffffffssssfffffs</script>', 'mayra');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL DEFAULT '0',
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `user_id`, `title`, `details`, `photo`) VALUES
(6, 13, 'FREE SHIPPING', 'Free Shipping All Order', '1563247602brand1.png'),
(7, 13, 'PAYMENT METHOD', 'Secure Payment', '1563247614brand2.png'),
(8, 13, '30 DAY RETURNS', '30-Day Return Policy', '1563247620brand3.png'),
(9, 13, 'HELP CENTER', '24/7 Support System', '1563247670brand4.png');

-- --------------------------------------------------------

--
-- Table structure for table `shippings`
--

CREATE TABLE `shippings` (
  `id` int(11) NOT NULL,
  `user_id` int(191) NOT NULL DEFAULT '0',
  `title` text,
  `subtitle` text,
  `price` double NOT NULL DEFAULT '0',
  `usd_price` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shippings`
--

INSERT INTO `shippings` (`id`, `user_id`, `title`, `subtitle`, `price`, `usd_price`) VALUES
(1, 0, 'Free Shipping', '(10 - 12 days)', 0, 0),
(2, 0, 'Express Shipping', '(5 - 6 days)', 10, 13);

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` int(191) UNSIGNED NOT NULL,
  `subtitle_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `subtitle_size` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle_color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle_anime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `title_size` varchar(50) DEFAULT NULL,
  `title_color` varchar(50) DEFAULT NULL,
  `title_anime` varchar(50) DEFAULT NULL,
  `details_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `details_size` varchar(50) DEFAULT NULL,
  `details_color` varchar(50) DEFAULT NULL,
  `details_anime` varchar(50) DEFAULT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `subtitle_text`, `subtitle_size`, `subtitle_color`, `subtitle_anime`, `title_text`, `title_size`, `title_color`, `title_anime`, `details_text`, `details_size`, `details_color`, `details_anime`, `photo`, `position`, `link`) VALUES
(8, 'World Fashion', '24', '#ffffff', 'slideInUp', 'Get Up to 40% Off', '60', '#ffffff', 'slideInDown', 'Highlight your personality  and look with these fabulous and exquisite fashion.', '16', '#ffffff', 'slideInRight', '1564224870012.jpg', 'slide-three', 'https://www.google.com/'),
(10, 'World Fashion', '24', '#c32d2d', 'slideInUp', 'Get Up to 40% Off', '60', '#bc2727', 'slideInDown', 'Highlight your personality  and look with these fabulous and exquisite fashion.', '16', '#c51d1d', 'slideInLeft', '156422490902.jpg', 'slide-one', 'https://www.google.com/');

-- --------------------------------------------------------

--
-- Table structure for table `socialsettings`
--

CREATE TABLE `socialsettings` (
  `id` int(10) UNSIGNED NOT NULL,
  `facebook` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gplus` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `twitter` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `linkedin` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dribble` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `f_status` tinyint(4) NOT NULL DEFAULT '1',
  `g_status` tinyint(4) NOT NULL DEFAULT '1',
  `t_status` tinyint(4) NOT NULL DEFAULT '1',
  `l_status` tinyint(4) NOT NULL DEFAULT '1',
  `d_status` tinyint(4) NOT NULL DEFAULT '1',
  `f_check` tinyint(10) DEFAULT NULL,
  `g_check` tinyint(10) DEFAULT NULL,
  `fclient_id` text COLLATE utf8mb4_unicode_ci,
  `fclient_secret` text COLLATE utf8mb4_unicode_ci,
  `fredirect` text COLLATE utf8mb4_unicode_ci,
  `gclient_id` text COLLATE utf8mb4_unicode_ci,
  `gclient_secret` text COLLATE utf8mb4_unicode_ci,
  `gredirect` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `socialsettings`
--

INSERT INTO `socialsettings` (`id`, `facebook`, `gplus`, `twitter`, `linkedin`, `dribble`, `f_status`, `g_status`, `t_status`, `l_status`, `d_status`, `f_check`, `g_check`, `fclient_id`, `fclient_secret`, `fredirect`, `gclient_id`, `gclient_secret`, `gredirect`) VALUES
(1, 'https://www.facebook.com/', 'https://plus.google.com/', 'https://twitter.com/', 'https://www.linkedin.com/', 'https://dribbble.com/', 1, 1, 1, 1, 1, 1, 1, '3295714593783056', '7ca32c70e89bc04d66de0126971e15f8', 'https://mayrasales.local/auth/facebook/callback', '687441940729-l53jvsmil8qh93p39k4h0h1t3m9ofral.apps.googleusercontent.com', 'TgF1m9boFAX_EKCwZTNsTujt', 'https://mayrasales.local/auth/google/callback');

-- --------------------------------------------------------

--
-- Table structure for table `social_providers`
--

CREATE TABLE `social_providers` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL,
  `provider_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `social_providers`
--

INSERT INTO `social_providers` (`id`, `user_id`, `provider_id`, `provider`, `created_at`, `updated_at`) VALUES
(2, 12, '128921545532962', 'facebook', '2020-07-30 03:07:14', '2020-07-30 03:07:14');

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `id` int(191) NOT NULL,
  `category_id` int(191) NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(11) NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL DEFAULT '0',
  `days` int(11) NOT NULL,
  `allowed_products` int(11) NOT NULL DEFAULT '0',
  `percentage_commission` int(11) NOT NULL DEFAULT '0',
  `custom_shop` tinyint(1) NOT NULL,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `title`, `currency`, `currency_code`, `price`, `days`, `allowed_products`, `percentage_commission`, `custom_shop`, `details`) VALUES
(9, 'Premium', 'STEEM', 'STEEM', 100, 30, 0, 0, 1, '<div>The basic plan has a maximum of&nbsp; 2 active listings, a 15% comission, and no custom shop. Upgrade to this plan for following benefits:<br></div><div><br></div><div>1. No Markup</div><div>2. Custom Shop</div><div>3. Unlimited Listing<br></div>');

-- --------------------------------------------------------

--
-- Table structure for table `subscription_payments`
--

CREATE TABLE `subscription_payments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subscription_id` int(11) NOT NULL,
  `paid` int(11) NOT NULL DEFAULT '0',
  `memo` varchar(255) NOT NULL,
  `shop_name` text NOT NULL,
  `shop_message` text NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_token` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_provider` tinyint(10) NOT NULL DEFAULT '0',
  `status` tinyint(10) NOT NULL DEFAULT '0',
  `verification_link` text COLLATE utf8mb4_unicode_ci,
  `email_verified` enum('Yes','No') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No',
  `affilate_code` text COLLATE utf8mb4_unicode_ci,
  `affilate_income` double NOT NULL DEFAULT '0',
  `shop_name` text COLLATE utf8mb4_unicode_ci,
  `owner_name` text COLLATE utf8mb4_unicode_ci,
  `shop_number` text COLLATE utf8mb4_unicode_ci,
  `shop_address` text COLLATE utf8mb4_unicode_ci,
  `reg_number` text COLLATE utf8mb4_unicode_ci,
  `shop_message` text COLLATE utf8mb4_unicode_ci,
  `shop_details` text COLLATE utf8mb4_unicode_ci,
  `shop_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `f_url` text COLLATE utf8mb4_unicode_ci,
  `g_url` text COLLATE utf8mb4_unicode_ci,
  `t_url` text COLLATE utf8mb4_unicode_ci,
  `l_url` text COLLATE utf8mb4_unicode_ci,
  `is_vendor` tinyint(1) NOT NULL DEFAULT '0',
  `f_check` tinyint(1) NOT NULL DEFAULT '0',
  `g_check` tinyint(1) NOT NULL DEFAULT '0',
  `t_check` tinyint(1) NOT NULL DEFAULT '0',
  `l_check` tinyint(1) NOT NULL DEFAULT '0',
  `mail_sent` tinyint(1) NOT NULL DEFAULT '0',
  `shipping_cost` double NOT NULL DEFAULT '0',
  `current_balance` double NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `ban` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `photo`, `zip`, `city`, `country`, `address`, `phone`, `fax`, `email`, `password`, `api_token`, `remember_token`, `created_at`, `updated_at`, `is_provider`, `status`, `verification_link`, `email_verified`, `affilate_code`, `affilate_income`, `shop_name`, `owner_name`, `shop_number`, `shop_address`, `reg_number`, `shop_message`, `shop_details`, `shop_image`, `f_url`, `g_url`, `t_url`, `l_url`, `is_vendor`, `f_check`, `g_check`, `t_check`, `l_check`, `mail_sent`, `shipping_cost`, `current_balance`, `date`, `ban`) VALUES
(8, 'Daniel Sapkota', NULL, NULL, NULL, NULL, 'Boudha', '985132542952', NULL, 'danielsapkota13@gmail.com', '$2y$10$LVDle9jgASMwNMlBFCuXfO1s1s2bodqdCDmuZsWxOF.EjQyQwPWAu', 'kFqwjmu84L5Fh69UPxsjlhTSP1ZQupOcXn0rJZTRhbtA6Ehe9BsnmnFVg9hc', 'LUh7hnSOytUISBCzfc8OxL9stmodGvDzhFJ7GxIXEIxLVVcdXqZaGBRld6nK', '2020-07-16 02:47:42', '2020-07-25 01:41:08', 0, 0, '1fb6f8bd865cc4f18a90e08cb292a724', 'Yes', '0e123e7fa3b658afa658734e897d9336', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, 0, 0, 0, 0, 0, 0, NULL, 0),
(10, 'Daniel Sapkota', NULL, NULL, NULL, NULL, 'Boudha', '985132542952', NULL, 'n00bdan13@gmail.com', '$2y$10$i6QhC.Myv8waDo1BZ.VBJeIbCbYlEoacWBv8UILL3.okKSmz4llEm', 'AyqheV02JYXBXdB8QnJARRznRLduE2kaRhNA2931lcaKTpvI4bdFCJK6XswH', NULL, '2020-07-25 03:21:46', '2020-07-25 03:21:46', 0, 0, '6693aacad831a3f2d51622ba635319a9', 'Yes', '355ccc857ef50ba2bdb684de846afab3', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0),
(12, 'John Daniel', 'https://graph.facebook.com/v3.0/128921545532962/picture?width=1920', NULL, NULL, NULL, NULL, NULL, NULL, 'daniel@waterbot.xyz', NULL, 'bpinNgbAneTucc3utQmN53jwLWhXvtCBh2JoBtRXdN08ozFsb5V9xiX3vSYv', NULL, '2020-07-30 03:07:14', '2020-07-30 03:07:14', 1, 0, NULL, 'Yes', '5578261a8fc5c86a097368bb83121511', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL,
  `order_number` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_notifications`
--

INSERT INTO `user_notifications` (`id`, `user_id`, `order_number`, `is_read`, `created_at`, `updated_at`) VALUES
(1, 1, 'OPN-1592966607-6AY2', 0, '2020-06-23 20:58:27', '2020-06-23 20:58:27'),
(2, 1, 'OPN-1592991287-TTOB', 0, '2020-06-24 03:49:47', '2020-06-24 03:49:47'),
(3, 1, 'OPN-1593072120-IjO4', 0, '2020-06-25 02:17:00', '2020-06-25 02:17:00'),
(4, 1, 'OPN-1593085217-LerI', 0, '2020-06-25 05:55:17', '2020-06-25 05:55:17');

-- --------------------------------------------------------

--
-- Table structure for table `user_subscriptions`
--

CREATE TABLE `user_subscriptions` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL,
  `subscription_id` int(191) NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL DEFAULT '0',
  `days` int(11) NOT NULL,
  `allowed_products` int(11) NOT NULL DEFAULT '0',
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Free',
  `txnid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `payment_number` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vendor_orders`
--

CREATE TABLE `vendor_orders` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL,
  `order_id` int(191) NOT NULL,
  `qty` int(191) NOT NULL,
  `price` double NOT NULL,
  `order_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','processing','completed','declined','on delivery') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vendor_orders`
--

INSERT INTO `vendor_orders` (`id`, `user_id`, `order_id`, `qty`, `price`, `order_number`, `status`) VALUES
(1, 1, 1, 1, 25, 'OPN-1592966607-6AY2', 'pending'),
(4, 1, 4, 1, 150, 'OPN-1593085217-LerI', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `verifications`
--

CREATE TABLE `verifications` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL,
  `attachments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('Pending','Verified','Declined') DEFAULT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `admin_warning` tinyint(1) NOT NULL DEFAULT '0',
  `warning_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` int(191) UNSIGNED NOT NULL,
  `user_id` int(191) UNSIGNED NOT NULL,
  `product_id` int(191) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `admin_languages`
--
ALTER TABLE `admin_languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attribute_options`
--
ALTER TABLE `attribute_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `childcategories`
--
ALTER TABLE `childcategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorite_sellers`
--
ALTER TABLE `favorite_sellers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `generalsettings`
--
ALTER TABLE `generalsettings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_tracks`
--
ALTER TABLE `order_tracks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pagesettings`
--
ALTER TABLE `pagesettings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `products` ADD FULLTEXT KEY `name` (`name`);
ALTER TABLE `products` ADD FULLTEXT KEY `attributes` (`attributes`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `replies`
--
ALTER TABLE `replies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seotools`
--
ALTER TABLE `seotools`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shippings`
--
ALTER TABLE `shippings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `socialsettings`
--
ALTER TABLE `socialsettings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_providers`
--
ALTER TABLE `social_providers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscription_payments`
--
ALTER TABLE `subscription_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendor_orders`
--
ALTER TABLE `vendor_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `verifications`
--
ALTER TABLE `verifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `admin_languages`
--
ALTER TABLE `admin_languages`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `attribute_options`
--
ALTER TABLE `attribute_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `childcategories`
--
ALTER TABLE `childcategories`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;
--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `favorite_sellers`
--
ALTER TABLE `favorite_sellers`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` int(191) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=229;
--
-- AUTO_INCREMENT for table `generalsettings`
--
ALTER TABLE `generalsettings`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `order_tracks`
--
ALTER TABLE `order_tracks`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pagesettings`
--
ALTER TABLE `pagesettings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(191) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `replies`
--
ALTER TABLE `replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `seotools`
--
ALTER TABLE `seotools`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `shippings`
--
ALTER TABLE `shippings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(191) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `socialsettings`
--
ALTER TABLE `socialsettings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `social_providers`
--
ALTER TABLE `social_providers`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `subscription_payments`
--
ALTER TABLE `subscription_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `vendor_orders`
--
ALTER TABLE `vendor_orders`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `verifications`
--
ALTER TABLE `verifications`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` int(191) UNSIGNED NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
