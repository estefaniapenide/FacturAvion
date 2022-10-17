<div id="headerbar">

    <h1 class="headerbar-title"><?php _trans('invoices_provider'); ?></h1>

    <div class="headerbar-item pull-right">
        <button type="button" class="btn btn-default btn-sm submenu-toggle hidden-lg"
                data-toggle="collapse" data-target="#ip-submenu-collapse">
            <i class="fa fa-bars"></i> <?php _trans('submenu'); ?>
        </button>
        <a class="create-invoice-provider btn btn-sm btn-primary" href="#">
            <i class="fa fa-plus"></i> <?php _trans('new'); ?>
        </a>
    </div>

    <div class="headerbar-item pull-right visible-lg">
        <?php echo pager(site_url('invoices_provider/status/' . $this->uri->segment(3)), 'mdl_invoices_provider'); ?>
    </div>

    <div class="headerbar-item pull-right visible-lg">
        <div class="btn-group btn-group-sm index-options">
            <a href="<?php echo site_url('invoices_provider/status/all'); ?>"
               class="btn <?php echo $status == 'all' ? 'btn-primary' : 'btn-default' ?>">
                <?php _trans('all'); ?>
            </a>
            <a href="<?php echo site_url('invoices_provider/status/draft'); ?>"
               class="btn  <?php echo $status == 'draft' ? 'btn-primary' : 'btn-default' ?>">
                <?php _trans('draft'); ?>
            </a>
<!--             <a href="<?php echo site_url('invoices_provider/status/sent'); ?>"
               class="btn  <?php echo $status == 'sent' ? 'btn-primary' : 'btn-default' ?>">
                <?php _trans('sent'); ?>
            </a> -->
            <a href="<?php echo site_url('invoices_provider/status/invoiced'); ?>"
               class="btn  <?php echo $status == 'invoiced' ? 'btn-primary' : 'btn-default' ?>">
                <?php _trans('invoiced'); ?>
            </a>
            <a href="<?php echo site_url('invoices_provider/status/paid'); ?>"
               class="btn  <?php echo $status == 'paid' ? 'btn-primary' : 'btn-default' ?>">
                <?php _trans('paid'); ?>
            </a>
            <a href="<?php echo site_url('invoices_provider/status/overdue'); ?>"
               class="btn  <?php echo $status == 'overdue' ? 'btn-primary' : 'btn-default' ?>">
                <?php _trans('overdue'); ?>
            </a>
        </div>
    </div>

</div>

<div id="submenu">
    <div class="collapse clearfix" id="ip-submenu-collapse">

        <div class="submenu-row">
            <?php echo pager(site_url('invoices_provider/status/' . $this->uri->segment(3)), 'mdl_invoices_provider'); ?>
        </div>

        <div class="submenu-row">
            <div class="btn-group btn-group-sm index-options">
                <a href="<?php echo site_url('invoices_provider/status/all'); ?>"
                   class="btn <?php echo $status == 'all' ? 'btn-primary' : 'btn-default' ?>">
                    <?php _trans('all'); ?>
                </a>
                <a href="<?php echo site_url('invoices_provider/status/draft'); ?>"
                   class="btn  <?php echo $status == 'draft' ? 'btn-primary' : 'btn-default' ?>">
                    <?php _trans('draft'); ?>
                </a>
<!--                 <a href="<?php //echo site_url('invoices_provider/status/sent'); ?>"
                   class="btn  <?php //echo $status == 'sent' ? 'btn-primary' : 'btn-default' ?>">
                    <?php //_trans('sent'); ?>
                </a> -->
                <a href="<?php echo site_url('invoices_provider/status/invoiced'); ?>"
                   class="btn  <?php echo $status == 'invoiced' ? 'btn-primary' : 'btn-default' ?>">
                    <?php _trans('invoiced'); ?>
                </a>
                <a href="<?php echo site_url('invoices_provider/status/paid'); ?>"
                   class="btn  <?php echo $status == 'paid' ? 'btn-primary' : 'btn-default' ?>">
                    <?php _trans('paid'); ?>
                </a>
                <a href="<?php echo site_url('invoices_provider/status/overdue'); ?>"
                   class="btn  <?php echo $status == 'overdue' ? 'btn-primary' : 'btn-default' ?>">
                    <?php _trans('overdue'); ?>
                </a>
            </div>
        </div>

    </div>
</div>

<div id="content" class="table-content">
    <div id="filter_results">
        <?php $this->layout->load_view('invoices_provider/partial_invoice_table', array('invoices' => $invoices_provider)); ?>
    </div>
</div>
