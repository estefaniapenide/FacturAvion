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
 * Class Mdl_Providers
 */
class Mdl_providers extends Response_Model
{
    public $table = 'ip_providers';
    public $primary_key = 'ip_providers.provider_id';
    public $date_created_field = 'provider_date_created';
    public $date_modified_field = 'provider_date_modified';

    public function default_select()
    {
        $this->db->select(
            'SQL_CALC_FOUND_ROWS ' . $this->table . '.*, ' .
            'CONCAT(' . $this->table . '.provider_name) as provider_fullname'
            , false);
    }

    public function default_order_by()
    {
        $this->db->order_by('ip_providers.provider_name');
    }

    public function validation_rules()
    {
        return array(
            'provider_name' => array(
                'field' => 'provider_name',
                'label' => trans('provider_name'),
                'rules' => 'required'
            ),
            'provider_comercial_name' => array(
                'field' => 'provider_comercial_name',
                'label' => trans('provider_comercial_name')
            ),
            'provider_active' => array(
                'field' => 'provider_active'
            ),
            'provider_language' => array(
                'field' => 'provider_language',
                'label' => trans('language'),
            ),
            'provider_address_1' => array(
                'field' => 'provider_address_1'
            ),
            'provider_address_2' => array(
                'field' => 'provider_address_2'
            ),
            'provider_city' => array(
                'field' => 'provider_city'
            ),
            'provider_state' => array(
                'field' => 'provider_state'
            ),
            'provider_zip' => array(
                'field' => 'provider_zip'
            ),
            'provider_country' => array(
                'field' => 'provider_country'
            ),
            'provider_phone' => array(
                'field' => 'provider_phone'
            ),
            'provider_mobile' => array(
                'field' => 'provider_mobile'
            ),
            'provider_email' => array(
                'field' => 'provider_email'
            ),
            'provider_web' => array(
                'field' => 'provider_web'
            ),
            'provider_vat_id' => array(
                'field' => 'provider_vat_id'
            ),
        );
    }

    /**
     * @param int $amount
     * @return mixed
     */
    function get_latest($amount = 10)
    {
        return $this->mdl_providers
            ->where('provider_active', 1)
            ->order_by('provider_id', 'DESC')
            ->limit($amount)
            ->get()
            ->result();
    }

    /**
     * @param $input
     * @return string
     */
    function fix_avs($input)
    {
        if ($input != "") {
            if (preg_match('/(\d{3})\.(\d{4})\.(\d{4})\.(\d{2})/', $input, $matches)) {
                return $matches[1] . $matches[2] . $matches[3] . $matches[4];
            } else if (preg_match('/^\d{13}$/', $input)) {
                return $input;
            }
        }

        return "";
    }

    function convert_date($input)
    {
        $this->load->helper('date_helper');

        if ($input == '') {
            return '';
        }

        return date_to_mysql($input);
    }

    public function db_array()
    {
        $db_array = parent::db_array();

        if (!isset($db_array['provider_active'])) {
            $db_array['provider_active'] = 0;
        }

        return $db_array;
    }

    /**
     * @param int $id
     */
    public function delete($id)
    {
        parent::delete($id);

        $this->load->helper('orphan_provider');
        delete_orphans();
    }

    /**
     * Returns provider_id of existing dprovider
     *
     * @param $provider_name
     * @return int|null
     */
    public function provider_lookup($provider_name)
    {
        $dprovider = $this->mdl_providers->where('provider_name', $provider_name)->get();

        if ($dprovider->num_rows()) {
            $provider_id = $dprovider->row()->provider_id;
        } else {
            $db_array = array(
                'provider_name' => $provider_name
            );

            $provider_id = parent::save(null, $db_array);
        }

        return $provider_id;
    }

    public function with_total()
    {
        $this->filter_select('IFnull((SELECT SUM(invoice_total) FROM ip_invoice_amounts WHERE invoice_id IN (SELECT invoice_id FROM ip_invoices_provider WHERE ip_invoices_provider.provider_id = ip_providers.provider_id)), 0) AS provider_invoice_total', false);
        return $this;
    }

    public function with_total_paid()
    {
        $this->filter_select('IFnull((SELECT SUM(invoice_paid) FROM ip_invoice_amounts WHERE invoice_id IN (SELECT invoice_id FROM ip_invoices_provider WHERE ip_invoices_provider.provider_id = ip_providers.provider_id)), 0) AS provider_invoice_paid', false);
        return $this;
    }

    public function with_total_balance()
    {
        $this->filter_select('IFnull((SELECT SUM(invoice_balance) FROM ip_invoice_amounts WHERE invoice_id IN (SELECT invoice_id FROM ip_invoices_provider WHERE ip_invoices_provider.provider_id = ip_providers.provider_id)), 0) AS provider_invoice_balance', false);
        return $this;
    }

    public function is_inactive()
    {
        $this->filter_where('provider_active', 0);
        return $this;
    }

    /**
     * @param $user_id
     * @return $this
     */
    public function get_not_assigned_to_user($user_id)
    {
        $this->load->model('user_providers/mdl_user_providers');
        $providers = $this->mdl_user_providers->select('ip_user_providers.provider_id')
            ->assigned_to($user_id)->get()->result();

        $assigned_providers = [];
        foreach ($providers as $dprovider) {
            $assigned_providers[] = $dprovider->provider_id;
        }

        if (count($assigned_providers) > 0) {
            $this->where_not_in('ip_providers.provider_id', $assigned_providers);
        }

        $this->is_active();
        return $this->get()->result();
    }

    public function is_active()
    {
        $this->filter_where('provider_active', 1);
        return $this;
    }

}
