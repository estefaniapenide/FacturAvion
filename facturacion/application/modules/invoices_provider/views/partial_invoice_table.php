<div class="table-responsive">
    <table class="table table-hover table-striped">

        <thead>
        <tr>
            <th><?php _trans('status'); ?></th>
            <th><?php _trans('invoice_provider'); ?></th>
            <th><?php _trans('created'); ?></th>
            <th><?php _trans('due_date'); ?></th>
            <th><?php _trans('provider_name'); ?></th>
            <th style="text-align: right;"><?php _trans('amount'); ?></th>
            <th style="text-align: right;"><?php _trans('balance'); ?></th>
            <th><?php _trans('options'); ?></th>
        </tr>
        </thead>

        <tbody>
        <?php
        $invoice_idx = 1;
        $invoice_count = count($invoices);
        $invoice_list_split = $invoice_count > 3 ? $invoice_count / 2 : 9999;
        foreach ($invoices as $invoice) {

            // Disable read-only if not applicable
            if ($this->config->item('disable_read_only') == true) {
                $invoice->is_read_only = 0;
            }
            // Convert the dropdown menu to a dropup if invoice is after the invoice split
            $dropup = $invoice_idx > $invoice_list_split ? true : false;
            ?>
            <tr>
                <td>
                    <span class="label <?php echo $invoice_provider_statuses[$invoice->invoice_provider_status_id]['class']; ?>">
                        <?php echo $invoice_provider_statuses[$invoice->invoice_provider_status_id]['label'];
                        if ($invoice->invoice_provider_sign == '-1') { ?>
                            &nbsp;<i class="fa fa-credit-invoice" title="<?php echo trans('credit_invoice') ?>"></i>
                        <?php } ?>
                        <?php if ($invoice->is_read_only) { ?>
                            &nbsp;<i class="fa fa-read-only" title="<?php _trans('read_only') ?>"></i>
                        <?php } ?>
                    </span>
                </td>

                <td>
                    <a href="<?php echo site_url('invoices_provider/view/' . $invoice->invoice_provider_id); ?>"
                       title="<?php if ($invoice->is_read_only != 1) {  _trans('edit'); }else{
                                            _trans('view');
                                        }?>">
                        <?php echo($invoice->invoice_provider_number ? $invoice->invoice_provider_number : $invoice->invoice_id); ?>
                    </a>
                </td>

                <td>
                    <?php echo date_from_mysql($invoice->invoice_provider_date_created); ?>
                </td>

                <td>
                    <span class="<?php if ($invoice->is_overdue) { ?>font-overdue<?php } ?>">
                        <?php echo date_from_mysql($invoice->invoice_provider_date_due); ?>
                    </span>
                </td>

                <td>
                    <a href="<?php echo site_url('providers/view/' . $invoice->provider_id); ?>"
                       title="<?php _trans('view_provider'); ?>">
                        <?php _htmlsc($invoice->provider_name); ?>
                    </a>
                </td>

                <td class="amount <?php if ($invoice->invoice_provider_sign == '-1') {
                    echo 'text-danger';
                }; ?>">
                    <?php echo format_currency($invoice->invoice_total); ?>
                </td>

                <td class="amount">
                    <?php echo format_currency($invoice->invoice_balance); ?>
                </td>

                <td>
                    <div class="options btn-group<?php echo $dropup ? ' dropup' : ''; ?>">
                        <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-cog"></i> <?php _trans('options'); ?>
                        </a>
                        <ul class="dropdown-menu">
                                <li>
                                    <a href="<?php echo site_url('invoices_provider/view/' . $invoice->invoice_provider_id); ?>">
                                        <i class="fa fa-edit fa-margin"></i> <?php if ($invoice->is_read_only != 1) {  _trans('edit'); }else{
                                            _trans('view');
                                        }?>
                                    </a>
                                </li>
                            <li>
                            <?php if ($invoice->invoice_balance != 0 && $invoice->is_read_only != 1 && $invoice->invoice_provider_status_id != 3) { ?>
                                <a href="#" class="invoice-add-payment-provider"
                                   data-invoice-id="<?php echo $invoice->invoice_provider_id; ?>"
                                   data-invoice-balance="<?php echo $invoice->invoice_balance; ?>"
                                   data-invoice-payment-method="<?php echo $invoice->payment_method; ?>">
                                    <i class="fa fa-money fa-margin"></i>
                                    <?php _trans('enter_payment'); ?>
                                </a>
                            </li>
                            <?php } ?>
                            <?php if (($this->config->item('enable_invoice_provider_deletion') === true)) { ?>
                                <li>
                                    <form action="<?php echo site_url('invoices_provider/delete/' . $invoice->invoice_provider_id); ?>"
                                          method="POST">
                                        <?php _csrf_field(); ?>
                                        <button type="submit" class="dropdown-button"
                                                onclick="return confirm('<?php _trans('delete_invoice_warning'); ?>');">
                                            <i class="fa fa-trash-o fa-margin"></i> <?php _trans('delete'); ?>
                                        </button>
                                    </form>
                                </li>
                            <?php } ?>
                        </ul>
                    </div>
                </td>
            </tr>
            <?php
            $invoice_idx++;
        } ?>
        </tbody>

    </table>
</div>
