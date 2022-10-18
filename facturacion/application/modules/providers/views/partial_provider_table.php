<div class="table-responsive">
    <table class="table table-hover table-striped">
        <thead>
        <tr>
            <th><?php _trans('active'); ?></th>
            <th><?php _trans('provider_name'); ?></th>
            <th><?php _trans('email_address'); ?></th>
            <th><?php _trans('phone_number'); ?></th>
            <th class="amount"><?php _trans('balance'); ?></th>
            <th><?php _trans('options'); ?></th>
        </tr>
        </thead>
        <tbody>
        <?php foreach ($records as $provider) : ?>
            <tr>
				<td>
					<?php echo ($provider->provider_active) ? '<span class="label active">' . trans('yes') . '</span>' : '<span class="label inactive">' . trans('no') . '</span>'; ?>
				</td>
                <td><?php echo anchor('providers/view/' . $provider->provider_id, htmlsc($provider->provider_name)); ?></td>
                <td><?php _htmlsc($provider->provider_email); ?></td>
                <td><?php _htmlsc($provider->provider_phone ? $provider->provider_phone : ($provider->provider_mobile ? $provider->provider_mobile : '')); ?></td>
                <td class="amount"><?php echo format_currency($provider->provider_invoice_balance); ?></td>
                <td>
                    <div class="options btn-group">
                        <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-cog"></i> <?php _trans('options'); ?>
                        </a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="<?php echo site_url('providers/view/' . $provider->provider_id); ?>">
                                    <i class="fa fa-eye fa-margin"></i> <?php _trans('view'); ?>
                                </a>
                            </li>
                            <li>
                                <a href="<?php echo site_url('providers/form/' . $provider->provider_id); ?>">
                                    <i class="fa fa-edit fa-margin"></i> <?php _trans('edit'); ?>
                                </a>
                            </li>
                            <li>
                                <form action="<?php echo site_url('providers/delete/' . $provider->provider_id); ?>"
                                      method="POST">
                                    <?php _csrf_field(); ?>
                                    <button type="submit" class="dropdown-button"
                                            onclick="return confirm('<?php _trans('delete_provider_warning'); ?>');">
                                        <i class="fa fa-trash-o fa-margin"></i> <?php _trans('delete'); ?>
                                    </button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>

<script>
    $(function () {
        $('.add_pdf').click(function () {
        // Display the create quote modal
        $('#add_pdf').modal('show');

        $('.simple-select').select2();

        <?php $this->layout->load_view('providers/script_select2_provider_id.js'); ?>

        // Toggle on/off permissive search on providers names
        $('span#toggle_permissive_search_providers').click(function () {
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
    });
    })
</script>

<div id="add_pdf" class="modal modal-lg" role="dialog" aria-labelledby="modal_addpdf" aria-hidden="true">
<form action='<?php echo site_url() . "/providers/subirpdf";?>' method="post" class="modal-content" enctype="multipart/form-data">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><i class="fa fa-close"></i></button>
            <h4 class="panel-title"><?php _trans('addpdf'); ?></h4>
        </div>
        <div class="modal-body">

            <input class="hidden" id="input_permissive_search_providers"
                   value="<?php echo get_setting('enable_permissive_search_providers'); ?>">

            <div class="form-group has-feedback">
                <label for="addpdf_provider_id"><?php _trans('provider'); ?></label>
                <div class="input-group">
                            <p value="<?php echo $provider->provider_id; ?>"><?php _htmlsc($provider->provider_name); ?></p>

                </div>
            </div>

            <div class="form-group">
                <label for="archivo_id"><?php _trans('archive'); ?>: </label>
                <input type="file" name="archivo_id" id="archivo_id">
            </div>
            <?php _csrf_field(); ?>
        </div>

        <div class="modal-footer">
            <div class="btn-group">
                <button class="btn btn-success" id="subir" type="submit">
                    <i class="fa fa-check"></i> <?php _trans('submit'); ?>
                </button>
                <button class="btn btn-danger" type="button" data-dismiss="modal">
                    <i class="fa fa-times"></i> <?php _trans('cancel'); ?>
                </button>
            </div>
        </div>

    </form>

</div>
