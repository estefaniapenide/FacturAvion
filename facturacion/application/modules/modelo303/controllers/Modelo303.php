<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class Modelo303 extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();

        $this->load->model('mdl_modelo303');
    }

    public function index()
    {
        $this->layout->set(
            array(
                'baseemitidas' => $this->mdl_modelo303->baseemitida(),
                'baserecibidas' => $this->mdl_modelo303->baserecibida(),
                'ivaemitidas' => $this->mdl_modelo303->ivaemitidas(),
                'ivarecibidas' => $this->mdl_modelo303->ivarecibidas(),
            )
        );
        $this->layout->buffer('content','modelo303/index');
        $this->layout->render();
    }

}
