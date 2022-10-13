<?php
if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

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

    public function save()
    {
        $this->load->model('invoices_provider/mdl_invoice_provider_items');
        $this->load->model('invoices_provider/mdl_invoices_provider');
        $this->load->model('units/mdl_units');


        $invoice_id = $this->input->post('invoice_provider_id');

        $this->mdl_invoices_provider->set_id($invoice_id);

        if ($this->mdl_invoices_provider->run_validation('validation_rules_save_invoice')) {
            $items = json_decode($this->input->post('items'));

            foreach ($items as $item) {
                // Check if an item has either a quantity + price or name or description
                if (!empty($item->item_name)) {
                    $item->item_quantity = ($item->item_quantity ? standardize_amount($item->item_quantity) : floatval(0));
                    $item->item_price = ($item->item_price ? standardize_amount($item->item_price) : floatval(0));
                    $item->item_discount_amount = ($item->item_discount_amount) ? standardize_amount($item->item_discount_amount) : null;
                    $item->item_product_id = ($item->item_product_id ? $item->item_product_id : null);
                    if (property_exists($item, 'item_date')) {
                        $item->item_date = ($item->item_date ? date_to_mysql($item->item_date) : null);
                    }
                    $item->item_product_unit_id = ($item->item_product_unit_id ? $item->item_product_unit_id : null);
                    $item->item_product_unit = $this->mdl_units->get_name($item->item_product_unit_id, $item->item_quantity);
                    $item_id = ($item->item_id) ?: null;
                    unset($item->item_id);

                    if (!$item->item_task_id) {
                        unset($item->item_task_id);
                    } else {
                        $this->load->model('tasks/mdl_tasks');
                        $this->mdl_tasks->update_status(4, $item->item_task_id);
                    }

                    $this->mdl_invoice_provider_items->save($item_id, $item);
                } elseif (empty($item->item_name) && (!empty($item->item_quantity) || !empty($item->item_price))) {
                    // Throw an error message and use the form validation for that
                    $this->load->library('form_validation');
                    $this->form_validation->set_rules('item_name', trans('item'), 'required');
                    $this->form_validation->run();

                    $response = [
                        'success' => 0,
                        'validation_errors' => [
                            'item_name' => form_error('item_name', '', ''),
                        ],
                    ];

                    echo json_encode($response);
                    exit;
                }
            }

            $invoice_status = $this->input->post('invoice_provider_status_id');

            if ($this->input->post('invoice_provider_discount_amount') === '') {
                $invoice_discount_amount = floatval(0);
            } else {
                $invoice_discount_amount = $this->input->post('invoice_provider_discount_amount');
            }

            if ($this->input->post('invoice_provider_discount_percent') === '') {
                $invoice_discount_percent = floatval(0);
            } else {
                $invoice_discount_percent = $this->input->post('invoice_provider_discount_percent');
            }

            // Generate new invoice number if needed
            $invoice_number = $this->input->post('invoice_provider_number');

            if (empty($invoice_number) && $invoice_status != 1) {
                $invoice_group_id = $this->mdl_invoices_provider->get_invoice_group_id($invoice_id);
                $invoice_number = $this->mdl_invoices_provider->get_invoice_number($invoice_group_id);
            }

            $db_array = [
                'invoice_provider_number' => $invoice_number,
                'invoice_provider_terms' => $this->input->post('invoice_provider_terms'),
                'invoice_provider_date_created' => date_to_mysql($this->input->post('invoice_provider_date_created')),
                'invoice_provider_date_due' => date_to_mysql($this->input->post('invoice_provider_date_due')),
                'invoice_provider_password' => $this->input->post('invoice_provider_password'),
                'invoice_provider_status_id' => $invoice_status,
                'payment_method' => $this->input->post('payment_method'),
                'invoice_provider_discount_amount' => standardize_amount($invoice_discount_amount),
                'invoice_provider_discount_percent' => standardize_amount($invoice_discount_percent),
            ];

            // check if status changed to sent, the feature is enabled and settings is set to sent
            if ($this->config->item('disable_read_only') === false) {
                if ($invoice_status == get_setting('read_only_toggle')) {
                    $db_array['is_read_only'] = 1;
                }
            }

            $this->mdl_invoices_provider->save($invoice_id, $db_array);

            // Recalculate for discounts
            $this->load->model('invoices_provider/mdl_invoice_provider_amounts');
            $this->mdl_invoice__provider_amounts->calculate($invoice_id);

            $response = [
                'success' => 1,
            ];
        } else {
            $this->load->helper('json_error');
            $response = [
                'success' => 0,
                'validation_errors' => json_errors(),
            ];
        }

        // Save all custom fields
        if ($this->input->post('custom')) {
            $db_array = [];

            $values = [];
            foreach ($this->input->post('custom') as $custom) {
                if (preg_match("/^(.*)\[\]$/i", $custom['name'], $matches)) {
                    $values[$matches[1]][] = $custom['value'];
                } else {
                    $values[$custom['name']] = $custom['value'];
                }
            }

            foreach ($values as $key => $value) {
                preg_match("/^custom\[(.*?)\](?:\[\]|)$/", $key, $matches);
                if ($matches) {
                    $db_array[$matches[1]] = $value;
                }
            }


            $this->load->model('custom_fields/mdl_invoice_custom');
            $result = $this->mdl_invoice_custom->save_custom($invoice_id, $db_array);
            if ($result !== true) {
                $response = [
                    'success' => 0,
                    'validation_errors' => $result,
                ];

                echo json_encode($response);
                exit;
            }
        }

        echo json_encode($response);
    }

    public function save_invoice_tax_rate()
    {
        $this->load->model('invoices_provider/mdl_invoice_provider_tax_rates');

        if ($this->mdl_invoice_provider_tax_rates->run_validation()) {
            $this->mdl_invoice_provider_tax_rates->save();

            $response = [
                'success' => 1,
            ];
        } else {
            $response = [
                'success' => 0,
                'validation_errors' => $this->mdl_invoice_provider_tax_rates->validation_errors,
            ];
        }

        echo json_encode($response);
    }

    public function create()
    {
        $this->load->model('invoices_provider/mdl_invoices_provider');

        if ($this->mdl_invoices_provider->run_validation()) {
            $invoice_id = $this->mdl_invoices_provider->create();

            $response = [
                'success' => 1,
                'invoice_provider_id' => $invoice_id,
            ];
        } else {
            $this->load->helper('json_error');
            $response = [
                'success' => 0,
                'validation_errors' => json_errors(),
            ];
        }

        echo json_encode($response);
    }

    public function get_item()
    {
        $this->load->model('invoices_provider/mdl_invoice_provider_items');

        $item = $this->mdl_invoice_provider_items->get_by_id($this->input->post('item_id'));

        echo json_encode($item);
    }

    public function modal_create_invoice()
    {
        $this->load->module('layout');
        $this->load->model('invoice_groups/mdl_invoice_groups');
        $this->load->model('tax_rates/mdl_tax_rates');
        $this->load->model('providers/mdl_providers');

        $data = [
            'invoice_groups' => $this->mdl_invoice_groups->get()->result(),
            'tax_rates' => $this->mdl_tax_rates->get()->result(),
            'provider' => $this->mdl_providers->get_by_id($this->input->post('provider_id')),
            'providers' => $this->mdl_providers->get_latest(),
        ];


        $this->layout->load_view('invoices_provider/modal_create_invoice', $data);
    }



    public function get_recur_start_date()
    {
        $invoice_date = $this->input->post('invoice_provider_date');
        $recur_frequency = $this->input->post('recur_frequency');

        echo increment_user_date($invoice_date, $recur_frequency);
    }

    public function modal_change_provider()
    {
        $this->load->module('layout');
        $this->load->model('providers/mdl_providers');

        $data = [
            'provider_id' => $this->input->post('provider_id'),
            'invoice_provider_id' => $this->input->post('invoice_provider_id'),
            'providers' => $this->mdl_providers->get_latest(),
        ];

        $this->layout->load_view('invoices_provider/modal_change_provider', $data);
    }

    public function change_provider()
    {
        $this->load->model('invoices-provider/mdl_invoices_provider');
        $this->load->model('providers/mdl_providers');

        // Get the client ID
        $provider_id = $this->input->post('provider_id');
        $provider = $this->mdl_providers->where('ip_providers.provider_id', $provider_id)->get()->row();

        if (!empty($provider)) {
            $invoice_id = $this->input->post('invoice_provider_id');

            $db_array = [
                'provider_id' => $provider_id,
            ];
            $this->db->where('invoice_provider_id', $invoice_id);
            $this->db->update('ip_invoices_provider', $db_array);

            $response = [
                'success' => 1,
                'invoice_provider_id' => $invoice_id,
            ];
        } else {
            $this->load->helper('json_error');
            $response = [
                'success' => 0,
                'validation_errors' => json_errors(),
            ];
        }

        echo json_encode($response);
    }

    public function modal_copy_invoice()
    {
        $this->load->module('layout');

        $this->load->model('invoices_provider/mdl_invoices_provider');
        $this->load->model('invoice_groups/mdl_invoice_groups');
        $this->load->model('tax_rates/mdl_tax_rates');

        $data = [
            'tax_rates' => $this->mdl_tax_rates->get()->result(),
            'invoice_provider_id' => $this->input->post('invoice_provider_id'),
            'invoice_provider' => $this->mdl_invoices_provider->where('ip_invoices_provider.invoice_provider_id', $this->input->post('invoice_provider_id'))
                ->get()
                ->row(),
        ];

        $this->layout->load_view('invoices_provider/modal_copy_invoice', $data);
    }

    public function copy_invoice()
    {
        $this->load->model('invoices_provider/mdl_invoices_provider');
        $this->load->model('invoices_provider/mdl_invoice_provider_items');
        $this->load->model('invoices_provider/mdl_invoice_provider_tax_rates');

        if ($this->mdl_invoices_provider->run_validation()) {
            $target_id = $this->mdl_invoices_provider->save();
            $source_id = $this->input->post('invoice_provider_id');

            $this->mdl_invoices_provider->copy_invoice($source_id, $target_id);

            $response = [
                'success' => 1,
                'invoice_id' => $target_id,
            ];
        } else {
            $this->load->helper('json_error');
            $response = [
                'success' => 0,
                'validation_errors' => json_errors(),
            ];
        }

        echo json_encode($response);
    }

    public function modal_create_credit()
    {
        $this->load->module('layout');

        $this->load->model('invoices_provider/mdl_invoices_provider');
        $this->load->model('invoice_groups/mdl_invoice_groups');
        $this->load->model('tax_rates/mdl_tax_rates');

        $data = [
            'invoice_groups' => $this->mdl_invoice_groups->get()->result(),
            'tax_rates' => $this->mdl_tax_rates->get()->result(),
            'invoice_provider_id' => $this->input->post('invoice_provider_id'),
            'invoice_provider' => $this->mdl_invoices_provider->where('ip_invoices_provider.invoice_provider_id', $this->input->post('invoice_provider_id'))
                ->get()
                ->row(),
        ];

        $this->layout->load_view('invoices_provider/modal_create_credit', $data);
    }

    public function create_credit()
    {
        $this->load->model('invoices_provider/mdl_invoices_provider');
        $this->load->model('invoices_provider/mdl_invoice_provider_items');
        $this->load->model('invoices_provider/mdl_invoice_provider_tax_rates');

        if ($this->mdl_invoices_provider->run_validation()) {
            $target_id = $this->mdl_invoices_provider->save();
            $source_id = $this->input->post('invoice_provider_id');

            $this->mdl_invoices_provider->copy_credit_invoice($source_id, $target_id);

            // Set source invoice to read-only
            if ($this->config->item('disable_read_only') == false) {
                $this->mdl_invoices_provider->where('invoice_provider_id', $source_id);
                $this->mdl_invoices_provider->update('ip_invoices_provider', ['is_read_only' => '1']);
            }

            // Set target invoice to credit invoice
            $this->mdl_invoices_provider->where('invoice_provider_id', $target_id);
            $this->mdl_invoices_provider->update('ip_invoices_provider', ['creditinvoice_parent_id' => $source_id]);

            $this->mdl_invoices_provider->where('invoice_provider_id', $target_id);
            $this->mdl_invoices_provider->update('ip_invoice_provider_amounts', ['invoice_provider_sign' => '-1']);

            $response = [
                'success' => 1,
                'invoice_id' => $target_id,
            ];
        } else {
            $this->load->helper('json_error');
            $response = [
                'success' => 0,
                'validation_errors' => json_errors(),
            ];
        }

        echo json_encode($response);
    }

    /**
     * @param $invoice_id
     */
    public function delete_item($invoice_id)
    {
        $success = 0;
        $item_id = $this->input->post('item_id');
        $this->load->model('mdl_invoices_provider');

        // Only continue if the invoice exists or no item id was provided
        if ($this->mdl_invoices_provider->get_by_id($invoice_id) || empty($item_id)) {

            // Delete invoice item
            $this->load->model('mdl_invoice_provider_items');
            $item = $this->mdl_invoice_provider_items->delete($item_id);

            // Check if deletion was successful
            if ($item) {

                $success = 1;

                // Mark task as complete from invoiced
                if (isset($item->item_task_id) && $item->item_task_id) {
                    $this->load->model('tasks/mdl_tasks');
                    $this->mdl_tasks->update_status(3, $item->item_task_id);
                }
            }

        }

        // Return the response
        echo json_encode([
            'success' => $success
        ]);
    }

}
