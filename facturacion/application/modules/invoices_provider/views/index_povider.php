<div id="headerbar">

    <h1 class="headerbar-title"><?php _trans('invoices_provider'); ?></h1>

    <div class="headerbar-item pull-right">
        <a class="create-invoice btn btn-sm btn-primary" href="#">
            <i class="fa fa-plus"></i> <?php _trans('new'); ?>
        </a>
    </div>

    <div class="headerbar-item pull-right">
        <?php echo pager(site_url('invoices_provider/provider/' . $provider_id . '/' . $status), 'mdl_invoices'); ?>
    </div>

    <div class="headerbar-item pull-right">
        <div class="btn-group btn-group-sm index-options">
            <a href="<?php echo site_url('invoices_provider/provider/' . $provider_id . '/open'); ?>"
               class="btn <?php echo $status == 'open' ? 'btn-primary' : 'btn-default' ?>">
                <?php _trans('open'); ?>
            </a>
            <a href="<?php echo site_url('invoices/provider/' . $provider_id . '/closed'); ?>"
               class="btn  <?php echo $status == 'closed' ? 'btn-primary' : 'btn-default' ?>">
                <?php _trans('closed'); ?>
            </a>
            <a href="<?php echo site_url('invoices_provider/provider/' . $provider_id . '/overdue'); ?>"
               class="btn  <?php echo $status == 'overdue' ? 'btn-primary' : 'btn-default' ?>">
                <?php _trans('overdue'); ?>
            </a>
        </div>
    </div>

</div>

<div id="content" class="table-content">

    <?php $this->layout->load_view('invoices_provider/partial_invoice_table', array('invoices' => $invoices)); ?>

</div>
