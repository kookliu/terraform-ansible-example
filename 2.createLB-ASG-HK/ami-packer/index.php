<?php
$time = microtime();
$time = explode(' ', $time);
$time = $time[1] + $time[0];
$start = $time;
?>

<!DOCTYPE html>
<html>
<body>
<div align="center">

<h1 style="font-family:verdana;">CPU Stress test Page</h1>

<p style="font-family:verdana;font-size:130%;color:black">
<?php
echo "This machine is: ";
echo gethostname();
?>

</p>
<?php
$EC2_AZ=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`;
if ($EC2_AZ == 'ap-east-1a') $COLOR="blue";
if ($EC2_AZ == 'ap-east-1b') $COLOR="green";
if ($EC2_AZ == 'ap-east-1c') $COLOR="red";
echo '<p style="font-family:verdana;font-size:180%;color:'.$COLOR.'">'.$EC2_AZ;
?>
</p>

<br><br><br>
<p style="font-family:verdana;font-size:120%;color:black">
CPU Stress test performed.
</p>
<?php
// CPU stress test
for($i = 0; $i < 10000000; $i++) {
     $a += $i;
}
?>

<?php
$time = microtime();
$time = explode(' ', $time);
$time = $time[1] + $time[0];
$finish = $time;
$total_time = round(($finish - $start), 4);
echo '<p style="font-family:verdana;font-size:90%;color:black">';
echo 'Page generated in '.$total_time.' seconds.';
echo '</p>';
?>

</div>

<script type="text/javascript">
	// Refresh this page in 2 seconds
	setTimeout(function(){
		location.reload();
	}, 2000);
</script>

<br><br><br><br>
<p style="font-family:verdana;font-size:120%;color:black;text-align:center">
Current CPU Stress status.
</p>
<?php
$output = shell_exec('top -b -n 1 | head -5');
echo "<pre align=center>$output</pre>";
?>


<br><br><br><br>
<?php
if ($_GET['run']) {
  # This code will run if ?run=true is set.
  exec("/var/www/html/burnCPU.sh");
}
?>
<p style="font-family:verdana;font-size:120%;color:red;text-align:center">
<a href="?run=true">Start Burning  CPU!!!!</a>
</p>

</body>
</html>


