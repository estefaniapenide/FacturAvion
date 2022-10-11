CREATE TABLE `ip_invoices_provider` (
  `invoice_provider_id`            INT(11)     NOT NULL AUTO_INCREMENT,
  `user_id`               INT(11)     NOT NULL,
  `provider_id`             INT(11)     NOT NULL,
  `invoice_provider_status_id`     TINYINT(2)  NOT NULL DEFAULT '1',
  `invoice_provider_date_created`  DATE        NOT NULL,
  `invoice_provider_date_modified` DATETIME    NOT NULL,
  `invoice_provider_date_due`      DATE        NOT NULL,
  `invoice_provider_number`        VARCHAR(200) NOT NULL,
  `invoice_terms`         LONGTEXT    NOT NULL,
  `invoice_provider_url_key`       CHAR(32)    NOT NULL,
  `invoice_provider_pdf`  VARCHAR(100)        ,
  PRIMARY KEY (`invoice_provider_id`),
  UNIQUE KEY `invoice_provider_url_key` (`invoice_provider_url_key`),
  KEY `user_id` (`user_id`, `provider_id`, `invoice_provider_date_created`, `invoice_provider_date_due`, `invoice_provider_number`),
  KEY `invoice_provider_status_id` (`invoice_provider_status_id`)
)
  ENGINE = MyISAM
  DEFAULT CHARSET = utf8;

CREATE TABLE `ip_invoice_provider_amounts` (
  `invoice_provider_amount_id`      INT(11) NOT NULL AUTO_INCREMENT,
  `invoice_provider_id`             INT(11) NOT NULL,
  `invoice_provider_item_subtotal`  DECIMAL(20, 2)   DEFAULT '0.00',
  `invoice_provider_item_tax_total` DECIMAL(20, 2)   DEFAULT '0.00',
  `invoice_provider_tax_total`      DECIMAL(20, 2)   DEFAULT '0.00',
  `invoice_provider_total`          DECIMAL(20, 2)   DEFAULT '0.00',
  `invoice_provider_paid`           DECIMAL(20, 2)   DEFAULT '0.00',
  `invoice_provider_balance`        DECIMAL(20, 2)   DEFAULT '0.00',
  PRIMARY KEY (`invoice_provider_amount_id`),
  KEY `invoice_provider_id` (`invoice_provider_id`),
  KEY `invoice_provider_paid` (`invoice_provider_paid`, `invoice_provider_balance`)
)
  ENGINE = MyISAM
  DEFAULT CHARSET = utf8;

CREATE TABLE `ip_invoice_provider_custom` (
  `invoice_provider_custom_id` INT(11) NOT NULL AUTO_INCREMENT,
  `invoice_provider_id`        INT(11) NOT NULL,
  PRIMARY KEY (`invoice_provider_custom_id`),
  KEY `invoice_provider_id` (`invoice_provider_id`)
)
  ENGINE = MyISAM
  DEFAULT CHARSET = utf8;
 
 CREATE TABLE `ip_invoice_provider_item_amounts` (
  `item_amount_id` INT(11)        NOT NULL AUTO_INCREMENT,
  `item_id`        INT(11)        NOT NULL,
  `item_subtotal`  DECIMAL(20, 2) NOT NULL,
  `item_tax_total` DECIMAL(20, 2) NOT NULL,
  `item_total`     DECIMAL(20, 2) NOT NULL,
  PRIMARY KEY (`item_amount_id`),
  KEY `item_id` (`item_id`)
)
  ENGINE = MyISAM
  DEFAULT CHARSET = utf8;

CREATE TABLE `ip_invoice_provider_items` (
  `item_id`          INT(11)        NOT NULL AUTO_INCREMENT,
  `invoice_provider_id`       INT(11)        NOT NULL,
  `item_tax_rate_id` INT(11)        NOT NULL DEFAULT '0',
  `item_date_added`  DATE           NOT NULL,
  `item_name`        TEXT DEFAULT NULL,
  `item_description` LONGTEXT DEFAULT NULL,
  `item_quantity`    DECIMAL(10, 2) NOT NULL,
  `item_price`       DECIMAL(20, 2) DEFAULT NULL,
  `item_order`       INT(2)         NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_id`),
  KEY `invoice_provider_id` (`invoice_provider_id`, `item_tax_rate_id`, `item_date_added`, `item_order`)
)
  ENGINE = MyISAM
  DEFAULT CHARSET = utf8;

CREATE TABLE `ip_invoice_provider_tax_rates` (
  `invoice_provider_tax_rate_id`     INT(11)        NOT NULL AUTO_INCREMENT,
  `invoice_provider_id`              INT(11)        NOT NULL,
  `tax_rate_id`             INT(11)        NOT NULL,
  `include_item_tax`        INT(1)         NOT NULL DEFAULT '0',
  `invoice_providere_tax_rate_amount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`invoice_provider_tax_rate_id`),
  KEY `invoice_provider_id` (`invoice_provider_id`, `tax_rate_id`)
)
  ENGINE = MyISAM
  DEFAULT CHARSET = utf8;
 
 ALTER TABLE `ip_invoice_provider_amounts`
  ADD `invoice_provider_sign` ENUM ('1', '-1') NOT NULL DEFAULT '1'
  AFTER `invoice_provider_id`;

ALTER TABLE `ip_invoices_provider`
  ADD `creditinvoice_parent_id` INT(11),
  ADD `is_read_only` TINYINT(1)
  AFTER `invoice_provider_status_id`;
 
 
ALTER TABLE `ip_invoices_provider`
  ADD COLUMN `invoice_time_created` TIME NOT NULL DEFAULT '00:00:00'
  AFTER `invoice_date_created`,
  ADD COLUMN `invoice_password` VARCHAR(90) NULL
  AFTER `is_read_only`;


ALTER TABLE `ip_invoices_provider`
  ADD COLUMN `payment_method` INT NOT NULL DEFAULT 0
  AFTER `invoice_provider_url_key`;

ALTER TABLE `ip_invoices_provider`
  ADD COLUMN `invoice_provider_discount_amount` DECIMAL(20, 2) NULL DEFAULT NULL
  AFTER `invoice_provider_number`,
  ADD COLUMN `invoice_provider_discount_percent` DECIMAL(20, 2) NULL DEFAULT NULL
  AFTER `invoice_provider_discount_amount`;

ALTER TABLE `ip_invoice_provider_item_amounts`
  ADD COLUMN `item_discount` DECIMAL(20, 2) NULL DEFAULT NULL
  AFTER `item_tax_total`;
ALTER TABLE `ip_invoice_provider_items`
  ADD COLUMN `item_discount_amount` DECIMAL(20, 2) NULL DEFAULT NULL
  AFTER `item_price`;
 
 ALTER TABLE `ip_invoices_provider`
  MODIFY COLUMN `invoice_provider_number` VARCHAR(100) NULL DEFAULT NULL;
 
 
 ALTER TABLE `ip_invoice_provider_items`
  ADD COLUMN `item_product_id` INT(11) DEFAULT NULL
  AFTER `item_tax_rate_id`;
 
ALTER TABLE `ip_invoice_items`
  ADD COLUMN `item_product_unit` VARCHAR(50) DEFAULT NULL,
  ADD COLUMN `item_product_unit_id` INT(11);
 
 ALTER TABLE `ip_invoice_provider_items`
  ADD COLUMN `item_date` DATE;
 
 ALTER TABLE `ip_invoice_provider_items`
  ADD COLUMN `item_task_id` INT(11) DEFAULT NULL
  AFTER `item_date_added`;
