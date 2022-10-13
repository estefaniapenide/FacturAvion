<?php
$cv = $this->controller->view_data["custom_values"];
?>

<script>
    $(function () {
        $('.item-task-id').each(function () {
            // Disable client chaning if at least one item already has a task id assigned
            if ($(this).val().length > 0) {
                $('#invoice_change_provider').hide();
                return false;
            }
        });

        $('.btn_add_product').click(function () {
            $('#modal-placeholder').load(
                "<?php echo site_url('products/ajax/modal_product_lookups'); ?>/" + Math.floor(Math.random() * 1000)
            );
        });

        $('.btn_add_task').click(function () {
            $('#modal-placeholder').load(
                "<?php echo site_url('tasks/ajax/modal_task_lookups/' . $invoice_id); ?>/" +
                Math.floor(Math.random() * 1000)
            );
        });

        $('.btn_add_row').click(function () {
            $('#new_row').clone().appendTo('#item_table').removeAttr('id').addClass('item').show();
        });

        <?php if (!$items) { ?>
        $('#new_row').clone().appendTo('#item_table').removeAttr('id').addClass('item').show();
        <?php } ?>

        $('#btn_create_recurring').click(function () {
            $('#modal-placeholder').load(
                "<?php echo site_url('invoices/ajax/modal_create_recurring'); ?>",
                {
                    invoice_id: <?php echo $invoice_id; ?>
                }
            );
        });

        $('#invoice_change_provider').click(function () {
            $('#modal-placeholder').load("<?php echo site_url('invoicesProvider/ajax/modal_change_provider'); ?>", {
                invoice_provider_id: <?php echo $invoice_id; ?>,
                provider_id: "<?php echo $this->db->escape_str($invoice->provider_id); ?>",
            });
        });

        $('#btn_save_invoice').click(function () {
            var items = [];
            var item_order = 1;
            $('table tbody.item').each(function () {
                var row = {};
                $(this).find('input,select,textarea').each(function () {
                    if ($(this).is(':checkbox')) {
                        row[$(this).attr('name')] = $(this).is(':checked');
                    } else {
                        row[$(this).attr('name')] = $(this).val();
                    }
                });
                row['item_order'] = item_order;
                item_order++;
                items.push(row);
            });
            $.post("<?php echo site_url('invoicesProvider/ajax/save'); ?>", {
                    invoice_provider_id: <?php echo $invoice_id; ?>,
                    invoice_provider_number: $('#invoice_provider_number').val(),
                    invoice_provider_date_created: $('#invoice_provider_date_created').val(),
                    invoice_provider_date_due: $('#invoice_provider_date_due').val(),
                    invoice_provider_status_id: $('#invoice_provider_status_id').val(),
                    invoice_provider_password: $('#invoice_provider_password').val(),
                    items: JSON.stringify(items),
                    invoice_provider_discount_amount: $('#invoice_provider_discount_amount').val(),
                    invoice_provider_discount_percent: $('#invoice_provider_discount_percent').val(),
                    invoice_provider_terms: $('#invoice_provider_terms').val(),
                    custom: $('input[name^=custom],select[name^=custom]').serializeArray(),
                    payment_method: $('#payment_method').val(),
                },
                function (data) {
                    <?php echo(IP_DEBUG ? 'console.log(data);' : ''); ?>
                    var response = JSON.parse(data);
                    if (response.success === 1) {
                        window.location = "<?php echo site_url('invoicesProvider/view'); ?>/" + <?php echo $invoice_id; ?>;
                    } else {
                        $('#fullpage-loader').hide();
                        $('.control-group').removeClass('has-error');
                        $('div.alert[class*="alert-"]').remove();
                        var resp_errors = response.validation_errors,
                            all_resp_errors = '';
                        for (var key in resp_errors) {
                            $('#' + key).parent().addClass('has-error');
                            all_resp_errors += resp_errors[key];
                        }
                        $('#invoice_form').prepend('<div class="alert alert-danger">' + all_resp_errors + '</div>');
                    }
                });
        });


        $(document).on('click', '.btn_delete_item', function () {
            var btn = $(this);
            var item_id = btn.data('item-id');

            // Just remove the row if no item ID is set (new row)
            if (typeof item_id === 'undefined') {
                $(this).parents('.item').remove();
            }

            $.post("<?php echo site_url('invoicesPovider/ajax/delete_item/' . $invoice->invoice_provider_id); ?>", {
                    'item_id': item_id,
                },
                function (data) {
                    <?php echo(IP_DEBUG ? 'console.log(data);' : ''); ?>
                    var response = JSON.parse(data);

                    if (response.success === 1) {
                        btn.parents('.item').remove();
                    } else {
                        btn.removeClass('btn-link').addClass('btn-danger').prop('disabled', true);
                    }
                });
        });

        <?php if ($invoice->is_read_only != 1): ?>
        var fixHelper = function (e, tr) {
            var $originals = tr.children();
            var $helper = tr.clone();
            $helper.children().each(function (index) {
                $(this).width($originals.eq(index).width());
            });
            return $helper;
        };

        $('#item_table').sortable({
            items: 'tbody',
            helper: fixHelper,
        });

        if ($('#invoice_provider_discount_percent').val().length > 0) {
            $('#invoice_provider_discount_amount').prop('disabled', true);
        }

        if ($('#invoice_provider_discount_amount').val().length > 0) {
            $('#invoice_provider_discount_percent').prop('disabled', true);
        }

        $('#invoice_provider_discount_amount').keyup(function () {
            if (this.value.length > 0) {
                $('#invoice_provider_discount_percent').prop('disabled', true);
            } else {
                $('#invoice_provider_discount_percent').prop('disabled', false);
            }
        });
        $('#invoice_provider_discount_percent').keyup(function () {
            if (this.value.length > 0) {
                $('#invoice_provider_discount_amount').prop('disabled', true);
            } else {
                $('#invoice_provider_discount_amount').prop('disabled', false);
            }
        });
        <?php endif; ?>

    });
</script>

<?php
echo $modal_delete_invoice;
echo $modal_add_invoice_tax;
if ($this->config->item('disable_read_only') == true) {
    $invoice->is_read_only = 0;
}
?>

<div id="headerbar">
    <h1 class="headerbar-title">
        <?php
        echo trans('invoice_provider') . ' ';
        echo($invoice->invoice_provider_number ? '#' . $invoice->invoice_provider_number : $invoice->invoice_provider_id);
        ?>
    </h1>

    <div class="headerbar-item pull-right <?php if ($invoice->is_read_only != 1 || $invoice->invoice_provider_status_id != 4) { ?>btn-group<?php } ?>">

        <div class="options btn-group btn-group-sm">
            <a class="btn btn-sm btn-default dropdown-toggle" data-toggle="dropdown" href="#">
                <i class="fa fa-caret-down no-margin"></i> <?php _trans('options'); ?>
            </a>
            <ul class="dropdown-menu">
                <?php if ($invoice->is_read_only != 1) { ?>
                    <li>
                        <a href="#add-invoice-tax" data-toggle="modal">
                            <i class="fa fa-plus fa-margin"></i> <?php _trans('add_invoice_tax'); ?>
                        </a>
                    </li>
                <?php } ?>
                <li>
                    <a href="#" id="btn_create_credit" data-invoice-id="<?php echo $invoice_id; ?>">
                        <i class="fa fa-minus fa-margin"></i> <?php _trans('create_credit_invoice'); ?>
                    </a>
                </li>
                <?php if ($invoice->invoice_balance != 0) : ?>
                    <li>
                        <a href="#" class="invoice-add-payment"
                           data-invoice-id="<?php echo $invoice_id; ?>"
                           data-invoice-balance="<?php echo $invoice->invoice_provider_balance; ?>"
                           data-invoice-payment-method="<?php echo $invoice->payment_method; ?>"
                           data-payment-cf-exist="<?php echo $payment_cf_exist; ?>">
                            <i class="fa fa-credit-card fa-margin"></i>
                            <?php _trans('enter_payment'); ?>
                        </a>
                    </li>
                <?php endif; ?>
                <li>
                    <a href="#" id="btn_generate_pdf"
                       data-invoice-id="<?php echo $invoice_id; ?>">
                        <i class="fa fa-print fa-margin"></i>
                        <?php _trans('download_pdf'); ?>
                    </a>
                </li>
                <li>
                    <a href="<?php echo site_url('mailer/invoice/' . $invoice->invoice_id); ?>">
                        <i class="fa fa-send fa-margin"></i>
                        <?php _trans('send_email'); ?>
                    </a>
                </li>
                <li class="divider"></li>
                <li>
                    <a href="#" id="btn_copy_invoice"
                       data-invoice-id="<?php echo $invoice_id; ?>">
                        <i class="fa fa-copy fa-margin"></i>
                        <?php _trans('copy_invoice'); ?>
                    </a>
                </li>
                <?php if ($invoice->invoice_provider_status_id == 1 || ($this->config->item('enable_invoice_deletion') === true && $invoice->is_read_only != 1)) { ?>
                    <li>
                        <a href="#delete-invoice" data-toggle="modal">
                            <i class="fa fa-trash-o fa-margin"></i>
                            <?php _trans('delete'); ?>
                        </a>
                    </li>
                <?php } ?>
            </ul>
        </div>

        <?php if ($invoice->is_read_only != 1 || $invoice->invoice_provider_status_id != 4) { ?>
            <a href="#" class="btn btn-sm btn-success ajax-loader" id="btn_save_invoice">
                <i class="fa fa-check"></i> <?php _trans('save'); ?>
            </a>
        <?php } ?>
    </div>

    <div class="headerbar-item invoice-labels pull-right">
        <?php if ($invoice->is_read_only == 1) { ?>
            <span class="label label-danger">
                <i class="fa fa-read-only"></i> <?php _trans('read_only'); ?>
            </span>
        <?php } ?>
    </div>

</div>

<div id="content">

    <?php echo $this->layout->load_view('layout/alerts'); ?>

    <div id="invoice_form">
        <div class="invoice">

            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-5">

                    <h3>
                        <a href="<?php echo site_url('providers/view/' . $invoice->provider_id); ?>">
                            <?php _htmlsc(format_client($invoice)) ?>
                        </a>
                        <?php if ($invoice->invoice_provider_status_id == 1 && !$invoice->creditinvoice_parent_id) { ?>
                            <span id="invoice_change_provider" class="fa fa-edit cursor-pointer small"
                                  data-toggle="tooltip" data-placement="bottom"
                                  title="<?php _trans('change_provider'); ?>"></span>
                        <?php } ?>
                    </h3>
                    <br>
                    <div class="client-address">
                        <?php $this->layout->load_view('providers/partial_provider_address', ['provider' => $invoice]); ?>
                    </div>
                    <?php if ($invoice->provider_phone || $invoice->provider_email) : ?>
                        <hr>
                    <?php endif; ?>
                    <?php if ($invoice->provider_phone): ?>
                        <div>
                            <?php _trans('phone'); ?>:&nbsp;
                            <?php _htmlsc($invoice->provider_phone); ?>
                        </div>
                    <?php endif; ?>
                    <?php if ($invoice->provider_email): ?>
                        <div>
                            <?php _trans('email'); ?>:&nbsp;
                            <?php _auto_link($invoice->provider_email); ?>
                        </div>
                    <?php endif; ?>

                </div>

                <div class="col-xs-12 visible-xs"><br></div>

                <div class="col-xs-12 col-sm-5 col-sm-offset-1 col-md-6 col-md-offset-1">
                    <div class="details-box panel panel-default panel-body">
                        <div class="row">

                            <?php if ($invoice->invoice_sign == -1) { ?>
                                <div class="col-xs-12">
                                    <div class="alert alert-warning small">
                                        <i class="fa fa-credit-invoice"></i>&nbsp;
                                        <?php
                                        echo trans('credit_invoice_for_invoice') . ' ';
                                        $parent_invoice_number = $this->mdl_invoices->get_parent_invoice_number($invoice->creditinvoice_parent_id);
                                        echo anchor('/invoicesProvider/view/' . $invoice->creditinvoice_parent_id, $parent_invoice_number);
                                        ?>
                                    </div>
                                </div>
                            <?php } ?>

                            <div class="col-xs-12 col-md-6">

                                <div class="invoice-properties">
                                    <label><?php _trans('invoice_provider'); ?> #</label>
                                    <input type="text" id="invoice_provider_number" class="form-control input-sm"
                                        <?php if ($invoice->invoice_provider_number) : ?>
                                            value="<?php echo $invoice->invoice_provider_number; ?>"
                                        <?php else : ?>
                                            placeholder="<?php _trans('not_set'); ?>"
                                        <?php endif; ?>
                                        <?php if ($invoice->is_read_only == 1) {
                                            echo 'disabled="disabled"';
                                        } ?>>
                                </div>

                                <div class="invoice-properties has-feedback">
                                    <label><?php _trans('date'); ?></label>

                                    <div class="input-group">
                                        <input name="invoice_provider_date_created" id="invoice_provider_date_created"
                                               class="form-control input-sm datepicker"
                                               value="<?php echo date_from_mysql($invoice->invoice_provider_date_created); ?>"
                                            <?php if ($invoice->is_read_only == 1) {
                                                echo 'disabled="disabled"';
                                            } ?>>
                                        <span class="input-group-addon">
                                            <i class="fa fa-calendar fa-fw"></i>
                                        </span>
                                    </div>
                                </div>

                                <div class="invoice-properties has-feedback">
                                    <label><?php _trans('due_date'); ?></label>

                                    <div class="input-group">
                                        <input name="invoice_provider_date_due" id="invoice_provider_date_due"
                                               class="form-control input-sm datepicker"
                                               value="<?php echo date_from_mysql($invoice->invoice_provider_date_due); ?>"
                                            <?php if ($invoice->is_read_only == 1) {
                                                echo 'disabled="disabled"';
                                            } ?>>
                                        <span class="input-group-addon">
                                            <i class="fa fa-calendar fa-fw"></i>
                                        </span>
                                    </div>
                                </div>

                            </div>

                            <div class="col-xs-12 col-md-6">

                                <div class="invoice-properties">
                                    <label>
                                        <?php _trans('status');
                                        if ($invoice->is_read_only != 1 || $invoice->invoice_provider_status_id != 4) {
                                            echo ' <span class="small">(' . trans('can_be_changed') . ')</span>';
                                        } ?>
                                    </label>
                                    <select name="invoice_provider_status_id" id="invoice_provider_status_id"
                                            class="form-control input-sm simple-select" data-minimum-results-for-search="Infinity"
                                        <?php if ($invoice->is_read_only == 1 && $invoice->invoice_provider_status_id == 4) {
                                            echo 'disabled="disabled"';
                                        } ?>>
                                        <?php foreach ($invoice_statuses as $key => $status) { ?>
                                            <option value="<?php echo $key; ?>"
                                                    <?php if ($key == $invoice->invoice_provider_status_id) { ?>selected="selected"<?php } ?>>
                                                <?php echo $status['label']; ?>
                                            </option>
                                        <?php } ?>
                                    </select>
                                </div>

                                <div class="invoice-properties">
                                    <label><?php _trans('payment_method'); ?></label>
                                    <select name="payment_method" id="payment_method"
                                            class="form-control input-sm simple-select"
                                        <?php if ($invoice->is_read_only == 1 && $invoice->invoice_provider_status_id == 4) {
                                            echo 'disabled="disabled"';
                                        } ?>>
                                        <option value="0"><?php _trans('select_payment_method'); ?></option>
                                        <?php foreach ($payment_methods as $payment_method) { ?>
                                            <option <?php check_select($invoice->payment_method,
                                                $payment_method->payment_method_id) ?>
                                                value="<?php echo $payment_method->payment_method_id; ?>">
                                                <?php echo $payment_method->payment_method_name; ?>
                                            </option>
                                        <?php } ?>
                                    </select>
                                </div>

                                <div class="invoice-properties">
                                    <label><?php _trans('invoice_password'); ?></label>
                                    <input type="text" id="invoice_provider_password" class="form-control input-sm"
                                           value="<?php _htmlsc($invoice->invoice_provider_password); ?>"
                                        <?php if ($invoice->is_read_only == 1) {
                                            echo 'disabled="disabled"';
                                        } ?>>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>

            <br>

            <?php $this->layout->load_view('invoicesProvider/partial_item_table'); ?>

            <hr/>

            <div class="row">
                <div class="col-xs-12 col-md-6">

                    <div class="panel panel-default no-margin">
                        <div class="panel-heading">
                            <?php _trans('invoice_terms'); ?>
                        </div>
                        <div class="panel-body">
                            <textarea id="invoice_provider_terms" name="invoice_provider_terms" class="form-control" rows="3"
                                <?php if ($invoice->is_read_only == 1) {
                                    echo 'disabled="disabled"';
                                } ?>
                            ><?php _htmlsc($invoice->invoice_provider_terms); ?></textarea>
                        </div>
                    </div>

                    <div class="col-xs-12 visible-xs visible-sm"><br></div>

                </div>
                <div class="col-xs-12 col-md-6">

                    <?php $this->layout->load_view('upload/dropzone-invoice-html'); ?>

                </div>
            </div>

        </div>

    </div>
</div>

<?php $this->layout->load_view('upload/dropzone-invoice-scripts'); ?>
