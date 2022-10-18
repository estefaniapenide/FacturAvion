<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class Mdl_modelo303 extends Response_Model
{
    public function baseemitida($year,$quarter)
    {
        $this->db->select('SUM(ip_invoice_amounts.invoice_item_subtotal) AS subtotal');
        $this->db->from('ip_invoice_amounts');
        $this->db->join('ip_invoices','ip_invoices.invoice_id = ip_invoice_amounts.invoice_id');
        $this->db->where('ip_invoices.invoice_status_id',4);
        $this->db->where('YEAR(ip_invoices.invoice_date_modified)', $year);
        $this->db->where('QUARTER(ip_invoices.invoice_date_modified)', $quarter);
        $query = $this->db->get()->row();
        return $query;
    }

    public function baserecibida($year,$quarter)
    {
        $this->db->select('SUM(ip_invoice_provider_amounts.invoice_provider_item_subtotal) AS subtotal');
        $this->db->from('ip_invoice_provider_amounts');
        $this->db->join('ip_invoices_provider','ip_invoices_provider.invoice_provider_id = ip_invoice_provider_amounts.invoice_provider_id');
        $this->db->where('ip_invoices_provider.invoice_provider_status_id IN (2,3)');
        $this->db->where('YEAR(ip_invoices_provider.invoice_provider_date_modified)', $year);
        $this->db->where('QUARTER(ip_invoices_provider.invoice_provider_date_modified)', $quarter);
        $query = $this->db->get()->row();
        return $query;
    }

    public function ivaemitidas($year,$quarter)
    {
        $this->db->select('ip_tax_rates.tax_rate_name AS tipoiva, SUM(ip_invoice_item_amounts.item_tax_total) AS totaltipoiva');
        $this->db->from('ip_invoice_item_amounts');
        $this->db->join('ip_invoice_items','ip_invoice_items.item_id = ip_invoice_item_amounts.item_id');
        $this->db->join('ip_tax_rates','ip_tax_rates.tax_rate_id = ip_invoice_items.item_tax_rate_id');
        $this->db->join('ip_invoices','ip_invoice_items.invoice_id = ip_invoices.invoice_id');
        $this->db->where('ip_invoices.invoice_status_id',4);
        $this->db->where('YEAR(ip_invoices.invoice_date_modified)', $year);
        $this->db->where('QUARTER(ip_invoices.invoice_date_modified)', $quarter);        
        $this->db->group_by('ip_invoice_items.item_tax_rate_id');
        $query = $this->db->get()->result();
        return $query;
    }

    public function ivarecibidas($year,$quarter)
    {
        $this->db->select('ip_tax_rates.tax_rate_name AS tipoiva, SUM(ip_invoice_provider_item_amounts.item_tax_total) AS totaltipoiva');
        $this->db->from('ip_invoice_provider_item_amounts');
        $this->db->join('ip_invoice_provider_items','ip_invoice_provider_items.item_id = ip_invoice_provider_item_amounts.item_id');
        $this->db->join('ip_tax_rates','ip_tax_rates.tax_rate_id = ip_invoice_provider_items.item_tax_rate_id');
        $this->db->join('ip_invoices_provider','ip_invoice_provider_items.invoice_provider_id = ip_invoices_provider.invoice_provider_id');
        $this->db->where('ip_invoices_provider.invoice_provider_status_id IN (2,3)');
        $this->db->where('YEAR(ip_invoices_provider.invoice_provider_date_modified)', $year);
        $this->db->where('QUARTER(ip_invoices_provider.invoice_provider_date_modified)', $quarter);
        $this->db->group_by('ip_invoice_provider_items.item_tax_rate_id');
        $query = $this->db->get()->result();
        return $query;
    }

    public function ivasfactura($id)
    {
        $this->db->select('ip_tax_rates.tax_rate_name AS tipoiva, SUM(ip_invoice_provider_item_amounts.item_tax_total) AS totaltipoiva');
        $this->db->from('ip_invoice_provider_item_amounts');
        $this->db->join('ip_invoice_provider_items','ip_invoice_provider_items.item_id = ip_invoice_provider_item_amounts.item_id');
        $this->db->join('ip_tax_rates','ip_tax_rates.tax_rate_id = ip_invoice_provider_items.item_tax_rate_id');
        $this->db->join('ip_invoices_provider','ip_invoice_provider_items.invoice_provider_id = ip_invoices_provider.invoice_provider_id');
        $this->db->where('ip_invoices_provider.invoice_provider_number',$id);
        $this->db->group_by('ip_invoice_provider_items.item_tax_rate_id');
        $query = $this->db->get()->result();
        return $query;

    }

    public function ivasfacturacliente($id)
    {
        $this->db->select('ip_tax_rates.tax_rate_name AS tipoiva, SUM(ip_invoice_item_amounts.item_tax_total) AS totaltipoiva');
        $this->db->from('ip_invoice_item_amounts');
        $this->db->join('ip_invoice_items','ip_invoice_items.item_id = ip_invoice_item_amounts.item_id');
        $this->db->join('ip_tax_rates','ip_tax_rates.tax_rate_id = ip_invoice_items.item_tax_rate_id');
        $this->db->join('ip_invoices','ip_invoice_items.invoice_id = ip_invoices.invoice_id');
        $this->db->where('ip_invoices.invoice_number',$id);
        $this->db->group_by('ip_invoice_items.item_tax_rate_id');
        $query = $this->db->get()->result();
        return $query;

    }

}
