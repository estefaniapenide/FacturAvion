# Facturavion
## _Manual de instalación_

Facturavion consiste en un conjunto de módulos para complementar una instalación de invoicePlane


## El paquete de migración, contiene:

- La carpeta instalacion
  - Carpeta de instalacion/autoinstalación/facturacion con el arbol completo de directorios y ficheros para una instalación rápida. 
  - Carpeta de instalación básica (/instalacion/facturacion) con solo archivos nuevos.
    - #facturacion/application/helper
      - 2 helpers extra en la carpeta usados en los módulos de provider e invoices_provider.

    - #facturacion/application/modules
      - Los módulos completos de proveedores, facturas de proveedores, pagos a proveedores y modelo 303

    - #facturacion/application/modules/custom_fields 
      - 2 modelos extra al modulo custom_fields 

    - #facturacion/application/languages
      - Carpeta de idiomas Spanish y english con archivos necesarios a añadir

    - #facturacion/uploads/
      - Carpeta provider_files en uploads/ para los archivos adjuntos de proveedores.
   - Script SQL

## Características

- Módulo proveedores, permite agregar, ver y editar proveedores en tu invoiceplane.
- Módulo facturas de proveedores, que permite crear, ver y editar facturas de proveedores en tu invoiceplane.
- Módulo de pagos de proveedores, que permite pagar las facturas de proveedores y luego ver los pagos y modificarlos.
- Módulo modelo 303, permite ver la información por años y trimestres para presentar el modelo 303.

## Instalación

### Instalación rápida o automática, recomendada para instalaciones de IP 1.5.11 nuevas en las que no se ha modificado y/o añadido módulos extra previamente

- Importar el archivo de base de datos /instalacion/BBDD.sql en la base de datos de ip de tu servidor mysql/mariadb
- Copia la carpeta instalacionautomatica/facturacion en tu IP

### Instalación con ediciones, recomenda para migraciones de IP con módulos modificados y/o añadidos previamente

- Importar el archivo de base de datos /instalacion/BBDD.sql en la base de datos de ip de tu servidor mysql/mariadb
- Copia la carpeta /instalacion/facturación en tu IP
- Edición de archivos:
  - #application/config/config.php
    - Añade la linea: ```$config['enable_invoice_provider_deletion'] = true;```  
        Se recomienda ponerla junto a ```$config['enable_invoice_deletion'] = env_bool('ENABLE_INVOICE_DELETION');``` por legibilidad
    
  - #application/modules/custom_fields/controllers/Custom_fields.php
     - En la función ```form()```
       - Añadir la linea ```$this->load->model('mdl_payment_custom_provider');```  
          despues de ```$this->load->model('mdl_user_custom');```

  - #application/modules/custom_fields/views/form.php:  
     - En el array ```$positions```  
        añadir el campo: ```'payment_provider' => Mdl_payment_custom_provider::$positions```

  - #application/modules/filter/controllers/Ajax.php:
    - Inserta las siguientes funciones:  
        <details>
            <summary>filter_invoices_provider</summary>


                public function filter_invoices_provider()
                  {
                      $this->load->model('invoices_provider/mdl_invoices_provider');

                      $query = $this->input->post('filter_query');
                      $keywords = explode(' ', $query);

                      foreach ($keywords as $keyword) {
                          if ($keyword) {
                              $keyword = strtolower($keyword);
                              $this->mdl_invoices_provider-   >like("CONCAT_WS('^',LOWER(invoice_provider_number),invoice_provider_date_created,invoice_provider_date_due,LOWER(provider_name),invoice_provider_total,invoice_provider_balance)", $keyword);
                          }
                      }

                      $data = array(
                          'invoices_provider' => $this->mdl_invoices_provider->get()->result(),
                          'invoice_provider_statuses' => $this->mdl_invoices_provider->statuses()
                      );

                      $this->layout->load_view('invoices_provider/partial_invoice_table', $data);
                  }


        </details>
        <details>
            <summary>filter_providers</summary>
            
            
                      public function filter_providers()
                          {
                              $this->load->model('providers/mdl_providers');
                              $query = $this->input->post('filter_query');
                              $keywords = explode(' ', $query);

                              foreach ($keywords as $keyword) {
                                  if ($keyword) {
                                      $keyword = strtolower($keyword);
                                      $this->mdl_providers->like("CONCAT_WS('^',LOWER(provider_name),LOWER(provider_comercial_name),LOWER(provider_email),provider_phone,provider_active)", $keyword);
                                  }
                              }

                              $data = array(
                                  'records' => $this->mdl_providers->with_total_balance()->get()->result()
                              );


                              $this->layout->load_view('providers/partial_provider_table', $data);
                          }
                          
                          
        </details>
        
   - #application/modules/layout/views/includes/head.php  
      - Despues del siguiente bloque:
      
      
            $(document).on('click', '.create-invoice', function () {
            $('#modal-placeholder').load("<?php echo site_url('invoices/ajax/modal_create_invoice'); ?>");
            });
      
      
      - Añade los siguientes bloques:
      
      
      
        <details>
            <summary>'.create-invoice-provider', function () </summary>
            
            $(document).on('click', '.create-invoice-provider', function () {
            $('#modal-placeholder').load("<?php echo site_url('invoices_provider/ajax/modal_create_invoice'); ?>");
            });
        
        
        </details>
        
        <details>
            <summary>'#btn_copy_invoice_provider', function ()</summary>
            
            $(document).on('click', '#btn_copy_invoice_provider', function () {
            var invoice_id = $(this).data('invoice-id');
            $('#modal-placeholder').load("<?php echo site_url('invoices_provider/ajax/modal_copy_invoice'); ?>", {invoice_provider_id: invoice_id});
            });
            
            
        </details>
        
        <details>
            <summary>'.provider-create-invoice', function ()</summary>
            
            
            $(document).on('click', '.provider-create-invoice', function () {
            var provider_id = $(this).data('provider-id');
            $('#modal-placeholder').load("<?php echo site_url('invoices_provider/ajax/modal_create_invoice_provider'); ?>", {provider_id: provider_id});
            });
             
             
        </details>
        
        <details>
            <summary>'add-file-provider', function ()</summary>
            
            
            $(document).on('click', 'add-file-provider', function () {
            var invoice_id = $(this).data('invoice-id');
            $('#modal-placeholder').load("<?php echo site_url('invoices_provider/ajax/modal_add_file'); ?>");
            });
             
             
        </details>
        
        <details>
            <summary>'.invoice-add-payment-provider', function ()</summary>
            
            $(document).on('click', '.invoice-add-payment-provider', function () {
            var invoice_id = $(this).data('invoice-id');
            var invoice_balance = $(this).data('invoice-balance');
            var invoice_payment_method = $(this).data('invoice-payment-method');
            var payment_cf_exist =  $(this).data('payment-cf-exist');
            $('#modal-placeholder').load("<?php echo site_url('payments_provider/ajax/modal_add_payment'); ?>", {
                invoice_id: invoice_id,
                invoice_balance: invoice_balance,
                invoice_payment_method: invoice_payment_method,
                payment_cf_exist: payment_cf_exist
                });
            });
            
            
        </details>
        
   - #application/modules/layout/views/includes/navbar.php  
      - Despues de:  
   
      ```
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-caret-down"></i> &nbsp;
                        <span class="hidden-md"><?php _trans('clients'); ?></span>
                        <i class="visible-md-inline fa fa-users"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><?php echo anchor('clients/form', trans('add_client')); ?></li>
                        <li><?php echo anchor('clients/index', trans('view_clients')); ?></li>
                    </ul>
                </li>
      ```
      - Añadir:  
   
      ```
                 <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-caret-down"></i> &nbsp;
                        <span class="hidden-md"><?php _trans('providers'); ?></span>
                        <i class="visible-md-inline fa fa-users"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><?php echo anchor('providers/form', trans('add_provider')); ?></li>
                        <li><?php echo anchor('providers/index', trans('view_providers')); ?></li>
                    </ul>
                </li>
      ```
        
        
        
      - Despues de:  
   
      ```
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-caret-down"></i> &nbsp;
                        <span class="hidden-md"><?php _trans('invoices'); ?></span>
                        <i class="visible-md-inline fa fa-file-text"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="#" class="create-invoice"><?php _trans('create_invoice'); ?></a></li>
                        <li><?php echo anchor('invoices/index', trans('view_invoices')); ?></li>
                        <li><?php echo anchor('invoices/recurring/index', trans('view_recurring_invoices')); ?></li>
                    </ul>
                </li>
      ```
      - Añadir:  
   
      ```
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-caret-down"></i> &nbsp;
                        <span class="hidden-md"><?php _trans('invoices_provider'); ?></span>
                        <i class="visible-md-inline fa fa-file-text"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="#" class="create-invoice-provider"><?php _trans('create_invoice_provider'); ?></a></li>
                        <li><?php echo anchor('invoices_provider/index', trans('view_invoices_provider')); ?></li>
                    </ul>
                </li>
      ```
      
      
      
      
      
      
      - Despues de:  
   
      ```
                <li><?php echo anchor('payments/form', trans('enter_payment')); ?></li>
                        <li><?php echo anchor('payments/index', trans('view_payments')); ?></li>
                        <li><?php echo anchor('payments/online_logs', trans('view_payment_logs')); ?></li>
      ```
      - Añadir:  
   
      ```
                <li class="divider"></li>
                        <li><?php echo anchor('payments_provider/form', trans('enter_payment_provider')); ?></li>
                        <li><?php echo anchor('payments_provider/index', trans('view_payments_provider')); ?></li>
                        <li><?php echo anchor('payments_provider/online_logs', trans('view_payment_provider_logs')); ?></li>
      ```
      
      
      
      
      
      - Despues de:  
   
      ```
                <li><?php echo anchor('reports/invoice_aging', trans('invoice_aging')); ?></li>
                        <li><?php echo anchor('reports/payment_history', trans('payment_history')); ?></li>
                        <li><?php echo anchor('reports/sales_by_client', trans('sales_by_client')); ?></li>
                        <li><?php echo anchor('reports/sales_by_year', trans('sales_by_date')); ?></li>
      ```
      - Añadir:  
   
      ```
                <li role="separator" class="divider"></li>
                        <li><?php echo anchor('modelo303', trans('modelo303'), 'class="hidden-md"') ?>
                    <?php echo anchor('modelo303', '<i class="fa fa-dashboard"></i>', 'class="visible-md-inline-block"') ?></li>
      ```
     
  - #application/modules/products/controllers/Ajax.php  
      - Inserta en la función ```public function modal_product_lookups():```  
          - Despues de ```$this->load->model('families/mdl_families');```  
              añade ```$this->load->model('providers/mdl_providers');```        
          - Despues de ```$families = $this->mdl_families->get()->result();```  
              añade ```$providers = $this->mdl_products->get()->result();```  
          - Despues de ```'families' => $families,```  
              añade ```'providers' => $providers,``` 
  - #application/modules/products/controllers/Products.php
      - Inserta en la función form()  
          - Despues de ```$this->load->model('families/mdl_families');```  
              añade ```$this->load->model('providers/mdl_providers');```        
          - Despues de ```'families' => $this->mdl_families->get()->result(),```  
              añade ```'providers' => $this->mdl_providers->get()->result(),```
      
      
  - #application/modules/products/models/Mdl_products.php  
  
      - En la función ```default_order_by()```  
            añade ```$this->db->order_by('ip_providers.provider_name, ip_products.product_name');```
      - En la función ```default_join()```  
            añade ```$this->db->join('ip_providers', 'ip_providers.provider_id = ip_products.provider_id', 'left');```
      - Añade la función  

        ```
            public function by_provider($match)
            {
              $this->db->where('ip_products.provider_id', $match);
            }  
            
        ```  
        
      - En la función ``` validation_rules() ``` 
          - Comenta  
            ```
                'provider_name' => array(
                   'field' => 'provider_name',
                   'label' => trans('provider_name'),
                   'rules' => ''
                ),
            ```
          - Añade
            ```
                'provider_id' => array(
                  'field' => 'provider_id',
                  'label' => trans('provider'),
                  'rules' => 'numeric'
                ),
            ```
       - En la función ``` db_array() ```  
         añade ```$db_array['provider_id'] = (empty($db_array['provider_id']) ? null : $db_array['provider_id']);```
            
      
      
  - #application/modules/products/views/form.php
      
      - Sustituye  

        ```
                <div class="form-group">
                            <label for="provider_name">
                                <?php _trans('provider_name'); ?>
                            </label>

                            <input type="text" name="provider_name" id="provider_name" class="form-control"
                                   value="<?php echo $this->mdl_products->form_value('provider_name', true); ?>">
                </div>
        ```
      - En su lugar pon:
        ```
                    <div class="form-group">
                        <select name="provider_id" id="provider_id" class="form-control simple-select">
                                <option value="0"><?php _trans('select_provider'); ?></option>
                                <?php foreach ($providers as $provider) { ?>
                                    <option value="<?php echo $provider->provider_id; ?>"
                                        <?php check_select($this->mdl_products->form_value('provider_id'), $provider->provider_id) ?>
                                    ><?php echo $provider->provider_name; ?></option>
                                <?php } ?>
                            </select>
                    </div>
        ```
      
 - Idiomas ```languages/Spanish/custom_lang.php``` y/o 
    - Añade las siguientes lineas en ```languages/english/custom_lang.php```
    
        <details>
                <summary>$lang = array()</summary>

                'modelo303' => 'Model 303',
                'baseimponible' => 'Tax base',
                'totalbaseemitidas' => 'Issued invoices',
                'totalbaserecibidas' => 'Received invoices',
                'cantidad' => 'Amount',
                'totalivarecibidas' => 'Total VAT received invoices',
                'totalivaemitidas' => 'Total VAT issued invoices',

                'add_invoice'                                    => 'Upload pdf invoice',
                'addpdf'                                         => 'Add pdf invoice',
                'archive'                                        => 'Select',
                'active_provider'                                => 'Active',
                'add_provider'                                   => 'Add provider',
                'assign_provider'                                => 'Asigne to provider',
                'user_all_providers'                             => 'Add all providers',
                'user_all_providers_text'                        => '* If this option is checked, the user will be able to see all the providers, including the ones that are added later.',
                'assigned_providers'                             => 'Asigned Providers',
                'change_provider'                                => 'Change Provider',
                'provider'                                       => 'Provider',
                'provider_access'                                => 'Provider Accesss',
                'provider_already_exists'                        => 'Provider already exists!',
                'provider_form'                                  => 'Provider Form',
                'provider_name'                                  => 'Provider Name',
                'provider_surname'                               => 'Provider Surname',
                'provider_surname_optional'                      => 'Provider Surname (optional)',
                'providers'                                      => 'Providers',
                'create_invoice_provider'                        => 'Create Provider Invoice',
                'delete_provider'                                => 'Delete Provider',
                'delete_provider_warning'                        => 'If you delete this provider you will also delete any invoices and payments related to this provider. Are you sure you want to permanently delete this provider?',
                'provider_comercial_name'                        => "Provider's business name",
                'delete_invoice_provider'                        => 'Delete Provider Invoice',
                'enable_permissive_search_providers'             => 'Enable permissive providers search',
                'enter_payment_provider'                         => 'Enter provider payment',
                'filter_providers'                               => 'Filter Provider',
                'filter_invoices_provider'                       => 'Filter Provider Invoices',
                'invoice_provider'                               => "Provider's Invoice",
                'invoices_provider'                              => "Providers' Invoices",
                'providers'                                      => 'Providers',
                'provider_name'                                  => 'Provider Name',
                'recent_providers'                               => 'Recent Providers',
                'sales_by_provider'                              => 'Sales by Provider',
                'select_provider'                                => 'Select Provider',
                'view_provider'                                  => 'View Provider',
                'view_providers'                                 => 'View Providers',
                'view_invoices_provider'                         => "View Provider's Invoices",
                'view_payment_provider_logs'                      =>'View Online Provider Payment Logs',
                'view_payments_provider'                         => 'View Providers Payments',
                'no_provider'                                    => 'No Provider',
                'alert_no_provider_assigned'                     => 'No provider assigned to this project.',
                'vat_id_long'                                    => 'VAT ID',
                'form_validation_validate_payment_amount'        => 'Validate payment amount',
                'transaction_successful'                         => 'Successful transaction',
                'provider_response'                              => 'Provider response'


        </details>
    - Añade las siguientes lineas en ```languages/Spanish/custom_lang.php```
    
        <details>
                <summary>$lang = array()</summary>

                'modelo303' => 'Modelo 303',
                'baseimponible' => 'Base imponible',
                'totalbaseemitidas' => 'Facturas emitidas',
                'totalbaserecibidas' => 'Facturas recibidas',
                'cantidad' => 'Cantidad',
                'totalivarecibidas' => 'Totales IVA facturas recibidas',
                'totalivaemitidas' => 'Totales IVA facturas emitidas',

                'add_invoice'                                    => 'Subir factura en pdf',
                'addpdf'                                         => 'Añadir factura en pdf',
                'archive'                                        => 'Seleccionar',
                'active_provider'                                => 'Activo',
                'add_provider'                                   => 'Agregar Proveedor',
                'assign_provider'                                => 'Asignar a proveedor',
                'user_all_providers'                             => 'Agregar todos los Proveedores',
                'user_all_providers_text'                        => '* Si esta opción está marcada, el usuario podrá ver todos los Proveedores, incluidos los que se agregarán más tarde.',
                'assigned_providers'                             => 'Proveedores asignados',
                'change_provider'                                => 'Cambiar Proveedor',
                'provider'                                       => 'Proveedor',
                'provider_access'                                => 'Acceso de proveedor',
                'provider_already_exists'                        => '¡El proveedor ya existe!',
                'provider_form'                                  => 'Formulario de proveedor',
                'provider_name'                                  => 'Nombre del proveedor',
                'provider_surname'                               => 'Apellido del proveedor',
                'provider_surname_optional'                      => 'Apellido del proveedor (opcional)',
                'providers'                                      => 'Proveedores',
                'create_invoice_provider'                        => 'Crear factura de proveedor',
                'delete_provider'                                => 'Eliminar proveedor',
                'delete_provider_warning'                        => 'Si eliminas este proveedor de igual manera eliminaras cualquier documento relacionado, ¿Está seguro que desea eliminar este cliente permanentemente?',
                'provider_comercial_name'                        => 'Nombre Comercial del proveedor',
                'delete_invoice_provider'                        => 'Eliminar factura de proveedor',
                'enable_permissive_search_providers'             => 'Habilitar y permitir la búsqueda de proveedores',
                'enter_payment_provider'                         => 'Ingresar pago a proveedor',
                'filter_providers'                               => 'Filtro de proveedores',
                'filter_invoices_provider'                       => 'Filtro facturas de proveedores',
                'invoice_provider'                               => 'Factura de proveedor',
                'invoices_provider'                              => 'Facturas de proveedores',
                'providers'                                      => 'Proveedores',
                'provider_name'                                  => 'Nombre del Proveedor',
                'recent_providers'                               => 'Proveedores recientes',
                'sales_by_provider'                              => 'Compras por cliente',
                'select_provider'                                => 'Seleccionar proveedor',
                'view_provider'                                  => 'Ver proveedor',
                'view_providers'                                 => 'Ver proveedores',
                'view_invoices_provider'                         => 'Ver facturas de proveedores',
                'view_payment_privder_logs'                      => 'Ver registros de pagos a proveedores en línea',
                'view_payments_provider'                         => 'Ver los pagos a proveedores',
                'no_provider'                                    => 'Ningún proveedor',
                'alert_no_provider_assigned'                     => 'No hay proveedores asignados a este proyecto.',
                'vat_id_long'                                    => 'NIF/CIF',
                'form_validation_validate_payment_amount'        => 'validar cantidad de pago',
                'transaction_successful'                         => 'Transacción correcta',
                'provider_response'                              => 'Respuesta proveedor'


        </details>
      
      
      
      
      
      
      
      
      
      
      
