<script>
    $(function () {
        $('#save_provider_note').click(function () {
            $.post('<?php echo site_url('providers/ajax/save_provider_note'); ?>',
                {
                    provider_id: $('#provider_id').val(),
                    provider_note: $('#provider_note').val()
                }, function (data) {
                    <?php echo(IP_DEBUG ? 'console.log(data);' : ''); ?>
                    var response = JSON.parse(data);
                    if (response.success === 1) {
                        // The validation was successful
                        $('.control-group').removeClass('error');
                        $('#provider_note').val('');

                        // Reload all notes
                        $('#notes_list').load("<?php echo site_url('providers/ajax/load_provider_notes'); ?>",
                            {
                                provider_id: <?php echo $provider->provider_id; ?>
                            }, function (response) {
                                <?php echo(IP_DEBUG ? 'console.log(response);' : ''); ?>
                            });
                    } else {
                        // The validation was not successful
                        $('.control-group').removeClass('error');
                        for (var key in response.validation_errors) {
                            $('#' + key).parent().addClass('has-error');
                        }
                    }
                });
        });
    });
</script>

<?php
$locations = array();
foreach ($custom_fields as $custom_field) {
    if (array_key_exists($custom_field->custom_field_location, $locations)) {
        $locations[$custom_field->custom_field_location] += 1;
    } else {
        $locations[$custom_field->custom_field_location] = 1;
    }
}
?>

<div id="headerbar">
    <h1 class="headerbar-title"><?php _htmlsc($provider->provider_name); ?></h1>

    <div class="headerbar-item pull-right">
        <div class="btn-group btn-group-sm">
            <form action="<?php echo site_url('providers/delete/' . $provider->provider_id); ?>"
                                      method="POST">
                                    <?php _csrf_field(); ?>
                                    <button type="submit" class="btn btn-danger"
                                            onclick="return confirm('<?php _trans('delete_provider_warning'); ?>');">
                                        <i class="fa fa-trash-o fa-margin"></i> <?php _trans('delete'); ?>
                                    </button>
                                </form>
        </div>
    </div>

</div>

<ul id="submenu" class="nav nav-tabs nav-tabs-noborder">
    <li class="active"><a data-toggle="tab" href="#providerDetails"><?php _trans('details'); ?></a></li>
    <li><a data-toggle="tab" href="#providerInvoices"><?php _trans('invoices'); ?></a></li>
    <li><a data-toggle="tab" href="#providerPayments"><?php _trans('payments'); ?></a></li>
</ul>

<div id="content" class="tabbable tabs-below no-padding">
    <div class="tab-content no-padding">

        <div id="providerDetails" class="tab-pane tab-rich-content active">

            <?php $this->layout->load_view('layout/alerts'); ?>

            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-6">

                    <h3><?php _htmlsc($provider->provider_name); ?></h3>
                    <p>
                        <?php $this->layout->load_view('providers/partial_provider_address'); ?>
                    </p>

                </div>
                <div class="col-xs-12 col-sm-6 col-md-6">

                    <table class="table table-bordered no-margin">
                        <tr>
                            <th>
                                <?php _trans('language'); ?>
                            </th>
                            <td class="td-amount">
                                <?php echo ucfirst($provider->provider_language); ?>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <?php _trans('total_billed'); ?>
                            </th>
                            <td class="td-amount">
                                <?php echo format_currency($provider->provider_invoice_total); ?>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <?php _trans('total_paid'); ?>
                            </th>
                            <th class="td-amount">
                                <?php echo format_currency($provider->provider_invoice_paid); ?>
                            </th>
                        </tr>
                        <tr>
                            <th>
                                <?php _trans('total_balance'); ?>
                            </th>
                            <td class="td-amount">
                                <?php echo format_currency($provider->provider_invoice_balance); ?>
                            </td>
                        </tr>
                    </table>

                </div>
            </div>

            <hr>

            <div class="row">
                <div class="col-xs-12 col-md-6">

                    <div class="panel panel-default no-margin">
                        <div class="panel-heading"><?php _trans('contact_information'); ?></div>
                        <div class="panel-body table-content">
                            <table class="table no-margin">
                                <?php if ($provider->provider_email) : ?>
                                    <tr>
                                        <th><?php _trans('email'); ?></th>
                                        <td><?php _auto_link($provider->provider_email, 'email'); ?></td>
                                    </tr>
                                <?php endif; ?>
                                <?php if ($provider->provider_phone) : ?>
                                    <tr>
                                        <th><?php _trans('phone'); ?></th>
                                        <td><?php _htmlsc($provider->provider_phone); ?></td>
                                    </tr>
                                <?php endif; ?>
                                <?php if ($provider->provider_mobile) : ?>
                                    <tr>
                                        <th><?php _trans('mobile'); ?></th>
                                        <td><?php _htmlsc($provider->provider_mobile); ?></td>
                                    </tr>
                                <?php endif; ?>
                                <?php if ($provider->provider_web) : ?>
                                    <tr>
                                        <th><?php _trans('web'); ?></th>
                                        <td><?php _auto_link($provider->provider_web, 'url', true); ?></td>
                                    </tr>
                                <?php endif; ?>

                                <?php foreach ($custom_fields as $custom_field) : ?>
                                    <?php if ($custom_field->custom_field_location != 2) {
                                        continue;
                                    } ?>
                                    <tr>
                                        <?php
                                        $column = $custom_field->custom_field_label;
                                        $value = $this->mdl_provider_custom->form_value('cf_' . $custom_field->custom_field_id);
                                        ?>
                                        <th><?php _htmlsc($column); ?></th>
                                        <td><?php _htmlsc($value); ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </table>
                        </div>
                    </div>

                </div>
                <div class="col-xs-12 col-md-6">
                    <div class="panel panel-default no-margin">

                        <div class="panel-heading"><?php _trans('tax_information'); ?></div>
                        <div class="panel-body table-content">
                            <table class="table no-margin">
                                <?php if ($provider->provider_vat_id) : ?>
                                    <tr>
                                        <th><?php _trans('vat_id'); ?></th>
                                        <td><?php _htmlsc($provider->provider_vat_id); ?></td>
                                    </tr>
                                <?php endif; ?>

                                <?php foreach ($custom_fields as $custom_field) : ?>
                                    <?php if ($custom_field->custom_field_location != 4) {
                                        continue;
                                    } ?>
                                    <tr>
                                        <?php
                                        $column = $custom_field->custom_field_label;
                                        $value = $this->mdl_provider_custom->form_value('cf_' . $custom_field->custom_field_id);
                                        ?>
                                        <th><?php _htmlsc($column); ?></th>
                                        <td><?php _htmlsc($value); ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </table>
                        </div>

                    </div>
                </div>
            </div>

            <?php
            if ($custom_fields) : ?>
                <hr>

                <div class="row">
                    <div class="col-xs-12 col-md-6">
                        <div class="panel panel-default no-margin">

                            <div class="panel-heading">
                                <?php _trans('custom_fields'); ?>
                            </div>
                            <div class="panel-body table-content">
                                <table class="table no-margin">
                                    <?php foreach ($custom_fields as $custom_field) : ?>
                                        <?php if ($custom_field->custom_field_location != 0) {
                                            continue;
                                        } ?>
                                        <tr>
                                            <?php
                                            $column = $custom_field->custom_field_label;
                                            $value = $this->mdl_provider_custom->form_value('cf_' . $custom_field->custom_field_id);
                                            ?>
                                            <th><?php _htmlsc($column); ?></th>
                                            <td><?php _htmlsc($value); ?></td>
                                        </tr>
                                    <?php endforeach; ?>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            <?php endif; ?>

            <hr>

            <div class="row">
                <div class="col-xs-12 col-md-6">

                    <div class="panel panel-default no-margin">
                        <div class="panel-heading">
                            <?php _trans('notes'); ?>
                        </div>
                        <div class="panel-body">
                            <div id="notes_list">
                                <?php echo $partial_notes; ?>
                            </div>
                            <input type="hidden" name="provider_id" id="provider_id"
                                   value="<?php echo $provider->provider_id; ?>">
                            <div class="input-group">
                                <textarea id="provider_note" class="form-control" rows="2" style="resize:none"></textarea>
                                <span id="save_provider_note" class="input-group-addon btn btn-default">
                                    <?php _trans('add_note'); ?>
                                </span>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>
        <div id="providerInvoices" class="tab-pane table-content">
            <?php echo $invoice_table; ?>
        </div>
        <div id="providerPayments" class="tab-pane table-content">
            <?php echo $payment_table; ?>
        </div>
    </div>

</div>
