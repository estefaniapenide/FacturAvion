<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 * InvoicePlane
 *
 * @author      InvoicePlane Developers & Contributors
 * @copyright   Copyright (c) 2012 - 2018 InvoicePlane.com
 * @license     https://invoiceplane.com/license.txt
 * @link        https://invoiceplane.com
 */

/**
 * Deletes orphaned entries in the database
 */
function delete_orphans()
{
    $CI =& get_instance();

    $queries = array(
        'DELETE FROM ip_invoices_provider WHERE invoice_provider_id NOT IN (SELECT provider_id FROM ip_providers)',
        'DELETE FROM ip_invoice_provider_amounts WHERE invoice_provider_id NOT IN (SELECT invoice_provider_id FROM ip_invoices_provider)',
        'DELETE FROM ip_payments_provider WHERE invoice_id NOT IN (SELECT invoice_provider_id FROM ip_invoices_provider)',
        'DELETE FROM ip_provider_custom WHERE provider_id NOT IN (SELECT provider_id FROM ip_providers)',
        'DELETE FROM ip_invoice_provider_custom WHERE invoice_provider_id NOT IN (SELECT invoice_provider_id FROM ip_invoices_provider)'.
        'DELETE FROM ip_user_custom WHERE user_id NOT IN (SELECT user_id FROM ip_users)',
        'DELETE FROM ip_payment_custom WHERE payment_id NOT IN (SELECT payment_id FROM ip_payments)',
        'DELETE FROM ip_invoice_provider_items WHERE invoice_provider_id NOT IN (SELECT invoice_provider_id FROM ip_invoices_provider)',
        'DELETE FROM ip_invoice_provider_item_amounts WHERE item_provider_id NOT IN (SELECT item_id FROM ip_invoice_provider_items)',
        'DELETE FROM ip_provider_notes WHERE provider_id NOT IN (SELECT provider_id FROM ip_providers)',
        'DELETE FROM ip_invoice_provider_tax_rates WHERE invoice_provider_id NOT IN (SELECT invoice_provider_id FROM ip_invoices_provider)',
    );

    foreach ($queries as $query) {
        $CI->db->query($query);
    }
}
