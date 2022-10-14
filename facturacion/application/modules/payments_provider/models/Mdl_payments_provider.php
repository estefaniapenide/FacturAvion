<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 * InvoicePlane
 *
 * @author		InvoicePlane Developers & Contributors
 * @copyright	Copyright (c) 2012 - 2018 InvoicePlane.com
 * @license		https://invoiceplane.com/license.txt
 * @link		https://invoiceplane.com
 */

/**
 * Class Mdl_Payments
 */
class Mdl_Payments_provider extends Response_Model
{
    public $table = 'ip_payments_provider';
    public $primary_key = 'ip_payments_provider.payment_id';
    public $validation_rules = 'validation_rules';

    public function default_select()
    {
        $this->db->select("
            SQL_CALC_FOUND_ROWS
            ip_payment_methods.*,
            ip_invoice_provider_amounts.*,
            ip_providers.provider_name,
            ip_providers.provider_comercial_name,
        	ip_providers.provider_id,
            ip_invoices_provider.invoice_provider_id,
            ip_invoices_provider.invoice_provider_date_created,
            ip_payments_provider.*", false);
    }

    public function default_order_by()
    {
        $this->db->order_by('ip_payments_provider.payment_date DESC');
    }

    public function default_join()
    {
        $this->db->join('ip_invoices_provider', 'ip_invoices_provider.invoice_provider_id = ip_payments_provider.invoice_id');
        $this->db->join('ip_providers', 'ip_providers.provider_id = ip_invoices_provider.provider_id');
        $this->db->join('ip_invoice_provider_amounts', 'ip_invoice_provider_amounts.invoice_provider_id = ip_invoices_provider.invoice_provider_id');
        $this->db->join('ip_payment_methods', 'ip_payment_methods.payment_method_id = ip_payments_provider.payment_method_id', 'left');
    }

    /**
     * @return array
     */
    public function validation_rules()
    {
        return array(
            'invoice_id' => array(
                'field' => 'invoice_id',
                'label' => trans('invoice'),
                'rules' => 'required'
            ),
            'payment_date' => array(
                'field' => 'payment_date',
                'label' => trans('date'),
                'rules' => 'required'
            ),
            'payment_amount' => array(
                'field' => 'payment_amount',
                'label' => trans('payment'),
                'rules' => 'required|callback_validate_payment_amount'
            ),
            'payment_method_id' => array(
                'field' => 'payment_method_id',
                'label' => trans('payment_method')
            ),
            'payment_note' => array(
                'field' => 'payment_note',
                'label' => trans('note')
            )
        );
    }

    /**
     * @param $amount
     * @return bool
     */
    public function validate_payment_amount($amount)
    {
        $amount = (float)standardize_amount($amount);
        $invoice_id = $this->input->post('invoice_id');
        $payment_id = $this->input->post('payment_id');

        $invoice = $this->db->where('invoice_provider_id', $invoice_id)->get('ip_invoice_provider_amounts')->row();
        if ($invoice == null) {
            return false;
        }

        $invoice_balance = (float)$invoice->invoice_provider_balance;

        if ($payment_id) {
            $payment = $this->db->where('payment_id', $payment_id)->get('ip_payments_provider')->row();

            $invoice_balance = $invoice_balance + (float)$payment->payment_amount;
        }

        $invoice_balance = (float)$invoice_balance;

        if ($amount > $invoice_balance) {
            $this->form_validation->set_message('validate_payment_amount', trans('payment_cannot_exceed_balance'));
            return false;
        }

        return true;
    }

    /**
     * @param null $id
     * @param null $db_array
     * @return bool|int|null
     */
    public function save($id = null, $db_array = null)
    {
        $db_array = ($db_array) ? $db_array : $this->db_array();
        $this->load->model('invoices_provider/mdl_invoice_provider_amounts');

        // Save the payment
        $id = parent::save($id, $db_array);

        // Recalculate invoice amounts
        $this->mdl_invoice_provider_amounts->calculate($db_array['invoice_id']);

        // Set proper status for the invoice
        $invoice = $this->db->where('invoice_provider_id', $db_array['invoice_id'])->get('ip_invoice_provider_amounts')->row();

        // Calculate sum for payments
        if ($invoice == null) {
            return false;
        }

        $paid = (float)$invoice->invoice_provider_paid;
        $total = (float)$invoice->invoice_provider_total;

        if ($paid >= $total) {
            $this->db->where('invoice_provider_id', $db_array['invoice_id']);
            $this->db->set('invoice_status_id', 4);
            $this->db->update('ip_invoices_provider');
        }

        // Recalculate invoice amounts
        $this->mdl_invoice_provider_amounts->calculate($db_array['invoice_id']);

        return $id;
    }

    /**
     * @return array
     */
    public function db_array()
    {
        $db_array = parent::db_array();

        $db_array['payment_date'] = date_to_mysql($db_array['payment_date']);
        $db_array['payment_amount'] = standardize_amount($db_array['payment_amount']);

        return $db_array;
    }

    /**
     * @param null $id
     */
    public function delete($id = null)
    {
        // Get the invoice id before deleting payment
        $this->db->select('invoice_provider_id');
        $this->db->where('payment_provider_id', $id);
        $invoice_id = $this->db->get('ip_payments_provider')->row()->invoice_id;

        // Delete the payment
        parent::delete($id);

        // Recalculate invoice amounts
        $this->load->model('invoices_provider/mdl_invoice_provider_amounts');
        $this->mdl_invoice_amounts->calculate($invoice_id);

        // Change invoice status back to sent
        $this->db->select('invoice_provider_status_id');
        $this->db->where('invoice_provider_id', $invoice_id);
        $invoice = $this->db->get('ip_invoices_provider')->row();

        if ($invoice->invoice_status_id == 4) {
            $this->db->where('invoice_provider_id', $invoice_id);
            $this->db->set('invoice_provider_status_id', 2);
            $this->db->update('ip_invoices_provider');
        }

        $this->load->helper('orphan_provider');
        delete_orphans();
    }

    /**
     * @param null $id
     * @return bool
     */
    public function prep_form($id = null)
    {
        if (!parent::prep_form($id)) {
            return false;
        }

        if (!$id) {
            parent::set_form_value('payment_date', date('Y-m-d'));
        }

        return true;
    }

    /**
     * @param $client_id
     * @return $this
     */
    public function by_provider($provider_id)
    {
        $this->filter_where('ip_providers.provider_id', $provider_id);
        return $this;
    }

}
