<div id="add-file-provider" class="modal modal-lg" role="dialog" aria-labelledby="add-file-provider" aria-hidden="true">
    <?php log_message("error","entra en el modal"); ?>

    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><i class="fa fa-close"></i></button>
            <h4 class="panel-title"><?php echo 'Prueba';//_trans('delete_invoice_provider'); ?></h4>
        </div>
        <div class="modal-body">

        <div class="col-xs-12 col-md-6">

            <?php $this->layout->load_view('upload_provider/dropzone-invoice-html'); ?>

        </div>

        </div>>

        </div>
        <div class="modal-footer">

           <!-- <form action="<?php echo site_url('invoices_provider/delete/' . $invoice->invoice_provider_id);?>"
                  method="POST">
                <?php _csrf_field(); ?>

                <div class="btn-group">
                     <button type="submit" class="btn btn-danger">
                        <i class="fa fa-trash-o fa-margin"></i> <?php echo trans('confirm_deletion') ?>
                    </button>
                    <a href="#" class="btn btn-default" data-dismiss="modal">
                        <i class="fa fa-times"></i> <?php _trans('cancel'); ?>
                    </a>
                </div>
            </form>-->
            <a href="#" class="btn btn-default" data-dismiss="modal">
                     <i class="fa fa-times"></i> <?php _trans('cancel'); ?>

        </div>
    </div>

</div>
