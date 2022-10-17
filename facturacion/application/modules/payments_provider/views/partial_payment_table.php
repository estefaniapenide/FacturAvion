<div class="table-responsive">
    <table class="table table-hover table-striped">

        <thead>
        <tr>
            <th><?php _trans('payment_date'); ?></th>
            <th><?php _trans('invoice_date'); ?></th>
            <th><?php _trans('invoice'); ?></th>
            <th><?php _trans('provider'); ?></th>
            <th><?php _trans('amount'); ?></th>
            <th><?php _trans('payment_method'); ?></th>
            <th><?php _trans('note'); ?></th>
            <th><?php _trans('options'); ?></th>
        </tr>
        </thead>

        <tbody>
        <?php foreach ($payments_provider as $payment_provider) { ?>

            <tr>
                <td><?php echo date_from_mysql($payment_provider->payment_date); ?></td>
                <td><?php echo date_from_mysql($payment_provider->invoice_provider_date_created); ?></td>
                <td><?php echo anchor('invoices_provider/view/' . $payment_provider->invoice_provider_id, $payment_provider->invoice_provider_number); ?></td>
                <td>
                    <a href="<?php echo site_url('provider/view/' . $payment_provider->provider_id); ?>"
                       title="<?php _trans('view_provider'); ?>">
                        <?php _htmlsc($payment_provider->provider_id); ?>
                    </a>
                </td>
                <td class="amount"><?php echo format_currency($payment_provider->payment_amount); ?></td>
                <td><?php _htmlsc($payment_provider->payment_method_name); ?></td>
                <td><?php _htmlsc($payment_provider->payment_note); ?></td>
                <td>
                    <div class="options btn-group">
                        <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-cog"></i> <?php _trans('options'); ?>
                        </a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="<?php echo site_url('payments_provider/form/' . $payment_provider->payment_id); ?>">
                                    <i class="fa fa-edit fa-margin"></i>
                                    <?php _trans('edit'); ?>
                                </a>
                            </li>
                            <li>
                                <form action="<?php echo site_url('payments_provider    /delete/' . $payment_provider->payment_id); ?>"
                                      method="POST">
                                    <?php _csrf_field(); ?>
                                    <button type="submit" class="dropdown-button"
                                            onclick="return confirm('<?php _trans('delete_record_warning'); ?>');">
                                        <i class="fa fa-trash-o fa-margin"></i> <?php _trans('delete'); ?>
                                    </button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </td>
            </tr>
        <?php } ?>
        </tbody>

    </table>
</div>
