-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 15-10-2022 a las 09:56:28
-- Versión del servidor: 5.7.33-0ubuntu0.16.04.1
-- Versión de PHP: 7.0.33-0ubuntu0.16.04.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mtoffice`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_clients`
--

DROP TABLE IF EXISTS `ip_clients`;
CREATE TABLE `ip_clients` (
  `client_id` int(11) NOT NULL,
  `client_date_created` datetime NOT NULL,
  `client_date_modified` datetime NOT NULL,
  `client_name` text,
  `client_address_1` text,
  `client_address_2` text,
  `client_city` text,
  `client_state` text,
  `client_zip` text,
  `client_country` text,
  `client_phone` text,
  `client_fax` text,
  `client_mobile` text,
  `client_email` text,
  `client_web` text,
  `client_vat_id` text,
  `client_tax_code` text,
  `client_language` varchar(255) DEFAULT 'system',
  `client_active` int(1) NOT NULL DEFAULT '1',
  `client_surname` varchar(255) DEFAULT NULL,
  `client_avs` varchar(16) DEFAULT NULL,
  `client_insurednumber` varchar(30) DEFAULT NULL,
  `client_veka` varchar(30) DEFAULT NULL,
  `client_birthdate` date DEFAULT NULL,
  `client_gender` int(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_clients`
--

INSERT INTO `ip_clients` (`client_id`, `client_date_created`, `client_date_modified`, `client_name`, `client_address_1`, `client_address_2`, `client_city`, `client_state`, `client_zip`, `client_country`, `client_phone`, `client_fax`, `client_mobile`, `client_email`, `client_web`, `client_vat_id`, `client_tax_code`, `client_language`, `client_active`, `client_surname`, `client_avs`, `client_insurednumber`, `client_veka`, `client_birthdate`, `client_gender`) VALUES
(1, '2022-10-10 11:49:15', '2022-10-10 15:26:03', 'Carlin', 'Plaza independencia', '', 'Vigo', 'Galicia', '36234', 'ES', '986543210', '', '657456124', 'carlinmtoffice@gmail.com', 'carlin.com', '8756354A', '', 'system', 1, '', NULL, NULL, NULL, '2019-11-20', 2),
(2, '2022-10-10 11:54:48', '2022-10-10 11:54:48', 'garajesvigo', 'plaza américa 3', '', 'Vigo', 'Galicia', '36211', 'ES', '986546398', '', '687238456', 'garajesvigo@gmail.com', 'garajesvigo.es', '97645676W', '', 'system', 1, '', NULL, NULL, NULL, '2019-07-23', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_client_custom`
--

DROP TABLE IF EXISTS `ip_client_custom`;
CREATE TABLE `ip_client_custom` (
  `client_custom_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `client_custom_fieldid` int(11) NOT NULL,
  `client_custom_fieldvalue` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ip_client_custom`
--

INSERT INTO `ip_client_custom` (`client_custom_id`, `client_id`, `client_custom_fieldid`, `client_custom_fieldvalue`) VALUES
(1, 1, 1, 'http://facebook.com/lalalala');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_client_notes`
--

DROP TABLE IF EXISTS `ip_client_notes`;
CREATE TABLE `ip_client_notes` (
  `client_note_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `client_note_date` date NOT NULL,
  `client_note` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_custom_fields`
--

DROP TABLE IF EXISTS `ip_custom_fields`;
CREATE TABLE `ip_custom_fields` (
  `custom_field_id` int(11) NOT NULL,
  `custom_field_table` varchar(50) DEFAULT NULL,
  `custom_field_label` varchar(50) DEFAULT NULL,
  `custom_field_type` varchar(255) NOT NULL DEFAULT 'TEXT',
  `custom_field_location` int(11) DEFAULT '0',
  `custom_field_order` int(11) DEFAULT '999'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_custom_fields`
--

INSERT INTO `ip_custom_fields` (`custom_field_id`, `custom_field_table`, `custom_field_label`, `custom_field_type`, `custom_field_location`, `custom_field_order`) VALUES
(1, 'ip_client_custom', 'Facebook', 'TEXT', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_custom_values`
--

DROP TABLE IF EXISTS `ip_custom_values`;
CREATE TABLE `ip_custom_values` (
  `custom_values_id` int(11) NOT NULL,
  `custom_values_field` int(11) NOT NULL,
  `custom_values_value` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_email_templates`
--

DROP TABLE IF EXISTS `ip_email_templates`;
CREATE TABLE `ip_email_templates` (
  `email_template_id` int(11) NOT NULL,
  `email_template_title` text,
  `email_template_type` varchar(255) DEFAULT NULL,
  `email_template_body` longtext NOT NULL,
  `email_template_subject` text,
  `email_template_from_name` text,
  `email_template_from_email` text,
  `email_template_cc` text,
  `email_template_bcc` text,
  `email_template_pdf_template` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_families`
--

DROP TABLE IF EXISTS `ip_families`;
CREATE TABLE `ip_families` (
  `family_id` int(11) NOT NULL,
  `family_name` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_families`
--

INSERT INTO `ip_families` (`family_id`, `family_name`) VALUES
(1, 'Boligrafos'),
(2, 'Papel'),
(3, 'Inmuebles');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_imports`
--

DROP TABLE IF EXISTS `ip_imports`;
CREATE TABLE `ip_imports` (
  `import_id` int(11) NOT NULL,
  `import_date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_import_details`
--

DROP TABLE IF EXISTS `ip_import_details`;
CREATE TABLE `ip_import_details` (
  `import_detail_id` int(11) NOT NULL,
  `import_id` int(11) NOT NULL,
  `import_lang_key` varchar(35) NOT NULL,
  `import_table_name` varchar(35) NOT NULL,
  `import_record_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoices`
--

DROP TABLE IF EXISTS `ip_invoices`;
CREATE TABLE `ip_invoices` (
  `invoice_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_group_id` int(11) NOT NULL,
  `invoice_status_id` tinyint(2) NOT NULL DEFAULT '1',
  `is_read_only` tinyint(1) DEFAULT NULL,
  `invoice_password` varchar(90) DEFAULT NULL,
  `invoice_date_created` date NOT NULL,
  `invoice_time_created` time NOT NULL DEFAULT '00:00:00',
  `invoice_date_modified` datetime NOT NULL,
  `invoice_date_due` date NOT NULL,
  `invoice_number` varchar(100) DEFAULT NULL,
  `invoice_discount_amount` decimal(20,2) DEFAULT NULL,
  `invoice_discount_percent` decimal(20,2) DEFAULT NULL,
  `invoice_terms` longtext NOT NULL,
  `invoice_url_key` char(32) NOT NULL,
  `payment_method` int(11) NOT NULL DEFAULT '0',
  `creditinvoice_parent_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_invoices`
--

INSERT INTO `ip_invoices` (`invoice_id`, `user_id`, `client_id`, `invoice_group_id`, `invoice_status_id`, `is_read_only`, `invoice_password`, `invoice_date_created`, `invoice_time_created`, `invoice_date_modified`, `invoice_date_due`, `invoice_number`, `invoice_discount_amount`, `invoice_discount_percent`, `invoice_terms`, `invoice_url_key`, `payment_method`, `creditinvoice_parent_id`) VALUES
(1, 3, 1, 3, 4, 1, '', '2022-10-05', '12:45:51', '2022-10-10 12:46:42', '2022-11-04', '1', '0.00', '0.00', '', '3Lkt7NHqEu4cf2rwGjFpdhzJbV01Yx5W', 2, NULL),
(2, 3, 2, 3, 2, NULL, '', '2022-10-10', '13:03:45', '2022-10-10 15:37:22', '2022-11-09', '2', '0.00', '0.00', '', 'nQly8M5JmOtwYDHNkBc1ah6Ks74TCrfu', 2, NULL),
(3, 3, 2, 3, 1, NULL, '', '2022-08-24', '13:11:33', '2022-10-10 15:37:32', '2022-09-23', '3', '0.00', '0.00', '', 'RAxo9jQP2S5tcdrO3hw1u7ILbCeZamp8', 2, NULL),
(7, 3, 2, 3, 1, NULL, '', '2022-10-14', '12:03:29', '2022-10-14 12:03:39', '2022-11-13', '7', NULL, NULL, '', 'TFB2J8Khlm0t1Rcbk3s7MLVWGrwaAPeX', 2, NULL),
(8, 3, 2, 3, 1, NULL, '', '2022-10-14', '13:51:06', '2022-10-14 13:51:09', '2022-11-13', '8', NULL, NULL, '', 'EquJvPFai19re7nUCNKxpTlVLDAyzZjS', 2, NULL),
(9, 3, 2, 3, 1, NULL, '', '2022-10-14', '14:20:43', '2022-10-14 19:23:17', '2022-11-13', '10', '0.00', '0.00', '', 'ZLQzIelywj20Xmhiqc1DruJpoC3UNRsx', 2, NULL),
(10, 2, 2, 0, 1, NULL, '', '2022-10-15', '00:39:32', '2022-10-15 00:39:51', '2022-11-14', '10', NULL, NULL, '', 'wiI53L1uRhWdYrQT7JUtEm0aMDxXeZsj', 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoices_provider`
--

DROP TABLE IF EXISTS `ip_invoices_provider`;
CREATE TABLE `ip_invoices_provider` (
  `invoice_provider_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `invoice_group_id` int(11) NOT NULL,
  `invoice_provider_status_id` tinyint(2) NOT NULL DEFAULT '1',
  `is_read_only` tinyint(1) DEFAULT NULL,
  `invoice_provider_password` varchar(90) DEFAULT NULL,
  `invoice_provider_date_created` date NOT NULL,
  `invoice_provider_date_modified` datetime NOT NULL,
  `invoice_provider_date_due` date NOT NULL,
  `invoice_provider_number` varchar(200) NOT NULL,
  `invoice_provider_discount_amount` decimal(20,2) DEFAULT NULL,
  `invoice_provider_discount_percent` decimal(20,2) DEFAULT NULL,
  `invoice_provider_terms` longtext NOT NULL,
  `invoice_provider_url_key` char(32) NOT NULL,
  `payment_method` int(11) NOT NULL DEFAULT '0',
  `creditinvoice_parent_id` int(11) DEFAULT NULL,
  `invoice_provider_pdf` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_invoices_provider`
--

INSERT INTO `ip_invoices_provider` (`invoice_provider_id`, `user_id`, `provider_id`, `invoice_group_id`, `invoice_provider_status_id`, `is_read_only`, `invoice_provider_password`, `invoice_provider_date_created`, `invoice_provider_date_modified`, `invoice_provider_date_due`, `invoice_provider_number`, `invoice_provider_discount_amount`, `invoice_provider_discount_percent`, `invoice_provider_terms`, `invoice_provider_url_key`, `payment_method`, `creditinvoice_parent_id`, `invoice_provider_pdf`) VALUES
(1, 2, 11, 0, 1, NULL, NULL, '2022-10-15', '2022-10-15 01:59:51', '2022-11-14', '1', NULL, NULL, '', 'PRgfZaSCdkYvtK7jMGQio81r4N0TxOuX', 0, NULL, NULL),
(3, 2, 11, 0, 1, NULL, NULL, '2022-10-15', '2022-10-15 09:53:48', '2022-11-14', '1', NULL, NULL, '', 'cpAKlTizq0LhnMvykuGP7IRf6mt8UadO', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoices_recurring`
--

DROP TABLE IF EXISTS `ip_invoices_recurring`;
CREATE TABLE `ip_invoices_recurring` (
  `invoice_recurring_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `recur_start_date` date NOT NULL,
  `recur_end_date` date NOT NULL,
  `recur_frequency` varchar(255) NOT NULL,
  `recur_next_date` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_amounts`
--

DROP TABLE IF EXISTS `ip_invoice_amounts`;
CREATE TABLE `ip_invoice_amounts` (
  `invoice_amount_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `invoice_sign` enum('1','-1') NOT NULL DEFAULT '1',
  `invoice_item_subtotal` decimal(20,2) DEFAULT NULL,
  `invoice_item_tax_total` decimal(20,2) DEFAULT NULL,
  `invoice_tax_total` decimal(20,2) DEFAULT NULL,
  `invoice_total` decimal(20,2) DEFAULT NULL,
  `invoice_paid` decimal(20,2) DEFAULT NULL,
  `invoice_balance` decimal(20,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_invoice_amounts`
--

INSERT INTO `ip_invoice_amounts` (`invoice_amount_id`, `invoice_id`, `invoice_sign`, `invoice_item_subtotal`, `invoice_item_tax_total`, `invoice_tax_total`, `invoice_total`, `invoice_paid`, `invoice_balance`) VALUES
(1, 1, '1', '5.00', '1.05', '-1.15', '4.90', '4.90', '0.00'),
(2, 2, '1', '50.00', '10.50', '-11.50', '49.00', '0.00', '49.00'),
(3, 3, '1', '50.00', '10.50', '-11.50', '49.00', '0.00', '49.00'),
(7, 7, '1', '50.00', '10.50', '-11.50', '49.00', '0.00', '49.00'),
(8, 8, '1', '50.00', '10.50', '-11.50', '49.00', '0.00', '49.00'),
(9, 9, '1', '50.00', '10.50', '-11.50', '49.00', '0.00', '49.00'),
(10, 10, '1', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_custom`
--

DROP TABLE IF EXISTS `ip_invoice_custom`;
CREATE TABLE `ip_invoice_custom` (
  `invoice_custom_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `invoice_custom_fieldid` int(11) NOT NULL,
  `invoice_custom_fieldvalue` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_groups`
--

DROP TABLE IF EXISTS `ip_invoice_groups`;
CREATE TABLE `ip_invoice_groups` (
  `invoice_group_id` int(11) NOT NULL,
  `invoice_group_name` text,
  `invoice_group_identifier_format` varchar(255) NOT NULL,
  `invoice_group_next_id` int(11) NOT NULL,
  `invoice_group_left_pad` int(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_invoice_groups`
--

INSERT INTO `ip_invoice_groups` (`invoice_group_id`, `invoice_group_name`, `invoice_group_identifier_format`, `invoice_group_next_id`, `invoice_group_left_pad`) VALUES
(0, 'Invoice Default', '{{{id}}}', 11, 0),
(1, 'Quote Default', 'QUO{{{id}}}', 3, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_items`
--

DROP TABLE IF EXISTS `ip_invoice_items`;
CREATE TABLE `ip_invoice_items` (
  `item_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `item_tax_rate_id` int(11) NOT NULL DEFAULT '0',
  `item_product_id` int(11) DEFAULT NULL,
  `item_date_added` date NOT NULL,
  `item_task_id` int(11) DEFAULT NULL,
  `item_name` text,
  `item_description` longtext,
  `item_quantity` decimal(10,2) NOT NULL,
  `item_price` decimal(20,2) DEFAULT NULL,
  `item_discount_amount` decimal(20,2) DEFAULT NULL,
  `item_order` int(2) NOT NULL DEFAULT '0',
  `item_is_recurring` tinyint(1) DEFAULT NULL,
  `item_product_unit` varchar(50) DEFAULT NULL,
  `item_product_unit_id` int(11) DEFAULT NULL,
  `item_date` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_invoice_items`
--

INSERT INTO `ip_invoice_items` (`item_id`, `invoice_id`, `item_tax_rate_id`, `item_product_id`, `item_date_added`, `item_task_id`, `item_name`, `item_description`, `item_quantity`, `item_price`, `item_discount_amount`, `item_order`, `item_is_recurring`, `item_product_unit`, `item_product_unit_id`, `item_date`) VALUES
(1, 1, 1, NULL, '2022-10-10', NULL, 'boligrafos', '', '2.00', '2.00', NULL, 1, NULL, NULL, NULL, NULL),
(2, 1, 1, NULL, '2022-10-10', NULL, 'papel', '', '1.00', '1.00', NULL, 2, NULL, NULL, NULL, NULL),
(3, 2, 1, 3, '2022-10-10', NULL, 'Garaje', 'Plaza garaje 20m2', '1.00', '50.00', NULL, 1, 0, 'mensual', 1, NULL),
(4, 3, 1, 3, '2022-10-10', NULL, 'Garaje', 'Plaza garaje 20m2', '1.00', '50.00', NULL, 1, 0, 'mensual', 1, NULL),
(7, 7, 1, 3, '2022-10-14', NULL, 'Garaje', 'Plaza garaje 20m2', '1.00', '50.00', NULL, 1, 0, 'mensual', 1, NULL),
(8, 8, 1, 3, '2022-10-14', NULL, 'Garaje', 'Plaza garaje 20m2', '1.00', '50.00', NULL, 1, 0, 'mensual', 1, NULL),
(9, 9, 1, 3, '2022-10-14', NULL, 'Garaje', 'Plaza garaje 20m2', '1.00', '50.00', NULL, 1, 0, 'mensual', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_item_amounts`
--

DROP TABLE IF EXISTS `ip_invoice_item_amounts`;
CREATE TABLE `ip_invoice_item_amounts` (
  `item_amount_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_subtotal` decimal(20,2) DEFAULT NULL,
  `item_tax_total` decimal(20,2) DEFAULT NULL,
  `item_discount` decimal(20,2) DEFAULT NULL,
  `item_total` decimal(20,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_invoice_item_amounts`
--

INSERT INTO `ip_invoice_item_amounts` (`item_amount_id`, `item_id`, `item_subtotal`, `item_tax_total`, `item_discount`, `item_total`) VALUES
(1, 1, '4.00', '0.84', '0.00', '4.84'),
(2, 2, '1.00', '0.21', '0.00', '1.21'),
(3, 3, '50.00', '10.50', '0.00', '60.50'),
(4, 4, '50.00', '10.50', '0.00', '60.50'),
(7, 7, '50.00', '10.50', '0.00', '60.50'),
(8, 8, '50.00', '10.50', '0.00', '60.50'),
(9, 9, '50.00', '10.50', '0.00', '60.50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_provider_amounts`
--

DROP TABLE IF EXISTS `ip_invoice_provider_amounts`;
CREATE TABLE `ip_invoice_provider_amounts` (
  `invoice_provider_amount_id` int(11) NOT NULL,
  `invoice_provider_id` int(11) NOT NULL,
  `invoice_provider_sign` enum('1','-1') NOT NULL DEFAULT '1',
  `invoice_provider_item_subtotal` decimal(20,2) DEFAULT '0.00',
  `invoice_provider_item_tax_total` decimal(20,2) DEFAULT '0.00',
  `invoice_provider_tax_total` decimal(20,2) DEFAULT '0.00',
  `invoice_provider_total` decimal(20,2) DEFAULT '0.00',
  `invoice_provider_paid` decimal(20,2) DEFAULT '0.00',
  `invoice_provider_balance` decimal(20,2) DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_invoice_provider_amounts`
--

INSERT INTO `ip_invoice_provider_amounts` (`invoice_provider_amount_id`, `invoice_provider_id`, `invoice_provider_sign`, `invoice_provider_item_subtotal`, `invoice_provider_item_tax_total`, `invoice_provider_tax_total`, `invoice_provider_total`, `invoice_provider_paid`, `invoice_provider_balance`) VALUES
(65, 3, '1', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00'),
(64, 1, '1', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_provider_custom`
--

DROP TABLE IF EXISTS `ip_invoice_provider_custom`;
CREATE TABLE `ip_invoice_provider_custom` (
  `invoice_provider_custom_id` int(11) NOT NULL,
  `invoice_provider_id` int(11) NOT NULL,
  `invoice_custom_fieldid` int(11) NOT NULL,
  `invoice_custom_fieldvalue` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_provider_items`
--

DROP TABLE IF EXISTS `ip_invoice_provider_items`;
CREATE TABLE `ip_invoice_provider_items` (
  `item_id` int(11) NOT NULL,
  `invoice_provider_id` int(11) NOT NULL,
  `item_tax_rate_id` int(11) NOT NULL DEFAULT '0',
  `item_product_id` int(11) DEFAULT NULL,
  `item_date_added` date NOT NULL,
  `item_task_id` int(11) DEFAULT NULL,
  `item_name` text,
  `item_description` longtext,
  `item_quantity` decimal(10,2) NOT NULL,
  `item_price` decimal(20,2) DEFAULT NULL,
  `item_discount_amount` decimal(20,2) DEFAULT NULL,
  `item_order` int(2) NOT NULL DEFAULT '0',
  `item_product_unit` varchar(50) DEFAULT NULL,
  `item_product_unit_id` int(11) DEFAULT NULL,
  `item_date` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_provider_item_amounts`
--

DROP TABLE IF EXISTS `ip_invoice_provider_item_amounts`;
CREATE TABLE `ip_invoice_provider_item_amounts` (
  `item_amount_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_subtotal` decimal(20,2) NOT NULL,
  `item_tax_total` decimal(20,2) NOT NULL,
  `item_discount` decimal(20,2) DEFAULT NULL,
  `item_total` decimal(20,2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_provider_tax_rates`
--

DROP TABLE IF EXISTS `ip_invoice_provider_tax_rates`;
CREATE TABLE `ip_invoice_provider_tax_rates` (
  `invoice_provider_tax_rate_id` int(11) NOT NULL,
  `invoice_provider_id` int(11) NOT NULL,
  `tax_rate_id` int(11) NOT NULL,
  `include_item_tax` int(1) NOT NULL DEFAULT '0',
  `invoice_provider_tax_rate_amount` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_sumex`
--

DROP TABLE IF EXISTS `ip_invoice_sumex`;
CREATE TABLE `ip_invoice_sumex` (
  `sumex_id` int(11) NOT NULL,
  `sumex_invoice` int(11) NOT NULL,
  `sumex_reason` int(11) NOT NULL,
  `sumex_diagnosis` varchar(500) NOT NULL,
  `sumex_observations` varchar(500) NOT NULL,
  `sumex_treatmentstart` date NOT NULL,
  `sumex_treatmentend` date NOT NULL,
  `sumex_casedate` date NOT NULL,
  `sumex_casenumber` varchar(35) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_invoice_tax_rates`
--

DROP TABLE IF EXISTS `ip_invoice_tax_rates`;
CREATE TABLE `ip_invoice_tax_rates` (
  `invoice_tax_rate_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `tax_rate_id` int(11) NOT NULL,
  `include_item_tax` int(1) NOT NULL DEFAULT '0',
  `invoice_tax_rate_amount` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_invoice_tax_rates`
--

INSERT INTO `ip_invoice_tax_rates` (`invoice_tax_rate_id`, `invoice_id`, `tax_rate_id`, `include_item_tax`, `invoice_tax_rate_amount`) VALUES
(1, 1, 4, 1, '-1.15'),
(2, 2, 4, 1, '-11.50'),
(3, 3, 4, 1, '-11.50'),
(7, 7, 4, 1, '-11.50'),
(8, 8, 4, 1, '-11.50'),
(9, 9, 4, 1, '-11.50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_item_lookups`
--

DROP TABLE IF EXISTS `ip_item_lookups`;
CREATE TABLE `ip_item_lookups` (
  `item_lookup_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL DEFAULT '',
  `item_description` longtext NOT NULL,
  `item_price` decimal(10,2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_merchant_responses`
--

DROP TABLE IF EXISTS `ip_merchant_responses`;
CREATE TABLE `ip_merchant_responses` (
  `merchant_response_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `merchant_response_successful` tinyint(1) DEFAULT '1',
  `merchant_response_date` date NOT NULL,
  `merchant_response_driver` varchar(35) NOT NULL,
  `merchant_response` varchar(255) NOT NULL,
  `merchant_response_reference` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_payments`
--

DROP TABLE IF EXISTS `ip_payments`;
CREATE TABLE `ip_payments` (
  `payment_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL DEFAULT '0',
  `payment_date` date NOT NULL,
  `payment_amount` decimal(20,2) DEFAULT NULL,
  `payment_note` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_payments`
--

INSERT INTO `ip_payments` (`payment_id`, `invoice_id`, `payment_method_id`, `payment_date`, `payment_amount`, `payment_note`) VALUES
(1, 1, 2, '2022-10-10', '4.90', ''),
(2, 1, 2, '2022-10-10', '0.00', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_payments_provider`
--

DROP TABLE IF EXISTS `ip_payments_provider`;
CREATE TABLE `ip_payments_provider` (
  `payment_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL DEFAULT '0',
  `payment_date` date NOT NULL,
  `payment_amount` decimal(20,2) DEFAULT NULL,
  `payment_note` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_payments_provider`
--

INSERT INTO `ip_payments_provider` (`payment_id`, `invoice_id`, `payment_method_id`, `payment_date`, `payment_amount`, `payment_note`) VALUES
(3, 1, 1, '2022-10-14', '21.84', 'ASDSADSADSA'),
(4, 1, 1, '2022-10-14', '21.84', 'sadsadsadsadsa'),
(5, 1, 1, '2022-10-14', '-21.84', 'sdsadsa'),
(6, 1, 1, '2022-10-14', '21.84', 'asdsadsadas'),
(7, 1, 1, '2022-10-14', '21.84', 'sadsadsadsad'),
(8, 1, 1, '2022-10-14', '1.00', 'asd'),
(9, 1, 1, '2022-10-14', '21.84', 'asdasdsadsada'),
(10, 1, 1, '2022-10-14', '21.84', 'asdasdasda'),
(11, 1, 1, '2022-10-14', '-88.36', 'asdsadsa'),
(12, 41, 1, '2022-10-14', '23.65', 'sadsadsada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_payment_custom`
--

DROP TABLE IF EXISTS `ip_payment_custom`;
CREATE TABLE `ip_payment_custom` (
  `payment_custom_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `payment_custom_fieldid` int(11) NOT NULL,
  `payment_custom_fieldvalue` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_payment_methods`
--

DROP TABLE IF EXISTS `ip_payment_methods`;
CREATE TABLE `ip_payment_methods` (
  `payment_method_id` int(11) NOT NULL,
  `payment_method_name` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_payment_methods`
--

INSERT INTO `ip_payment_methods` (`payment_method_id`, `payment_method_name`) VALUES
(1, 'Cash'),
(2, 'Credit Card');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_products`
--

DROP TABLE IF EXISTS `ip_products`;
CREATE TABLE `ip_products` (
  `product_id` int(11) NOT NULL,
  `family_id` int(11) DEFAULT NULL,
  `product_sku` text,
  `product_name` text,
  `product_description` longtext NOT NULL,
  `product_price` decimal(20,2) DEFAULT NULL,
  `purchase_price` decimal(20,2) DEFAULT NULL,
  `provider_name` text,
  `tax_rate_id` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `product_tariff` int(11) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_products`
--

INSERT INTO `ip_products` (`product_id`, `family_id`, `product_sku`, `product_name`, `product_description`, `product_price`, `purchase_price`, `provider_name`, `tax_rate_id`, `unit_id`, `product_tariff`, `provider_id`) VALUES
(1, 1, '24324324324', 'boligrafo BIC', 'Un boligrafo, el titulo es muy claro, no?', '2.00', NULL, '', 1, NULL, 0, 11),
(2, 2, '5432654643', '100 folios DIN-A4', 'Paquete de folios de 100', '1.00', NULL, '', 1, NULL, 0, 0),
(3, 3, '4324232432', 'Garaje', 'Plaza garaje 20m2', '50.00', NULL, '', 1, 1, 0, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_projects`
--

DROP TABLE IF EXISTS `ip_projects`;
CREATE TABLE `ip_projects` (
  `project_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `project_name` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_providers`
--

DROP TABLE IF EXISTS `ip_providers`;
CREATE TABLE `ip_providers` (
  `provider_id` int(11) NOT NULL,
  `provider_date_created` datetime NOT NULL,
  `provider_date_modified` datetime NOT NULL,
  `provider_name` text,
  `provider_comercial_name` text,
  `provider_address_1` text,
  `provider_address_2` text,
  `provider_city` text,
  `provider_state` text,
  `provider_zip` text,
  `provider_country` text,
  `provider_phone` text,
  `provider_mobile` text,
  `provider_email` text,
  `provider_web` text,
  `provider_vat_id` text,
  `provider_language` varchar(255) DEFAULT 'system',
  `provider_active` int(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_providers`
--

INSERT INTO `ip_providers` (`provider_id`, `provider_date_created`, `provider_date_modified`, `provider_name`, `provider_comercial_name`, `provider_address_1`, `provider_address_2`, `provider_city`, `provider_state`, `provider_zip`, `provider_country`, `provider_phone`, `provider_mobile`, `provider_email`, `provider_web`, `provider_vat_id`, `provider_language`, `provider_active`) VALUES
(11, '2022-10-11 15:49:51', '2022-10-13 08:46:59', 'empresa', 'lalalala', 'sadsadsda', 'sadsadadsa', 'asdsad', 'adsadsa', '123123', 'DE', '4323243', '131231323', 'sdsadsa@gmail.com', 'sadsasad.com', '12321313', 'Arabic', 1),
(13, '2022-10-13 14:01:07', '2022-10-13 14:01:07', 'dfdssa', 'asdsadsadsa', '', '', '', '', '', '', '', '', '', '', '', 'system', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_provider_custom`
--

DROP TABLE IF EXISTS `ip_provider_custom`;
CREATE TABLE `ip_provider_custom` (
  `provider_custom_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `provider_custom_fieldid` int(11) NOT NULL,
  `provider_custom_fieldvalue` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_provider_notes`
--

DROP TABLE IF EXISTS `ip_provider_notes`;
CREATE TABLE `ip_provider_notes` (
  `provider_note_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `provider_note_date` date NOT NULL,
  `provider_note` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_provider_notes`
--

INSERT INTO `ip_provider_notes` (`provider_note_id`, `provider_id`, `provider_note_date`, `provider_note`) VALUES
(2, 11, '2022-10-11', 'adasada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_quotes`
--

DROP TABLE IF EXISTS `ip_quotes`;
CREATE TABLE `ip_quotes` (
  `quote_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_group_id` int(11) NOT NULL,
  `quote_status_id` tinyint(2) NOT NULL DEFAULT '1',
  `quote_date_created` date NOT NULL,
  `quote_date_modified` datetime NOT NULL,
  `quote_date_expires` date NOT NULL,
  `quote_number` varchar(100) DEFAULT NULL,
  `quote_discount_amount` decimal(20,2) DEFAULT NULL,
  `quote_discount_percent` decimal(20,2) DEFAULT NULL,
  `quote_url_key` char(32) NOT NULL,
  `quote_password` varchar(90) DEFAULT NULL,
  `notes` longtext
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_quotes`
--

INSERT INTO `ip_quotes` (`quote_id`, `invoice_id`, `user_id`, `client_id`, `invoice_group_id`, `quote_status_id`, `quote_date_created`, `quote_date_modified`, `quote_date_expires`, `quote_number`, `quote_discount_amount`, `quote_discount_percent`, `quote_url_key`, `quote_password`, `notes`) VALUES
(1, 1, 3, 1, 4, 4, '2022-10-10', '2022-10-10 12:45:10', '2022-10-25', 'QUO1', '0.00', '0.00', 'bpUwSeqWDY3rEzvZM0hR5aOG9gLJ76nx', '', ''),
(2, 0, 3, 2, 4, 1, '2022-10-10', '2022-10-10 13:02:22', '2022-10-25', 'QUO2', NULL, NULL, 'erDsyuhFGzPKLM9k8XVOJ4aWfBmYCjQn', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_quote_amounts`
--

DROP TABLE IF EXISTS `ip_quote_amounts`;
CREATE TABLE `ip_quote_amounts` (
  `quote_amount_id` int(11) NOT NULL,
  `quote_id` int(11) NOT NULL,
  `quote_item_subtotal` decimal(20,2) DEFAULT NULL,
  `quote_item_tax_total` decimal(20,2) DEFAULT NULL,
  `quote_tax_total` decimal(20,2) DEFAULT NULL,
  `quote_total` decimal(20,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_quote_amounts`
--

INSERT INTO `ip_quote_amounts` (`quote_amount_id`, `quote_id`, `quote_item_subtotal`, `quote_item_tax_total`, `quote_tax_total`, `quote_total`) VALUES
(1, 1, '5.00', '1.05', '-1.15', '4.90'),
(2, 2, '0.00', NULL, '0.00', '0.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_quote_custom`
--

DROP TABLE IF EXISTS `ip_quote_custom`;
CREATE TABLE `ip_quote_custom` (
  `quote_custom_id` int(11) NOT NULL,
  `quote_id` int(11) NOT NULL,
  `quote_custom_fieldid` int(11) NOT NULL,
  `quote_custom_fieldvalue` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_quote_items`
--

DROP TABLE IF EXISTS `ip_quote_items`;
CREATE TABLE `ip_quote_items` (
  `item_id` int(11) NOT NULL,
  `quote_id` int(11) NOT NULL,
  `item_tax_rate_id` int(11) NOT NULL,
  `item_product_id` int(11) DEFAULT NULL,
  `item_date_added` date NOT NULL,
  `item_name` text,
  `item_description` text,
  `item_quantity` decimal(20,2) DEFAULT NULL,
  `item_price` decimal(20,2) DEFAULT NULL,
  `item_discount_amount` decimal(20,2) DEFAULT NULL,
  `item_order` int(2) NOT NULL DEFAULT '0',
  `item_product_unit` varchar(50) DEFAULT NULL,
  `item_product_unit_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_quote_items`
--

INSERT INTO `ip_quote_items` (`item_id`, `quote_id`, `item_tax_rate_id`, `item_product_id`, `item_date_added`, `item_name`, `item_description`, `item_quantity`, `item_price`, `item_discount_amount`, `item_order`, `item_product_unit`, `item_product_unit_id`) VALUES
(1, 1, 1, NULL, '2022-10-10', 'boligrafos', '', '2.00', '2.00', NULL, 1, NULL, NULL),
(2, 1, 1, NULL, '2022-10-10', 'papel', '', '1.00', '1.00', NULL, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_quote_item_amounts`
--

DROP TABLE IF EXISTS `ip_quote_item_amounts`;
CREATE TABLE `ip_quote_item_amounts` (
  `item_amount_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_subtotal` decimal(20,2) DEFAULT NULL,
  `item_tax_total` decimal(20,2) DEFAULT NULL,
  `item_discount` decimal(20,2) DEFAULT NULL,
  `item_total` decimal(20,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_quote_item_amounts`
--

INSERT INTO `ip_quote_item_amounts` (`item_amount_id`, `item_id`, `item_subtotal`, `item_tax_total`, `item_discount`, `item_total`) VALUES
(1, 1, '4.00', '0.84', '0.00', '4.84'),
(2, 2, '1.00', '0.21', '0.00', '1.21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_quote_tax_rates`
--

DROP TABLE IF EXISTS `ip_quote_tax_rates`;
CREATE TABLE `ip_quote_tax_rates` (
  `quote_tax_rate_id` int(11) NOT NULL,
  `quote_id` int(11) NOT NULL,
  `tax_rate_id` int(11) NOT NULL,
  `include_item_tax` int(1) NOT NULL DEFAULT '0',
  `quote_tax_rate_amount` decimal(20,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_quote_tax_rates`
--

INSERT INTO `ip_quote_tax_rates` (`quote_tax_rate_id`, `quote_id`, `tax_rate_id`, `include_item_tax`, `quote_tax_rate_amount`) VALUES
(1, 1, 4, 1, '-1.15'),
(2, 2, 4, 1, '0.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_sessions`
--

DROP TABLE IF EXISTS `ip_sessions`;
CREATE TABLE `ip_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_settings`
--

DROP TABLE IF EXISTS `ip_settings`;
CREATE TABLE `ip_settings` (
  `setting_id` int(11) NOT NULL,
  `setting_key` varchar(50) NOT NULL,
  `setting_value` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_settings`
--

INSERT INTO `ip_settings` (`setting_id`, `setting_key`, `setting_value`) VALUES
(19, 'default_language', 'Spanish'),
(20, 'date_format', 'm/d/Y'),
(21, 'currency_symbol', '€'),
(22, 'currency_symbol_placement', 'after'),
(23, 'currency_code', 'EUR'),
(24, 'invoices_due_after', '30'),
(25, 'quotes_expire_after', '15'),
(26, 'default_invoice_group', '3'),
(27, 'default_quote_group', '4'),
(28, 'thousands_separator', '.'),
(29, 'decimal_point', ','),
(30, 'cron_key', 'KhJqm8v2rVOyEixk'),
(31, 'tax_rate_decimal_places', '2'),
(32, 'pdf_invoice_template', 'InvoicePlane'),
(33, 'pdf_invoice_template_paid', 'InvoicePlane - paid'),
(34, 'pdf_invoice_template_overdue', 'InvoicePlane - overdue'),
(35, 'pdf_quote_template', 'InvoicePlane'),
(36, 'public_invoice_template', 'InvoicePlane_Web'),
(37, 'public_quote_template', 'InvoicePlane_Web'),
(38, 'disable_sidebar', '1'),
(39, 'read_only_toggle', '4'),
(40, 'invoice_pre_password', ''),
(41, 'quote_pre_password', ''),
(42, 'email_pdf_attachment', '1'),
(43, 'generate_invoice_number_for_draft', '1'),
(44, 'generate_quote_number_for_draft', '1'),
(45, 'sumex', '0'),
(46, 'sumex_sliptype', '1'),
(47, 'sumex_canton', '0'),
(48, 'system_theme', 'invoiceplane'),
(49, 'default_hourly_rate', '0.00'),
(50, 'projects_enabled', '1'),
(51, 'pdf_quote_footer', ''),
(52, 'first_day_of_week', '0'),
(53, 'default_country', ''),
(54, 'default_list_limit', '15'),
(55, 'number_format', 'number_format_european'),
(56, 'quote_overview_period', 'this-month'),
(57, 'invoice_overview_period', 'this-month'),
(58, 'disable_quickactions', '0'),
(59, 'custom_title', ''),
(60, 'monospace_amounts', '0'),
(61, 'reports_in_new_tab', '0'),
(62, 'bcc_mails_to_admin', '0'),
(63, 'default_invoice_terms', ''),
(64, 'invoice_default_payment_method', ''),
(65, 'mark_invoices_sent_pdf', '0'),
(66, 'include_zugferd', '0'),
(67, 'pdf_watermark', '0'),
(68, 'email_invoice_template', ''),
(69, 'email_invoice_template_paid', ''),
(70, 'email_invoice_template_overdue', ''),
(71, 'pdf_invoice_footer', ''),
(72, 'automatic_email_on_recur', '0'),
(73, 'sumex_role', '0'),
(74, 'sumex_place', '0'),
(75, 'default_quote_notes', ''),
(76, 'mark_quotes_sent_pdf', '0'),
(77, 'email_quote_template', ''),
(78, 'default_invoice_tax_rate', ''),
(79, 'default_item_tax_rate', ''),
(80, 'default_include_item_tax', ''),
(81, 'email_send_method', 'smtp'),
(82, 'smtp_server_address', 'ssl://teconsite.com'),
(83, 'smtp_mail_from', 'ssl://teconsite.com'),
(84, 'smtp_authentication', '1'),
(85, 'smtp_username', 'pablob@teconsite.com'),
(86, 'smtp_port', '465'),
(87, 'smtp_security', 'tls'),
(88, 'smtp_verify_certs', '1'),
(89, 'enable_online_payments', '0'),
(90, 'gateway_authorizenet_aim_enabled', '0'),
(91, 'gateway_authorizenet_aim_apiLoginId', ''),
(92, 'gateway_authorizenet_aim_transactionKey', ''),
(93, 'gateway_authorizenet_aim_testMode', '0'),
(94, 'gateway_authorizenet_aim_developerMode', '0'),
(95, 'gateway_authorizenet_aim_currency', 'AUD'),
(96, 'gateway_authorizenet_aim_payment_method', ''),
(97, 'gateway_authorizenet_sim_enabled', '0'),
(98, 'gateway_authorizenet_sim_apiLoginId', ''),
(99, 'gateway_authorizenet_sim_transactionKey', ''),
(100, 'gateway_authorizenet_sim_testMode', '0'),
(101, 'gateway_authorizenet_sim_developerMode', '0'),
(102, 'gateway_authorizenet_sim_currency', 'AUD'),
(103, 'gateway_authorizenet_sim_payment_method', ''),
(104, 'gateway_buckaroo_ideal_enabled', '0'),
(105, 'gateway_buckaroo_ideal_websiteKey', ''),
(106, 'gateway_buckaroo_ideal_testMode', '0'),
(107, 'gateway_buckaroo_ideal_currency', 'AUD'),
(108, 'gateway_buckaroo_ideal_payment_method', ''),
(109, 'gateway_buckaroo_paypal_enabled', '0'),
(110, 'gateway_buckaroo_paypal_websiteKey', ''),
(111, 'gateway_buckaroo_paypal_testMode', '0'),
(112, 'gateway_buckaroo_paypal_currency', 'AUD'),
(113, 'gateway_buckaroo_paypal_payment_method', ''),
(114, 'gateway_cardsave_enabled', '0'),
(115, 'gateway_cardsave_merchantId', ''),
(116, 'gateway_cardsave_currency', 'AUD'),
(117, 'gateway_cardsave_payment_method', ''),
(118, 'gateway_coinbase_enabled', '0'),
(119, 'gateway_coinbase_apiKey', ''),
(120, 'gateway_coinbase_accountId', ''),
(121, 'gateway_coinbase_currency', 'AUD'),
(122, 'gateway_coinbase_payment_method', ''),
(123, 'gateway_eway_rapid_enabled', '0'),
(124, 'gateway_eway_rapid_apiKey', ''),
(125, 'gateway_eway_rapid_testMode', '0'),
(126, 'gateway_eway_rapid_currency', 'AUD'),
(127, 'gateway_eway_rapid_payment_method', ''),
(128, 'gateway_firstdata_connect_enabled', '0'),
(129, 'gateway_firstdata_connect_storeId', ''),
(130, 'gateway_firstdata_connect_testMode', '0'),
(131, 'gateway_firstdata_connect_currency', 'AUD'),
(132, 'gateway_firstdata_connect_payment_method', ''),
(133, 'gateway_gocardless_enabled', '0'),
(134, 'gateway_gocardless_appId', ''),
(135, 'gateway_gocardless_merchantId', ''),
(136, 'gateway_gocardless_accessToken', ''),
(137, 'gateway_gocardless_testMode', '0'),
(138, 'gateway_gocardless_currency', 'AUD'),
(139, 'gateway_gocardless_payment_method', ''),
(140, 'gateway_migs_threeparty_enabled', '0'),
(141, 'gateway_migs_threeparty_merchantId', ''),
(142, 'gateway_migs_threeparty_merchantAccessCode', ''),
(143, 'gateway_migs_threeparty_secureHash', ''),
(144, 'gateway_migs_threeparty_currency', 'AUD'),
(145, 'gateway_migs_threeparty_payment_method', ''),
(146, 'gateway_migs_twoparty_enabled', '0'),
(147, 'gateway_migs_twoparty_merchantId', ''),
(148, 'gateway_migs_twoparty_merchantAccessCode', ''),
(149, 'gateway_migs_twoparty_secureHash', ''),
(150, 'gateway_migs_twoparty_currency', 'AUD'),
(151, 'gateway_migs_twoparty_payment_method', ''),
(152, 'gateway_mollie_enabled', '0'),
(153, 'gateway_mollie_apiKey', ''),
(154, 'gateway_mollie_currency', 'AUD'),
(155, 'gateway_mollie_payment_method', ''),
(156, 'gateway_multisafepay_enabled', '0'),
(157, 'gateway_multisafepay_accountId', ''),
(158, 'gateway_multisafepay_siteId', ''),
(159, 'gateway_multisafepay_siteCode', ''),
(160, 'gateway_multisafepay_testMode', '0'),
(161, 'gateway_multisafepay_currency', 'AUD'),
(162, 'gateway_multisafepay_payment_method', ''),
(163, 'gateway_netaxept_enabled', '0'),
(164, 'gateway_netaxept_merchantId', ''),
(165, 'gateway_netaxept_testMode', '0'),
(166, 'gateway_netaxept_currency', 'AUD'),
(167, 'gateway_netaxept_payment_method', ''),
(168, 'gateway_netbanx_enabled', '0'),
(169, 'gateway_netbanx_accountNumber', ''),
(170, 'gateway_netbanx_storeId', ''),
(171, 'gateway_netbanx_testMode', '0'),
(172, 'gateway_netbanx_currency', 'AUD'),
(173, 'gateway_netbanx_payment_method', ''),
(174, 'gateway_payfast_enabled', '0'),
(175, 'gateway_payfast_merchantId', ''),
(176, 'gateway_payfast_merchantKey', ''),
(177, 'gateway_payfast_pdtKey', ''),
(178, 'gateway_payfast_testMode', '0'),
(179, 'gateway_payfast_currency', 'AUD'),
(180, 'gateway_payfast_payment_method', ''),
(181, 'gateway_payflow_pro_enabled', '0'),
(182, 'gateway_payflow_pro_username', ''),
(183, 'gateway_payflow_pro_vendor', ''),
(184, 'gateway_payflow_pro_partner', ''),
(185, 'gateway_payflow_pro_testMode', '0'),
(186, 'gateway_payflow_pro_currency', 'AUD'),
(187, 'gateway_payflow_pro_payment_method', ''),
(188, 'gateway_paymentexpress_pxpay_enabled', '0'),
(189, 'gateway_paymentexpress_pxpay_username', ''),
(190, 'gateway_paymentexpress_pxpay_pxPostUsername', ''),
(191, 'gateway_paymentexpress_pxpay_testMode', '0'),
(192, 'gateway_paymentexpress_pxpay_currency', 'AUD'),
(193, 'gateway_paymentexpress_pxpay_payment_method', ''),
(194, 'gateway_paymentexpress_pxpost_enabled', '0'),
(195, 'gateway_paymentexpress_pxpost_username', ''),
(196, 'gateway_paymentexpress_pxpost_testMode', '0'),
(197, 'gateway_paymentexpress_pxpost_currency', 'AUD'),
(198, 'gateway_paymentexpress_pxpost_payment_method', ''),
(199, 'gateway_paypal_express_enabled', '0'),
(200, 'gateway_paypal_express_username', ''),
(201, 'gateway_paypal_express_testMode', '0'),
(202, 'gateway_paypal_express_currency', 'AUD'),
(203, 'gateway_paypal_express_payment_method', ''),
(204, 'gateway_paypal_pro_enabled', '0'),
(205, 'gateway_paypal_pro_username', ''),
(206, 'gateway_paypal_pro_signature', ''),
(207, 'gateway_paypal_pro_testMode', '0'),
(208, 'gateway_paypal_pro_currency', 'AUD'),
(209, 'gateway_paypal_pro_payment_method', ''),
(210, 'gateway_pin_enabled', '0'),
(211, 'gateway_pin_testMode', '0'),
(212, 'gateway_pin_currency', 'AUD'),
(213, 'gateway_pin_payment_method', ''),
(214, 'gateway_sagepay_direct_enabled', '0'),
(215, 'gateway_sagepay_direct_vendor', ''),
(216, 'gateway_sagepay_direct_testMode', '0'),
(217, 'gateway_sagepay_direct_referrerId', ''),
(218, 'gateway_sagepay_direct_currency', 'AUD'),
(219, 'gateway_sagepay_direct_payment_method', ''),
(220, 'gateway_sagepay_server_enabled', '0'),
(221, 'gateway_sagepay_server_vendor', ''),
(222, 'gateway_sagepay_server_testMode', '0'),
(223, 'gateway_sagepay_server_referrerId', ''),
(224, 'gateway_sagepay_server_currency', 'AUD'),
(225, 'gateway_sagepay_server_payment_method', ''),
(226, 'gateway_securepay_directpost_enabled', '0'),
(227, 'gateway_securepay_directpost_merchantId', ''),
(228, 'gateway_securepay_directpost_testMode', '0'),
(229, 'gateway_securepay_directpost_currency', 'AUD'),
(230, 'gateway_securepay_directpost_payment_method', ''),
(231, 'gateway_stripe_enabled', '0'),
(232, 'gateway_stripe_currency', 'AUD'),
(233, 'gateway_stripe_payment_method', ''),
(234, 'gateway_targetpay_directebanking_enabled', '0'),
(235, 'gateway_targetpay_directebanking_subAccountId', ''),
(236, 'gateway_targetpay_directebanking_currency', 'AUD'),
(237, 'gateway_targetpay_directebanking_payment_method', ''),
(238, 'gateway_targetpay_ideal_enabled', '0'),
(239, 'gateway_targetpay_ideal_subAccountId', ''),
(240, 'gateway_targetpay_ideal_currency', 'AUD'),
(241, 'gateway_targetpay_ideal_payment_method', ''),
(242, 'gateway_targetpay_mrcash_enabled', '0'),
(243, 'gateway_targetpay_mrcash_subAccountId', ''),
(244, 'gateway_targetpay_mrcash_currency', 'AUD'),
(245, 'gateway_targetpay_mrcash_payment_method', ''),
(246, 'gateway_twocheckout_enabled', '0'),
(247, 'gateway_twocheckout_accountNumber', ''),
(248, 'gateway_twocheckout_testMode', '0'),
(249, 'gateway_twocheckout_currency', 'AUD'),
(250, 'gateway_twocheckout_payment_method', ''),
(251, 'gateway_worldpay_enabled', '0'),
(252, 'gateway_worldpay_installationId', ''),
(253, 'gateway_worldpay_accountId', ''),
(254, 'gateway_worldpay_testMode', '0'),
(255, 'gateway_worldpay_currency', 'AUD'),
(256, 'gateway_worldpay_payment_method', ''),
(257, 'smtp_password', 'Lo6MkH4WuO57W1GH9sKxu0+hsV1gZXvcQR8vo8HxEbz3YHvRxfRCLErx'),
(258, 'enable_permissive_search_clients', '0'),
(259, 'enable_permissive_search_providers', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_tasks`
--

DROP TABLE IF EXISTS `ip_tasks`;
CREATE TABLE `ip_tasks` (
  `task_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `task_name` text,
  `task_description` longtext NOT NULL,
  `task_price` decimal(20,2) DEFAULT NULL,
  `task_finish_date` date NOT NULL,
  `task_status` tinyint(1) NOT NULL,
  `tax_rate_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_tax_rates`
--

DROP TABLE IF EXISTS `ip_tax_rates`;
CREATE TABLE `ip_tax_rates` (
  `tax_rate_id` int(11) NOT NULL,
  `tax_rate_name` text,
  `tax_rate_percent` decimal(5,2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_tax_rates`
--

INSERT INTO `ip_tax_rates` (`tax_rate_id`, `tax_rate_name`, `tax_rate_percent`) VALUES
(1, 'IVA 21%', '21.00'),
(2, 'IVA 10%', '10.00'),
(3, 'IVA 4%', '4.00'),
(4, 'Retencion 19%', '-19.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_units`
--

DROP TABLE IF EXISTS `ip_units`;
CREATE TABLE `ip_units` (
  `unit_id` int(11) NOT NULL,
  `unit_name` varchar(50) DEFAULT NULL,
  `unit_name_plrl` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_units`
--

INSERT INTO `ip_units` (`unit_id`, `unit_name`, `unit_name_plrl`) VALUES
(1, 'mensual', 'mensuales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_uploads`
--

DROP TABLE IF EXISTS `ip_uploads`;
CREATE TABLE `ip_uploads` (
  `upload_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `url_key` char(32) NOT NULL,
  `file_name_original` longtext NOT NULL,
  `file_name_new` longtext NOT NULL,
  `uploaded_date` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_uploads`
--

INSERT INTO `ip_uploads` (`upload_id`, `client_id`, `url_key`, `file_name_original`, `file_name_new`, `uploaded_date`) VALUES
(2, 2, 'TFB2J8Khlm0t1Rcbk3s7MLVWGrwaAPeX', 'descargados.txt', 'TFB2J8Khlm0t1Rcbk3s7MLVWGrwaAPeX_descargados.txt', '2022-10-14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_uploads_provider`
--

DROP TABLE IF EXISTS `ip_uploads_provider`;
CREATE TABLE `ip_uploads_provider` (
  `upload_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `url_key` char(32) NOT NULL,
  `file_name_original` longtext NOT NULL,
  `file_name_new` longtext NOT NULL,
  `uploaded_date` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_users`
--

DROP TABLE IF EXISTS `ip_users`;
CREATE TABLE `ip_users` (
  `user_id` int(11) NOT NULL,
  `user_type` int(1) NOT NULL DEFAULT '0',
  `user_active` tinyint(1) DEFAULT '1',
  `user_date_created` datetime NOT NULL,
  `user_date_modified` datetime NOT NULL,
  `user_language` varchar(255) DEFAULT 'system',
  `user_name` text,
  `user_company` text,
  `user_address_1` text,
  `user_address_2` text,
  `user_city` text,
  `user_state` text,
  `user_zip` text,
  `user_country` text,
  `user_phone` text,
  `user_fax` text,
  `user_mobile` text,
  `user_email` text,
  `user_password` varchar(60) NOT NULL,
  `user_web` text,
  `user_vat_id` text,
  `user_tax_code` text,
  `user_psalt` text,
  `user_all_clients` int(1) NOT NULL DEFAULT '0',
  `user_passwordreset_token` varchar(100) DEFAULT '',
  `user_subscribernumber` varchar(40) DEFAULT NULL,
  `user_iban` varchar(34) DEFAULT NULL,
  `user_gln` bigint(13) DEFAULT NULL,
  `user_rcc` varchar(7) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_users`
--

INSERT INTO `ip_users` (`user_id`, `user_type`, `user_active`, `user_date_created`, `user_date_modified`, `user_language`, `user_name`, `user_company`, `user_address_1`, `user_address_2`, `user_city`, `user_state`, `user_zip`, `user_country`, `user_phone`, `user_fax`, `user_mobile`, `user_email`, `user_password`, `user_web`, `user_vat_id`, `user_tax_code`, `user_psalt`, `user_all_clients`, `user_passwordreset_token`, `user_subscribernumber`, `user_iban`, `user_gln`, `user_rcc`) VALUES
(1, 1, 1, '2022-10-10 12:58:17', '2022-10-10 12:58:17', 'system', 'mtoffice', NULL, 'Rúa Uruguay', '', '', '', '', 'ES', '', '', '', 'estefania@teconsite.com', '$2a$10$084c42e9145dcd69406a6usBo/HNceGXEUWvft1ODpJmkqg.hqjqW', '', NULL, NULL, '084c42e9145dcd69406a66', 0, '', NULL, NULL, NULL, NULL),
(2, 1, 1, '2022-10-10 11:11:33', '2022-10-10 11:11:33', 'system', 'pablo', 'teconsite', '', '', '', '', '', '', '', '', '', 'pablob@teconsite.com', '$2a$10$01bb074d1874a04c8a972OSoLjtDkb7Vr5Rwkp7rx4LQ8SnEQ1fT2', '', '', '', '01bb074d1874a04c8a972a', 0, '', '', '', NULL, NULL),
(3, 1, 1, '2022-10-10 11:13:21', '2022-10-10 11:13:21', 'system', 'tamara', 'teconsite.com', '', '', '', '', '', '', '', '', '', 'tamara@teconsite.com', '$2a$10$3f5aa0c2a459b8e4c5185O0Zh.xe0EPNnX5eqjEVp9iNATxczNCaS', '', '', '', '3f5aa0c2a459b8e4c5185d', 0, '', '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_user_clients`
--

DROP TABLE IF EXISTS `ip_user_clients`;
CREATE TABLE `ip_user_clients` (
  `user_client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_user_custom`
--

DROP TABLE IF EXISTS `ip_user_custom`;
CREATE TABLE `ip_user_custom` (
  `user_custom_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_custom_fieldid` int(11) NOT NULL,
  `user_custom_fieldvalue` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_user_providers`
--

DROP TABLE IF EXISTS `ip_user_providers`;
CREATE TABLE `ip_user_providers` (
  `user_provider_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_versions`
--

DROP TABLE IF EXISTS `ip_versions`;
CREATE TABLE `ip_versions` (
  `version_id` int(11) NOT NULL,
  `version_date_applied` varchar(14) NOT NULL,
  `version_file` varchar(45) NOT NULL,
  `version_sql_errors` int(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ip_versions`
--

INSERT INTO `ip_versions` (`version_id`, `version_date_applied`, `version_file`, `version_sql_errors`) VALUES
(1, '1665399456', '000_1.0.0.sql', 0),
(2, '1665399457', '001_1.0.1.sql', 0),
(3, '1665399457', '002_1.0.2.sql', 0),
(4, '1665399457', '003_1.1.0.sql', 0),
(5, '1665399457', '004_1.1.1.sql', 0),
(6, '1665399457', '005_1.1.2.sql', 0),
(7, '1665399457', '006_1.2.0.sql', 0),
(8, '1665399457', '007_1.2.1.sql', 0),
(9, '1665399458', '008_1.3.0.sql', 0),
(10, '1665399458', '009_1.3.1.sql', 0),
(11, '1665399458', '010_1.3.2.sql', 0),
(12, '1665399458', '011_1.3.3.sql', 0),
(13, '1665399458', '012_1.4.0.sql', 0),
(14, '1665399458', '013_1.4.1.sql', 0),
(15, '1665399458', '014_1.4.2.sql', 0),
(16, '1665399458', '015_1.4.3.sql', 0),
(17, '1665399458', '016_1.4.4.sql', 0),
(18, '1665399458', '017_1.4.5.sql', 0),
(19, '1665399458', '018_1.4.6.sql', 0),
(20, '1665399459', '019_1.4.7.sql', 0),
(21, '1665399459', '020_1.4.8.sql', 0),
(22, '1665399459', '021_1.4.9.sql', 0),
(23, '1665399459', '022_1.4.10.sql', 0),
(24, '1665399460', '023_1.5.0.sql', 0),
(25, '1665399460', '024_1.5.1.sql', 0),
(26, '1665399460', '025_1.5.2.sql', 0),
(27, '1665399460', '026_1.5.3.sql', 0),
(28, '1665399460', '027_1.5.4.sql', 0),
(29, '1665399460', '028_1.5.5.sql', 0),
(30, '1665399460', '029_1.5.6.sql', 0),
(31, '1665399460', '030_1.5.7.sql', 0),
(32, '1665399460', '031_1.5.8.sql', 0),
(33, '1665399460', '032_1.5.9.sql', 0),
(34, '1665399460', '033_1.5.10.sql', 0),
(35, '1665399460', '034_1.5.11.sql', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ip_clients`
--
ALTER TABLE `ip_clients`
  ADD PRIMARY KEY (`client_id`),
  ADD KEY `client_active` (`client_active`);

--
-- Indices de la tabla `ip_client_custom`
--
ALTER TABLE `ip_client_custom`
  ADD PRIMARY KEY (`client_custom_id`),
  ADD UNIQUE KEY `client_id` (`client_id`,`client_custom_fieldid`);

--
-- Indices de la tabla `ip_client_notes`
--
ALTER TABLE `ip_client_notes`
  ADD PRIMARY KEY (`client_note_id`),
  ADD KEY `client_id` (`client_id`,`client_note_date`);

--
-- Indices de la tabla `ip_custom_fields`
--
ALTER TABLE `ip_custom_fields`
  ADD PRIMARY KEY (`custom_field_id`),
  ADD UNIQUE KEY `custom_field_table_2` (`custom_field_table`,`custom_field_label`),
  ADD KEY `custom_field_table` (`custom_field_table`);

--
-- Indices de la tabla `ip_custom_values`
--
ALTER TABLE `ip_custom_values`
  ADD PRIMARY KEY (`custom_values_id`);

--
-- Indices de la tabla `ip_email_templates`
--
ALTER TABLE `ip_email_templates`
  ADD PRIMARY KEY (`email_template_id`);

--
-- Indices de la tabla `ip_families`
--
ALTER TABLE `ip_families`
  ADD PRIMARY KEY (`family_id`);

--
-- Indices de la tabla `ip_imports`
--
ALTER TABLE `ip_imports`
  ADD PRIMARY KEY (`import_id`);

--
-- Indices de la tabla `ip_import_details`
--
ALTER TABLE `ip_import_details`
  ADD PRIMARY KEY (`import_detail_id`),
  ADD KEY `import_id` (`import_id`,`import_record_id`);

--
-- Indices de la tabla `ip_invoices`
--
ALTER TABLE `ip_invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD UNIQUE KEY `invoice_url_key` (`invoice_url_key`),
  ADD KEY `user_id` (`user_id`,`client_id`,`invoice_group_id`,`invoice_date_created`,`invoice_date_due`,`invoice_number`),
  ADD KEY `invoice_status_id` (`invoice_status_id`);

--
-- Indices de la tabla `ip_invoices_provider`
--
ALTER TABLE `ip_invoices_provider`
  ADD PRIMARY KEY (`invoice_provider_id`),
  ADD UNIQUE KEY `invoice_provider_url_key` (`invoice_provider_url_key`),
  ADD KEY `user_id` (`user_id`,`provider_id`,`invoice_provider_date_created`,`invoice_provider_date_due`,`invoice_provider_number`),
  ADD KEY `invoice_provider_status_id` (`invoice_provider_status_id`);

--
-- Indices de la tabla `ip_invoices_recurring`
--
ALTER TABLE `ip_invoices_recurring`
  ADD PRIMARY KEY (`invoice_recurring_id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indices de la tabla `ip_invoice_amounts`
--
ALTER TABLE `ip_invoice_amounts`
  ADD PRIMARY KEY (`invoice_amount_id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `invoice_paid` (`invoice_paid`,`invoice_balance`);

--
-- Indices de la tabla `ip_invoice_custom`
--
ALTER TABLE `ip_invoice_custom`
  ADD PRIMARY KEY (`invoice_custom_id`),
  ADD UNIQUE KEY `invoice_id` (`invoice_id`,`invoice_custom_fieldid`);

--
-- Indices de la tabla `ip_invoice_groups`
--
ALTER TABLE `ip_invoice_groups`
  ADD PRIMARY KEY (`invoice_group_id`),
  ADD KEY `invoice_group_next_id` (`invoice_group_next_id`),
  ADD KEY `invoice_group_left_pad` (`invoice_group_left_pad`);

--
-- Indices de la tabla `ip_invoice_items`
--
ALTER TABLE `ip_invoice_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `invoice_id` (`invoice_id`,`item_tax_rate_id`,`item_date_added`,`item_order`);

--
-- Indices de la tabla `ip_invoice_item_amounts`
--
ALTER TABLE `ip_invoice_item_amounts`
  ADD PRIMARY KEY (`item_amount_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indices de la tabla `ip_invoice_provider_amounts`
--
ALTER TABLE `ip_invoice_provider_amounts`
  ADD PRIMARY KEY (`invoice_provider_amount_id`),
  ADD KEY `invoice_provider_id` (`invoice_provider_id`),
  ADD KEY `invoice_provider_paid` (`invoice_provider_paid`,`invoice_provider_balance`);

--
-- Indices de la tabla `ip_invoice_provider_custom`
--
ALTER TABLE `ip_invoice_provider_custom`
  ADD PRIMARY KEY (`invoice_provider_custom_id`),
  ADD KEY `invoice_provider_id` (`invoice_provider_id`);

--
-- Indices de la tabla `ip_invoice_provider_items`
--
ALTER TABLE `ip_invoice_provider_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `invoice_provider_id` (`invoice_provider_id`,`item_tax_rate_id`,`item_date_added`,`item_order`);

--
-- Indices de la tabla `ip_invoice_provider_item_amounts`
--
ALTER TABLE `ip_invoice_provider_item_amounts`
  ADD PRIMARY KEY (`item_amount_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indices de la tabla `ip_invoice_provider_tax_rates`
--
ALTER TABLE `ip_invoice_provider_tax_rates`
  ADD PRIMARY KEY (`invoice_provider_tax_rate_id`),
  ADD KEY `invoice_provider_id` (`invoice_provider_id`,`tax_rate_id`);

--
-- Indices de la tabla `ip_invoice_sumex`
--
ALTER TABLE `ip_invoice_sumex`
  ADD PRIMARY KEY (`sumex_id`);

--
-- Indices de la tabla `ip_invoice_tax_rates`
--
ALTER TABLE `ip_invoice_tax_rates`
  ADD PRIMARY KEY (`invoice_tax_rate_id`),
  ADD KEY `invoice_id` (`invoice_id`,`tax_rate_id`);

--
-- Indices de la tabla `ip_item_lookups`
--
ALTER TABLE `ip_item_lookups`
  ADD PRIMARY KEY (`item_lookup_id`);

--
-- Indices de la tabla `ip_merchant_responses`
--
ALTER TABLE `ip_merchant_responses`
  ADD PRIMARY KEY (`merchant_response_id`),
  ADD KEY `merchant_response_date` (`merchant_response_date`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indices de la tabla `ip_payments`
--
ALTER TABLE `ip_payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `payment_method_id` (`payment_method_id`),
  ADD KEY `payment_amount` (`payment_amount`);

--
-- Indices de la tabla `ip_payments_provider`
--
ALTER TABLE `ip_payments_provider`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `payment_method_id` (`payment_method_id`),
  ADD KEY `payment_amount` (`payment_amount`);

--
-- Indices de la tabla `ip_payment_custom`
--
ALTER TABLE `ip_payment_custom`
  ADD PRIMARY KEY (`payment_custom_id`),
  ADD UNIQUE KEY `payment_id` (`payment_id`,`payment_custom_fieldid`);

--
-- Indices de la tabla `ip_payment_methods`
--
ALTER TABLE `ip_payment_methods`
  ADD PRIMARY KEY (`payment_method_id`);

--
-- Indices de la tabla `ip_products`
--
ALTER TABLE `ip_products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indices de la tabla `ip_projects`
--
ALTER TABLE `ip_projects`
  ADD PRIMARY KEY (`project_id`);

--
-- Indices de la tabla `ip_providers`
--
ALTER TABLE `ip_providers`
  ADD PRIMARY KEY (`provider_id`),
  ADD KEY `provider_active` (`provider_active`);

--
-- Indices de la tabla `ip_provider_custom`
--
ALTER TABLE `ip_provider_custom`
  ADD PRIMARY KEY (`provider_custom_id`),
  ADD UNIQUE KEY `provider_id` (`provider_id`,`provider_custom_fieldid`);

--
-- Indices de la tabla `ip_provider_notes`
--
ALTER TABLE `ip_provider_notes`
  ADD PRIMARY KEY (`provider_note_id`),
  ADD KEY `provider_id` (`provider_id`,`provider_note_date`);

--
-- Indices de la tabla `ip_quotes`
--
ALTER TABLE `ip_quotes`
  ADD PRIMARY KEY (`quote_id`),
  ADD KEY `user_id` (`user_id`,`client_id`,`invoice_group_id`,`quote_date_created`,`quote_date_expires`,`quote_number`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `quote_status_id` (`quote_status_id`);

--
-- Indices de la tabla `ip_quote_amounts`
--
ALTER TABLE `ip_quote_amounts`
  ADD PRIMARY KEY (`quote_amount_id`),
  ADD KEY `quote_id` (`quote_id`);

--
-- Indices de la tabla `ip_quote_custom`
--
ALTER TABLE `ip_quote_custom`
  ADD PRIMARY KEY (`quote_custom_id`),
  ADD UNIQUE KEY `quote_id` (`quote_id`,`quote_custom_fieldid`);

--
-- Indices de la tabla `ip_quote_items`
--
ALTER TABLE `ip_quote_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `quote_id` (`quote_id`,`item_date_added`,`item_order`),
  ADD KEY `item_tax_rate_id` (`item_tax_rate_id`);

--
-- Indices de la tabla `ip_quote_item_amounts`
--
ALTER TABLE `ip_quote_item_amounts`
  ADD PRIMARY KEY (`item_amount_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indices de la tabla `ip_quote_tax_rates`
--
ALTER TABLE `ip_quote_tax_rates`
  ADD PRIMARY KEY (`quote_tax_rate_id`),
  ADD KEY `quote_id` (`quote_id`),
  ADD KEY `tax_rate_id` (`tax_rate_id`);

--
-- Indices de la tabla `ip_sessions`
--
ALTER TABLE `ip_sessions`
  ADD KEY `ip_sessions_timestamp` (`timestamp`);

--
-- Indices de la tabla `ip_settings`
--
ALTER TABLE `ip_settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD KEY `setting_key` (`setting_key`);

--
-- Indices de la tabla `ip_tasks`
--
ALTER TABLE `ip_tasks`
  ADD PRIMARY KEY (`task_id`);

--
-- Indices de la tabla `ip_tax_rates`
--
ALTER TABLE `ip_tax_rates`
  ADD PRIMARY KEY (`tax_rate_id`);

--
-- Indices de la tabla `ip_units`
--
ALTER TABLE `ip_units`
  ADD PRIMARY KEY (`unit_id`);

--
-- Indices de la tabla `ip_uploads`
--
ALTER TABLE `ip_uploads`
  ADD PRIMARY KEY (`upload_id`);

--
-- Indices de la tabla `ip_uploads_provider`
--
ALTER TABLE `ip_uploads_provider`
  ADD PRIMARY KEY (`upload_id`);

--
-- Indices de la tabla `ip_users`
--
ALTER TABLE `ip_users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indices de la tabla `ip_user_clients`
--
ALTER TABLE `ip_user_clients`
  ADD PRIMARY KEY (`user_client_id`),
  ADD KEY `user_id` (`user_id`,`client_id`);

--
-- Indices de la tabla `ip_user_custom`
--
ALTER TABLE `ip_user_custom`
  ADD PRIMARY KEY (`user_custom_id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`user_custom_fieldid`);

--
-- Indices de la tabla `ip_user_providers`
--
ALTER TABLE `ip_user_providers`
  ADD PRIMARY KEY (`user_provider_id`),
  ADD KEY `user_id` (`user_id`,`provider_id`);

--
-- Indices de la tabla `ip_versions`
--
ALTER TABLE `ip_versions`
  ADD PRIMARY KEY (`version_id`),
  ADD KEY `version_date_applied` (`version_date_applied`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ip_clients`
--
ALTER TABLE `ip_clients`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `ip_client_custom`
--
ALTER TABLE `ip_client_custom`
  MODIFY `client_custom_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `ip_client_notes`
--
ALTER TABLE `ip_client_notes`
  MODIFY `client_note_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_custom_fields`
--
ALTER TABLE `ip_custom_fields`
  MODIFY `custom_field_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `ip_custom_values`
--
ALTER TABLE `ip_custom_values`
  MODIFY `custom_values_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_email_templates`
--
ALTER TABLE `ip_email_templates`
  MODIFY `email_template_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_families`
--
ALTER TABLE `ip_families`
  MODIFY `family_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `ip_imports`
--
ALTER TABLE `ip_imports`
  MODIFY `import_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_import_details`
--
ALTER TABLE `ip_import_details`
  MODIFY `import_detail_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_invoices`
--
ALTER TABLE `ip_invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT de la tabla `ip_invoices_provider`
--
ALTER TABLE `ip_invoices_provider`
  MODIFY `invoice_provider_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `ip_invoices_recurring`
--
ALTER TABLE `ip_invoices_recurring`
  MODIFY `invoice_recurring_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_amounts`
--
ALTER TABLE `ip_invoice_amounts`
  MODIFY `invoice_amount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_custom`
--
ALTER TABLE `ip_invoice_custom`
  MODIFY `invoice_custom_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_groups`
--
ALTER TABLE `ip_invoice_groups`
  MODIFY `invoice_group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_items`
--
ALTER TABLE `ip_invoice_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_item_amounts`
--
ALTER TABLE `ip_invoice_item_amounts`
  MODIFY `item_amount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_provider_amounts`
--
ALTER TABLE `ip_invoice_provider_amounts`
  MODIFY `invoice_provider_amount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_provider_custom`
--
ALTER TABLE `ip_invoice_provider_custom`
  MODIFY `invoice_provider_custom_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_provider_items`
--
ALTER TABLE `ip_invoice_provider_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_provider_item_amounts`
--
ALTER TABLE `ip_invoice_provider_item_amounts`
  MODIFY `item_amount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_provider_tax_rates`
--
ALTER TABLE `ip_invoice_provider_tax_rates`
  MODIFY `invoice_provider_tax_rate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_sumex`
--
ALTER TABLE `ip_invoice_sumex`
  MODIFY `sumex_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_invoice_tax_rates`
--
ALTER TABLE `ip_invoice_tax_rates`
  MODIFY `invoice_tax_rate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `ip_item_lookups`
--
ALTER TABLE `ip_item_lookups`
  MODIFY `item_lookup_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_merchant_responses`
--
ALTER TABLE `ip_merchant_responses`
  MODIFY `merchant_response_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_payments`
--
ALTER TABLE `ip_payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `ip_payments_provider`
--
ALTER TABLE `ip_payments_provider`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de la tabla `ip_payment_custom`
--
ALTER TABLE `ip_payment_custom`
  MODIFY `payment_custom_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_payment_methods`
--
ALTER TABLE `ip_payment_methods`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `ip_products`
--
ALTER TABLE `ip_products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `ip_projects`
--
ALTER TABLE `ip_projects`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_providers`
--
ALTER TABLE `ip_providers`
  MODIFY `provider_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `ip_provider_custom`
--
ALTER TABLE `ip_provider_custom`
  MODIFY `provider_custom_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_provider_notes`
--
ALTER TABLE `ip_provider_notes`
  MODIFY `provider_note_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `ip_quotes`
--
ALTER TABLE `ip_quotes`
  MODIFY `quote_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `ip_quote_amounts`
--
ALTER TABLE `ip_quote_amounts`
  MODIFY `quote_amount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `ip_quote_custom`
--
ALTER TABLE `ip_quote_custom`
  MODIFY `quote_custom_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_quote_items`
--
ALTER TABLE `ip_quote_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `ip_quote_item_amounts`
--
ALTER TABLE `ip_quote_item_amounts`
  MODIFY `item_amount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `ip_quote_tax_rates`
--
ALTER TABLE `ip_quote_tax_rates`
  MODIFY `quote_tax_rate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `ip_settings`
--
ALTER TABLE `ip_settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=260;
--
-- AUTO_INCREMENT de la tabla `ip_tasks`
--
ALTER TABLE `ip_tasks`
  MODIFY `task_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_tax_rates`
--
ALTER TABLE `ip_tax_rates`
  MODIFY `tax_rate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `ip_units`
--
ALTER TABLE `ip_units`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `ip_uploads`
--
ALTER TABLE `ip_uploads`
  MODIFY `upload_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `ip_uploads_provider`
--
ALTER TABLE `ip_uploads_provider`
  MODIFY `upload_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `ip_users`
--
ALTER TABLE `ip_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `ip_user_clients`
--
ALTER TABLE `ip_user_clients`
  MODIFY `user_client_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_user_custom`
--
ALTER TABLE `ip_user_custom`
  MODIFY `user_custom_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_user_providers`
--
ALTER TABLE `ip_user_providers`
  MODIFY `user_provider_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ip_versions`
--
ALTER TABLE `ip_versions`
  MODIFY `version_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
