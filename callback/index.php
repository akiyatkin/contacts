<?php
use infrajs\ans\Ans;
use infrajs\mail\Mail;
use infrajs\config\Config;
use akiyatkin\recaptcha\reCAPTCHA;

if (isset($_POST["phone"])) {
	$phone = $_POST["phone"];
} else {
	$phone = '';
}

$ans = array();

$contconf = Config::get('contacts');
if (!empty($contconf['terms'])) {
	if (empty($_REQUEST['terms'])) return Ans::err($ans, 'Вам нужно принять политику конфиденциальности!');
}
$ans['phone'] = $phone;
if (strlen($phone) < 6 ) return Ans::err($ans,'Уточните ваш телефон!');

$r = reCAPTCHA::check();
if (!$r) return Ans::err($ans,'Ошибка, не пройдена защита от спама!');

session_start();
if (!isset($_SESSION['submit_time'])) $_SESSION['submit_time'] = 0;
 
if (time() - $_SESSION['submit_time'] < 30) return Ans::err($ans, 'Письмо уже отправлено! Новое сообщение можно будет отправить через 1 минуту!');
$_SESSION['submit_time'] = time();

$subject = 'Заказ обратного звонка';
$body = "Перезвоните по телефону<br>".$phone;


$utms = ANS::REQ('utms');
$utms = json_decode($utms, true);
if (!is_array($utms)) $utms = [];
$body.="<table>";
foreach ($utms as $utm) {
	$body.= "<tr>";
	$body.= "<td>";
	$body.= date('Y.m.d H:i', $utm['time']);
	$body.= "</td>";
	$body.= "<td>";
	$body.= $utm['referrer'];
	$body.= "</td>";
	$body.= "<td>";
	$body.= $utm['href'];
	$body.= "</td>";
	$body.= "</tr>";
}	
$body.='</table>';


$from = "noreplay@".$_SERVER["HTTP_HOST"];
			//($subject, $body, $replay_to, $email_to, $debug = false) { //from to
$r = Mail::html($subject, $body);
if (!$r) return Ans::err($ans,'Ошибка, письмо менеджеру не отправлено!');

return Ans::ret($ans, 'Менеджер оповещён!');

 
