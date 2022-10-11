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
 * Class User_Providers
 */
class User_Providers extends Admin_Controller
{
    /**
     * Custom_Values constructor.
     */
    public function __construct()
    {
        parent::__construct();

        $this->load->model('users/mdl_users');
        $this->load->model('providers/mdl_providers');
        $this->load->model('user_providers/mdl_user_providers');
    }

    public function index()
    {
        redirect('users');
    }

    /**
     * @param null $id
     */
    public function user($id = null)
    {
        if ($this->input->post('btn_cancel')) {
            redirect('users');
        }

        $user = $this->mdl_users->get_by_id($id);

        if (empty($user)) {
            redirect('users');
        }

        $user_providers = $this->mdl_user_providers->assigned_to($id)->get()->result();

        $this->layout->set('user', $user);
        $this->layout->set('user_providers', $user_providers);
        $this->layout->set('id', $id);
        $this->layout->buffer('content', 'user_providers/field');
        $this->layout->render();
    }

    /**
     * @param null $user_id
     */
    public function create($user_id = null)
    {
        if (!$user_id) {
            redirect('custom_values');
        }

        if ($this->input->post('btn_cancel')) {
            redirect('user_providers/field/' . $user_id);
        }

        if ($this->mdl_user_providers->run_validation()) {
            
            if ($this->input->post('user_all_providers')) {
                $users_id = array($user_id);
                
                $this->mdl_user_providers->set_all_providers_user($users_id);
                
                $user_update = array(
                    'user_all_providers' => 1
                );
                
            } else {
                $user_update = array(
                    'user_all_providers' => 0
                );
                
               $this->mdl_user_providers->save(); 
            }
            
            $this->db->where('user_id',$user_id);
            $this->db->update('ip_users',$user_update);
            
            redirect('user_providers/user/' . $user_id);
        }

        $user = $this->mdl_users->get_by_id($user_id);
        $providers = $this->mdl_providers->get_not_assigned_to_user($user_id);

        $this->layout->set('id', $user_id);
        $this->layout->set('user', $user);
        $this->layout->set('providers', $providers);
        $this->layout->buffer('content', 'user_providers/new');
        $this->layout->render();
    }

    /**
     * @param integer $user_client_id
     */
    public function delete($user_client_id)
    {
        $ref = $this->mdl_user_providers->get_by_id($user_client_id);

        $this->mdl_user_providers->delete($user_client_id);
        redirect('user_providers/user/' . $ref->user_id);
    }

}
