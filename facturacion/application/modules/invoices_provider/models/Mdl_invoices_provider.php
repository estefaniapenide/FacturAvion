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
 * Class Mdl_Invoices
 */
class Mdl_Invoices_Provider extends Response_Model
{
    public $table = 'ip_invoices_provider';
    public $primary_key = 'ip_invoices_provider.invoice_provider_id';
    public $date_modified_field = 'invoice_provider_date_modified';

    /**
     * @return array
     */
    public function statuses()
    {
        return array(
            '1' => array(
                'label' => trans('draft'),
                'class' => 'draft',
                'href' => 'invoices_provider/status/draft'
            ),
/*             '2' => array(
                'label' => trans('sent'),
                'class' => 'sent',
                'href' => 'invoices_provider/status/sent'
            ), */
            '2' => array(
                'label' => trans('invoiced'),
                'class' => 'viewed', //De donde sale esta clase para darle color!?
                'href' => 'invoices_provider/status/invoiced'
            ),
            '3' => array(
                'label' => trans('paid'),
                'class' => 'paid',
                'href' => 'invoices_provider/status/paid'
            )
        );
    }

    public function default_select()
    {
        $this->db->select("
            SQL_CALC_FOUND_ROWS
            ip_users.*,
            ip_providers.*,
            ip_invoice_provider_amounts.invoice_provider_amount_id,
            IFnull(ip_invoice_provider_amounts.invoice_provider_item_subtotal, '0.00') AS invoice_item_subtotal,
            IFnull(ip_invoice_provider_amounts.invoice_provider_item_tax_total, '0.00') AS invoice_item_tax_total,
            IFnull(ip_invoice_provider_amounts.invoice_provider_tax_total, '0.00') AS invoice_tax_total,
            IFnull(ip_invoice_provider_amounts.invoice_provider_total, '0.00') AS invoice_total,
            IFnull(ip_invoice_provider_amounts.invoice_provider_paid, '0.00') AS invoice_paid,
            IFnull(ip_invoice_provider_amounts.invoice_provider_balance, '0.00') AS invoice_balance,
            ip_invoice_provider_amounts.invoice_provider_sign AS invoice_provider_sign,
            (CASE WHEN ip_invoices_provider.invoice_provider_status_id NOT IN (1,3) AND DATEDIFF(NOW(), invoice_provider_date_due) > 0 THEN 1 ELSE 0 END) is_overdue,
            DATEDIFF(NOW(), invoice_provider_date_due) AS days_overdue,
            ip_invoices_provider.*", false);
    }

    public function default_order_by()
    {
        $this->db->order_by('ip_invoices_provider.invoice_provider_id DESC');
    }

    public function default_join()
    {
        $this->db->join('ip_providers', 'ip_providers.provider_id = ip_invoices_provider.provider_id');
        $this->db->join('ip_users', 'ip_users.user_id = ip_invoices_provider.user_id');
        $this->db->join('ip_invoice_provider_amounts', 'ip_invoice_provider_amounts.invoice_provider_id = ip_invoices_provider.invoice_provider_id', 'left');
    }

    /**
     * @return array
     */
    public function validation_rules()
    {
        return array(
            'provider_id' => array(
                'field' => 'provider_id',
                'label' => trans('provider'),
                'rules' => 'required'
            ),
            'invoice_provider_date_created' => array(
                'field' => 'invoice_provider_date_created',
                'label' => trans('invoice_date'),
                'rules' => 'required'
            ),
            'invoice_time_created' => array(
                'rules' => 'required'
            ),
            'invoice_group_id' => array(
                'field' => 'invoice_group_id',
                'label' => trans('invoice_group'),
                'rules' => 'required'
            ),
            'invoice_password' => array(
                'field' => 'invoice_provider_password',
                'label' => trans('invoice_password')
            ),
            'user_id' => array(
                'field' => 'user_id',
                'label' => trans('user'),
                'rule' => 'required'
            ),
            'payment_method' => array(
                'field' => 'payment_method',
                'label' => trans('payment_method')
            ),
        );
    }

    /**
     * @return array
     */
    public function validation_rules_save_invoice()
    {
        $array = array(
            'invoice_provider_number' => array(
                'field' => 'invoice_provider_number',
                'label' => trans('invoice_provider') . ' #',
                'rules' => 'is_unique[ip_invoices_provider.invoice_provider_number' . (($this->id) ? '.invoice_provider_id.' . $this->id : '') . ']'
            ),
            'invoice_provider_date_created' => array(
                'field' => 'invoice_provider_date_created',
                'label' => trans('date'),
                'rules' => 'required'
            ),
            'invoice_provider_date_due' => array(
                'field' => 'invoice_provider_date_due',
                'label' => trans('due_date'),
                'rules' => 'required'
            ),
            'invoice_provider_time_created' => array(
                'rules' => 'required'
            ),
            'invoice_provider_password' => array(
                'field' => 'invoice_provider_password',
                'label' => trans('invoice_password')
            )
        );
        return $array;
    }

    /**
     * @param null $db_array
     * @param bool $include_invoice_tax_rates
     * @return int|null
     */
    public function create($db_array = null, $include_invoice_tax_rates = true)
    {
        $invoice_id = parent::save(null, $db_array);
        $inv = $this->where('ip_invoices_provider.invoice_provider_id', $invoice_id)->get()->row();
        $invoice_group = $inv->invoice_group_id;
        // Create an invoice amount record
        $db_array = array(
            'invoice_provider_id' => $invoice_id
        );
        $this->db->insert('ip_invoice_provider_amounts', $db_array);
        if ($include_invoice_tax_rates) {
            // Create the default invoice tax record if applicable
            if (get_setting('default_invoice_tax_rate')) {
                $db_array = array(
                    'invoice_provider_id' => $invoice_id,
                    'tax_rate_id' => get_setting('default_invoice_tax_rate'),
                    'include_item_tax' => get_setting('default_include_item_tax', 0),
                    'invoice_provider_tax_rate_amount' => 0
                );

                $this->db->insert('ip_invoice_provider_tax_rates', $db_array);
            }
        }

/*         if($invoice_group !== '0') {
            $this->load->model('invoice_groups/mdl_invoice_groups');
            $invgroup = $this->mdl_invoice_groups->where('invoice_group_id', $invoice_group)->get()->row();
            if (preg_match("/sumex/i", $invgroup->invoice_group_name)) {
                // If the Invoice Group includes "Sumex", make the invoice a Sumex one
                $db_array = array(
                    'sumex_invoice' => $invoice_id
                );
                $this->db->insert('ip_invoice_sumex', $db_array);
            }
        } */
        return $invoice_id;
    }

    /**
     * Copies invoice items, tax rates, etc from source to target
     * @param int $source_id
     * @param int $target_id
     * @param bool $copy_recurring_items_only
     */
    public function copy_invoice($source_id, $target_id, $copy_recurring_items_only = false)
    {
        $this->load->model('invoices_provider/mdl_invoice_provider_items');
        $this->load->model('invoices_provider/mdl_invoice_provider_tax_rates');

        // Copy the items
        $invoice_items = $this->mdl_invoice_provider_items->where('invoice_provider_id', $source_id)->get()->result();
        foreach ($invoice_items as $invoice_item) {
            $db_array = array(
                'invoice_provider_id' => $target_id,
                'item_tax_rate_id' => $invoice_item->item_tax_rate_id,
                'item_product_id' => $invoice_item->item_product_id,
                'item_task_id' => $invoice_item->item_task_id,
                'item_name' => $invoice_item->item_name,
                'item_description' => $invoice_item->item_description,
                'item_quantity' => $invoice_item->item_quantity,
                'item_price' => $invoice_item->item_price,
                'item_discount_amount' => $invoice_item->item_discount_amount,
                'item_order' => $invoice_item->item_order,
                'item_product_unit' => $invoice_item->item_product_unit,
                'item_product_unit_id' => $invoice_item->item_product_unit_id,
            );
            if (!$copy_recurring_items_only) {
                $this->mdl_invoice_provider_items->save(null, $db_array);
            }
        }

        // Copy the tax rates
        $invoice_tax_rates = $this->mdl_invoice_provider_tax_rates->where('invoice_provider_id', $source_id)->get()->result();

        foreach ($invoice_tax_rates as $invoice_tax_rate) {
            $db_array = array(
                'invoice_provider_id' => $target_id,
                'tax_rate_id' => $invoice_tax_rate->tax_rate_id,
                'include_item_tax' => $invoice_tax_rate->include_item_tax,
                'invoice_provider_tax_rate_amount' => $invoice_tax_rate->invoice_tax_rate_amount
            );

            $this->mdl_invoice_provider_tax_rates->save(null, $db_array);
        }

        // Copy the custom fields
        $this->load->model('custom_fields/mdl_invoice_custom');
        $custom_fields = $this->mdl_invoice_custom->where('invoice_id', $source_id)->get()->result();

        $form_data = array();
        foreach ($custom_fields as $field) {
            $form_data[$field->invoice_custom_fieldid] = $field->invoice_custom_fieldvalue;
        }
        $this->mdl_invoice_custom->save_custom($target_id, $form_data);
    }

    /**
     * Copies invoice items, tax rates, etc from source to target
     * @param int $source_id
     * @param int $target_id
     */
    public function copy_credit_invoice($source_id, $target_id)
    {
        $this->load->model('invoices_provider/mdl_invoice_provider_items');
        $this->load->model('invoices_provider/mdl_invoice_provider_tax_rates');

        $invoice_items = $this->mdl_invoice_provider_items->where('invoices_provider_id', $source_id)->get()->result();

        foreach ($invoice_items as $invoice_item) {
            $db_array = array(
                'invoice_provider_id' => $target_id,
                'item_tax_rate_id' => $invoice_item->item_tax_rate_id,
                'item_product_id' => $invoice_item->item_product_id,
                'item_task_id' => $invoice_item->item_task_id,
                'item_name' => $invoice_item->item_name,
                'item_description' => $invoice_item->item_description,
                'item_quantity' => $invoice_item->item_quantity * -1,
                'item_price' => $invoice_item->item_price,
                'item_discount_amount' => $invoice_item->item_discount_amount,
                'item_order' => $invoice_item->item_order,
                'item_product_unit' => $invoice_item->item_product_unit,
                'item_product_unit_id' => $invoice_item->item_product_unit_id,
            );

            $this->mdl_invoice_provider_items->save(null, $db_array);
        }

        $invoice_tax_rates = $this->mdl_invoice_provider_tax_rates->where('invoice_provider_id', $source_id)->get()->result();

        foreach ($invoice_tax_rates as $invoice_tax_rate) {
            $db_array = array(
                'invoice_provider_id' => $target_id,
                'tax_rate_id' => $invoice_tax_rate->tax_rate_id,
                'include_item_tax' => $invoice_tax_rate->include_item_tax,
                'invoice_provider_tax_rate_amount' => -$invoice_tax_rate->invoice_tax_rate_amount
            );

            $this->mdl_invoice_provider_tax_rates->save(null, $db_array);
        }

        // Copy the custom fields
        $this->load->model('custom_fields/mdl_invoice_custom');
        $custom_fields = $this->mdl_invoice_custom->where('invoice_provider_id', $source_id)->get()->result();

        $form_data = array();
        foreach ($custom_fields as $field) {
            $form_data[$field->invoice_custom_fieldid] = $field->invoice_custom_fieldvalue;
        }
        $this->mdl_invoice_custom->save_custom($target_id, $form_data);
    }

    /**
     * @return array
     */
    public function db_array()
    {
        $db_array = parent::db_array();

        // Get the provider id for the submitted invoice
        $this->load->model('providers/mdl_providers');

         // Check if is SUMEX
         $this->load->model('invoice_groups/mdl_invoice_groups');


        $db_array['invoice_provider_date_created'] = date_to_mysql($db_array['invoice_provider_date_created']);
        $db_array['invoice_provider_date_due'] = $this->get_date_due($db_array['invoice_provider_date_created']);
        $db_array['invoice_provider_terms'] = get_setting('default_invoice_terms');

        if (!isset($db_array['invoice_provider_status_id'])) {
            $db_array['invoice_provider_status_id'] = 1;
        }

        $generate_invoice_number = get_setting('generate_invoice_number_for_draft');

        if ($db_array['invoice_provider_status_id'] === 1 && $generate_invoice_number == 1) {
            $db_array['invoice_provider_number'] = $this->get_invoice_number($db_array['invoice_group_id']);
        } elseif ($db_array['invoice_provider_status_id'] != 1) {
            $db_array['invoice_provider_number'] = $this->get_invoice_number($db_array['invoice_group_id']);
        } else {
            $db_array['invoice_provider_number'] = '';
        }

        // Set default values
        $db_array['payment_method'] = (empty($db_array['payment_method']) ? 0 : $db_array['payment_method']);

        // Generate the unique url key
        $db_array['invoice_provider_url_key'] = $this->get_url_key();

        return $db_array;
    }

    /**
     * @param $invoice
     * @return mixed
     */
    public function get_payments($invoice)
    {
        $this->load->model('payments_provider/mdl_payments');

        $this->db->where('invoice_provider_id', $invoice->invoice_provider_id);
        $payment_results = $this->db->get('ip_payments');

        if ($payment_results->num_rows()) {
            return $invoice;
        }

        $invoice->payments = $payment_results->result();

        return $invoice;
    }

    /**
     * @param string $invoice_date_created
     * @return string
     */
    public function get_date_due($invoice_date_created)
    {
        $invoice_date_due = new DateTime($invoice_date_created);
        $invoice_date_due->add(new DateInterval('P' . get_setting('invoices_due_after') . 'D'));
        return $invoice_date_due->format('Y-m-d');
    }

    public function set_next_invoice_number($invoice_group_id)
    {
        $this->db->where($this->primary_key, $invoice_group_id);
        $this->db->set('invoice_group_next_id', 'invoice_group_next_id+1', false);
        $this->db->update($this->table);
    }

    /**
     * @param $invoice_group_id
     * @return mixed
     */
    public function get_invoice_number($invoice_group_id)
    {
        $this->load->model('invoice_groups/mdl_invoice_groups');
        return $this->mdl_invoice_groups->generate_invoice_number($invoice_group_id);
    }

    /**
     * @return string
     */
    public function get_url_key()
    {
        $this->load->helper('string');
        return random_string('alnum', 32);
    }

    public function get_invoice_group_id($invoice_id)
    {
        $invoice = $this->get_by_id($invoice_id);
        return $invoice->invoice_group_id;
    }

    /**
     * @param int $parent_invoice_id
     * @return mixed
     */
    public function get_parent_invoice_number($parent_invoice_id)
    {
        $parent_invoice = $this->get_by_id($parent_invoice_id);
        return $parent_invoice->invoice_provider_number;
    }

    /**
     * @return mixed
     */
    public function get_custom_values($id)
    {
        $this->load->module('custom_fields/Mdl_invoice_custom');
        return $this->invoice_custom->get_by_invid($id);
    }


    /**
     * @param int $invoice_id
     */
    public function delete($invoice_id)
    {
        parent::delete($invoice_id);

        $this->load->helper('orphan_invoices_provider');
        delete_orphans();
    }

    // Excludes draft and paid invoices, i.e. keeps unpaid invoices.
    public function is_open()
    {
        //$this->filter_where_in('invoice_provider_status_id', array(2, 3));
        $this->filter_where_in('invoice_provider_status_id', array(1,2));
        return $this;
    }


    public function guest_visible()
    {
        //$this->filter_where_in('invoice_provider_status_id', array(2, 3, 4));
        $this->filter_where_in('invoice_provider_status_id', array(2, 3));
        return $this;
    }

    public function is_draft()
    {
        $this->filter_where('invoice_provider_status_id', 1);
        return $this;
    }

  /*   public function is_sent()
    {
        $this->filter_where('invoice_provider_status_id', 2);
        return $this;
    } */

    public function is_invoiced()
    {
        //$this->filter_where('invoice_provider_status_id', 3);
        $this->filter_where('invoice_provider_status_id', 2);
        return $this;
    }

    public function is_paid()
    {
        //$this->filter_where('invoice_provider_status_id', 4);
        $this->filter_where('invoice_provider_status_id', 3);
        return $this;
    }

    public function is_overdue()
    {
        $this->filter_having('is_overdue', 1);
        return $this;
    }

    public function by_provider($provider_id)
    {
        $this->filter_where('ip_invoices_provider.provider_id', $provider_id);
        return $this;
    }

    /**
     * @param $invoice_id
     */
    public function mark_invoiced($invoice_id)
    {
        $invoice = $this->get_by_id($invoice_id);

        if (!empty($invoice)) {
            if ($invoice->invoice_status_id == 2) {
                $this->db->where('invoice_provider_id', $invoice_id);
                $this->db->where('invoice_provider_id', $invoice_id);
                $this->db->set('invoice_provider_status_id', 2);
                $this->db->update('ip_invoices_provider');
            }

            // Set the invoice to read-only if feature is not disabled and setting is view
            if ($this->config->item('disable_read_only') == false && get_setting('read_only_toggle') == 2) {
                $this->db->where('invoice_provider_id', $invoice_id);
                $this->db->set('is_read_only', 1);
                $this->db->update('ip_invoices_provider');
            }
        }
    }

    /**
     * @param $invoice_id
     */
/*     public function mark_sent($invoice_id)
    {
        $invoice = $this->mdl_invoices_provider->get_by_id($invoice_id);

        if (!empty($invoice)) {
            if ($invoice->invoice_status_id == 1) {
                // Generate new invoice number if applicable
                $invoice_number = $invoice->invoice_number;

                // Set new date and save
                $this->db->where('invoice_provider_id', $invoice_id);
                $this->db->set('invoice_provider_status_id', 2);
                $this->db->set('invoice_provider_number', $invoice_number);
                $this->db->update('ip_invoices_provider');
            }

            // Set the invoice to read-only if feature is not disabled and setting is sent
            if ($this->config->item('disable_read_only') == false && get_setting('read_only_toggle') == 2) {
                $this->db->where('invoice_provider_id', $invoice_id);
                $this->db->set('is_read_only', 1);
                $this->db->update('ip_invoices_provider');
            }
        }
    } */

     /**
     * @param $invoice_id
     */
   public function generate_invoice_number_if_applicable($invoice_id)
    {
        $invoice = $this->mdl_invoices_provider->get_by_id($invoice_id);

        if (!empty($invoice)) {
            if ($invoice->invoice_provider_status_id == 1 && $invoice->invoice_provider_number == "") {
                // Generate new invoice number if applicable
                if (get_setting('generate_invoice_number_for_draft') == 0) {
                    $invoice_number = $this->get_invoice_number($invoice->invoice_group_id);

                    // Set new invoice number and save
                    $this->db->where('invoice_provider_id', $invoice_id);
                    $this->db->set('invoice_provider_number', $invoice_number);
                    $this->db->update('ip_invoices_provider');
                }
            }
        }
    }
}
