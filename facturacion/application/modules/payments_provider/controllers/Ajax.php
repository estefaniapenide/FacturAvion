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
 * Class Ajax
 */
class Ajax extends Admin_Controller
{
    public $ajax_controller = true;

    public function add()
    {
        $this->load->model('payments_provider/mdl_payments_provider');
        if ($this->mdl_payments_provider->run_validation()) {
            $payment_id = $this->mdl_payments_provider->save();

            $response = array(
                'success' => 1,
                'payment_id' => $payment_id
            );
        } else {
            $this->load->helper('json_error');
            $response = array(
                'success' => 0,
                'validation_errors' => json_errors()
            );
        }

        echo json_encode($response);
    }

    public function modal_add_payment()
    {
        $this->load->module('layout');
        $this->load->model('payments_provider/mdl_payments_provider');
        $this->load->model('payment_methods/mdl_payment_methods');
        $this->load->model('custom_fields/mdl_payment_custom');

        $data = array(
            'payment_methods' => $this->mdl_payment_methods->get()->result(),
            'invoice_id' => $this->input->post('invoice_id'),
            'invoice_balance' => $this->input->post('invoice_balance'),
            'invoice_payment_method' => $this->input->post('invoice_payment_method'),
            'payment_cf_exist' => $this->input->post('payment_cf_exist')
        );
        $this->layout->load_view('payments_provider/modal_add_payment', $data);
    }

}
