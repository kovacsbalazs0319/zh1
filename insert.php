<?php
    session_start();
	require 'db.php';
	$nev = '';
    $eletkor = '';

    $fasz = isset($_SESSION['fasz']) ? $_SESSION['fasz'] : [];
    if(!empty($_GET))
	{
		$db=getDB();
		$nev = $_GET['nev'];
		$eletkor = $_GET['eletkor'];

                
        
        $insertStatement = $db->prepare("INSERT INTO eladok(nev, eletkor) VALUES(:nev, :eletkor)");
                $insertStatement->bindParam(':nev', $nev, PDO::PARAM_STR);
                $insertStatement->bindParam(':eletkor', $eletkor, PDO::PARAM_STR);
                $insertStatement->execute();
                $redirectUrl = "index.php";
                $redirectUrl .= "?" . http_build_query($fasz);
                header("Location: $redirectUrl");
                exit();
    }
?>

<!DOCTYPE html>
<html lang="hu">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
    
        <form action="insert.php" method="get">
            <h1>Új Eladó</h1>
            <p>
                <label>Név: <input type="text" name="nev" value = "<?php echo $nev ?>"/></label>
            </p>
            <p>
                <label>Életkor: <input type="text" name="eletkor" value = "<?php echo $eletkor ?>"/></label>
            </p>
            <p> 
                <input type="submit" value="Elküld" name="uj" />
            </p>
        </form>
    </body>
</html>