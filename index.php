<?php
echo "<h1>Página principal</h1><br>";
echo "<a  href='http://mtoffice.com/facturacion'>Ir al dashboard</a><br><br>";
echo "<a href='?actualiza=true'>Actualizar BBDD</a>";

if(isset($_GET['actualiza'])){
        $server_name   = "localhost";
        $username      = "root";
        $database_name = "mtoffice";
        
        $cmd = "mysql -h {$server_name} -u {$username} {$database_name} < ./facturacion/mtoffice.sql";
        exec($cmd);
}
?>