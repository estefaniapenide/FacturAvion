<script>
    $(function () {
        // Display the create invoice modal
        $('#create-invoice-provider').modal('show');


        // Enable select2 for all selects
        $('.simple-select').select2();

        <?php $this->layout->load_view('providers/script_select2_provider_id.js'); ?>

        // Toggle on/off permissive search on clients names
        $('#toggle_permissive_search_providers').click(function () {
            if ($('input#input_permissive_search_providers').val() == ('1')) {
                $.get("<?php echo site_url('providers/ajax/save_preference_permissive_search_providers'); ?>", {
                    permissive_search_providers: '0'
                });
                $('input#input_permissive_search_providers').val('0');
                $('span#toggle_permissive_search_providers i').removeClass('fa-toggle-on');
                $('span#toggle_permissive_search_providers i').addClass('fa-toggle-off');
            } else {
                $.get("<?php echo site_url('providers/ajax/save_preference_permissive_search_providers'); ?>", {
                    permissive_search_providers: '1'
                });
                $('input#input_permissive_search_providers').val('1');
                $('span#toggle_permissive_search_providers i').removeClass('fa-toggle-off');
                $('span#toggle_permissive_search_providers i').addClass('fa-toggle-on');
            }
        });

        // Creates the invoice
        $('#invoice_provider_create_confirm').click(function () {
            // Posts the data to validate and create the invoice;
            // will create the new client if necessar
            $.post("<?php echo site_url('invoices_provider/ajax/create'); ?>", {
                    provider_id: $('#create_invoice_provider_id').val(),
                    invoice_provider_date_created: $('#invoice_provider_date_created').val(),
                    invoice_group_id: $('#id_grupo_facturas_proveedor').val(),
                    invoice_provider_time_created: '<?php echo date('H:i:s') ?>',
                    invoice_provider_password: $('#invoice_provider_password').val(),
                    user_id: '<?php echo $this->session->userdata('user_id'); ?>',
                    payment_method: $('#payment_method_id').val()
                },
                function (data) {
                    <?php echo(IP_DEBUG ? 'console.log(data);' : ''); ?>
                    var response = JSON.parse(data);
                    if (response.success === 1) {
                        // The validation was successful and invoice was created
                        window.location = "<?php echo site_url('invoices_provider/view'); ?>/" + response.invoice_id;

                    }
                    else {
                        // The validation was not successful
                        $('.control-group').removeClass('has-error');
                        for (var key in response.validation_errors) {
                            $('#' + key).parent().parent().addClass('has-error');
                        }
                    }
                });
        });
    });

</script>

<div id="create-invoice-provider" class="modal modal-lg"
     role="dialog" aria-labelledby="modal_create_invoice_provider" aria-hidden="true">
    <form class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><i class="fa fa-close"></i></button>
            <h4 class="panel-title"><?php _trans('create_invoice_provider'); ?></h4>
        </div>
        <div class="modal-body">

            <input class="hidden" id="payment_method_id"
                   value="<?php echo get_setting('invoice_default_payment_method'); ?>">
            <input class="hidden" id="id_grupo_facturas_proveedor"
                   value="2">

            <input class="hidden" id="input_permissive_search_providers"
                   value="<?php echo get_setting('enable_permissive_search_providers'); ?>">

            <div class="form-group has-feedback">
                <label for="create_invoice_provider_id"><?php _trans('provider'); ?></label>
                <div class="input-group">
                    <select name="provider_id" id="create_invoice_provider_id" class="provider-id-select form-control"
                            autofocus="autofocus">
                        <?php if (!empty($provider)) : ?>
                            <option value="<?php echo $provider->provider_id; ?>"></option>
                        <?php endif; ?>
                    </select>
                    <span id="toggle_permissive_search_providers" class="input-group-addon"
                          title="<?php _trans('enable_permissive_search_providers'); ?>" style="cursor:pointer;">
                        <i class="fa fa-toggle-<?php echo get_setting('enable_permissive_search_providers') ? 'on' : 'off' ?> fa-fw"></i>
                    </span>
                </div>
            </div>

            <div class="form-group has-feedback">
                <label for="invoice_provider_date_created"><?php _trans('invoice_date'); ?></label>

                <div class="input-group">
                    <input name="invoice_provider_date_created" id="invoice_provider_date_created"
                           class="form-control datepicker"
                           value="<?php echo date(date_format_setting()); ?>">
                    <span class="input-group-addon">
                    <i class="fa fa-calendar fa-fw"></i>
                </span>
                </div>
            </div>

            <div class="form-group">
                <label for="invoice_provider_password"><?php _trans('invoice_password'); ?></label>
                <input type="text" name="invoice_provider_password" id="invoice_provider_password" class="form-control"
                       value="<?php echo get_setting('invoice_provider_pre_password') == '' ? '' : get_setting('invoice_provider_pre_password'); ?>"
                       style="margin: 0 auto;" autocomplete="off">
            </div>
        </div>

        <div class="modal-footer">
            <div class="btn-group">
                <button class="btn btn-success ajax-loader" id="invoice_provider_create_confirm" type="button">
                    <i class="fa fa-check"></i> <?php _trans('submit'); ?>
                </button>
                <button class="btn btn-danger" type="button" data-dismiss="modal">
                    <i class="fa fa-times"></i> <?php _trans('cancel'); ?>
                </button>
            </div>
        </div>

    </form>

</div>
