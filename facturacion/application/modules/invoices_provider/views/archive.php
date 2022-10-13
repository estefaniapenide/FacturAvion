<div id="headerbar">

    <h1 class="headerbar-title"><?php _trans('invoice_archive'); ?></h1>

    <div class="headerbar-item pull-right">
        <form action="<?php echo site_url('invoicesProvider/archive/'); ?>" method="post">
            <div class="input-group">
                <input name="invoice_provider_number" id="invoice_provider_number" type="text" class="form-control input-sm">
                <span class="input-group-btn">
                    <button class="btn btn-default btn-sm"
                            type="submit"><?php _trans('filter_invoices_provider'); ?></button>
                </span>
            </div>
        </form>
    </div>

</div>
<div id="content" class="table-content">

    <div id="filter_results">
        <?php $this->layout->load_view('invoicesProvider/partial_invoice_archive', array('invoices_provider_archive' => $invoices_archive)); ?>
    </div>

</div>
