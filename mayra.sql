-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 10, 2020 at 08:35 PM
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
(1, 'Admin', 'daniel@waterbot.xyz', '01629552892', 0, '1556780563user.png', '$2y$10$exGozYUkvvnfScErNvg5weki6DujTMABgO3RPqWBfIIVnmyMxnLc6', '9PwWzW2Al8boW9qBXc6aDNhLdoXQsAyaNC528U61w1yu9ZPAALQNIav5bWxR', 1, '6euvcSK8vdNhGXTxFWvZ6ghWjiqQJNWa5KiRKQRATJolDakBQQQQmcAiDEbF', '2018-02-28 23:27:08', '2019-07-26 21:21:32', 'Genius Store'),
(2, 'TEsty', 'test@test.com', '35467', 17, '15987122912191163_0621ec2c915g9faf.jpg', '$2y$10$9iD5hbaIYF1x9vQmwPoE2.BcaKwpgha4jMf5GJSSvYLO0FtaFxjdy', NULL, 1, NULL, '2020-08-29 08:59:51', '2020-08-29 08:59:51', NULL);

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
-- Table structure for table `admin_user_conversations`
--

CREATE TABLE `admin_user_conversations` (
  `id` int(191) NOT NULL,
  `subject` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(191) NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` enum('Ticket','Dispute') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_number` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `admin_user_messages`
--

CREATE TABLE `admin_user_messages` (
  `id` int(191) NOT NULL,
  `conversation_id` int(191) NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`id`, `attributable_id`, `attributable_type`, `name`, `input_name`, `price_status`, `details_status`, `created_at`, `updated_at`) VALUES
(14, 5, 'App\\Models\\Category', 'Warranty Type', 'warranty_type', 1, 1, '2019-09-23 22:56:07', '2019-09-23 22:56:07'),
(20, 4, 'App\\Models\\Category', 'Warranty Type', 'warranty_type', 1, 1, '2019-09-24 00:41:46', '2019-10-03 00:18:54'),
(21, 4, 'App\\Models\\Category', 'Brand', 'brand', 1, 1, '2019-09-24 00:44:13', '2019-10-03 00:19:13'),
(22, 2, 'App\\Models\\Subcategory', 'Color Family', 'color_family', 1, 1, '2019-09-24 00:45:45', '2019-09-24 00:45:45'),
(24, 1, 'App\\Models\\Childcategory', 'Display Size', 'display_size', 1, 1, '2019-09-24 00:54:17', '2019-09-24 00:54:17'),
(25, 12, 'App\\Models\\Subcategory', 'demo', 'demo', 1, 1, '2019-09-24 01:26:47', '2019-09-24 01:26:47'),
(30, 3, 'App\\Models\\Subcategory', 'Interior Color', 'interior_color', 1, 1, '2019-09-24 04:31:44', '2019-09-24 04:31:44'),
(31, 8, 'App\\Models\\Childcategory', 'Temperature', 'temperature', 1, 1, '2019-09-24 04:34:35', '2019-09-24 04:34:35'),
(32, 18, 'App\\Models\\Category', 'Demo', 'demo', 1, 1, '2019-10-02 23:39:12', '2019-10-02 23:39:12'),
(33, 4, 'App\\Models\\Category', 'RAM', 'ram', 1, 1, '2019-10-12 03:22:03', '2019-10-12 23:30:39');

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

--
-- Dumping data for table `attribute_options`
--

INSERT INTO `attribute_options` (`id`, `attribute_id`, `name`, `created_at`, `updated_at`) VALUES
(107, 14, 'No Warranty', '2019-09-23 22:56:07', '2019-09-23 22:56:07'),
(108, 14, 'Local seller Warranty', '2019-09-23 22:56:07', '2019-09-23 22:56:07'),
(109, 14, 'Non local warranty', '2019-09-23 22:56:07', '2019-09-23 22:56:07'),
(110, 14, 'International Manufacturer Warranty', '2019-09-23 22:56:07', '2019-09-23 22:56:07'),
(111, 14, 'International Seller Warranty', '2019-09-23 22:56:07', '2019-09-23 22:56:07'),
(157, 22, 'Black', '2019-09-24 00:46:26', '2019-09-24 00:46:26'),
(158, 22, 'White', '2019-09-24 00:46:26', '2019-09-24 00:46:26'),
(159, 22, 'Sliver', '2019-09-24 00:46:26', '2019-09-24 00:46:26'),
(160, 22, 'Red', '2019-09-24 00:46:26', '2019-09-24 00:46:26'),
(161, 22, 'Dark Grey', '2019-09-24 00:46:26', '2019-09-24 00:46:26'),
(162, 22, 'Dark Blue', '2019-09-24 00:46:26', '2019-09-24 00:46:26'),
(163, 22, 'Brown', '2019-09-24 00:46:26', '2019-09-24 00:46:26'),
(172, 24, '40', '2019-09-24 01:25:32', '2019-09-24 01:25:32'),
(173, 24, '22', '2019-09-24 01:25:32', '2019-09-24 01:25:32'),
(174, 24, '24', '2019-09-24 01:25:32', '2019-09-24 01:25:32'),
(175, 24, '32', '2019-09-24 01:25:32', '2019-09-24 01:25:32'),
(176, 24, '21', '2019-09-24 01:25:32', '2019-09-24 01:25:32'),
(177, 25, 'demo 1', '2019-09-24 01:26:47', '2019-09-24 01:26:47'),
(178, 25, 'demo 2', '2019-09-24 01:26:47', '2019-09-24 01:26:47'),
(187, 30, 'Yellow', '2019-09-24 04:31:44', '2019-09-24 04:31:44'),
(188, 30, 'White', '2019-09-24 04:31:44', '2019-09-24 04:31:44'),
(189, 31, '22', '2019-09-24 04:34:35', '2019-09-24 04:34:35'),
(190, 31, '34', '2019-09-24 04:34:35', '2019-09-24 04:34:35'),
(191, 31, '45', '2019-09-24 04:34:35', '2019-09-24 04:34:35'),
(195, 20, 'Local seller warranty', '2019-10-03 00:18:54', '2019-10-03 00:18:54'),
(196, 20, 'No warranty', '2019-10-03 00:18:54', '2019-10-03 00:18:54'),
(197, 20, 'international manufacturer warranty', '2019-10-03 00:18:54', '2019-10-03 00:18:54'),
(198, 20, 'Non-local warranty', '2019-10-03 00:18:54', '2019-10-03 00:18:54'),
(199, 21, 'Symphony', '2019-10-03 00:19:13', '2019-10-03 00:19:13'),
(200, 21, 'Oppo', '2019-10-03 00:19:13', '2019-10-03 00:19:13'),
(201, 21, 'EStore', '2019-10-03 00:19:13', '2019-10-03 00:19:13'),
(202, 21, 'Infinix', '2019-10-03 00:19:13', '2019-10-03 00:19:13'),
(203, 21, 'Apple', '2019-10-03 00:19:13', '2019-10-03 00:19:13'),
(243, 33, '1 GB', '2019-10-12 23:30:39', '2019-10-12 23:30:39'),
(244, 33, '2 GB', '2019-10-12 23:30:39', '2019-10-12 23:30:39'),
(245, 33, '3 GB', '2019-10-12 23:30:39', '2019-10-12 23:30:39'),
(253, 32, 'demo 1', '2019-10-13 03:18:04', '2019-10-13 03:18:04'),
(254, 32, 'demo 2', '2019-10-13 03:18:04', '2019-10-13 03:18:04'),
(255, 32, 'demo 3', '2019-10-13 03:18:04', '2019-10-13 03:18:04');

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

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `photo`, `link`, `type`) VALUES
(4, '1564398600side-triple3.jpg', 'https://www.google.com/', 'BottomSmall'),
(5, '1564398579side-triple2.jpg', 'https://www.google.com/', 'BottomSmall'),
(6, '1564398571side-triple1.jpg', 'https://www.google.com/', 'BottomSmall');

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(191) NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `views` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `meta_tag` text COLLATE utf8mb4_unicode_ci,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `tags` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` int(191) NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `blog_categories`
--

INSERT INTO `blog_categories` (`id`, `name`, `slug`) VALUES
(2, 'Oil & gas', 'oil-and-gas'),
(3, 'Manufacturing', 'manufacturing'),
(4, 'Chemical Research', 'chemical_research'),
(5, 'Agriculture', 'agriculture'),
(6, 'Mechanical', 'mechanical'),
(7, 'Entrepreneurs', 'entrepreneurs'),
(8, 'Technology', 'technology');

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
(4, 'Electronic', 'electric', 1, '1557807287light.png', 1, '1568709131f6.jpg'),
(5, 'Fashion & Beauty', 'fashion-and-Beauty', 1, '1557807279fashion.png', 1, '1568709123f1.jpg'),
(6, 'Camera & Photo', 'camera-and-photo', 1, '1557807264camera.png', 1, '1568709110f2.jpg'),
(7, 'Smart Phone & Table', 'smart-phone-and-table', 1, '1557377810mobile.png', 1, '1568709597f4.jpg'),
(8, 'Sport & Outdoor', 'sport-and-Outdoor', 1, '1557807258sports.png', 1, '1568709577f8.jpg'),
(9, 'Jewelry & Watches', 'jewelry-and-watches', 1, '1557807252furniture.png', 1, '1568709077f7.jpg'),
(10, 'Health & Beauty', 'health-and-beauty', 1, '1557807228trends.png', 1, '1568709067f3.jpg'),
(11, 'Books & Office', 'books-and-office', 1, '1557377917bags.png', 1, '1568709050f8.jpg'),
(12, 'Toys & Hobbies', 'toys-and-hobbies', 1, '1557807214sports.png', 1, '1568709042f9.jpg'),
(13, 'Books', 'books', 1, '1557807208bags.png', 1, '1568709037f10.jpg'),
(15, 'Automobiles & Motorcycles', 'automobiles-and-motorcycles', 1, '1568708648motor.car.png', 1, '1568709031f11.jpg'),
(16, 'Home decoration & Appliance', 'Home-decoration-and-Appliance', 1, '1568708757home.png', 1, '1568709027f12.jpg'),
(17, 'Portable & Personal Electronics', 'portable-and-personal-electronics', 1, '1568878538electronic.jpg', 0, NULL),
(18, 'Outdoor, Recreation & Fitness', 'Outdoor-Recreation-and-Fitness', 1, '1568878596home.jpg', 0, NULL),
(19, 'Surveillance Safety & Security', 'Surveillance-Safety-and-Security', 1, NULL, 0, NULL);

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
(1, 2, 'LCD TV', 'lcd-tv', 1),
(2, 2, 'LED TV', 'led-tv', 1),
(3, 2, 'Curved TV', 'curved-tv', 1),
(4, 2, 'Plasma TV', 'plasma-tv', 1),
(5, 3, 'Top Freezer', 'top-freezer', 1),
(6, 3, 'Side-by-Side', 'side-by-side', 1),
(7, 3, 'Counter-Depth', 'counter-depth', 1),
(8, 3, 'Mini Fridge', 'mini-fridge', 1),
(9, 4, 'Front Loading', 'front-loading', 1),
(10, 4, 'Top Loading', 'top-loading', 1),
(11, 4, 'Washer Dryer Combo', 'washer-dryer-combo', 1),
(12, 4, 'Laundry Center', 'laundry-center', 1),
(13, 5, 'Central Air', 'central-air', 1),
(14, 5, 'Window Air', 'window-air', 1),
(15, 5, 'Portable Air', 'portable-air', 1),
(16, 5, 'Hybrid Air', 'hybrid-air', 1);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(191) NOT NULL,
  `user_id` int(191) UNSIGNED NOT NULL,
  `product_id` int(191) UNSIGNED NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
  `is_dispute` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `counters`
--

CREATE TABLE `counters` (
  `id` int(11) NOT NULL,
  `type` enum('referral','browser') NOT NULL DEFAULT 'referral',
  `referral` varchar(255) DEFAULT NULL,
  `total_count` int(11) NOT NULL DEFAULT '0',
  `todays_count` int(11) NOT NULL DEFAULT '0',
  `today` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(1, 'NRs', 'Rs.', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE `email_templates` (
  `id` int(11) NOT NULL,
  `email_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_subject` mediumtext COLLATE utf8_unicode_ci,
  `email_body` longtext COLLATE utf8_unicode_ci,
  `status` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`id`, `email_type`, `email_subject`, `email_body`, `status`) VALUES
(1, 'new_order', 'Your Order Placed Successfully', '<p>Hello {customer_name},<br>Your Order Number is {order_number}<br>Your order has been placed successfully</p>', 1),
(2, 'new_registration', 'Welcome To Royal Commerce', '<p>Hello {customer_name},<br>You have successfully registered to {website_title}, We wish you will have a wonderful experience using our service.</p><p>Thank You<br></p>', 1),
(3, 'vendor_accept', 'Your Vendor Account Activated', '<p>Hello {customer_name},<br>Your Vendor Account Activated Successfully. Please Login to your account and build your own shop.</p><p>Thank You<br></p>', 1),
(4, 'subscription_warning', 'Your subscrption plan will end after five days', '<p>Hello {customer_name},<br>Your subscription plan duration will end after five days. Please renew your plan otherwise all of your products will be deactivated.</p><p>Thank You<br></p>', 1),
(5, 'vendor_verification', 'Request for verification.', '<p>Hello {customer_name},<br>You are requested verify your account. Please send us photo of your passport.</p><p>Thank You<br></p>', 1);

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
  `is_location` int(1) NOT NULL DEFAULT '1',
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
  `maintain_text` text COLLATE utf8mb4_unicode_ci,
  `cash_only_limit` int(11) NOT NULL DEFAULT '10',
  `og_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `og_description` text COLLATE utf8mb4_unicode_ci,
  `og_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `generalsettings`
--

INSERT INTO `generalsettings` (`id`, `logo`, `favicon`, `title`, `header_email`, `header_phone`, `footer`, `copyright`, `colors`, `loader`, `admin_loader`, `is_talkto`, `talkto`, `is_language`, `is_location`, `is_loader`, `map_key`, `is_disqus`, `disqus`, `is_contact`, `is_faq`, `guest_checkout`, `stripe_check`, `cod_check`, `stripe_key`, `stripe_secret`, `currency_format`, `withdraw_fee`, `withdraw_charge`, `tax`, `shipping_cost`, `smtp_host`, `smtp_port`, `smtp_user`, `smtp_pass`, `from_email`, `from_name`, `is_smtp`, `is_comment`, `is_currency`, `add_cart`, `out_stock`, `add_wish`, `already_wish`, `wish_remove`, `add_compare`, `already_compare`, `compare_remove`, `color_change`, `coupon_found`, `no_coupon`, `already_coupon`, `order_title`, `order_text`, `is_affilate`, `affilate_charge`, `affilate_banner`, `already_cart`, `fixed_commission`, `percentage_commission`, `multiple_shipping`, `multiple_packaging`, `vendor_ship_info`, `reg_vendor`, `cod_text`, `paypal_text`, `stripe_text`, `header_color`, `footer_color`, `copyright_color`, `is_admin_loader`, `menu_color`, `menu_hover_color`, `is_home`, `is_verification_email`, `instamojo_key`, `instamojo_token`, `instamojo_text`, `is_instamojo`, `instamojo_sandbox`, `is_paystack`, `paystack_key`, `paystack_email`, `paystack_text`, `wholesell`, `is_capcha`, `error_banner`, `is_popup`, `popup_title`, `popup_text`, `popup_background`, `invoice_logo`, `user_image`, `vendor_color`, `is_secure`, `is_report`, `paypal_check`, `paypal_business`, `footer_logo`, `email_encryption`, `paytm_merchant`, `paytm_secret`, `paytm_website`, `paytm_industry`, `is_paytm`, `paytm_text`, `paytm_mode`, `is_molly`, `molly_key`, `molly_text`, `is_razorpay`, `razorpay_key`, `razorpay_secret`, `razorpay_text`, `show_stock`, `is_maintain`, `maintain_text`, `cash_only_limit`, `og_title`, `og_description`, `og_image`) VALUES
(1, '1598853704118645108_2684721365077729_2960526408381310693_n.png', '1598610921favicon.png', 'MayraSales', 'info@mayrasales.com', '0123 456789', 'Footer', 'COPYRIGHT © 2020. All Rights Reserved By&nbsp;mayrasales.com', '#02020c', '1564224328loading3.gif', '1564224329loading3.gif', 0, '<script type=\"text/javascript\">\r\nvar Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();\r\n(function(){\r\nvar s1=document.createElement(\"script\"),s0=document.getElementsByTagName(\"script\")[0];\r\ns1.async=true;\r\ns1.src=\'https://embed.tawk.to/5bc2019c61d0b77092512d03/default\';\r\ns1.charset=\'UTF-8\';\r\ns1.setAttribute(\'crossorigin\',\'*\');\r\ns0.parentNode.insertBefore(s1,s0);\r\n})();\r\n</script>', 1, 1, 1, 'AIzaSyB1GpE4qeoJ__70UZxvX9CTMUTZRZNHcu8', 0, '<div id=\"disqus_thread\">         \r\n    <script>\r\n    /**\r\n    *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.\r\n    *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/\r\n    /*\r\n    var disqus_config = function () {\r\n    this.page.url = PAGE_URL;  // Replace PAGE_URL with your page\'s canonical URL variable\r\n    this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page\'s unique identifier variable\r\n    };\r\n    */\r\n    (function() { // DON\'T EDIT BELOW THIS LINE\r\n    var d = document, s = d.createElement(\'script\');\r\n    s.src = \'https://junnun.disqus.com/embed.js\';\r\n    s.setAttribute(\'data-timestamp\', +new Date());\r\n    (d.head || d.body).appendChild(s);\r\n    })();\r\n    </script>\r\n    <noscript>Please enable JavaScript to view the <a href=\"https://disqus.com/?ref_noscript\">comments powered by Disqus.</a></noscript>\r\n    </div>', 1, 1, 1, 0, 1, 'pk_test_UnU1Coi1p5qFGwtpjZMRMgJM', 'sk_test_QQcg3vGsKRPlW6T3dXcNJsor', 0, 0, 0, 0, 5, 'smtp.zoho.com', '587', 'admin@mayrasales.com', '7Px!wHBwQgx%Tt', 'admin@mayrasales.com', 'Mayra', 0, 1, 0, 'Successfully Added To Cart', 'Out Of Stock', 'Add To Wishlist', 'Already Added To Wishlist', 'Successfully Removed From The Wishlist', 'Successfully Added To Compare', 'Already Added To Compare', 'Successfully Removed From The Compare', 'Successfully Changed The Color', 'Coupon Found', 'No Coupon Found', 'Coupon Already Applied', 'THANK YOU FOR YOUR PURCHASE.', 'We\'ll email you an order confirmation with details and tracking info.', 1, 8, '15587771131554048228onepiece.jpeg', 'Already Added To Cart', 0, 0, 1, 1, 1, 1, 'Pay with cash upon delivery.', 'Pay via your PayPal account.', 'Pay via your Credit Card.', '#ffffff', '#02020c', '#02020c', 1, '#ff5500', '#02020c', 0, 0, 'test_172371aa837ae5cad6047dc3052', 'test_4ac5a785e25fc596b67dbc5c267', 'Pay via your Instamojo account.', 0, 0, 0, 'pk_test_162a56d42131cbb01932ed0d2c48f9cb99d8e8e2', 'junnuns@gmail.com', 'Pay via your Paystack account.', 6, 0, '1566878455404.png', 0, 'NEWSLETTER', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Expedita porro ipsa nulla, alias, ab minus.', '1567488562subscribe.jpg', '1598853719118645108_2684721365077729_2960526408381310693_n.png', '1567655174profile.jpg', '#666666', 0, 1, 0, 'shaon143-facilitator-1@gmail.com', '1598853714118645108_2684721365077729_2960526408381310693_n.png', 'tls', 'tkogux49985047638244', 'LhNGUUKE9xCQ9xY8', 'WEBSTAGING', 'Retail', 0, 'Pay via your Paytm account.', 'live', 0, 'test_5HcWVs9qc5pzy36H9Tu9mwAyats33J', 'Pay with Molly Payment.', 0, 'rzp_test_xDH74d48cwl8DF', 'cr0H1BiQ20hVzhpHfHuNbGri', 'Pay via your Razorpay account.', 0, 0, '<div style=\"text-align: center;\"><font size=\"5\"><br></font></div><h1 style=\"text-align: center;\"><font size=\"6\">UNDER MAINTENANCE</font></h1>', 11, 'MayraSales', 'Shop now at mayra!', 'https://mayrasales.com/assets/images/1598853704118645108_2684721365077729_2960526408381310693_n.png');

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
(1, 1, 'English', '1570967282kjZ4U7oI.json');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(191) UNSIGNED NOT NULL,
  `location` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `location`, `is_default`) VALUES
(0, 'All', 1),
(3, 'Kathmandu', 0),
(4, 'Dharan', 0),
(5, 'Itahari', 0);

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

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(191) NOT NULL,
  `order_id` int(191) UNSIGNED DEFAULT NULL,
  `user_id` int(191) DEFAULT NULL,
  `vendor_id` int(191) DEFAULT NULL,
  `product_id` int(191) DEFAULT NULL,
  `conversation_id` int(191) DEFAULT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(191) DEFAULT NULL,
  `cart` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pickup_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `totalQty` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pay_amount` float NOT NULL,
  `txnid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `txn_image` varchar(255) DEFAULT NULL,
  `charge_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_number` varchar(255) NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `customer_email` varchar(255) NOT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `customer_country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_phone` varchar(255) NOT NULL,
  `customer_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_city` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_zip` varchar(255) DEFAULT NULL,
  `customer_longitude` varchar(255) DEFAULT NULL,
  `customer_latitude` varchar(255) DEFAULT NULL,
  `shipping_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_city` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_zip` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_longitude` varchar(255) DEFAULT NULL,
  `shipping_latitude` varchar(255) DEFAULT NULL,
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
  `tax` int(191) NOT NULL,
  `dp` tinyint(1) NOT NULL DEFAULT '0',
  `pay_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `vendor_shipping_id` int(191) NOT NULL DEFAULT '0',
  `vendor_packing_id` int(191) NOT NULL DEFAULT '0',
  `delivery_range_start` date DEFAULT NULL,
  `delivery_range_end` date DEFAULT NULL,
  `reported` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL DEFAULT '0',
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `subtitle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `price` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `user_id`, `title`, `subtitle`, `price`) VALUES
(1, 0, 'Default Packaging', 'Default packaging by store', 0);

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

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `title`, `slug`, `details`, `meta_tag`, `meta_description`, `header`, `footer`) VALUES
(1, 'About Us', 'about', '<div helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><h2><font size=\"6\">Title number 1</font><br></h2><p><span style=\"font-weight: 700;\">Lorem Ipsum</span>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p></div><div helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><h2><font size=\"6\">Title number 2</font><br></h2><p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p></div><br helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><div helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><h2><font size=\"6\">Title number 3</font><br></h2><p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p><p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p></div><h2 helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-weight:=\"\" 700;=\"\" line-height:=\"\" 1.1;=\"\" color:=\"\" rgb(51,=\"\" 51,=\"\" 51);=\"\" margin:=\"\" 0px=\"\" 15px;=\"\" font-size:=\"\" 30px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\" style=\"font-family: \" 51);\"=\"\"><font size=\"6\">Title number 9</font><br></h2><p helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>', NULL, NULL, 1, 0),
(2, 'Privacy & Policy', 'privacy', '<div helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><h2><img src=\"https://i.imgur.com/BobQuyA.jpg\" width=\"591\"></h2><h2><font size=\"6\">Title number 1</font></h2><p><span style=\"font-weight: 700;\">Lorem Ipsum</span>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p></div><div helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><h2><font size=\"6\">Title number 2</font><br></h2><p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p></div><br helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><div helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><h2><font size=\"6\">Title number 3</font><br></h2><p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p><p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p></div><h2 helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-weight:=\"\" 700;=\"\" line-height:=\"\" 1.1;=\"\" color:=\"\" rgb(51,=\"\" 51,=\"\" 51);=\"\" margin:=\"\" 0px=\"\" 15px;=\"\" font-size:=\"\" 30px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\" 51);\"=\"\" style=\"font-family: \"><font size=\"6\">Title number 9</font><br></h2><p helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>', 'test,test1,test2,test3', 'Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.', 0, 1),
(3, 'Terms & Condition', 'terms', '<div helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><h2><font size=\"6\">Title number 1</font><br></h2><p><span style=\"font-weight: 700;\">Lorem Ipsum</span>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p></div><div helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><h2><font size=\"6\">Title number 2</font><br></h2><p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p></div><br helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><div helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\"><h2><font size=\"6\">Title number 3</font><br></h2><p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p><p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p></div><h2 helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-weight:=\"\" 700;=\"\" line-height:=\"\" 1.1;=\"\" color:=\"\" rgb(51,=\"\" 51,=\"\" 51);=\"\" margin:=\"\" 0px=\"\" 15px;=\"\" font-size:=\"\" 30px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\" 51);\"=\"\" style=\"font-family: \"><font size=\"6\">Title number 9</font><br></h2><p helvetica=\"\" neue\",=\"\" helvetica,=\"\" arial,=\"\" sans-serif;=\"\" font-size:=\"\" 14px;=\"\" font-style:=\"\" normal;=\"\" font-variant-ligatures:=\"\" font-variant-caps:=\"\" font-weight:=\"\" 400;=\"\" letter-spacing:=\"\" orphans:=\"\" 2;=\"\" text-align:=\"\" start;=\"\" text-indent:=\"\" 0px;=\"\" text-transform:=\"\" none;=\"\" white-space:=\"\" widows:=\"\" word-spacing:=\"\" -webkit-text-stroke-width:=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);=\"\" text-decoration-style:=\"\" initial;=\"\" text-decoration-color:=\"\" initial;\"=\"\">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>', 't1,t2,t3,t4', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.', 0, 1);

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
(1, 'Success! Thanks for contacting us, we will get back to you shortly.', 'admin@mayrasales.com', '<h4 class=\"subtitle\" style=\"margin-bottom: 6px; font-weight: 600; line-height: 28px; font-size: 28px; text-transform: uppercase;\">WE\'D LOVE TO</h4><h2 class=\"title\" style=\"margin-bottom: 13px;font-weight: 600;line-height: 50px;font-size: 40px;color: #0f78f2;text-transform: uppercase;\">HEAR FROM YOU</h2>', '<span style=\"color: rgb(119, 119, 119);\">Send us a message and we\' ll respond as soon as possible</span><br>', '<h4 class=\"title\" style=\"margin-bottom: 10px; font-weight: 600; line-height: 28px; font-size: 28px;\">Let\'s Connect</h4>', '<span style=\"color: rgb(51, 51, 51);\">Get in touch with us</span>', 'Nepal', '00 000 000 000', '00 000 000 000', 'admin@mayrasales.com', 'https://mayrasales.com/', 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, '1568889138banner1.jpg', 'http://google.com', '1565150264banner3.jpg', 'http://google.com', 0, 0, '1568889138banner2.jpg', 'http://google.com', '1565150264banner4.jpg', 'http://google.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `partners`
--

CREATE TABLE `partners` (
  `id` int(191) NOT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateways`
--

CREATE TABLE `payment_gateways` (
  `id` int(191) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `subtitle` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` tinyint(10) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment_gateways`
--

INSERT INTO `payment_gateways` (`id`, `user_id`, `subtitle`, `title`, `details`, `status`) VALUES
(51, 0, NULL, 'Khalti Test', 'Our Khalti address is 89439349<br>', 1),
(53, 0, NULL, 'Esewa', 'Address is 956<br>', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pickups`
--

CREATE TABLE `pickups` (
  `id` int(191) UNSIGNED NOT NULL,
  `location` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `previous_price` double DEFAULT NULL,
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
  `catalog_id` int(191) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `product_clicks`
--

CREATE TABLE `product_clicks` (
  `id` int(191) NOT NULL,
  `product_id` int(191) NOT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `review_date` datetime NOT NULL
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
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL,
  `product_id` int(192) NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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
  `details` text COLLATE utf8mb4_unicode_ci
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
(1, '<script>//Google Analytics Scriptfffffffffffffffffffffffssssfffffs</script>', 'Mayra,Sales');

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
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `user_agent` text,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('y7icfMoF4RRFNghdIERaNv2H8bi8RdNG5v0GppDv', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:80.0) Gecko/20100101 Firefox/80.0', 'YTo5OntzOjY6Il90b2tlbiI7czo0MDoiWFJxQmptdVVaaFV2c1M2R1BCZHdMVmNRVzloNHFlWUhzRldWQjEzeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vbWF5cmFzYWxlcy5sb2NhbCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NToicG9wdXAiO2k6MTtzOjE0OiJjYXB0Y2hhX3N0cmluZyI7czo2OiJyM1NzbUsiO3M6OToidGVtcG9yZGVyIjtPOjE2OiJBcHBcTW9kZWxzXE9yZGVyIjoyNjp7czoxMToiACoAZmlsbGFibGUiO2E6MzI6e2k6MDtzOjc6InVzZXJfaWQiO2k6MTtzOjQ6ImNhcnQiO2k6MjtzOjY6Im1ldGhvZCI7aTozO3M6ODoic2hpcHBpbmciO2k6NDtzOjE1OiJwaWNrdXBfbG9jYXRpb24iO2k6NTtzOjg6InRvdGFsUXR5IjtpOjY7czoxMDoicGF5X2Ftb3VudCI7aTo3O3M6NToidHhuaWQiO2k6ODtzOjk6InR4bl9pbWFnZSI7aTo5O3M6OToiY2hhcmdlX2lkIjtpOjEwO3M6MTI6Im9yZGVyX251bWJlciI7aToxMTtzOjE0OiJwYXltZW50X3N0YXR1cyI7aToxMjtzOjE0OiJjdXN0b21lcl9lbWFpbCI7aToxMztzOjEzOiJjdXN0b21lcl9uYW1lIjtpOjE0O3M6MTQ6ImN1c3RvbWVyX3Bob25lIjtpOjE1O3M6MTY6ImN1c3RvbWVyX2FkZHJlc3MiO2k6MTY7czoxMzoiY3VzdG9tZXJfY2l0eSI7aToxNztzOjEyOiJjdXN0b21lcl96aXAiO2k6MTg7czoxODoiY3VzdG9tZXJfbG9uZ2l0dWRlIjtpOjE5O3M6MTc6ImN1c3RvbWVyX2xhdGl0dWRlIjtpOjIwO3M6MTM6InNoaXBwaW5nX25hbWUiO2k6MjE7czoxNDoic2hpcHBpbmdfZW1haWwiO2k6MjI7czoxNDoic2hpcHBpbmdfcGhvbmUiO2k6MjM7czoxNjoic2hpcHBpbmdfYWRkcmVzcyI7aToyNDtzOjEzOiJzaGlwcGluZ19jaXR5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ZXNzIjtzOjY6IkJvdWRoYSI7czoxNjoiY3VzdG9tZXJfY291bnRyeSI7czo1OiJOZXBhbCI7czoxMzoiY3VzdG9tZXJfY2l0eSI7TjtzOjEyOiJjdXN0b21lcl96aXAiO047czoxODoiY3VzdG9tZXJfbG9uZ2l0dWRlIjtzOjk6Ijg1LjM0NDYyMiI7czoxNzoiY3VzdG9tZXJfbGF0aXR1ZGUiO3M6MTA6IjI3LjY5MTAyMjkiO3M6MTQ6InNoaXBwaW5nX2VtYWlsIjtOO3M6MTM6InNoaXBwaW5nX25hbWUiO047czoxNDoic2hpcHBpbmdfcGhvbmUiO047czoxNjoic2hpcHBpbmdfYWRkcmVzcyI7TjtzOjE2OiJzaGlwcGluZ19jb3VudHJ5IjtzOjU6Ik5lcGFsIjtzOjEzOiJzaGlwcGluZ19jaXR5IjtOO3M6MTI6InNoaXBwaW5nX3ppcCI7TjtzOjE4OiJzaGlwcGluZ19sb25naXR1ZGUiO047czoxNzoic2hpcHBpbmdfbGF0aXR1ZGUiO047czoxMDoib3JkZXJfbm90ZSI7TjtzOjExOiJjb3Vwb25fY29kZSI7TjtzOjE1OiJjb3Vwb25fZGlzY291bnQiO047czoyOiJkcCI7czoxOiIwIjtzOjE0OiJwYXltZW50X3N0YXR1cyI7czo3OiJQZW5kaW5nIjtzOjEzOiJjdXJyZW5jeV9zaWduIjtzOjM6IlJzLiI7czoxNDoiY3VycmVuY3lfdmFsdWUiO2Q6MTtzOjE4OiJ2ZW5kb3Jfc2hpcHBpbmdfaWQiO3M6MToiMCI7czoxNzoidmVuZG9yX3BhY2tpbmdfaWQiO3M6MToiMCI7czoyMDoiZGVsaXZlcnlfcmFuZ2Vfc3RhcnQiO3M6MTA6IjIwMjAtMDktMTAiO3M6MTg6ImRlbGl2ZXJ5X3JhbmdlX2VuZCI7czoxMDoiMjAyMC0wOS0xOCI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMC0wOS0xMCAwNDowNzoyMCI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMC0wOS0xMCAwNDowNzoyMCI7czoyOiJpZCI7aToxO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fXM6ODoidGVtcGNhcnQiO086MTU6IkFwcFxNb2RlbHNcQ2FydCI6Mjk6e3M6NToiaXRlbXMiO2E6MTp7aToyO2E6MTM6e3M6MzoicXR5IjtpOjE7czo4OiJzaXplX2tleSI7aTowO3M6ODoic2l6ZV9xdHkiO3M6MDoiIjtzOjEwOiJzaXplX3ByaWNlIjtzOjA6IiI7czo0OiJzaXplIjtzOjA6IiI7czo1OiJjb2xvciI7czowOiIiO3M6NToic3RvY2siO047czo1OiJwcmljZSI7ZDoxMDA7czo0OiJpdGVtIjtPOjE4OiJBcHBcTW9kZWxzXFByb2R1Y3QiOjI2OntzOjExOiIAKgBmaWxsYWJsZSI7YTo1Mjp7aTowO3M6NzoidXNlcl9pZCI7aToxO3M6MTE6ImNhdGVnb3J5X2lkIjtpOjI7czoxMjoicHJvZHVjdF90eXBlIjtpOjM7czoxNDoiYWZmaWxpYXRlX2xpbmsiO2k6NDtzOjM6InNrdSI7aTo1O3M6MTQ6InN1YmNhdGVnb3J5X2lkIjtpOjY7czoxNjoiY2hpbGRjYXRlZ29yeV9pZCI7aTo3O3M6MTA6ImF0dHJpYnV0ZXMiO2k6ODtzOjQ6Im5hbWUiO2k6OTtzOjU6InBob3RvIjtpOjEwO3M6NDoic2l6ZSI7aToxMTtzOjg6InNpemVfcXR5IjtpOjEyO3M6MTA6InNpemVfcHJpY2UiO2k6MTM7czo1OiJjb2xvciI7aToxNDtzOjc6ImRldGFpbHMiO2k6MTU7czo1OiJwcmljZSI7aToxNjtzOjE0OiJwcmV2aW91c19wcmljZSI7aToxNztzOjU6InN0b2NrIjtpOjE4O3M6NjoicG9saWN5IjtpOjE5O3M6Njoic3RhdHVzIjtpOjIwO3M6NToidmlld3MiO2k6MjE7czo0OiJ0YWdzIjtpOjIyO3M6ODoiZmVhdHVyZWQiO2k6MjM7czo0OiJiZXN0IjtpOjI0O3M6MzoidG9wIjtpOjI1O3M6MzoiaG90IjtpOjI2O3M6NjoibGF0ZXN0IjtpOjI3O3M6MzoiYmlnIjtpOjI4O3M6ODoidHJlbmRpbmciO2k6Mjk7czo0OiJzYWxlIjtpOjMwO3M6ODoiZmVhdHVyZXMiO2k6MzE7czo2OiJjb2xvcnMiO2k6MzI7czoxNzoicHJvZHVjdF9jb25kaXRpb24iO2k6MzM7czo0OiJzaGlwIjtpOjM0O3M6ODoibWV0YV90YWciO2k6MzU7czoxNjoibWV0YV9kZXNjcmlwdGlvbiI7aTozNjtzOjc6InlvdXR1YmUiO2k6Mzc7czo0OiJ0eXBlIjtpOjM4O3M6NDoiZmlsZSI7aTozOTtzOjc6ImxpY2Vuc2UiO2k6NDA7czoxMToibGljZW5zZV9xdHkiO2k6NDE7czo0OiJsaW5rIjtpOjQyO3M6ODoicGxhdGZvcm0iO2k6NDM7czo2OiJyZWdpb24iO2k6NDQ7czoxMjoibGljZW5jZV90eXBlIjtpOjQ1O3M6NzoibWVhc3VyZSI7aTo0NjtzOjEzOiJkaXNjb3VudF9kYXRlIjtpOjQ3O3M6MTE6ImlzX2Rpc2NvdW50IjtpOjQ4O3M6MTQ6Indob2xlX3NlbGxfcXR5IjtpOjQ5O3M6MTk6Indob2xlX3NlbGxfZGlzY291bnQiO2k6NTA7czoxMDoiY2F0YWxvZ19pZCI7aTo1MTtzOjQ6InNsdWciO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtOO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MjA6e3M6MjoiaWQiO2k6MjtzOjc6InVzZXJfaWQiO2k6MjtzOjQ6InNsdWciO3M6MTg6InBlcy0yMC0wZ3UxMzk1dHB5cyI7czo0OiJuYW1lIjtzOjY6IlBFUyAyMCI7czo1OiJwaG90byI7czoyMjoiMTU5OTY2MTQ0NWJGc3E1eUVyLnBuZyI7czo0OiJzaXplIjtOO3M6ODoic2l6ZV9xdHkiO047czoxMDoic2l6ZV9wcmljZSI7TjtzOjU6ImNvbG9yIjtOO3M6NToicHJpY2UiO2Q6MTAwO3M6NToic3RvY2siO047czo0OiJ0eXBlIjtzOjg6IlBoeXNpY2FsIjtzOjQ6ImZpbGUiO047czo0OiJsaW5rIjtOO3M6NzoibGljZW5zZSI7TjtzOjExOiJsaWNlbnNlX3F0eSI7TjtzOjc6Im1lYXN1cmUiO047czoxNDoid2hvbGVfc2VsbF9xdHkiO047czoxOToid2hvbGVfc2VsbF9kaXNjb3VudCI7TjtzOjEwOiJhdHRyaWJ1dGVzIjtOO31zOjExOiIAKgBvcmlnaW5hbCI7YToyMDp7czoyOiJpZCI7aToyO3M6NzoidXNlcl9pZCI7aToyO3M6NDoic2x1ZyI7czoxODoicGVzLTIwLTBndTEzOTV0cHlzIjtzOjQ6Im5hbWUiO3M6NjoiUEVTIDIwIjtzOjU6InBob3RvIjtzOjIyOiIxNTk5NjYxNDQ1YkZzcTV5RXIucG5nIjtzOjQ6InNpemUiO047czo4OiJzaXplX3F0eSI7TjtzOjEwOiJzaXplX3ByaWNlIjtOO3M6NToiY29sb3IiO047czo1OiJwcmljZSI7ZDoxMDA7czo1OiJzdG9jayI7TjtzOjQ6InR5cGUiO3M6ODoiUGh5c2ljYWwiO3M6NDoiZmlsZSI7TjtzOjQ6ImxpbmsiO047czo3OiJsaWNlbnNlIjtOO3M6MTE6ImxpY2Vuc2VfcXR5IjtOO3M6NzoibWVhc3VyZSI7TjtzOjE0OiJ3aG9sZV9zZWxsX3F0eSI7TjtzOjE5OiJ3aG9sZV9zZWxsX2Rp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MTQ6InByZXZpb3VzX3ByaWNlIjtpOjE3O3M6NToic3RvY2siO2k6MTg7czo2OiJwb2xpY3kiO2k6MTk7czo2OiJzdGF0dXMiO2k6MjA7czo1OiJ2aWV3cyI7aToyMTtzOjQ6InRhZ3MiO2k6MjI7czo4OiJmZWF0dXJlZCI7aToyMztzOjQ6ImJlc3QiO2k6MjQ7czozOiJ0b3AiO2k6MjU7czozOiJob3QiO2k6MjY7czo2OiJsYXRlc3QiO2k6Mjc7czozOiJiaWciO2k6Mjg7czo4OiJ0cmVuZGluZyI7aToyOTtzOjQ6InNhbGUiO2k6MzA7czo4OiJmZWF0dXJlcyI7aTozMTtzOjY6ImNvbG9ycyI7aTozMjtzOjE3OiJwcm9kdWN0X2NvbmRpdGlvbiI7aTozMztzOjQ6InNoaXAiO2k6MzQ7czo4OiJtZXRhX3RhZyI7aTozNTtzOjE2OiJtZXRhX2Rlc2NyaXB0aW9uIjtpOjM2O3M6NzoieW91dHViZSI7aTozNztzOjQ6InR5cGUiO2k6Mzg7czo0OiJmaWxlIjtpOjM5O3M6NzoibGljZW5zZSI7aTo0MDtzOjExOiJsaWNlbnNlX3F0eSI7aTo0MTtzOjQ6ImxpbmsiO2k6NDI7czo4OiJwbGF0Zm9ybSI7aTo0MztzOjY6InJlZ2lvbiI7aTo0NDtzOjEyOiJsaWNlbmNlX3R5cGUiO2k6NDU7czo3OiJtZWFzdXJlIjtpOjQ2O3M6MTM6ImRpc2NvdW50X2RhdGUiO2k6NDc7czoxMToiaXNfZGlzY291bnQiO2k6NDg7czoxNDoid2hvbGVfc2VsbF9xdHkiO2k6NDk7czoxOToid2hvbGVfc2VsbF9kaXNjb3VudCI7aTo1MDtzOjEwOiJjYXRhbG9nX2lkIjtpOjUxO3M6NDoic2x1ZyI7fXM6MTM6IgAqAGNvbm5lY3Rpb24iO3M6NToibXlzcWwiO3M6ODoiACoAdGFibGUiO047czoxMzoiACoAcHJpbWFyeUtleSI7czoyOiJpZCI7czoxMDoiACoAa2V5VHlwZSI7czozOiJpbnQiO3M6MTI6ImluY3JlbWVudGluZyI7YjoxO3M6NzoiACoAd2l0aCI7YTowOnt9czoxMjoiACoAd2l0aENvdW50IjthOjA6e31zOjEwOiIAKgBwZXJQYWdlIjtpOjE1O3M6NjoiZXhpc3RzIjtiOjE7czoxODoid2FzUmVjZW50bHlDcmVhdGVkIjtiOjA7czoxMzoiACoAYXR0cmlidXRlcyI7YToyMDp7czoyOiJpZCI7aToxO3M6NzoidXNlcl9pZCI7aToyO3M6NDoic2x1ZyI7czoxODoiZmlmYS0yMC05b2IyMjY1dGR4IjtzOjQ6Im5hbWUiO3M6NzoiRklGQSAyMCI7czo1OiJwaG90byI7czoyMjoiMTU5OTM2MjMwM0xTTFZVMkpMLnBuZyI7czo0OiJzaXplIjtOO3M6ODoic2l6ZV9xdHkiO047czoxMDoic2l6ZV9wcmljZSI7TjtzOjU6ImNvbG9yIjtOO3M6NToicHJpY2UiO2Q6NTAwO3M6NToic3RvY2siO047czo0OiJ0eXBlIjtzOjg6IlBoeXNpY2FsIjtzOjQ6ImZpbGUiO047czo0OiJsaW5rIjtOO3M6NzoibGljZW5zZSI7TjtzOjExOiJsaWNlbnNlX3F0eSI7TjtzOjc6Im1lYXN1cmUiO047czoxNDoid2hvbGVfc2VsbF9xdHkiO047czoxOToid2hvbGVfc2VsbF9kaXNjb3VudCI7TjtzOjEwOiJhdHRyaWJ1dGVzIjtOO31zOjExOiIAKgBvcmlnaW5hbCI7YToyMDp7czoyOiJpZCI7aToxO3M6NzoidXNlcl9pZCI7aToyO3M6NDoic2x1ZyI7czoxODoiZmlmYS0yMC05b2IyMjY1dGR4IjtzOjQ6Im5hbWUiO3M6NzoiRklGQSAyMCI7czo1OiJwaG90byI7czoyMjoiMTU5OTM2MjMwM0xTTFZVMkpMLnBuZyI7czo0OiJzaXplIjtOO3M6ODoic2l6ZV9xdHkiO047czoxMDoic2l6ZV9wcmljZSI7TjtzOjU6ImNvbG9yIjtOO3M6NToicHJpY2UiO2Q6NTAwO3M6NToic3RvY2siO047czo0OiJ0eXBlIjtzOjg6IlBoeXNpY2FsIjtzOjQ6ImZpbGUiO047czo0OiJsaW5rIjtOO3M6NzoibGljZW5zZSI7TjtzOjExOiJsaWNlbnNlX3F0eSI7TjtzOjc6Im1lYXN1cmUiO047czoxNDoid2hvbGVfc2VsbF9xdHkiO047czoxOToid2hvbGVfc2VsbF9kaXNjb3VudCI7TjtzOjEwOiJhdHRyaWJ1dGVzIjtOO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fXM6NzoibGljZW5zZSI7czowOiIiO3M6MjoiZHAiO3M6MToiMCI7czo0OiJrZXlzIjtzOjA6IiI7czo2OiJ2YWx1ZXMiO3M6MDoiIjt9aToyO2E6MTM6e3M6MzoicXR5IjtpOjE7czo4OiJzaXplX2tleSI7aTowO3M6ODoic2l6ZV9xdHkiO3M6MDoiIjtzOjEwOiJzaXplX3ByaWNlIjtzOjA6IiI7czo0OiJzaXplIjtzOjA6IiI7czo1OiJjb2xvciI7czowOiIiO3M6NToic3RvY2siO047czo1OiJwcmljZSI7ZDoxMDA7czo0OiJpdGVtIjtPOjE4OiJBcHBcTW9kZWxzXFByb2R1Y3QiOjI2OntzOjExOiIAKgBmaWxsYWJsZSI7YTo1Mjp7aTowO3M6NzoidXNlcl9pZCI7aToxO3M6MTE6ImNhdGVnb3J5X2lkIjtpOjI7czoxMjoicHJvZHVjdF90eXBlIjtpOjM7czoxNDoiYWZmaWxpYXRlX2xpbmsiO2k6NDtzOjM6InNrdSI7aTo1O3M6MTQ6InN1YmNhdGVnb3J5X2lkIjtpOjY7czoxNjoiY2hpbGRjYXRlZ29yeV9pZCI7aTo3O3M6MTA6ImF0dHJpYnV0ZXMiO2k6ODtzOjQ6Im5hbWUiO2k6OTtzOjU6InBob3RvIjtpOjEwO3M6NDoic2l6ZSI7aToxMTtzOjg6InNpemVfcXR5IjtpOjEyO3M6MTA6InNpemVfcHJpY2UiO2k6MTM7czo1OiJjb2xvciI7aToxNDtzOjc6ImRldGFpbHMiO2k6MTU7czo1OiJwcmljZSI7aToxNjtzOjE0OiJwcmV2aW91c19wcmljZSI7aToxNztzOjU6InN0b2NrIjtpOjE4O3M6NjoicG9saWN5IjtpOjE5O3M6Njoic3RhdHVzIjtpOjIwO3M6NToidmlld3MiO2k6MjE7czo0OiJ0YWdzIjtpOjIyO3M6ODoiZmVhdHVyZWQiO2k6MjM7czo0OiJiZXN0IjtpOjI0O3M6MzoidG9wIjtpOjI1O3M6MzoiaG90IjtpOjI2O3M6NjoibGF0ZXN0IjtpOjI3O3M6MzoiYmlnIjtpOjI4O3M6ODoidHJlbmRpbmciO2k6Mjk7czo0OiJzYWxlIjtpOjMwO3M6ODoiZmVhdHVyZXMiO2k6MzE7czo2OiJjb2xvcnMiO2k6MzI7czoxNzoicHJvZHVjdF9jb25kaXRpb24iO2k6MzM7czo0OiJzaGlwIjtpOjM0O3M6ODoibWV0YV90YWciO2k6MzU7czoxNjoibWV0YV9kZXNjcmlwdGlvbiI7aTozNjtzOjc6InlvdXR1YmUiO2k6Mzc7czo0OiJ0eXBlIjtpOjM4O3M6NDoiZmlsZSI7aTozOTtzOjc6ImxpY2Vuc2UiO2k6NDA7czoxMToibGljZW5zZV9xdHkiO2k6NDE7czo0OiJsaW5rIjtpOjQyO3M6ODoicGxhdGZvcm0iO2k6NDM7czo2OiJyZWdpb24iO2k6NDQ7czoxMjoibGljZW5jZV90eXBlIjtpOjQ1O3M6NzoibWVhc3VyZSI7aTo0NjtzOjEzOiJkaXNjb3VudF9kYXRlIjtpOjQ3O3M6MTE6ImlzX2Rpc2NvdW50IjtpOjQ4O3M6MTQ6Indob2xlX3NlbGxfcXR5IjtpOjQ5O3M6MTk6Indob2xlX3NlbGxfZGlzY291bnQiO2k6NTA7czoxMDoiY2F0YWxvZ19pZCI7aTo1MTtzOjQ6InNsdWciO31zOjEzOiIAKgBjb25uZWN0aW9uIjtzOjU6Im15c3FsIjtzOjg6IgAqAHRhYmxlIjtOO3M6MTM6IgAqAHByaW1hcnlLZXkiO3M6MjoiaWQiO3M6MTA6IgAqAGtleVR5cGUiO3M6MzoiaW50IjtzOjEyOiJpbmNyZW1lbnRpbmciO2I6MTtzOjc6IgAqAHdpdGgiO2E6MDp7fXM6MTI6IgAqAHdpdGhDb3VudCI7YTowOnt9czoxMDoiACoAcGVyUGFnZSI7aToxNTtzOjY6ImV4aXN0cyI7YjoxO3M6MTg6Indhc1JlY2VudGx5Q3JlYXRlZCI7YjowO3M6MTM6IgAqAGF0dHJpYnV0ZXMiO2E6MjA6e3M6MjoiaWQiO2k6MjtzOjc6InVzZXJfaWQiO2k6MjtzOjQ6InNsdWciO3M6MTg6InBlcy0yMC0wZ3UxMzk1dHB5cyI7czo0OiJuYW1lIjtzOjY6IlBFUyAyMCI7czo1OiJwaG90byI7czoyMjoiMTU5OTY2MTQ0NWJGc3E1eUVyLnBuZyI7czo0OiJzaXplIjtOO3M6ODoic2l6ZV9xdHkiO047czoxMDoic2l6ZV9wcmljZSI7TjtzOjU6ImNvbG9yIjtOO3M6NToicHJpY2UiO2Q6MTAwO3M6NToic3RvY2siO047czo0OiJ0eXBlIjtzOjg6IlBoeXNpY2FsIjtzOjQ6ImZpbGUiO047czo0OiJsaW5rIjtOO3M6NzoibGljZW5zZSI7TjtzOjExOiJsaWNlbnNlX3F0eSI7TjtzOjc6Im1lYXN1cmUiO047czoxNDoid2hvbGVfc2VsbF9xdHkiO047czoxOToid2hvbGVfc2VsbF9kaXNjb3VudCI7TjtzOjEwOiJhdHRyaWJ1dGVzIjtOO31zOjExOiIAKgBvcmlnaW5hbCI7YToyMDp7czoyOiJpZCI7aToyO3M6NzoidXNlcl9pZCI7aToyO3M6NDoic2x1ZyI7czoxODoicGVzLTIwLTBndTEzOTV0cHlzIjtzOjQ6Im5hbWUiO3M6NjoiUEVTIDIwIjtzOjU6InBob3RvIjtzOjIyOiIxNTk5NjYxNDQ1YkZzcTV5RXIucG5nIjtzOjQ6InNpemUiO047czo4OiJzaXplX3F0eSI7TjtzOjEwOiJzaXplX3ByaWNlIjtOO3M6NToiY29sb3IiO047czo1OiJwcmljZSI7ZDoxMDA7czo1OiJzdG9jayI7TjtzOjQ6InR5cGUiO3M6ODoiUGh5c2ljYWwiO3M6NDoiZmlsZSI7TjtzOjQ6ImxpbmsiO047czo3OiJsaWNlbnNlIjtOO3M6MTE6ImxpY2Vuc2VfcXR5IjtOO3M6NzoibWVhc3VyZSI7TjtzOjE0OiJ3aG9sZV9zZWxsX3F0eSI7TjtzOjE5OiJ3aG9sZV9zZWxsX2Rpc2NvdW50IjtOO3M6MTA6ImF0dHJpYnV0ZXMiO047fXM6MTA6IgAqAGNoYW5nZXMiO2E6MDp7fXM6ODoiACoAY2FzdHMiO2E6MDp7fXM6ODoiACoAZGF0ZXMiO2E6MDp7fXM6MTM6IgAqAGRhdGVGb3JtYXQiO047czoxMDoiACoAYXBwZW5kcyI7YTowOnt9czoxOToiACoAZGlzcGF0Y2hlc0V2ZW50cyI7YTowOnt9czoxNDoiACoAb2JzZXJ2YWJsZXMiO2E6MDp7fXM6MTI6IgAqAHJlbGF0aW9ucyI7YTowOnt9czoxMDoiACoAdG91Y2hlcyI7YTowOnt9czoxMDoidGltZXN0YW1wcyI7YjoxO3M6OToiACoAaGlkZGVuIjthOjA6e31zOjEwOiIAKgB2aXNpYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319czo3OiJsaWNlbnNlIjtzOjA6IiI7czoyOiJkcCI7czoxOiIwIjtzOjQ6ImtleXMiO3M6MDoiIjtzOjY6InZhbHVlcyI7czowOiIiO319czo4OiJ0b3RhbFF0eSI7aToyO3M6MTA6InRvdGFsUHJpY2UiO2Q6NjAwO3M6MTM6IgAqAGNvbm5lY3Rpb24iO047czo4OiIAKgB0YWJsZSI7TjtzOjEzOiIAKgBwcmltYXJ5S2V5IjtzOjI6ImlkIjtzOjEwOiIAKgBrZXlUeXBlIjtzOjM6ImludCI7czoxMjoiaW5jcmVtZW50aW5nIjtiOjE7czo3OiIAKgB3aXRoIjthOjA6e31zOjEyOiIAKgB3aXRoQ291bnQiO2E6MDp7fXM6MTA6IgAqAHBlclBhZ2UiO2k6MTU7czo2OiJleGlzdHMiO2I6MDtzOjE4OiJ3YXNSZWNlbnRseUNyZWF0ZWQiO2I6MDtzOjEzOiIAKgBhdHRyaWJ1dGVzIjthOjA6e31zOjExOiIAKgBvcmlnaW5hbCI7YTowOnt9czoxMDoiACoAY2hhbmdlcyI7YTowOnt9czo4OiIAKgBjYXN0cyI7YTowOnt9czo4OiIAKgBkYXRlcyI7YTowOnt9czoxMzoiACoAZGF0ZUZvcm1hdCI7TjtzOjEwOiIAKgBhcHBlbmRzIjthOjA6e31zOjE5OiIAKgBkaXNwYXRjaGVzRXZlbnRzIjthOjA6e31zOjE0OiIAKgBvYnNlcnZhYmxlcyI7YTowOnt9czoxMjoiACoAcmVsYXRpb25zIjthOjA6e31zOjEwOiIAKgB0b3VjaGVzIjthOjA6e31zOjEwOiJ0aW1lc3RhbXBzIjtiOjE7czo5OiIAKgBoaWRkZW4iO2E6MDp7fXM6MTA6IgAqAHZpc2libGUiO2E6MDp7fXM6MTE6IgAqAGZpbGxhYmxlIjthOjA6e31zOjEwOiIAKgBndWFyZGVkIjthOjE6e2k6MDtzOjE6IioiO319fQ==', 1599748091),
('aJZbCb1jkSXaTqsEVxrjvF2FbqPcZ3muA3D7roJH', 2, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:80.0) Gecko/20100101 Firefox/80.0', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoibzY5Q2dBclh0eEZkOVVLYWlUSU5wRXFXOXdFNWJpWWRiVTZqamt2ZCI7czoxNDoiY2FwdGNoYV9zdHJpbmciO3M6NjoiS0tCS3pRIjtzOjU6InBvcHVwIjtpOjE7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vbWF5cmFzYWxlcy5sb2NhbC91c2VyL21lc3NhZ2UvMiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czo5OiJ0ZW1wb3JkZXIiO086MTY6IkFwcFxNb2RlbHNcT3JkZXIiOjI2OntzOjExOiIAKgBmaWxsYWJsZSI7YTozMzp7aTowO3M6NzoidXNlcl9pZCI7aToxO3M6NDoiY2FydCI7aToyO3M6NjoibWV0aG9kIjtpOjM7czo4OiJzaGlwcGluZyI7aTo0O3M6MTU6InBpY2t1cF9sb2NhdGlvbiI7aTo1O3M6ODoidG90YWxRdHkiO2k6NjtzOjEwOiJwYXlfYW1vdW50IjtpOjc7czo1OiJ0eG5pZCI7aTo4O3M6OToidHhuX2ltYWdlIjtpOjk7czo5OiJjaGFyZ2VfaWQiO2k6MTA7czoxMjoib3JkZXJfbnVtYmVyIjtpOjExO3M6MTQ6InBheW1lbnRfc3RhdHVzIjtpOjEyO3M6MTQ6ImN1c3RvbWVyX2VtYWlsIjtpOjEzO3M6MTM6ImN1c3RvbWVyX25hbWUiO2k6MTQ7czoxNDoiY3VzdG9tZXJfcGhvbmUiO2k6MTU7czoxNjoiY3VzdG9tZXJfYWRkcmVzcyI7aToxNjtzOjEzOiJjdXN0b21lcl9jaXR5IjtpOjE3O3M6MTI6ImN1c3RvbWVyX3ppcCI7aToxODtzOjE4OiJjdXN0b21lcl9sb25naXR1ZGUiO2k6MTk7czoxNzoiY3VzdG9tZXJfbGF0aXR1ZGUiO2k6MjA7czoxMzoic2hpcHBpbmdfbmFtZSI7aToyMTtzOjE0OiJzaGlwcGluZ19lbWFpbCI7aToy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O047czoxMjoiY3VzdG9tZXJfemlwIjtOO3M6MTg6ImN1c3RvbWVyX2xvbmdpdHVkZSI7czo5OiI4NS4zNDQ2MjIiO3M6MTc6ImN1c3RvbWVyX2xhdGl0dWRlIjtzOjEwOiIyNy42OTEwMjI5IjtzOjE0OiJzaGlwcGluZ19lbWFpbCI7TjtzOjEzOiJzaGlwcGluZ19uYW1lIjtOO3M6MTQ6InNoaXBwaW5nX3Bob25lIjtOO3M6MTY6InNoaXBwaW5nX2FkZHJlc3MiO047czoxNjoic2hpcHBpbmdfY291bnRyeSI7czo1OiJOZXBhbCI7czoxMzoic2hpcHBpbmdfY2l0eSI7TjtzOjEyOiJzaGlwcGluZ196aXAiO047czoxODoic2hpcHBpbmdfbG9uZ2l0dWRlIjtOO3M6MTc6InNoaXBwaW5nX2xhdGl0dWRlIjtOO3M6MTA6Im9yZGVyX25vdGUiO047czoxMToiY291cG9uX2NvZGUiO047czoxNToiY291cG9uX2Rpc2NvdW50IjtOO3M6MjoiZHAiO3M6MToiMCI7czoxNDoicGF5bWVudF9zdGF0dXMiO3M6NzoiUGVuZGluZyI7czoxMzoiY3VycmVuY3lfc2lnbiI7czozOiJScy4iO3M6MTQ6ImN1cnJlbmN5X3ZhbHVlIjtkOjE7czoxODoidmVuZG9yX3NoaXBwaW5nX2lkIjtzOjE6IjAiO3M6MTc6InZlbmRvcl9wYWNraW5nX2lkIjtzOjE6IjAiO3M6MjA6ImRlbGl2ZXJ5X3JhbmdlX3N0YXJ0IjtzOjEwOiIyMDIwLTA5LTEwIjtzOjE4OiJkZWxpdmVyeV9yYW5nZV9lbmQiO3M6MTA6IjIwMjAtMDktMTEiO3M6MTA6InVwZGF0ZWRfYXQiO3M6MTk6IjIwMjAtMDktMTAgMTQ6NDI6NTIiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6MTk6IjIwMjAtMDktMTAgMTQ6NDI6NTIiO3M6MjoiaWQiO2k6Mjt9czoxMToiACoAb3JpZ2luYWwiO2E6NDM6e3M6NzoidXNlcl9pZCI7czoxOiIyIjtzOjQ6ImNhcnQiO3M6MTYwNToiQlpoOTFBWSZTWcOYPcOew4wAA8Kfw5/CgEAAUBN/w7grP8O/BMK/w6/Dv8O6UAV7w50CLMKxFAAaCMOmATACYAATAAEwABLCgCDCqQfClAAAaA00AAAEwprCklAAA0BoAAxANMOQAMOmATACYAATAAEwABIiCCApw6DCmSnDrUnCtTIPU0NHwqnCmsKGaMOUwqDCkMKwSGvCmsOAScKQwp9mAiJ4wojDpBLDh8Ktw4fCucKPHMKYFCoyWsO4woxHwojDrMOpJB8RwpIYw7lEPRTCgMORQsOowrDCjcK/wrLCmR0uTkrClsKELx0IwoTDjMOLZ8OwwqbCqsKVNsOkHGzDjMORwqTCpiYmwqPCl8KZwoFjXQgsWcKVw55TcgAOAMKRB8OIw4DDsCfDrg9YdTrCiWLCk0jCoQkKwp7CuDBpw5XClcKbMQBcaEVBwqbChsKVwq9rURVnccOUwoDDshrDtg1cYsKwQQjCgMOBw4YMwqY/w5kEwovDnDDCsA3CsTc2wptpKiJTBMOaBsOBwqnCisONZShNIMKJwpVMShQpUGwiwrMzSAUtFMKlKUE2DGgZScKZwqXDjEkoKkUrwr1sw4jDhyjDgwMZJMKBwoUwOMOEwpgocMOlHGRJRjUyKXTCi217wrBbwpw5woDDgkQIwqXCvcKtTcKEwqQjJF1CKjPCu8KEVcOMwolYBQh0wosGJMKFwpJVw5XCrUMVVV7CqXrCkhbCtcO/BMKgTcKgbAbDkExAD8KDKFbCqCnCgsOLSsKXRiUUWENhwotQYRkZBgR4w4EuwrECwpAUAWQFHVNjw5XCrMOZwqoSFkDCksKrQhHDsBjDjVTCgwpUwq0Kw5DDl2lQZyvDgcOODsO1woLDtWbDnMKBN2xsw5sbwqbDgcKYczTDhS7CijXCgMKpLUdNYHprwoN6w45xQsKbw5EKYzRmLTc4asKRY0w5QcOMKcO1w7QeI8KBw45Jw6Asw6Qow7bCnE/CmcKzwpwAw7R+BmfCusKvUcOeZn/ChBPDoD/DlMOrcl5YM8OzwoNyKsOVRg3CpWvDh8OMw5QgJCp5wprDp8OIZ8K8w7oQZsOtRQdDw558D8KPwonDtTI2KSPCgcOgwrwqUUnCtDbCmcKOwqbCnxNwGsKKwpwWY1UhLBBzbgQ4wqgbKMOJwrMZBUPDtydZDMKLacKDKgrCisOAw5IXwrhqwqHDkMOMw5JbRsKICMOAwphlVsKTScKRwojDjcKHw5jCgMKAwofDmjJ2w67Ch3d8N8OSw7jDmMKgw4rCksOYwqo2w64rWVzDqHnCmk3CpkVGwpnCkMKkwpkcGE5kJcKIw47ChMKXRcOOwoPDkDNYw7F8wqpnwrLCmgJtw4Nxw6XDsxrCkk7CjRvDuRlvLMOtwqjCgcOywpJKHQJuXDjCigfCv8K0WjjCrsOjw5F3ITbCkkc7wpvDkMOGIhB3YDEzwpnDm8OAw6lywpItwrJtO0wIOmYSSsKjWWN6w50UGcO+wpJ6woJ1IW5cwobDjcKcC8OXWHozYBTDo8OIw6zDoDHChcKjwpjCpMKLAS1nYVDCtVESTkt5O8KqMsKrBULChBJMXgYUJUwOWcKowpXCmWICwqFUwroKRwLDhXjCmwgPwqnCoWzDpC0bwpHCmhplw6oYHMO9w6TDtFjDmGnCmB/CgMOWPsOdwrHDj0nDhMKqUGo4wofCmMO8w45EcxptwpUgw7bCmcOlVMKow5bCgMOsRgc1wrB2w4jDmG3CpsK4QzvDmlkMwqwpwpIxw4hkKDtGwpXDjcOEEGzCiC5xw4/Cryt0fMKfwrEHwoAxwonCgMKLw4zClQQZGMOEYRHCgUJFwpJFwoTCkMOSYMOQwptSbDI7M8OhCMKuw5TCuQrCq8OvLWNBCAgiw6Eow4TCoRDCuMOqwoMgw6fDhcOAVcK8DsODTjNzDBM+Q0HCmcKpQMOGQFzDjMOOeEVKGMKsQsOrQMO4wqLCpQLDiMOJwq7DtMK+w4wvwqxnw6PDmGHClsKDwrVxCErCisKKLsK4wqI4E8O2Hx9RADDCjMKGYCbDtzRBwpnCgQNXwqLDtBlOw7PCr2IXwpggw67DrsOrCMKgwqTCpBrCn8Oiw65IwqcKEhsHwrvDmcKAIjtzOjg6InRvdGFsUXR5IjtzOjE6IjEiO3M6MTA6InBheV9hbW91bnQiO2Q6NTUwO3M6NjoibWV0aG9kIjtzOjE2OiJDYXNoIE9uIERlbGl2ZXJ5IjtzOjg6InNoaXBwaW5nIjtzOjY6InNoaXB0byI7czoxNToicGlja3VwX2xvY2F0aW9uIjtOO3M6MTQ6ImN1c3RvbWVyX2VtYWlsIjtzOjE5OiJuMDBiZGFuMTNAZ21haWwuY29tIjtzOjEzOiJjdXN0b21lcl9uYW1lIjtzOjE0OiJEYW5pZWwgU2Fwa290YSI7czoxMzoic2hpcHBpbmdfY29zdCI7czoyOiI1MCI7czoxMjoicGFja2luZ19jb3N0IjtzOjE6IjAiO3M6MzoidGF4IjtzOjE6IjAiO3M6MTQ6ImN1c3RvbWVyX3Bob25lIjtzOjEwOiI4OTk0Mzg1OTMwIjtzOjEyOiJvcmRlcl9udW1iZXIiO3M6MjA6Ik1BWVJBLXc5VlExNTk5NzQ4OTcyIjtzOjE2OiJjdXN0b21lcl9hZGRyZXNzIjtzOjY6IkJvdWRoYSI7czoxNjoiY3VzdG9tZXJfY291bnRyeSI7czo1OiJOZXBhbCI7czoxMzoiY3VzdG9tZXJfY2l0eSI7TjtzOjEyOiJjdXN0b21lcl96aXAiO047czoxODoiY3VzdG9tZXJfbG9uZ2l0dWRlIjtzOjk6Ijg1LjM0NDYyMiI7czoxNzoiY3VzdG9tZXJfbGF0aXR1ZGUiO3M6MTA6IjI3LjY5MTAyMjkiO3M6MTQ6InNoaXBwaW5nX2VtYWlsIjtOO3M6MTM6InNoaXBwaW5nX25hbWUiO047czoxNDoic2hpcHBpbmdfcGhvbmUiO047czoxNjoic2hpcHBpbmdfYWRkcmVzcyI7TjtzOjE2OiJzaGlwcGluZ19jb3VudHJ5IjtzOjU6Ik5lcGFsIjtzOjEzOiJzaGlwcGluZ19jaXR5IjtOO3M6MTI6InNoaXBwaW5nX3ppcCI7TjtzOjE4OiJzaGlwcGluZ19sb25naXR1ZGUiO047czoxNzoic2hpcHBpbmdfbGF0aXR1ZGUiO047czoxMDoib3JkZXJfbm90ZSI7TjtzOjExOiJjb3Vwb25fY29kZSI7TjtzOjE1OiJjb3Vwb25fZGlzY291bnQiO047czoyOiJkcCI7czoxOiIwIjtzOjE0OiJwYXltZW50X3N0YXR1cyI7czo3OiJQZW5kaW5nIjtzOjEzOiJjdXJyZW5jeV9zaWduIjtzOjM6IlJzLiI7czoxNDoiY3VycmVuY3lfdmFsdWUiO2Q6MTtzOjE4OiJ2ZW5kb3Jfc2hpcHBpbmdfaWQiO3M6MToiMCI7czoxNzoidmVuZG9yX3BhY2tpbmdfaWQiO3M6MToiMCI7czoyMDoiZGVsaXZlcnlfcmFuZ2Vfc3RhcnQiO3M6MTA6IjIwMjAtMDktMTAiO3M6MTg6ImRlbGl2ZXJ5X3JhbmdlX2VuZCI7czoxMDoiMjAyMC0wOS0xMSI7czoxMDoidXBkYXRlZF9hdCI7czoxOToiMjAyMC0wOS0xMCAxNDo0Mjo1MiI7czoxMDoiY3JlYXRlZF9hdCI7czoxOToiMjAyMC0wOS0xMCAxNDo0Mjo1MiI7czoyOiJpZCI7aToyO31zOjEwOiIAKgBjaGFuZ2VzIjthOjA6e31zOjg6IgAqAGNhc3RzIjthOjA6e31zOjg6IgAqAGRhdGVzIjthOjA6e31zOjEzOiIAKgBkYXRlRm9ybWF0IjtOO3M6MTA6IgAqAGFwcGVuZHMiO2E6MDp7fXM6MTk6IgAqAGRpc3BhdGNoZXNFdmVudHMiO2E6MDp7fXM6MTQ6IgAqAG9ic2VydmFibGVzIjthOjA6e31zOjEyOiIAKgByZWxhdGlvbnMiO2E6MDp7fXM6MTA6IgAqAHRvdWNoZXMiO2E6MDp7fXM6MTA6InRpbWVzdGFtcHMiO2I6MTtzOjk6IgAqAGhpZGRlbiI7YTowOnt9czoxMDoiACoAdmlzaWJsZSI7YTowOnt9czoxMDoiACoAZ3VhcmRlZCI7YToxOntpOjA7czoxOiIqIjt9fXM6ODoidGVtcGNhcnQiO086MTU6IkFwcFxNb2RlbHNcQ2FydCI6Mjk6e3M6NToiaXRlbXMiO2E6MTp7aToxO2E6MTM6e3M6MzoicXR5IjtpOjE7czo4OiJzaXplX2tleSI7aTowO3M6ODoic2l6ZV9xdHkiO3M6MDoiIjtzOjEwOiJzaXplX3ByaWNlIjtzOjA6IiI7czo0OiJzaXplIjtzOjA6IiI7czo1OiJjb2xvciI7czowOiIiO3M6NToic3RvY2siO047czo1OiJwcmljZSI7ZDo1MDA7czo0OiJpdGVtIjtPOjE4OiJBcHBcTW9kZWxzXFByb2R1Y3QiOjI2OntzOjExOiIAKgBmaWxsYWJsZSI7YTo1Mjp7aTowO3M6NzoidXNlcl9pZCI7aToxO3M6MTE6ImNhdGVnb3J5X2lkIjtpOjI7czoxMjoicHJvZHVjdF90eXBlIjtpOjM7czoxNDoiYWZmaWxpYXRlX2xpbmsiO2k6NDtzOjM6InNrdSI7aTo1O3M6MTQ6InN1YmNhdGVnb3J5X2lkIjtpOjY7czoxNjoiY2hpbGRjYXRlZ29yeV9pZCI7aTo3O3M6MTA6ImF0dHJpYnV0ZXMiO2k6ODtzOjQ6Im5hbWUiO2k6OTtzOjU6InBob3RvIjtpOjEwO3M6NDoic2l6ZSI7aToxMTtzOjg6InNpemVfcXR5IjtpOjEyO3M6MTA6InNpemVfcHJpY2UiO2k6MTM7czo1OiJjb2xvciI7aToxNDtzOjc6ImRldGFpbHMiO2k6MTU7czo1OiJwcmljZSI7aToxNjtzOjE0OiJwcmV2aW91c19wcmljZSI7aToxNztzOjU6InN0b2NrIjtpOjE4O3M6NjoicG9saWN5IjtpOjE5O3M6Njoic3RhdHVzIjtpOjIwO3M6NToidmlld3MiO2k6MjE7czo0OiJ0YWdzIjtpOjIyO3M6ODoiZmVhdHVyZWQiO2k6MjM7czo0OiJiZXN0IjtpOjI0O3M6MzoidG9wIjtpOjI1O3M6MzoiaG90IjtpOjI2O3M6NjoibGF0ZXN0IjtpOjI3O3M6MzoiYmlnIjtpOjI4O3M6ODoidHJlbmRpbmciO2k6Mjk7czo0OiJzYWxlIjtpOjMwO3M6ODoiZmVhdHVyZXMiO2k6MzE7czo2OiJjb2xvcnMiO2k6MzI7czoxNzoicHJvZHVjdF9jb25kaXRpb24iO2k6MzM7czo0OiJzaGlwIjtpOjM0O3M6ODoibWV0YV90YWciO2k6MzU7czoxNjoibWV0YV9kZXNjcmlwdGlvbiI7aTozNjtzOjc6InlvdXR1YmUiO2k6Mzc7czo0OiJ0eXBlIjtpOjM4O3M6NDoiZmlsZSI7aTozOTtzOjc6ImxpY2Vuc2UiO2k6NDA7czoxMToibGljZW5zZV9xdHkiO2k6NDE7czo0OiJsaW5rIjtpOjQyO3M6ODoicGxhdGZvcm0iO2k6NDM7czo2OiJyZWdpb24iO2k6NDQ7czoxMjoibGljZW5jZV90eXBlIjtpOjQ1O3M6NzoibWVhc3VyZSI7aTo0NjtzOjEzOiJkaXNjb3VudF9kYXRlIjtpOjQ3O3M6MTE6ImlzX2Rpc2NvdW50IjtpOjQ4O3M6MTQ6Indob2xlX3NlbGxfcXR5IjtpOjQ5O3M6MTk6Indob2xlX3NlbGxfZGlzY291bnQiO2k6NTA7czoxMDoiY2F0YWxvZ19pZCI7aTo1MTtzOjQ6InNsdWciO31zOjEzOiIAKgBjb25uZWN0aW9uIjtz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', 1599749431);

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
  `long_price` int(11) DEFAULT NULL,
  `threshold` float NOT NULL DEFAULT '0',
  `free_threshold` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shippings`
--

INSERT INTO `shippings` (`id`, `user_id`, `title`, `subtitle`, `price`, `long_price`, `threshold`, `free_threshold`) VALUES
(3, 0, 'Default', NULL, 50, 100, 1.5, 2000);

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
(9, 'World Fashion', '24', '#ffffff', 'slideInUp', 'Get Up to 40% Off', '60', '#ffffff', 'slideInDown', 'Highlight your personality  and look with these fabulous and exquisite fashion.', '16', '#ffffff', 'slideInDown', '1564224753007.jpg', 'slide-one', 'https://www.google.com/'),
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
(1, 'https://www.facebook.com/', 'https://plus.google.com/', 'https://twitter.com/', 'https://www.linkedin.com/', 'https://dribbble.com/', 1, 0, 1, 1, 0, 1, 1, '3295714593783056', '7ca32c70e89bc04d66de0126971e15f8', 'https://mayrasales.local/auth/facebook/callback', '687441940729-l53jvsmil8qh93p39k4h0h1t3m9ofral.apps.googleusercontent.com', 'TgF1m9boFAX_EKCwZTNsTujt', 'https://mayrasales.local/auth/google/callback');

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
(2, 1, '128921545532962', 'facebook', '2020-08-22 22:26:39', '2020-08-22 22:26:39');

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

--
-- Dumping data for table `subcategories`
--

INSERT INTO `subcategories` (`id`, `category_id`, `name`, `slug`, `status`) VALUES
(2, 4, 'TELEVISION', 'television', 1),
(3, 4, 'REFRIGERATOR', 'refrigerator', 1),
(4, 4, 'WASHING MACHINE', 'washing-machine', 1),
(5, 4, 'AIR CONDITIONERS', 'air-conditioners', 1),
(6, 5, 'ACCESSORIES', 'accessories', 1),
(7, 5, 'BAGS', 'bags', 1),
(8, 5, 'CLOTHINGS', 'clothings', 1),
(9, 5, 'SHOES', 'shoes', 1),
(10, 7, 'APPLE', 'apple', 1),
(11, 7, 'SAMSUNG', 'samsung', 1),
(12, 7, 'LG', 'lg', 1),
(13, 7, 'SONY', 'sony', 1),
(14, 6, 'DSLR', 'dslr', 1),
(15, 6, 'Camera Phone', 'camera-phone', 1),
(16, 6, 'Action Camera', 'animation-camera', 1),
(17, 6, 'Digital Camera', 'digital-camera', 1);

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` int(191) NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
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
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `title`, `currency`, `currency_code`, `price`, `days`, `allowed_products`, `details`) VALUES
(6, 'Premium', 'Rs', 'Rs', 1000, 30, 0, '<div>1) Premium seller\'s products are displayed on the home page</div><div>2) A premium badge above all products</div>'),
(8, 'Basic', 'Rs', 'Rs', 500, 30, 0, 'Basic Vendors can sell unlimited products<br>');

-- --------------------------------------------------------

--
-- Table structure for table `system_notifications`
--

CREATE TABLE `system_notifications` (
  `id` int(11) NOT NULL,
  `message` text,
  `user_id` int(11) DEFAULT NULL,
  `expiring_in` int(11) DEFAULT NULL,
  `message_type` varchar(10) NOT NULL,
  `is_read` int(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `system_notifications`
--

INSERT INTO `system_notifications` (`id`, `message`, `user_id`, `expiring_in`, `message_type`, `is_read`, `created_at`, `updated_at`) VALUES
(1, NULL, 2, 5, 'expiring', 1, '2020-09-05 04:09:24', '2020-09-05 05:30:02'),
(2, NULL, 2, NULL, 'report', 1, '2020-09-09 23:06:01', '2020-09-09 23:38:38'),
(3, NULL, 2, NULL, 'report', 0, '2020-09-09 23:25:49', '2020-09-09 23:25:49');

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
  `user_location` int(11) NOT NULL DEFAULT '0',
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `shop_location` int(11) NOT NULL DEFAULT '0',
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
  `ban` tinyint(1) NOT NULL DEFAULT '0',
  `suspend_till` date DEFAULT NULL,
  `payment_request` int(11) NOT NULL DEFAULT '0',
  `method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subs_id` int(11) DEFAULT NULL,
  `txn_id4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `txn_image` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_type` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reported_times` int(11) NOT NULL DEFAULT '0',
  `cash_only` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `photo`, `zip`, `city`, `user_location`, `country`, `address`, `phone`, `fax`, `email`, `password`, `longitude`, `latitude`, `api_token`, `remember_token`, `created_at`, `updated_at`, `is_provider`, `status`, `verification_link`, `email_verified`, `affilate_code`, `affilate_income`, `shop_name`, `owner_name`, `shop_number`, `shop_address`, `reg_number`, `shop_message`, `shop_details`, `shop_image`, `shop_location`, `f_url`, `g_url`, `t_url`, `l_url`, `is_vendor`, `f_check`, `g_check`, `t_check`, `l_check`, `mail_sent`, `shipping_cost`, `current_balance`, `date`, `ban`, `suspend_till`, `payment_request`, `method`, `subs_id`, `txn_id4`, `txn_image`, `subscription_type`, `reported_times`, `cash_only`) VALUES
(0, 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 'admin@mayrasales.com', NULL, NULL, NULL, 'o2qMzNetmJPIYf0eJ73455dsdwoEjUGnNGliYQAPFanqJQ0di0b6ZRvZ81PEo1B', NULL, NULL, '2020-09-05 00:47:22', 0, 0, NULL, 'Yes', NULL, 0, 'Admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, '', NULL, NULL, '', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL,
  `conversation_id` int(11) DEFAULT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Table structure for table `vendor_notifications`
--

CREATE TABLE `vendor_notifications` (
  `id` int(191) NOT NULL,
  `user_id` int(191) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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

-- --------------------------------------------------------

--
-- Table structure for table `withdraws`
--

CREATE TABLE `withdraws` (
  `id` int(191) NOT NULL,
  `user_id` int(191) DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acc_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acc_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `swift` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `amount` float DEFAULT NULL,
  `fee` float DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` enum('pending','completed','rejected') NOT NULL DEFAULT 'pending',
  `type` enum('user','vendor') NOT NULL
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
-- Indexes for table `admin_user_conversations`
--
ALTER TABLE `admin_user_conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_user_messages`
--
ALTER TABLE `admin_user_messages`
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
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
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
-- Indexes for table `counters`
--
ALTER TABLE `counters`
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
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
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
-- Indexes for table `locations`
--
ALTER TABLE `locations`
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
-- Indexes for table `packages`
--
ALTER TABLE `packages`
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
-- Indexes for table `partners`
--
ALTER TABLE `partners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pickups`
--
ALTER TABLE `pickups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `products` ADD FULLTEXT KEY `name` (`name`);
ALTER TABLE `products` ADD FULLTEXT KEY `attributes` (`attributes`);

--
-- Indexes for table `product_clicks`
--
ALTER TABLE `product_clicks`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `reports`
--
ALTER TABLE `reports`
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
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_notifications`
--
ALTER TABLE `system_notifications`
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
-- Indexes for table `vendor_notifications`
--
ALTER TABLE `vendor_notifications`
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
-- Indexes for table `withdraws`
--
ALTER TABLE `withdraws`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `admin_languages`
--
ALTER TABLE `admin_languages`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `admin_user_conversations`
--
ALTER TABLE `admin_user_conversations`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `admin_user_messages`
--
ALTER TABLE `admin_user_messages`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `attribute_options`
--
ALTER TABLE `attribute_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=256;
--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `childcategories`
--
ALTER TABLE `childcategories`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `counters`
--
ALTER TABLE `counters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
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
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
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
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(191) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `order_tracks`
--
ALTER TABLE `order_tracks`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `pagesettings`
--
ALTER TABLE `pagesettings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `partners`
--
ALTER TABLE `partners`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;
--
-- AUTO_INCREMENT for table `pickups`
--
ALTER TABLE `pickups`
  MODIFY `id` int(191) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(191) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `product_clicks`
--
ALTER TABLE `product_clicks`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=388;
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
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
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
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `system_notifications`
--
ALTER TABLE `system_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `vendor_notifications`
--
ALTER TABLE `vendor_notifications`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `vendor_orders`
--
ALTER TABLE `vendor_orders`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
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
--
-- AUTO_INCREMENT for table `withdraws`
--
ALTER TABLE `withdraws`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
