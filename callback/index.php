<?php
use infrajs\ans\Ans;
use infrajs\mail\Mail;
use infrajs\config\Config;
use akiyatkin\recaptcha\reCAPTCHA;
use infrajs\view\View;
use akiyatkin\utm\UTM;
use infrajs\template\Template;

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
 
if (time() - $_SESSION['submit_time'] < 15) return Ans::err($ans, 'Письмо уже отправлено! Новое сообщение можно будет отправить через 1 минуту!');
$_SESSION['submit_time'] = time();

$subject = 'Заказ обратного звонка';

$data = $_POST;
$data['post'] 	= $_POST;
$data['schema'] = View::getSchema();
$data['host']  	= View::getHost();
$data['phone']	= $phone;
$data['ip'] 	= $_SERVER['REMOTE_ADDR'];
$data['ref'] 	= $_SERVER['HTTP_REFERER'];
$data['browser'] = $_SERVER['HTTP_USER_AGENT'];
$data['time'] 	= date("F j, Y, g:i a");
$utms = ANS::REQ('utms');
$data['utms'] = UTM::parse($utms);

$body = Template::parse('-contacts/mail.tpl', $data, 'PHONE');
if (!$body) $body = 'Ошибка. Не найден шаблон письма!';

$r = Mail::html($subject, $body);
if (!$r) return Ans::err($ans,'Ошибка, письмо менеджеру не отправлено!');

return Ans::ret($ans, 'Менеджер оповещён!');

 
