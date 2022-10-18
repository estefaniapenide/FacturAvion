<div id="headerbar">
    <h1 class="headerbar-title"><?php _trans('modelo303'); ?></h1>
</div>
<nav class="navbar navbar-default text-center">

<form method="post" action="<?php print site_url("modelo303/form"); ?>" class="navbar-form" role="search">
<?php print form_error("year"); ?>
    <input style="width:100px; font-size:30px;" name="year" id="year" type="text" class="form-control" placeholder="2022"  value="<?php print set_value("year"); ?>">
    <input onChange="this.form.submit();" name="trimestre" style="height:35px; width:35px; padding-left: 20px;" type="radio" class="btn btn-default navbar-btn" value="1"/>
    <input onChange="this.form.submit();" name="trimestre" style="height:35px; width:35px;" type="radio" class="btn btn-default navbar-btn" value="2"/>
    <input onChange="this.form.submit();" name="trimestre" style="height:35px; width:35px;" type="radio" class="btn btn-default navbar-btn" value="3"/>
    <input onChange="this.form.submit();" name="trimestre" style="height:35px; width:35px;" type="radio" class="btn btn-default navbar-btn" value="4"/>
</form>

</nav>
<div class="container">
    <div class="table-responsive" style="padding-top:1vw;">
        <h1 class="text-center"> Trimestre <?php echo $quarter . " del año " . $year; ?></h1>
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