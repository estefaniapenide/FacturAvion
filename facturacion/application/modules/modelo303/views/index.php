<div id="headerbar">
    <h1 class="headerbar-title"><?php _trans('modelo303'); ?></h1>
</div>

<div class="container">
    <div class="table-responsive" style="padding-top:1vw;">
        <table class="table table-hover table-striped">
            <thead class="thead-primary">
                <tr>
                    <th style="font-size:1vw;"><?php _trans('baseimponible'); ?></th>
                    <th style="font-size:1vw;" class="text-right"><?php _trans('cantidad'); ?></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="font-size:1vw;"><?php _trans('totalbaseemitidas'); ?></td>
                    <?php log_message("error",print_r($baseemitidas,true));?>
                    <td style="font-size:1vw;" class="text-right"><?php echo $baseemitidas->subtotal ?> €</td>
                </tr>
                <tr>
                    <td style="font-size:1vw;"><?php _trans('totalbaserecibidas'); ?></td>
                    <td style="font-size:1vw;" class="text-right"><?php echo $baserecibidas->subtotal ?> €</td>
                </tr>
            </tbody>
        </table>
        <div class="table-responsive" style="padding-top:5%;">
            <table class="table table-hover table-striped">
                <thead class="thead-primary">
                    <tr>
                        <th style="font-size:1vw;"><?php _trans('totalivarecibidas'); ?></th>
                        <th style="font-size:1vw;" class="text-right"><?php _trans('cantidad'); ?></th>
                    </tr>
                </thead>
                <tbody>
                <?php 
                    foreach ($ivaemitidas as $row) {
                        echo '<tr>
                        <td style="font-size:1vw;">' . $row->tipoiva . '</td>
                        <td style="font-size:1vw;"class="text-right">' . $row->totaltipoiva . ' €</td>
                    </tr>';
                    }
                ?>
                </tbody>
            </table>
        </div>
        <div class="table-responsive" style="padding-top:5%;">
            <table class="table table-hover table-striped">
                <thead class="thead-primary">
                    <tr>
                        <th style="font-size:1vw;"><?php _trans('totalivaemitidas'); ?></th>
                        <th style="font-size:1vw;" class="text-right"><?php _trans('cantidad'); ?></th>
                    </tr>
                </thead>
                <tbody>
                <?php 
                    foreach ($ivarecibidas as $row) {
                        echo '<tr>
                        <td style="font-size:1vw;">' . $row->tipoiva . '</td>
                        <td style="font-size:1vw;"class="text-right">' . $row->totaltipoiva . ' €</td>
                    </tr>';
                    }
                ?>
                </tbody>
            </table>
        </div>
    </div>