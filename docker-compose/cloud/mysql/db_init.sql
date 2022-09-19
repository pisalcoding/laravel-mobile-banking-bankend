-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 19, 2022 at 07:27 AM
-- Server version: 5.7.32
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `mobilebanking`
--

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `id` int(11) NOT NULL,
  `account_number` varchar(15) NOT NULL,
  `customer` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` int(11) NOT NULL,
  `allow_negative` tinyint(1) NOT NULL DEFAULT '1',
  `allow_debit` tinyint(1) NOT NULL DEFAULT '1',
  `allow_credit` tinyint(1) NOT NULL DEFAULT '1',
  `allow_atm` tinyint(1) NOT NULL DEFAULT '1',
  `allow_card` tinyint(1) NOT NULL DEFAULT '1',
  `allow_otc` tinyint(1) NOT NULL DEFAULT '1',
  `currency` varchar(15) NOT NULL,
  `gross_balance` double NOT NULL DEFAULT '0',
  `min_balance` double NOT NULL DEFAULT '0',
  `interest_rate` double NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `history` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `bank_customers`
--

CREATE TABLE `bank_customers` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(63) NOT NULL,
  `selfie` varchar(255) DEFAULT NULL,
  `id_document` varchar(255) DEFAULT NULL,
  `id_mrz` varchar(255) DEFAULT NULL,
  `id_number` varchar(63) NOT NULL,
  `id_type` int(11) DEFAULT NULL,
  `gender` enum('FEMALE','MALE','OTHER','') DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `birth_village` int(11) DEFAULT NULL,
  `current_str_address` varchar(255) NOT NULL,
  `current_village` int(11) DEFAULT NULL,
  `workplace_name` varchar(255) DEFAULT NULL,
  `workplace_str_address` varchar(255) DEFAULT NULL,
  `workplace_village` int(11) DEFAULT NULL,
  `occupation` int(11) DEFAULT NULL,
  `income_primary` int(11) DEFAULT NULL,
  `income_secondary` int(11) DEFAULT NULL,
  `income_min_usd` double DEFAULT NULL,
  `classification` varchar(63) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `kyc_status` enum('FULL','HALF','ONLINE','') DEFAULT NULL,
  `created_on_platform` enum('OTC','MOBILE') DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `history` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `bank_transactions`
--

CREATE TABLE `bank_transactions` (
  `id` int(11) NOT NULL,
  `trx_code` varchar(63) NOT NULL,
  `src_account_number` varchar(15) NOT NULL,
  `dst_account_number` varchar(15) NOT NULL,
  `amount` double NOT NULL,
  `currency` varchar(3) NOT NULL,
  `by_gateway` varchar(11) NOT NULL,
  `reference` varchar(63) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `merchant` int(11) DEFAULT NULL,
  `type` varchar(15) NOT NULL,
  `src_name` int(63) NOT NULL,
  `platform` enum('OTC','MB','ATM','SMS','INTB','POS') NOT NULL,
  `by_card` int(11) DEFAULT NULL,
  `by_template` int(11) DEFAULT NULL,
  `third_party_info` varchar(1023) NOT NULL COMMENT 'List of key-values pairs',
  `channel` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Success, 2: Pending, 3: Un-authorized,  0: Failed',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `id` int(11) NOT NULL,
  `linked_account` int(11) NOT NULL,
  `card_name` varchar(255) NOT NULL,
  `card_number` varchar(63) NOT NULL,
  `holder_name` int(11) NOT NULL,
  `network_brand` int(11) NOT NULL,
  `expiry_year` int(5) NOT NULL,
  `expiry_month` int(2) NOT NULL,
  `cvv` varchar(5) NOT NULL,
  `debit` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Debit, 0: Credit',
  `virtual` tinyint(1) NOT NULL DEFAULT '0',
  `frozen` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `inputter` int(11) DEFAULT NULL,
  `authorizer` int(11) DEFAULT NULL,
  `printed_at` int(11) DEFAULT NULL,
  `created_on_platform` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `history` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `card_networks`
--

CREATE TABLE `card_networks` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `abbreviation` varchar(15) DEFAULT NULL,
  `square_logo` varchar(255) DEFAULT NULL,
  `badge_logo` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `history` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `order`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 'Category 1', 'category-1', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(2, NULL, 1, 'Category 2', 'category-2', '2022-09-07 18:05:48', '2022-09-07 18:05:48');

-- --------------------------------------------------------

--
-- Table structure for table `data_rows`
--

CREATE TABLE `data_rows` (
  `id` int(10) UNSIGNED NOT NULL,
  `data_type_id` int(10) UNSIGNED NOT NULL,
  `field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `browse` tinyint(1) NOT NULL DEFAULT '1',
  `read` tinyint(1) NOT NULL DEFAULT '1',
  `edit` tinyint(1) NOT NULL DEFAULT '1',
  `add` tinyint(1) NOT NULL DEFAULT '1',
  `delete` tinyint(1) NOT NULL DEFAULT '1',
  `details` text COLLATE utf8mb4_unicode_ci,
  `order` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_rows`
--

INSERT INTO `data_rows` (`id`, `data_type_id`, `field`, `type`, `display_name`, `required`, `browse`, `read`, `edit`, `add`, `delete`, `details`, `order`) VALUES
(1, 1, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(2, 1, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(3, 1, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, NULL, 3),
(4, 1, 'password', 'password', 'Password', 1, 0, 0, 1, 1, 0, NULL, 4),
(5, 1, 'remember_token', 'text', 'Remember Token', 0, 0, 0, 0, 0, 0, NULL, 5),
(6, 1, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, NULL, 6),
(7, 1, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
(8, 1, 'avatar', 'image', 'Avatar', 0, 1, 1, 1, 1, 1, NULL, 8),
(9, 1, 'user_belongsto_role_relationship', 'relationship', 'Role', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":0}', 10),
(10, 1, 'user_belongstomany_role_relationship', 'relationship', 'Roles', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}', 11),
(11, 1, 'settings', 'hidden', 'Settings', 0, 0, 0, 0, 0, 0, NULL, 12),
(12, 2, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(13, 2, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(14, 2, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(15, 2, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(16, 3, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(17, 3, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(18, 3, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(19, 3, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(20, 3, 'display_name', 'text', 'Display Name', 1, 1, 1, 1, 1, 1, NULL, 5),
(21, 1, 'role_id', 'text', 'Role', 1, 1, 1, 1, 1, 1, NULL, 9),
(22, 4, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(23, 4, 'parent_id', 'select_dropdown', 'Parent', 0, 0, 1, 1, 1, 1, '{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}', 2),
(24, 4, 'order', 'text', 'Order', 1, 1, 1, 1, 1, 1, '{\"default\":1}', 3),
(25, 4, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 4),
(26, 4, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\"}}', 5),
(27, 4, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 0, NULL, 6),
(28, 4, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
(29, 5, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(30, 5, 'author_id', 'text', 'Author', 1, 0, 1, 1, 0, 1, NULL, 2),
(31, 5, 'category_id', 'text', 'Category', 1, 0, 1, 1, 1, 0, NULL, 3),
(32, 5, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, NULL, 4),
(33, 5, 'excerpt', 'text_area', 'Excerpt', 1, 0, 1, 1, 1, 1, NULL, 5),
(34, 5, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, NULL, 6),
(35, 5, 'image', 'image', 'Post Image', 0, 1, 1, 1, 1, 1, '{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}', 7),
(36, 5, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"title\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:posts,slug\"}}', 8),
(37, 5, 'meta_description', 'text_area', 'Meta Description', 1, 0, 1, 1, 1, 1, NULL, 9),
(38, 5, 'meta_keywords', 'text_area', 'Meta Keywords', 1, 0, 1, 1, 1, 1, NULL, 10),
(39, 5, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{\"default\":\"DRAFT\",\"options\":{\"PUBLISHED\":\"published\",\"DRAFT\":\"draft\",\"PENDING\":\"pending\"}}', 11),
(40, 5, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, NULL, 12),
(41, 5, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 13),
(42, 5, 'seo_title', 'text', 'SEO Title', 0, 1, 1, 1, 1, 1, NULL, 14),
(43, 5, 'featured', 'checkbox', 'Featured', 1, 1, 1, 1, 1, 1, NULL, 15),
(44, 6, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(45, 6, 'author_id', 'text', 'Author', 1, 0, 0, 0, 0, 0, NULL, 2),
(46, 6, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, NULL, 3),
(47, 6, 'excerpt', 'text_area', 'Excerpt', 1, 0, 1, 1, 1, 1, NULL, 4),
(48, 6, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, NULL, 5),
(49, 6, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"title\"},\"validation\":{\"rule\":\"unique:pages,slug\"}}', 6),
(50, 6, 'meta_description', 'text', 'Meta Description', 1, 0, 1, 1, 1, 1, NULL, 7),
(51, 6, 'meta_keywords', 'text', 'Meta Keywords', 1, 0, 1, 1, 1, 1, NULL, 8),
(52, 6, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{\"default\":\"INACTIVE\",\"options\":{\"INACTIVE\":\"INACTIVE\",\"ACTIVE\":\"ACTIVE\"}}', 9),
(53, 6, 'created_at', 'timestamp', 'Created At', 1, 1, 1, 0, 0, 0, NULL, 10),
(54, 6, 'updated_at', 'timestamp', 'Updated At', 1, 0, 0, 0, 0, 0, NULL, 11),
(55, 6, 'image', 'image', 'Page Image', 0, 1, 1, 1, 1, 1, NULL, 12),
(56, 8, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(57, 8, 'service_code', 'text', 'Service Code', 0, 1, 1, 1, 1, 1, '{}', 3),
(58, 8, 'terminal_code', 'text', 'Terminal Code', 0, 0, 1, 1, 1, 1, '{}', 5),
(59, 8, 'parent_id', 'text', 'Parent Id', 0, 1, 1, 1, 1, 1, '{}', 6),
(60, 8, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, '{}', 7),
(61, 8, 'subtitle', 'text', 'Subtitle', 0, 1, 1, 1, 1, 1, '{}', 8),
(62, 8, 'icon', 'image', 'Icon', 0, 1, 1, 1, 1, 1, '{}', 9),
(64, 8, 'requires_auth', 'checkbox', 'Requires Auth', 1, 0, 1, 1, 0, 1, '{\"checked\":true}', 11),
(65, 8, 'needs_icon_outline', 'checkbox', 'Needs Icon Outline', 1, 0, 1, 1, 0, 1, '{\"checked\":true}', 12),
(66, 8, 'uses_circular_icon', 'checkbox', 'Uses Circular Icon', 1, 0, 1, 1, 0, 1, '{\"checked\":true}', 13),
(67, 8, 'sub_button_text', 'text', 'Sub Button Text', 0, 0, 1, 1, 1, 1, '{}', 14),
(68, 8, 'highlight_icons', 'multiple_images', 'Highlight Icons', 0, 0, 1, 1, 0, 1, '{}', 15),
(69, 8, 'enabled', 'checkbox', 'Enabled', 1, 1, 1, 1, 0, 1, '{\"checked\":true}', 16),
(70, 8, 'status', 'checkbox', 'Status', 1, 0, 1, 1, 0, 1, '{\"checked\":true}', 17),
(71, 8, 'created_at', 'timestamp', 'Created At', 1, 1, 1, 1, 0, 1, '{}', 18),
(72, 8, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 19),
(73, 8, 'version', 'number', 'Version', 1, 1, 1, 0, 0, 1, '{}', 20),
(74, 8, 'history', 'text', 'History', 0, 0, 1, 1, 0, 1, '{}', 21),
(75, 8, 'type', 'select_dropdown', 'Type', 1, 1, 1, 1, 1, 1, '{\"default\":\"PAYMENT\",\"options\":{\"TRANSFER\":\"TRANSFER\",\"PAYMENT\":\"PAYMENT\",\"NEW_ACCOUNT\":\"NEW_ACCOUNT\",\"LOANS\":\"LOANS\"}}', 4),
(76, 8, 'mb_transaction_channel_belongsto_mb_transaction_channel_relationship', 'relationship', 'Parent', 0, 1, 1, 1, 1, 1, '{\"model\":\"\\\\App\\\\Models\\\\MbTransactionChannel\",\"table\":\"mb_transaction_channels\",\"type\":\"belongsTo\",\"column\":\"parent_id\",\"key\":\"id\",\"label\":\"title\",\"pivot_table\":\"bank_accounts\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(77, 8, 'local_drawable_id', 'text', 'Local Drawable Id', 0, 0, 1, 1, 1, 1, '{}', 9);

-- --------------------------------------------------------

--
-- Table structure for table `data_types`
--

CREATE TABLE `data_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT '0',
  `server_side` tinyint(4) NOT NULL DEFAULT '0',
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_types`
--

INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
(1, 'users', 'users', 'User', 'Users', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', '', 1, 0, NULL, '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(3, 'roles', 'roles', 'Role', 'Roles', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, 'TCG\\Voyager\\Http\\Controllers\\VoyagerRoleController', '', 1, 0, NULL, '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(4, 'categories', 'categories', 'Category', 'Categories', 'voyager-categories', 'TCG\\Voyager\\Models\\Category', NULL, '', '', 1, 0, NULL, '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(5, 'posts', 'posts', 'Post', 'Posts', 'voyager-news', 'TCG\\Voyager\\Models\\Post', 'TCG\\Voyager\\Policies\\PostPolicy', '', '', 1, 0, NULL, '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(6, 'pages', 'pages', 'Page', 'Pages', 'voyager-file-text', 'TCG\\Voyager\\Models\\Page', NULL, '', '', 1, 0, NULL, '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(8, 'mb_transaction_channels', 'mb-transaction-channels', 'MB Transaction Channel', 'MB Transaction Channels', 'voyager-shop', 'App\\Models\\MbTransactionChannel', NULL, NULL, NULL, 1, 1, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2022-09-14 01:30:31', '2022-09-19 00:05:38');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mb_home_menus`
--

CREATE TABLE `mb_home_menus` (
  `id` int(11) NOT NULL,
  `service_code` varchar(63) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(1023) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `local_drawable_id` varchar(63) DEFAULT NULL,
  `requires_auth` tinyint(1) NOT NULL DEFAULT '1',
  `needs_icon_outline` tinyint(1) NOT NULL DEFAULT '0',
  `uses_circular_icon` tinyint(1) NOT NULL DEFAULT '1',
  `sub_button_text` varchar(63) NOT NULL,
  `highlight_icons` varchar(1023) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'When 0, show but can''t click',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'When 0, don''t show',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `history` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mb_payment_templates`
--

CREATE TABLE `mb_payment_templates` (
  `id` int(11) NOT NULL,
  `mb_user_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `third_party_id` varchar(63) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `other_fields` json DEFAULT NULL,
  `src_account_number` varchar(63) NOT NULL,
  `dst_account_number` varchar(63) DEFAULT NULL,
  `dst_phone` varchar(63) DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `history` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mb_transaction_channels`
--

CREATE TABLE `mb_transaction_channels` (
  `id` int(11) NOT NULL,
  `type` enum('PAYMENT','TRANSFER','NEW_ACCOUNT','LOANS') NOT NULL,
  `service_code` varchar(63) DEFAULT NULL,
  `terminal_code` varchar(15) DEFAULT NULL COMMENT 'For bill payment, it''s biller_code',
  `parent_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(1023) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `local_drawable_id` varchar(63) DEFAULT NULL,
  `requires_auth` tinyint(1) NOT NULL DEFAULT '1',
  `needs_icon_outline` tinyint(1) NOT NULL DEFAULT '0',
  `uses_circular_icon` tinyint(1) NOT NULL DEFAULT '1',
  `sub_button_text` varchar(63) DEFAULT NULL,
  `highlight_icons` varchar(1023) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'When 0, show but can''t click',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'When 0, don''t show',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `history` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mb_transaction_channels`
--

INSERT INTO `mb_transaction_channels` (`id`, `type`, `service_code`, `terminal_code`, `parent_id`, `title`, `subtitle`, `icon`, `local_drawable_id`, `requires_auth`, `needs_icon_outline`, `uses_circular_icon`, `sub_button_text`, `highlight_icons`, `enabled`, `status`, `created_at`, `updated_at`, `version`, `history`) VALUES
(1, 'PAYMENT', 'BP_UT_001', NULL, NULL, 'Utilities', 'Pay for electricity, water and waste bills', 'mb-transaction-channels/September2022/u7H2q9UO5g5ZEU79pRLi.png', NULL, 1, 1, 1, NULL, NULL, 1, 1, '2022-09-15 22:01:16', '2022-09-16 07:05:55', 1, NULL),
(2, 'PAYMENT', 'BP_PT_001', NULL, NULL, 'Mobile Top-up', 'Top-up own phone or other\'s phones', 'mb-transaction-channels/September2022/vmXta59dq2B5wO3fWa2J.png', NULL, 1, 1, 1, NULL, NULL, 1, 1, '2022-09-16 00:09:00', '2022-09-16 00:51:43', 1, NULL),
(3, 'PAYMENT', 'BP_PS_001', NULL, NULL, 'Public Services', 'Pay for taxes or public services', 'mb-transaction-channels/September2022/omUNJzta3Mv0BzUpk1rJ.png', NULL, 1, 1, 1, NULL, NULL, 1, 1, '2022-09-16 00:44:01', '2022-09-16 00:44:01', 1, NULL),
(4, 'PAYMENT', 'BP_IT_001', NULL, NULL, 'Internet &TV', 'Pay your internet and TV bills', 'mb-transaction-channels/September2022/nsrw6KHE5d8Rv5scKb05.png', NULL, 1, 1, 1, NULL, NULL, 1, 1, '2022-09-16 00:44:49', '2022-09-16 00:44:49', 1, NULL),
(5, 'PAYMENT', 'BP_RE_001', NULL, NULL, 'Real Estate', 'Pay for property', 'mb-transaction-channels/September2022/y2r83GVVO1HM2RyaBVnP.png', NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-16 00:46:25', '2022-09-16 00:46:25', 1, NULL),
(6, 'PAYMENT', 'BP_IS_001', NULL, NULL, 'Insurance', 'Pay for insurance premiums', 'mb-transaction-channels/September2022/LFRbBv9PxB938ocVSlOV.png', NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-16 00:47:18', '2022-09-16 00:47:18', 1, NULL),
(7, 'PAYMENT', 'BP_FI_001', NULL, NULL, 'Finance & Investment', 'Payment for 3rd party financial services', 'mb-transaction-channels/September2022/g2JoHpp8aFi9mCgAzFx7.png', NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-16 00:48:09', '2022-09-16 00:48:09', 1, NULL),
(8, 'PAYMENT', 'BP_ED_001', NULL, NULL, 'Education', 'Pay for school fees', 'mb-transaction-channels/September2022/jUSADUZgs171vAY0h7UE.png', NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-16 00:48:41', '2022-09-16 00:48:41', 1, NULL),
(9, 'PAYMENT', 'BP_ET_001', NULL, NULL, 'Entertainment', 'Shop for credit for games and apps', 'mb-transaction-channels/September2022/OtoIl4a4hta9XDC7uxNF.png', NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-16 00:49:25', '2022-09-16 00:49:25', 1, NULL),
(10, 'PAYMENT', 'BP_MS_001', NULL, NULL, 'Membership & Subscription', 'Pay for your subscriptions', 'mb-transaction-channels/September2022/GAGYI8nu6vdpUn00H6Nh.png', NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-16 00:50:06', '2022-09-16 00:50:06', 1, NULL),
(11, 'PAYMENT', 'BP_TT_001', NULL, NULL, 'Travel & Tours', 'Pay to travel service-providers', 'mb-transaction-channels/September2022/DM6Qj0dOpnKOYU54sNdt.png', NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-16 00:50:39', '2022-09-16 00:50:39', 1, NULL),
(12, 'PAYMENT', 'BP_CD_001', NULL, NULL, 'Charity & Donation', 'Donate to charitable organizations', 'mb-transaction-channels/September2022/txndljIIfeUoTichQpcX.png', NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-16 00:51:22', '2022-09-16 00:51:22', 1, NULL),
(13, 'TRANSFER', 'TF_TP_001', NULL, NULL, 'Choose from template', 'Transfer to friends from your templates list', NULL, NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-18 23:44:18', '2022-09-18 23:44:18', 1, NULL),
(14, 'TRANSFER', 'TF_OWN_001', NULL, NULL, 'Transfer to own ABA account', 'Make a transfer to your own account', NULL, NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-18 23:45:00', '2022-09-18 23:46:25', 1, NULL),
(15, 'TRANSFER', 'TF_OTH_001', NULL, NULL, 'Transfer to other ABA account', 'Transfer money to other ABA customers', NULL, NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-18 23:46:16', '2022-09-18 23:46:16', 1, NULL),
(16, 'TRANSFER', 'TF_ATM_001', NULL, NULL, 'Send money to ABA ATM\'s', 'Make cardless cash withdrawal at any ABA ATM', NULL, NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-18 23:47:03', '2022-09-18 23:47:03', 1, NULL),
(17, 'TRANSFER', 'TF_LOC_001', NULL, NULL, 'Transfer to Local Banks & Wallets', 'Make transfers to banks or wallets in Cambodia', NULL, NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-18 23:48:32', '2022-09-18 23:48:32', 1, NULL),
(18, 'TRANSFER', 'TF_ITT_001', NULL, NULL, 'International Transfers', 'Send money abroad via various channels', NULL, NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-18 23:49:37', '2022-09-18 23:49:37', 1, NULL),
(19, 'TRANSFER', 'TF_CAR_001', NULL, NULL, 'Transfer to cards', 'Transfer money to other bank card users', NULL, NULL, 1, 0, 1, NULL, '[\"mb-transaction-channels\\/September2022\\/Ux8GOWmwjVF4DIvJJwh5.png\",\"mb-transaction-channels\\/September2022\\/uGWWFISiBuoIKgAjutc7.png\",\"mb-transaction-channels\\/September2022\\/2zDRYaFYUH8ARywnzW8H.png\"]', 1, 1, '2022-09-18 23:50:00', '2022-09-18 23:51:03', 1, NULL),
(20, 'TRANSFER', 'TF_LOC_BK_001', NULL, 17, 'Bakong - Send to Local Banks', 'Transfer to any bank in the Bakong network', NULL, NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-18 23:56:40', '2022-09-18 23:56:40', 1, NULL),
(21, 'TRANSFER', 'TF_LOC_BK_002', NULL, 17, 'Bakong - Send to Wallet', 'Transfer money to any Bakong account', NULL, NULL, 1, 0, 1, NULL, NULL, 1, 1, '2022-09-18 23:57:35', '2022-09-18 23:57:35', 1, NULL),
(22, 'NEW_ACCOUNT', 'AO_JUA_001', NULL, NULL, 'Junior Account', 'Junior Account is a basic joint savings account designed for kids to help them understand the value of money and learn how to save. WIth this feature parents can always stay informed on their financial activities.', NULL, NULL, 1, 0, 1, 'CREATE ACCOUNT', NULL, 1, 1, '2022-09-19 00:09:13', '2022-09-19 00:09:13', 1, NULL),
(23, 'NEW_ACCOUNT', 'AO_PRE_001', NULL, NULL, 'Premium Account Number', 'Create a new ABA account with your favorite number that easy to remember. It can contain a date of birth, vehicle plate or any other special number that important for you.', NULL, NULL, 1, 0, 1, 'EXPLORE MORE', NULL, 1, 1, '2022-09-19 00:10:35', '2022-09-19 00:10:35', 1, NULL),
(24, 'NEW_ACCOUNT', 'AO_MTR_001', NULL, NULL, 'Mobile Trading Account', 'Open Mobile Trading Account that can be partnered companies. Find partnered companies list at: Payments > Finance & Investment.', NULL, NULL, 1, 0, 1, 'OPEN NEW ACCOUNT', NULL, 1, 1, '2022-09-19 00:12:04', '2022-09-19 00:12:04', 1, NULL),
(25, 'NEW_ACCOUNT', 'AO_MFD_001', NULL, NULL, 'Mobile Fixed Deposit', 'Choose the term deposit and get high return on your savings with our attractive interest rates in both USD and KHR currencies.', NULL, NULL, 1, 0, 1, 'MAKE NEW DEPOSIT', NULL, 1, 1, '2022-09-19 00:13:03', '2022-09-19 00:13:03', 1, NULL),
(26, 'NEW_ACCOUNT', 'AO_MBS_001', NULL, NULL, 'Mobile Savings Account', 'Our post popular bank account that helps you reach saving goals with competitive interest rate and other great features.', NULL, NULL, 1, 0, 1, 'OPEN NEW ACCOUNT', NULL, 1, 1, '2022-09-19 00:14:19', '2022-09-19 00:14:19', 1, NULL),
(27, 'NEW_ACCOUNT', 'AO_MBF_001', NULL, NULL, 'Mobile Flexi Account', 'WIth ABA Flexi Account in KHR you can deposit or/and withdraw funds any time and keep earning high interest on your ongoing balance.', NULL, NULL, 1, 0, 1, 'OPEN NEW ACCOUNT', NULL, 1, 1, '2022-09-19 00:15:30', '2022-09-19 00:15:30', 1, NULL),
(28, 'LOANS', 'LO_INS_001', NULL, NULL, 'Instant Loan', 'Request Instant Loan to borrow cash of up to 90% of your Fixed Deposit amount and make repayment anytime with no penalty for early loan repayment.', NULL, NULL, 1, 0, 1, 'GET NEW LOAN', NULL, 1, 1, '2022-09-19 00:17:08', '2022-09-19 00:17:08', 1, NULL),
(29, 'LOANS', 'LO_SLR_001', NULL, NULL, 'Salary Loan', 'Request Salary Loan to borrow cash up to 50% of your salary and make repayment monthly up to 12 months.', NULL, NULL, 1, 0, 1, 'GET NET LOAN', NULL, 1, 1, '2022-09-19 00:18:12', '2022-09-19 00:18:12', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mb_transfer_templates`
--

CREATE TABLE `mb_transfer_templates` (
  `id` int(11) NOT NULL,
  `mb_user_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `third_party_id` varchar(63) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `other_fields` json DEFAULT NULL,
  `src_account_number` varchar(63) NOT NULL,
  `dst_account_number` varchar(63) DEFAULT NULL,
  `dst_phone` varchar(63) DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `history` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mb_users`
--

CREATE TABLE `mb_users` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `default_account` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `profile_picture` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `history` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2022-09-07 18:02:07', '2022-09-07 18:02:07');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `icon_class`, `color`, `parent_id`, `order`, `created_at`, `updated_at`, `route`, `parameters`) VALUES
(1, 1, 'Dashboard', '', '_self', 'voyager-boat', NULL, NULL, 1, '2022-09-07 18:02:07', '2022-09-07 18:02:07', 'voyager.dashboard', NULL),
(2, 1, 'Media', '', '_self', 'voyager-images', NULL, NULL, 5, '2022-09-07 18:02:07', '2022-09-16 00:14:39', 'voyager.media.index', NULL),
(3, 1, 'Users', '', '_self', 'voyager-person', NULL, NULL, 3, '2022-09-07 18:02:07', '2022-09-07 18:02:07', 'voyager.users.index', NULL),
(4, 1, 'Roles', '', '_self', 'voyager-lock', NULL, NULL, 2, '2022-09-07 18:02:07', '2022-09-07 18:02:07', 'voyager.roles.index', NULL),
(5, 1, 'Tools', '', '_self', 'voyager-tools', NULL, NULL, 9, '2022-09-07 18:02:07', '2022-09-16 00:14:37', NULL, NULL),
(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 1, '2022-09-07 18:02:07', '2022-09-16 00:14:33', 'voyager.menus.index', NULL),
(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 2, '2022-09-07 18:02:07', '2022-09-16 00:14:33', 'voyager.database.index', NULL),
(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 3, '2022-09-07 18:02:07', '2022-09-16 00:14:33', 'voyager.compass.index', NULL),
(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 4, '2022-09-07 18:02:07', '2022-09-16 00:14:33', 'voyager.bread.index', NULL),
(10, 1, 'Settings', '', '_self', 'voyager-settings', NULL, NULL, 10, '2022-09-07 18:02:07', '2022-09-16 00:14:37', 'voyager.settings.index', NULL),
(14, 1, 'MB Transaction Channels', '', '_self', 'voyager-shop', '#000000', 15, 1, '2022-09-14 01:30:31', '2022-09-16 00:15:29', 'voyager.mb-transaction-channels.index', 'null'),
(15, 1, 'MB Menus', '', '_self', 'voyager-list', '#000000', NULL, 4, '2022-09-16 00:14:29', '2022-09-16 00:14:39', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_01_01_000000_add_voyager_user_fields', 1),
(4, '2016_01_01_000000_create_data_types_table', 1),
(5, '2016_05_19_173453_create_menu_table', 1),
(6, '2016_10_21_190000_create_roles_table', 1),
(7, '2016_10_21_190000_create_settings_table', 1),
(8, '2016_11_30_135954_create_permission_table', 1),
(9, '2016_11_30_141208_create_permission_role_table', 1),
(10, '2016_12_26_201236_data_types__add__server_side', 1),
(11, '2017_01_13_000000_add_route_to_menu_items_table', 1),
(12, '2017_01_14_005015_create_translations_table', 1),
(13, '2017_01_15_000000_make_table_name_nullable_in_permissions_table', 1),
(14, '2017_03_06_000000_add_controller_to_data_types_table', 1),
(15, '2017_04_21_000000_add_order_to_data_rows_table', 1),
(16, '2017_07_05_210000_add_policyname_to_data_types_table', 1),
(17, '2017_08_05_000000_add_group_to_settings_table', 1),
(18, '2017_11_26_013050_add_user_role_relationship', 1),
(19, '2017_11_26_015000_create_user_roles_table', 1),
(20, '2018_03_11_000000_add_user_settings', 1),
(21, '2018_03_14_000000_add_details_to_data_types_table', 1),
(22, '2018_03_16_000000_make_settings_value_nullable', 1),
(23, '2019_08_19_000000_create_failed_jobs_table', 1),
(24, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(25, '2016_01_01_000000_create_pages_table', 2),
(26, '2016_01_01_000000_create_posts_table', 2),
(27, '2016_02_15_204651_create_categories_table', 2),
(28, '2017_04_11_000000_alter_post_nullable_fields_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci,
  `body` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `author_id`, `title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 'Hello World', 'Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.', '<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', 'pages/page1.jpg', 'hello-world', 'Yar Meta Description', 'Keyword1, Keyword2', 'ACTIVE', '2022-09-07 18:05:48', '2022-09-07 18:05:48');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `key`, `table_name`, `created_at`, `updated_at`) VALUES
(1, 'browse_admin', NULL, '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(2, 'browse_bread', NULL, '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(3, 'browse_database', NULL, '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(4, 'browse_media', NULL, '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(5, 'browse_compass', NULL, '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(6, 'browse_menus', 'menus', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(7, 'read_menus', 'menus', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(8, 'edit_menus', 'menus', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(9, 'add_menus', 'menus', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(10, 'delete_menus', 'menus', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(11, 'browse_roles', 'roles', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(12, 'read_roles', 'roles', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(13, 'edit_roles', 'roles', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(14, 'add_roles', 'roles', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(15, 'delete_roles', 'roles', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(16, 'browse_users', 'users', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(17, 'read_users', 'users', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(18, 'edit_users', 'users', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(19, 'add_users', 'users', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(20, 'delete_users', 'users', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(21, 'browse_settings', 'settings', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(22, 'read_settings', 'settings', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(23, 'edit_settings', 'settings', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(24, 'add_settings', 'settings', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(25, 'delete_settings', 'settings', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(26, 'browse_categories', 'categories', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(27, 'read_categories', 'categories', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(28, 'edit_categories', 'categories', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(29, 'add_categories', 'categories', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(30, 'delete_categories', 'categories', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(31, 'browse_posts', 'posts', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(32, 'read_posts', 'posts', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(33, 'edit_posts', 'posts', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(34, 'add_posts', 'posts', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(35, 'delete_posts', 'posts', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(36, 'browse_pages', 'pages', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(37, 'read_pages', 'pages', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(38, 'edit_pages', 'pages', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(39, 'add_pages', 'pages', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(40, 'delete_pages', 'pages', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(41, 'browse_mb_transaction_channels', 'mb_transaction_channels', '2022-09-14 01:30:31', '2022-09-14 01:30:31'),
(42, 'read_mb_transaction_channels', 'mb_transaction_channels', '2022-09-14 01:30:31', '2022-09-14 01:30:31'),
(43, 'edit_mb_transaction_channels', 'mb_transaction_channels', '2022-09-14 01:30:31', '2022-09-14 01:30:31'),
(44, 'add_mb_transaction_channels', 'mb_transaction_channels', '2022-09-14 01:30:31', '2022-09-14 01:30:31'),
(45, 'delete_mb_transaction_channels', 'mb_transaction_channels', '2022-09-14 01:30:31', '2022-09-14 01:30:31');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci,
  `status` enum('PUBLISHED','DRAFT','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `author_id`, `category_id`, `title`, `seo_title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `featured`, `created_at`, `updated_at`) VALUES
(1, 0, NULL, 'Lorem Ipsum Post', NULL, 'This is the excerpt for the Lorem Ipsum Post', '<p>This is the body of the lorem ipsum post</p>', 'posts/post1.jpg', 'lorem-ipsum-post', 'This is the meta description', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(2, 0, NULL, 'My Sample Post', NULL, 'This is the excerpt for the sample Post', '<p>This is the body for the sample post, which includes the body.</p>\n                <h2>We can use all kinds of format!</h2>\n                <p>And include a bunch of other stuff.</p>', 'posts/post2.jpg', 'my-sample-post', 'Meta Description for sample post', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(3, 0, NULL, 'Latest Post', NULL, 'This is the excerpt for the latest post', '<p>This is the body for the latest post</p>', 'posts/post3.jpg', 'latest-post', 'This is the meta description', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(4, 0, NULL, 'Yarr Post', NULL, 'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.', '<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>', 'posts/post4.jpg', 'yarr-post', 'this be a meta descript', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2022-09-07 18:05:48', '2022-09-07 18:05:48');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Administrator', '2022-09-07 18:02:07', '2022-09-07 18:02:07'),
(2, 'user', 'Normal User', '2022-09-07 18:02:07', '2022-09-07 18:02:07');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `details` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `display_name`, `value`, `details`, `type`, `order`, `group`) VALUES
(1, 'site.title', 'Site Title', 'Site Title', '', 'text', 1, 'Site'),
(2, 'site.description', 'Site Description', 'Site Description', '', 'text', 2, 'Site'),
(3, 'site.logo', 'Site Logo', '', '', 'image', 3, 'Site'),
(4, 'site.google_analytics_tracking_id', 'Google Analytics Tracking ID', '', '', 'text', 4, 'Site'),
(5, 'admin.bg_image', 'Admin Background Image', '', '', 'image', 5, 'Admin'),
(6, 'admin.title', 'Admin Title', 'Voyager', '', 'text', 1, 'Admin'),
(7, 'admin.description', 'Admin Description', 'Welcome to Voyager. The Missing Admin for Laravel', '', 'text', 2, 'Admin'),
(8, 'admin.loader', 'Admin Loader', '', '', 'image', 3, 'Admin'),
(9, 'admin.icon_image', 'Admin Icon Image', '', '', 'image', 4, 'Admin'),
(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', '', '', 'text', 1, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `translations`
--

INSERT INTO `translations` (`id`, `table_name`, `column_name`, `foreign_key`, `locale`, `value`, `created_at`, `updated_at`) VALUES
(1, 'data_types', 'display_name_singular', 5, 'pt', 'Post', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(2, 'data_types', 'display_name_singular', 6, 'pt', 'Página', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(3, 'data_types', 'display_name_singular', 1, 'pt', 'Utilizador', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(4, 'data_types', 'display_name_singular', 4, 'pt', 'Categoria', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(5, 'data_types', 'display_name_singular', 2, 'pt', 'Menu', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(6, 'data_types', 'display_name_singular', 3, 'pt', 'Função', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(7, 'data_types', 'display_name_plural', 5, 'pt', 'Posts', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(8, 'data_types', 'display_name_plural', 6, 'pt', 'Páginas', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(9, 'data_types', 'display_name_plural', 1, 'pt', 'Utilizadores', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(10, 'data_types', 'display_name_plural', 4, 'pt', 'Categorias', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(11, 'data_types', 'display_name_plural', 2, 'pt', 'Menus', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(12, 'data_types', 'display_name_plural', 3, 'pt', 'Funções', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(13, 'categories', 'slug', 1, 'pt', 'categoria-1', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(14, 'categories', 'name', 1, 'pt', 'Categoria 1', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(15, 'categories', 'slug', 2, 'pt', 'categoria-2', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(16, 'categories', 'name', 2, 'pt', 'Categoria 2', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(17, 'pages', 'title', 1, 'pt', 'Olá Mundo', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(18, 'pages', 'slug', 1, 'pt', 'ola-mundo', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(19, 'pages', 'body', 1, 'pt', '<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(20, 'menu_items', 'title', 1, 'pt', 'Painel de Controle', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(21, 'menu_items', 'title', 2, 'pt', 'Media', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(22, 'menu_items', 'title', 12, 'pt', 'Publicações', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(23, 'menu_items', 'title', 3, 'pt', 'Utilizadores', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(24, 'menu_items', 'title', 11, 'pt', 'Categorias', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(25, 'menu_items', 'title', 13, 'pt', 'Páginas', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(26, 'menu_items', 'title', 4, 'pt', 'Funções', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(27, 'menu_items', 'title', 5, 'pt', 'Ferramentas', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(28, 'menu_items', 'title', 6, 'pt', 'Menus', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(29, 'menu_items', 'title', 7, 'pt', 'Base de dados', '2022-09-07 18:05:48', '2022-09-07 18:05:48'),
(30, 'menu_items', 'title', 10, 'pt', 'Configurações', '2022-09-07 18:05:48', '2022-09-07 18:05:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `created_at`, `updated_at`) VALUES
(1, 1, 'Admin', 'admin@admin.com', 'users/September2022/krz8N3vxMTdLtj76gKKi.jpg', NULL, '$2y$10$I701kcWvGzLtJiRvupHAcOLsiNizKK1bl7VFotV0J.M3KnXukY2WO', '9g186ZuBaIdg8DHfyxlk02Ff98AXaEtqopuvirKNk9IyWxFEsMOBqLrx29yV', '{\"locale\":\"en\"}', '2022-09-07 18:05:48', '2022-09-14 20:21:46');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_number` (`account_number`),
  ADD KEY `customer` (`customer`);

--
-- Indexes for table `bank_customers`
--
ALTER TABLE `bank_customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `id_number` (`id_number`),
  ADD KEY `phone_2` (`phone`),
  ADD KEY `id_number_2` (`id_number`);

--
-- Indexes for table `bank_transactions`
--
ALTER TABLE `bank_transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trx_code` (`trx_code`),
  ADD KEY `reference` (`reference`);

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `linked_account` (`linked_account`);

--
-- Indexes for table `card_networks`
--
ALTER TABLE `card_networks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_rows_data_type_id_foreign` (`data_type_id`);

--
-- Indexes for table `data_types`
--
ALTER TABLE `data_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `data_types_name_unique` (`name`),
  ADD UNIQUE KEY `data_types_slug_unique` (`slug`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `mb_home_menus`
--
ALTER TABLE `mb_home_menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mb_payment_templates`
--
ALTER TABLE `mb_payment_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mb_transaction_channels`
--
ALTER TABLE `mb_transaction_channels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mb_transfer_templates`
--
ALTER TABLE `mb_transfer_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mb_users`
--
ALTER TABLE `mb_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `default_account` (`default_account`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menus_name_unique` (`name`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_items_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permissions_key_index` (`key`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_permission_id_index` (`permission_id`),
  ADD KEY `permission_role_role_id_index` (`role_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `posts_slug_unique` (`slug`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `user_roles_user_id_index` (`user_id`),
  ADD KEY `user_roles_role_id_index` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bank_customers`
--
ALTER TABLE `bank_customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bank_transactions`
--
ALTER TABLE `bank_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `card_networks`
--
ALTER TABLE `card_networks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `data_rows`
--
ALTER TABLE `data_rows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `data_types`
--
ALTER TABLE `data_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mb_home_menus`
--
ALTER TABLE `mb_home_menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mb_payment_templates`
--
ALTER TABLE `mb_payment_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mb_transaction_channels`
--
ALTER TABLE `mb_transaction_channels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `mb_transfer_templates`
--
ALTER TABLE `mb_transfer_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mb_users`
--
ALTER TABLE `mb_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
