<?php
    session_start();
    require 'db.php';
    $db = getDb();
    $_SESSION['fasz'] = $_GET;
    $fizetesFilter = isset($_GET['fizetes']) ? intval($_GET['fizetes']) : 0;

    $result = $db->query("SELECT arufeltolto.nev as nev, count(kisbolt.ID) as boltokszama, sum(kisbolt.terulet) as osszterulet from 
arufeltolto inner join kisbolt on arufeltolto.ID = kisbolt.arufeltolto_ID
where arufeltolto.fizetes > $fizetesFilter
group by arufeltolto.nev")
?>



<!DOCTYPE html>
<html lang="hu">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ZH1</title>
        <link rel="stylesheet" type="text/css" href="theme.css">   
    </head>
    <body>
        
        
        <h1>Név: Kovács Balázs, Neptun kód: E3BJEG</h1>

        <?php if($fizetesFilter < 100000): ?>
            <h3>Kevés a fizu geci</h3>
        

        <?php else: ?>
        <table>
            <tr>
                <th>Árufeltöltő</th>
                <th>Boltok száma</th> 
                <th>Terület összege</th> 
                
                <?php while ($row = $result->fetchObject()):?>
                    <tr>
                        <td> <?= $row->nev ?> </td>
                        <td> <?= $row->boltokszama ?> </td>
                        <td> <?= $row->osszterulet ?></td>
                    </tr>                
                <?php endwhile; ?>         
            </tr> 
        </table>
        <p>
           <a class="insert-link" href="insert.php">Új elem beszúrása</a>
        </p>
        <?php endif ?>
    </body>
</html>