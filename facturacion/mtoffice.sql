-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 11-10-2022 a las 15:42:41
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

--
-- Truncar tablas antes de insertar `ip_clients`
--

TRUNCATE TABLE `ip_clients`;
--
-- Volcado de datos para la tabla `ip_clients`
--

INSERT INTO `ip_clients` (`client_id`, `client_date_created`, `client_date_modified`, `client_name`, `client_address_1`, `client_address_2`, `client_city`, `client_state`, `client_zip`, `client_country`, `client_phone`, `client_fax`, `client_mobile`, `client_email`, `client_web`, `client_vat_id`, `client_tax_code`, `client_language`, `client_active`, `client_surname`, `client_avs`, `client_insurednumber`, `client_veka`, `client_birthdate`, `client_gender`) VALUES
(1, '2022-10-10 11:49:15', '2022-10-10 15:26:03', 'Carlin', 'Plaza independencia', '', 'Vigo', 'Galicia', '36234', 'ES', '986543210', '', '657456124', 'carlinmtoffice@gmail.com', 'carlin.com', '8756354A', '', 'system', 1, '', NULL, NULL, NULL, '2019-11-20', 2),
(2, '2022-10-10 11:54:48', '2022-10-10 11:54:48', 'garajesvigo', 'plaza américa 3', '', 'Vigo', 'Galicia', '36211', 'ES', '986546398', '', '687238456', 'garajesvigo@gmail.com', 'garajesvigo.es', '97645676W', '', 'system', 1, '', NULL, NULL, NULL, '2019-07-23', 2),
(8, '2022-10-11 14:31:58', '2022-10-11 14:31:58', 'asdsadas', 'kkjlkjlkjl', 'lkjlkjlkjlkjlk', 'lkjlkjlkj', 'lkjlkjlkj', '123123', 'AL', '123123123', '123123123', '123123123', 'assadsa@gmail.com', 'sdsadsadsa.com', 'asdsadsada', 'sadsadsadsa', 'Albanian', 1, 'ljlkjl', NULL, NULL, NULL, '2022-10-12', 0);

--
-- Truncar tablas antes de insertar `ip_client_custom`
--

TRUNCATE TABLE `ip_client_custom`;
--
-- Volcado de datos para la tabla `ip_client_custom`
--

INSERT INTO `ip_client_custom` (`client_custom_id`, `client_id`, `client_custom_fieldid`, `client_custom_fieldvalue`) VALUES
(1, 1, 1, 'http://facebook.com/lalalala'),
(7, 8, 1, 'facebook');

--
-- Truncar tablas antes de insertar `ip_client_notes`
--

TRUNCATE TABLE `ip_client_notes`;
--
-- Truncar tablas antes de insertar `ip_custom_fields`
--

TRUNCATE TABLE `ip_custom_fields`;
--
-- Volcado de datos para la tabla `ip_custom_fields`
--

INSERT INTO `ip_custom_fields` (`custom_field_id`, `custom_field_table`, `custom_field_label`, `custom_field_type`, `custom_field_location`, `custom_field_order`) VALUES
(1, 'ip_client_custom', 'Facebook', 'TEXT', 0, 1);

--
-- Truncar tablas antes de insertar `ip_custom_values`
--

TRUNCATE TABLE `ip_custom_values`;
--
-- Truncar tablas antes de insertar `ip_email_templates`
--

TRUNCATE TABLE `ip_email_templates`;
--
-- Truncar tablas antes de insertar `ip_families`
--

TRUNCATE TABLE `ip_families`;
--
-- Volcado de datos para la tabla `ip_families`
--

INSERT INTO `ip_families` (`family_id`, `family_name`) VALUES
(1, 'Boligrafos'),
(2, 'Papel'),
(3, 'Inmuebles');

--
-- Truncar tablas antes de insertar `ip_imports`
--

TRUNCATE TABLE `ip_imports`;
--
-- Truncar tablas antes de insertar `ip_import_details`
--

TRUNCATE TABLE `ip_import_details`;
--
-- Truncar tablas antes de insertar `ip_invoices`
--

TRUNCATE TABLE `ip_invoices`;
--
-- Volcado de datos para la tabla `ip_invoices`
--

INSERT INTO `ip_invoices` (`invoice_id`, `user_id`, `client_id`, `invoice_group_id`, `invoice_status_id`, `is_read_only`, `invoice_password`, `invoice_date_created`, `invoice_time_created`, `invoice_date_modified`, `invoice_date_due`, `invoice_number`, `invoice_discount_amount`, `invoice_discount_percent`, `invoice_terms`, `invoice_url_key`, `payment_method`, `creditinvoice_parent_id`) VALUES
(1, 3, 1, 3, 4, 1, '', '2022-10-05', '12:45:51', '2022-10-10 12:46:42', '2022-11-04', '1', '0.00', '0.00', '', '3Lkt7NHqEu4cf2rwGjFpdhzJbV01Yx5W', 2, NULL),
(2, 3, 2, 3, 2, NULL, '', '2022-10-10', '13:03:45', '2022-10-10 15:37:22', '2022-11-09', '2', '0.00', '0.00', '', 'nQly8M5JmOtwYDHNkBc1ah6Ks74TCrfu', 2, NULL),
(3, 3, 2, 3, 1, NULL, '', '2022-08-24', '13:11:33', '2022-10-10 15:37:32', '2022-09-23', '3', '0.00', '0.00', '', 'RAxo9jQP2S5tcdrO3hw1u7ILbCeZamp8', 2, NULL),
(4, 3, 2, 3, 1, NULL, '', '2022-09-24', '13:11:59', '2022-10-10 15:37:45', '2022-10-24', '4', '0.00', '0.00', '', 'bu4Nf23cK5GtAgrxHdzQ81YLP6V9pUOa', 2, NULL),
(5, 3, 2, 3, 1, NULL, '', '2022-10-24', '13:12:26', '2022-10-10 15:41:27', '2022-11-23', '5', '0.00', '0.00', '', 'o4gGd2KXZIbaCvOqJRYM9zLQhf7jes3W', 2, NULL);

--
-- Truncar tablas antes de insertar `ip_invoices_provider`
--

TRUNCATE TABLE `ip_invoices_provider`;
--
-- Truncar tablas antes de insertar `ip_invoices_recurring`
--

TRUNCATE TABLE `ip_invoices_recurring`;
--
-- Truncar tablas antes de insertar `ip_invoice_amounts`
--

TRUNCATE TABLE `ip_invoice_amounts`;
--
-- Volcado de datos para la tabla `ip_invoice_amounts`
--

INSERT INTO `ip_invoice_amounts` (`invoice_amount_id`, `invoice_id`, `invoice_sign`, `invoice_item_subtotal`, `invoice_item_tax_total`, `invoice_tax_total`, `invoice_total`, `invoice_paid`, `invoice_balance`) VALUES
(1, 1, '1', '5.00', '1.05', '-1.15', '4.90', '4.90', '0.00'),
(2, 2, '1', '50.00', '10.50', '-11.50', '49.00', '0.00', '49.00'),
(3, 3, '1', '50.00', '10.50', '-11.50', '49.00', '0.00', '49.00'),
(4, 4, '1', '50.00', '10.50', '-11.50', '49.00', '0.00', '49.00'),
(5, 5, '1', '50.00', '0.00', '1.00', '51.00', '0.00', '51.00');

--
-- Truncar tablas antes de insertar `ip_invoice_custom`
--

TRUNCATE TABLE `ip_invoice_custom`;
--
-- Truncar tablas antes de insertar `ip_invoice_groups`
--

TRUNCATE TABLE `ip_invoice_groups`;
--
-- Volcado de datos para la tabla `ip_invoice_groups`
--

INSERT INTO `ip_invoice_groups` (`invoice_group_id`, `invoice_group_name`, `invoice_group_identifier_format`, `invoice_group_next_id`, `invoice_group_left_pad`) VALUES
(3, 'Invoice Default', '{{{id}}}', 6, 0),
(4, 'Quote Default', 'QUO{{{id}}}', 3, 0);

--
-- Truncar tablas antes de insertar `ip_invoice_items`
--

TRUNCATE TABLE `ip_invoice_items`;
--
-- Volcado de datos para la tabla `ip_invoice_items`
--

INSERT INTO `ip_invoice_items` (`item_id`, `invoice_id`, `item_tax_rate_id`, `item_product_id`, `item_date_added`, `item_task_id`, `item_name`, `item_description`, `item_quantity`, `item_price`, `item_discount_amount`, `item_order`, `item_is_recurring`, `item_product_unit`, `item_product_unit_id`, `item_date`) VALUES
(1, 1, 1, NULL, '2022-10-10', NULL, 'boligrafos', '', '2.00', '2.00', NULL, 1, NULL, NULL, NULL, NULL),
(2, 1, 1, NULL, '2022-10-10', NULL, 'papel', '', '1.00', '1.00', NULL, 2, NULL, NULL, NULL, NULL),
(3, 2, 1, 3, '2022-10-10', NULL, 'Garaje', 'Plaza garaje 20m2', '1.00', '50.00', NULL, 1, 0, 'mensual', 1, NULL),
(4, 3, 1, 3, '2022-10-10', NULL, 'Garaje', 'Plaza garaje 20m2', '1.00', '50.00', NULL, 1, 0, 'mensual', 1, NULL),
(5, 4, 1, 3, '2022-10-10', NULL, 'Garaje', 'Plaza garaje 20m2', '1.00', '50.00', NULL, 1, 0, 'mensual', 1, NULL),
(6, 5, 0, 3, '2022-10-10', NULL, 'Garaje', 'Plaza garaje 20m2', '1.00', '50.00', NULL, 1, 0, 'mensual', 1, NULL);

--
-- Truncar tablas antes de insertar `ip_invoice_item_amounts`
--

TRUNCATE TABLE `ip_invoice_item_amounts`;
--
-- Volcado de datos para la tabla `ip_invoice_item_amounts`
--

INSERT INTO `ip_invoice_item_amounts` (`item_amount_id`, `item_id`, `item_subtotal`, `item_tax_total`, `item_discount`, `item_total`) VALUES
(1, 1, '4.00', '0.84', '0.00', '4.84'),
(2, 2, '1.00', '0.21', '0.00', '1.21'),
(3, 3, '50.00', '10.50', '0.00', '60.50'),
(4, 4, '50.00', '10.50', '0.00', '60.50'),
(5, 5, '50.00', '10.50', '0.00', '60.50'),
(6, 6, '50.00', '0.00', '0.00', '50.00');

--
-- Truncar tablas antes de insertar `ip_invoice_provider_amounts`
--

TRUNCATE TABLE `ip_invoice_provider_amounts`;
--
-- Truncar tablas antes de insertar `ip_invoice_provider_custom`
--

TRUNCATE TABLE `ip_invoice_provider_custom`;
--
-- Truncar tablas antes de insertar `ip_invoice_provider_items`
--

TRUNCATE TABLE `ip_invoice_provider_items`;
--
-- Truncar tablas antes de insertar `ip_invoice_provider_item_amounts`
--

TRUNCATE TABLE `ip_invoice_provider_item_amounts`;
--
-- Truncar tablas antes de insertar `ip_invoice_provider_tax_rates`
--

TRUNCATE TABLE `ip_invoice_provider_tax_rates`;
--
-- Truncar tablas antes de insertar `ip_invoice_sumex`
--

TRUNCATE TABLE `ip_invoice_sumex`;
--
-- Truncar tablas antes de insertar `ip_invoice_tax_rates`
--

TRUNCATE TABLE `ip_invoice_tax_rates`;
--
-- Volcado de datos para la tabla `ip_invoice_tax_rates`
--

INSERT INTO `ip_invoice_tax_rates` (`invoice_tax_rate_id`, `invoice_id`, `tax_rate_id`, `include_item_tax`, `invoice_tax_rate_amount`) VALUES
(1, 1, 4, 1, '-1.15'),
(2, 2, 4, 1, '-11.50'),
(3, 3, 4, 1, '-11.50'),
(4, 4, 4, 1, '-11.50'),
(5, 5, 4, 1, '-9.50'),
(6, 5, 1, 0, '10.50');

--
-- Truncar tablas antes de insertar `ip_item_lookups`
--

TRUNCATE TABLE `ip_item_lookups`;
--
-- Truncar tablas antes de insertar `ip_merchant_responses`
--

TRUNCATE TABLE `ip_merchant_responses`;
--
-- Truncar tablas antes de insertar `ip_payments`
--

TRUNCATE TABLE `ip_payments`;
--
-- Volcado de datos para la tabla `ip_payments`
--

INSERT INTO `ip_payments` (`payment_id`, `invoice_id`, `payment_method_id`, `payment_date`, `payment_amount`, `payment_note`) VALUES
(1, 1, 2, '2022-10-10', '4.90', ''),
(2, 1, 2, '2022-10-10', '0.00', '');

--
-- Truncar tablas antes de insertar `ip_payments_provider`
--

TRUNCATE TABLE `ip_payments_provider`;
--
-- Truncar tablas antes de insertar `ip_payment_custom`
--

TRUNCATE TABLE `ip_payment_custom`;
--
-- Truncar tablas antes de insertar `ip_payment_methods`
--

TRUNCATE TABLE `ip_payment_methods`;
--
-- Volcado de datos para la tabla `ip_payment_methods`
--

INSERT INTO `ip_payment_methods` (`payment_method_id`, `payment_method_name`) VALUES
(1, 'Cash'),
(2, 'Credit Card');

--
-- Truncar tablas antes de insertar `ip_products`
--

TRUNCATE TABLE `ip_products`;
--
-- Volcado de datos para la tabla `ip_products`
--

INSERT INTO `ip_products` (`product_id`, `family_id`, `product_sku`, `product_name`, `product_description`, `product_price`, `purchase_price`, `provider_name`, `tax_rate_id`, `unit_id`, `product_tariff`) VALUES
(1, 1, '24324324324', 'boligrafo BIC', 'Un boligrafo, el titulo es muy claro, no?', '2.00', NULL, '', 1, NULL, 0),
(2, 2, '5432654643', '100 folios DIN-A4', 'Paquete de folios de 100', '1.00', NULL, '', 1, NULL, 0),
(3, 3, '4324232432', 'Garaje', 'Plaza garaje 20m2', '50.00', NULL, '', 1, 1, 0);

--
-- Truncar tablas antes de insertar `ip_projects`
--

TRUNCATE TABLE `ip_projects`;
--
-- Truncar tablas antes de insertar `ip_providers`
--

TRUNCATE TABLE `ip_providers`;
--
-- Volcado de datos para la tabla `ip_providers`
--

INSERT INTO `ip_providers` (`provider_id`, `provider_date_created`, `provider_date_modified`, `provider_name`, `provider_comercial_name`, `provider_address_1`, `provider_address_2`, `provider_city`, `provider_state`, `provider_zip`, `provider_country`, `provider_phone`, `provider_mobile`, `provider_email`, `provider_web`, `provider_vat_id`, `provider_language`, `provider_active`) VALUES
(9, '2022-10-11 15:41:37', '2022-10-11 15:41:37', 'sffsdf', NULL, 'sadsadsda', 'sadsadadsa', 'asdsad', 'adsadsa', '123123', 'DE', '4323243', '131231323', 'sdsadsa@gmail.com', 'sadsasad.com', '12321313', 'Arabic', 1);

--
-- Truncar tablas antes de insertar `ip_provider_custom`
--

TRUNCATE TABLE `ip_provider_custom`;
--
-- Truncar tablas antes de insertar `ip_provider_notes`
--

TRUNCATE TABLE `ip_provider_notes`;
--
-- Truncar tablas antes de insertar `ip_quotes`
--

TRUNCATE TABLE `ip_quotes`;
--
-- Volcado de datos para la tabla `ip_quotes`
--

INSERT INTO `ip_quotes` (`quote_id`, `invoice_id`, `user_id`, `client_id`, `invoice_group_id`, `quote_status_id`, `quote_date_created`, `quote_date_modified`, `quote_date_expires`, `quote_number`, `quote_discount_amount`, `quote_discount_percent`, `quote_url_key`, `quote_password`, `notes`) VALUES
(1, 1, 3, 1, 4, 4, '2022-10-10', '2022-10-10 12:45:10', '2022-10-25', 'QUO1', '0.00', '0.00', 'bpUwSeqWDY3rEzvZM0hR5aOG9gLJ76nx', '', ''),
(2, 0, 3, 2, 4, 1, '2022-10-10', '2022-10-10 13:02:22', '2022-10-25', 'QUO2', NULL, NULL, 'erDsyuhFGzPKLM9k8XVOJ4aWfBmYCjQn', '', '');

--
-- Truncar tablas antes de insertar `ip_quote_amounts`
--

TRUNCATE TABLE `ip_quote_amounts`;
--
-- Volcado de datos para la tabla `ip_quote_amounts`
--

INSERT INTO `ip_quote_amounts` (`quote_amount_id`, `quote_id`, `quote_item_subtotal`, `quote_item_tax_total`, `quote_tax_total`, `quote_total`) VALUES
(1, 1, '5.00', '1.05', '-1.15', '4.90'),
(2, 2, '0.00', NULL, '0.00', '0.00');

--
-- Truncar tablas antes de insertar `ip_quote_custom`
--

TRUNCATE TABLE `ip_quote_custom`;
--
-- Truncar tablas antes de insertar `ip_quote_items`
--

TRUNCATE TABLE `ip_quote_items`;
--
-- Volcado de datos para la tabla `ip_quote_items`
--

INSERT INTO `ip_quote_items` (`item_id`, `quote_id`, `item_tax_rate_id`, `item_product_id`, `item_date_added`, `item_name`, `item_description`, `item_quantity`, `item_price`, `item_discount_amount`, `item_order`, `item_product_unit`, `item_product_unit_id`) VALUES
(1, 1, 1, NULL, '2022-10-10', 'boligrafos', '', '2.00', '2.00', NULL, 1, NULL, NULL),
(2, 1, 1, NULL, '2022-10-10', 'papel', '', '1.00', '1.00', NULL, 2, NULL, NULL);

--
-- Truncar tablas antes de insertar `ip_quote_item_amounts`
--

TRUNCATE TABLE `ip_quote_item_amounts`;
--
-- Volcado de datos para la tabla `ip_quote_item_amounts`
--

INSERT INTO `ip_quote_item_amounts` (`item_amount_id`, `item_id`, `item_subtotal`, `item_tax_total`, `item_discount`, `item_total`) VALUES
(1, 1, '4.00', '0.84', '0.00', '4.84'),
(2, 2, '1.00', '0.21', '0.00', '1.21');

--
-- Truncar tablas antes de insertar `ip_quote_tax_rates`
--

TRUNCATE TABLE `ip_quote_tax_rates`;
--
-- Volcado de datos para la tabla `ip_quote_tax_rates`
--

INSERT INTO `ip_quote_tax_rates` (`quote_tax_rate_id`, `quote_id`, `tax_rate_id`, `include_item_tax`, `quote_tax_rate_amount`) VALUES
(1, 1, 4, 1, '-1.15'),
(2, 2, 4, 1, '0.00');

--
-- Truncar tablas antes de insertar `ip_sessions`
--

TRUNCATE TABLE `ip_sessions`;
--
-- Truncar tablas antes de insertar `ip_settings`
--

TRUNCATE TABLE `ip_settings`;
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
(258, 'enable_permissive_search_clients', '0');

--
-- Truncar tablas antes de insertar `ip_tasks`
--

TRUNCATE TABLE `ip_tasks`;
--
-- Truncar tablas antes de insertar `ip_tax_rates`
--

TRUNCATE TABLE `ip_tax_rates`;
--
-- Volcado de datos para la tabla `ip_tax_rates`
--

INSERT INTO `ip_tax_rates` (`tax_rate_id`, `tax_rate_name`, `tax_rate_percent`) VALUES
(1, 'IVA 21%', '21.00'),
(2, 'IVA 10%', '10.00'),
(3, 'IVA 4%', '4.00'),
(4, 'Retencion 19%', '-19.00');

--
-- Truncar tablas antes de insertar `ip_units`
--

TRUNCATE TABLE `ip_units`;
--
-- Volcado de datos para la tabla `ip_units`
--

INSERT INTO `ip_units` (`unit_id`, `unit_name`, `unit_name_plrl`) VALUES
(1, 'mensual', 'mensuales');

--
-- Truncar tablas antes de insertar `ip_uploads`
--

TRUNCATE TABLE `ip_uploads`;
--
-- Truncar tablas antes de insertar `ip_users`
--

TRUNCATE TABLE `ip_users`;
--
-- Volcado de datos para la tabla `ip_users`
--

INSERT INTO `ip_users` (`user_id`, `user_type`, `user_active`, `user_date_created`, `user_date_modified`, `user_language`, `user_name`, `user_company`, `user_address_1`, `user_address_2`, `user_city`, `user_state`, `user_zip`, `user_country`, `user_phone`, `user_fax`, `user_mobile`, `user_email`, `user_password`, `user_web`, `user_vat_id`, `user_tax_code`, `user_psalt`, `user_all_clients`, `user_passwordreset_token`, `user_subscribernumber`, `user_iban`, `user_gln`, `user_rcc`) VALUES
(1, 1, 1, '2022-10-10 12:58:17', '2022-10-10 12:58:17', 'system', 'mtoffice', NULL, 'Rúa Uruguay', '', '', '', '', 'ES', '', '', '', 'estefania@teconsite.com', '$2a$10$084c42e9145dcd69406a6usBo/HNceGXEUWvft1ODpJmkqg.hqjqW', '', NULL, NULL, '084c42e9145dcd69406a66', 0, '', NULL, NULL, NULL, NULL),
(2, 1, 1, '2022-10-10 11:11:33', '2022-10-10 11:11:33', 'system', 'pablo', 'teconsite', '', '', '', '', '', '', '', '', '', 'pablob@teconsite.com', '$2a$10$01bb074d1874a04c8a972OSoLjtDkb7Vr5Rwkp7rx4LQ8SnEQ1fT2', '', '', '', '01bb074d1874a04c8a972a', 0, '', '', '', NULL, NULL),
(3, 1, 1, '2022-10-10 11:13:21', '2022-10-10 11:13:21', 'system', 'tamara', 'teconsite.com', '', '', '', '', '', '', '', '', '', 'tamara@teconsite.com', '$2a$10$3f5aa0c2a459b8e4c5185O0Zh.xe0EPNnX5eqjEVp9iNATxczNCaS', '', '', '', '3f5aa0c2a459b8e4c5185d', 0, '', '', '', NULL, NULL);

--
-- Truncar tablas antes de insertar `ip_user_clients`
--

TRUNCATE TABLE `ip_user_clients`;
--
-- Truncar tablas antes de insertar `ip_user_custom`
--

TRUNCATE TABLE `ip_user_custom`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_user_providers`
--

CREATE TABLE `ip_user_providers` (
  `user_provider_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Truncar tablas antes de insertar `ip_user_providers`
--

TRUNCATE TABLE `ip_user_providers`;
--
-- Truncar tablas antes de insertar `ip_versions`
--

TRUNCATE TABLE `ip_versions`;
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
-- Indices de la tabla `ip_user_providers`
--
ALTER TABLE `ip_user_providers`
  ADD PRIMARY KEY (`user_provider_id`),
  ADD KEY `user_id` (`user_id`,`provider_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ip_user_providers`
--
ALTER TABLE `ip_user_providers`
  MODIFY `user_provider_id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
