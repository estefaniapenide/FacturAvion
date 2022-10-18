<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class Modelo303 extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->library("form_validation");
        $this->load->model('mdl_modelo303');
    }

    public function index()
    {
        $year = 2022;
        $quarter = 4;
        $this->layout->set(
            array(
                'quarter' => $quarter,
                'year' => $year,
                'baseemitidas' => $this->mdl_modelo303->baseemitida($year,$quarter),
                'baserecibidas' => $this->mdl_modelo303->baserecibida($year,$quarter),
                'ivaemitidas' => $this->mdl_modelo303->ivaemitidas($year,$quarter),
                'ivarecibidas' => $this->mdl_modelo303->ivarecibidas($year,$quarter),
            )
        );
        $this->layout->buffer('content', 'modelo303/index');
        $this->layout->render();
    }

    public function form()
    {
            $this->form_validation->set_rules('year', 'year', 'required|numeric');
            $this->form_validation->set_message("required", "Este campo es obligatorio");
            $this->form_validation->set_message("numeric", "Debe ser un año válido");
            $this->form_validation->set_error_delimiters("<span class='text-danger'>", "</span>");
            if ($this->form_validation->run()) {
                $year = $this->input->post("year");
                $quarter = $this->input->post("trimestre");
                $this->layout->set(
                    array(
                        'quarter' => $quarter,
                        'year' => $year,
                        'baseemitidas' => $this->mdl_modelo303->baseemitida($year,$quarter),
                        'baserecibidas' => $this->mdl_modelo303->baserecibida($year,$quarter),
                        'ivaemitidas' => $this->mdl_modelo303->ivaemitidas($year,$quarter),
                        'ivarecibidas' => $this->mdl_modelo303->ivarecibidas($year,$quarter),
                    )
                );
                $this->layout->buffer('content', 'modelo303/index');
                $this->layout->render();
            } else {
                 $this->index();
          }
    }
}
