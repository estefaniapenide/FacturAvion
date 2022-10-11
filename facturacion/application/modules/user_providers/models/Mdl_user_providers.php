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
 * Class Mdl_User_Providers
 */
class Mdl_User_Providers extends MY_Model
{
    public $table = 'ip_user_providers';
    public $primary_key = 'ip_user_providers.user_provider_id';

    public function default_select()
    {
        $this->db->select('ip_user_providers.*, ip_users.user_name, ip_providers.provider_name, ip_providers.provider_surname');
    }

    public function default_join()
    {
        $this->db->join('ip_users', 'ip_users.user_id = ip_user_providers.user_id');
        $this->db->join('ip_providers', 'ip_providers.provider_id = ip_user_providers.provider_id');
    }

    public function default_order_by()
    {
        $this->db->order_by('ip_providers.provider_name', 'ACS');
    }

    /**
     * @return array
     */
    public function validation_rules()
    {
        return array(
            'user_id' => array(
                'field' => 'user_id',
                'label' => trans('user'),
                'rules' => 'required'
            ),
            'provider_id' => array(
                'field' => 'provider_id',
                'label' => trans('provider'),
                'rules' => 'required'
            ),
        );
    }

    /**
     * @param $user_id
     * @return $this
     */
    public function assigned_to($user_id)
    {
        $this->filter_where('ip_user_providers.user_id', $user_id);
        return $this;
    }
    
    /**
    * 
    * @param array $users_id
    */
    public function set_all_providers_user($users_id)
    {
        $this->load->model('providers/mdl_providers');
        
        for ($x = 0; $x < count($users_id); $x++) {
            $providers = $this->mdl_providers->get_not_assigned_to_user($users_id[$x]);
            
            for ($i = 0; $i < count($providers); $i++) {
                $user_provider = array(
                    'user_id' => $users_id[$x],
                    'provider_id' => $providers[$i]->provider_id
                );
                
                $this->db->insert('ip_user_providers', $user_provider);
            }
        }
    }
    
    public function get_users_all_providers()
    {
        $this->load->model('users/mdl_users');
        $users = $this->mdl_users->where('user_all_clients', 1)->get()->result();
        
        $new_users = array();
        
        for ($i = 0; $i < count($users); $i++) {
            array_push($new_users, $users[$i]->user_id);
        }
        
        $this->set_all_providers_user($new_users);
    }
}
