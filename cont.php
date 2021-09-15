<?php
namespace infrajs\contacts;
use infrajs\path\Path;
use infrajs\ans\Ans;
use infrajs\view\View;
use infrajs\load\Load;
use infrajs\mail\Mail;
use infrajs\template\Template;
use infrajs\router\Router;
use infrajs\access\Access;
use infrajs\config\Config;
use akiyatkin\recaptcha\reCAPTCHA;
use akiyatkin\utm\UTM;

$conf = Config::get('contacts');

$ans = array();
$ans['popup'] = true;
if (empty($_POST['name'])) $persona = '';
else $persona = $_POST['name'];


if (empty($_POST['phone'])) $phone = '';
else $phone = $_POST['phone'];

if (empty($_POST['email'])) $email = '';
else $email = $_POST['email'];

if (empty($_POST['text'])) $text = '';
else $text = $_POST['text'];

if ($conf['terms']) {
	if (empty($_POST['terms'])) return Ans::err($ans, 'Вам нужно принять политику конфиденциальности!');
}

$r = reCAPTCHA::check();
if (!$r) return Ans::err($ans,'Ошибка, не пройдена проверка антибот.');

$key = Ans::GET('key');
if ($key != $conf['key']) return Ans::err($ans,'Ошибка, не пройдена защита от спама.');

if (in_array('name', $conf['required'])) {
	if (strlen($persona) < 2) return Ans::err($ans, 'Уточните, пожалуйста, ваше имя!');
}

if (in_array('email', $conf['required'])) {
	$is_email = Mail::check($email);
	if ($is_email != true) return Ans::err($ans, 'Уточните, пожалуйста, адрес электронной почты!');
}

if (in_array('text', $conf['required'])) {
	if (strlen($text) < 5) return Ans::err($ans, 'Уточните, пожалуйста, текст письма!');
}

if (in_array('phone', $conf['required'])) {
	if (strlen($phone) < 6) return Ans::err($ans, 'Уточните, пожалуйста, номер телефона!');
}



if ($conf['file']) {
	$file = $_FILES['file'];
	$isfile = $file && $file['error'] != 4;

	if (in_array('file', $conf['required'])) {
		if (!$isfile) return Ans::err($ans, 'Приложите файл!');
	}
	if ($isfile) {
		if ($file['error']) {
			if ($file['error'] == 1 || $file['error'] == 1) return Ans::err($ans, 'Приложен слишком большой файл.');
			return Ans::log($ans, 'Ошибка '.$file['error'].'. Извините за неудобства, воспользуйтесь почтовым адресом.');
		}
		
		if ($conf['filesize']) {
			$size = $file['size'] / (1024*1024);
			if ($size>$conf['filesize']) return Ans::err($ans, 'Приложен слишком большой файл. Ограничение '.$conf['filesize'].' Mb');
		}
	}
}
	




$data = $_POST;
$data['post'] 	= $_POST;

$data['email'] 	= $email;
$data['text'] 	= $text;
$data['name'] 	= $persona;
$data['schema'] = View::getSchema();
$data['host']  	= View::getHost();
$data['org']	= @$_POST['org'];
$data['phone']	= @$_POST['phone'];
$data['ip'] 	= $_SERVER['REMOTE_ADDR'];
$data['ref'] 	= $_SERVER['HTTP_REFERER'];
$data['browser'] = $_SERVER['HTTP_USER_AGENT'];
$data['time'] 	= date("F j, Y, g:i a");


$mdata = array();
if (in_array('email', $conf['required'])) {
	$p = explode(',', $data['email']);
	$mdata['email_from'] = $p[0];
} else {
	$mdata['email_from'] = 'noreplay@'.$_SERVER['HTTP_HOST'];
}
$mdata['subject'] = 'Сообщение через форму контактов '.$_SERVER['HTTP_HOST'];

session_start();
if (empty($_SESSION['submit_time'])) $_SESSION['submit_time'] = 0;			
if (time() - $_SESSION['submit_time'] < 30) return Ans::err($ans, 'Письмо уже отправлено! Новое сообщение можно будет отправить через 1 минуту!');

$utms = Ans::REQ('utms');
$data['utms'] = UTM::parse($utms);


$body = Template::parse('-contacts/mail.tpl', $data);
if (!$body) $body = 'Ошибка. Не найден шаблон письма!';


if (!isset($mdata['email_from'])) return Ans::err($ans, 'Ошибка с адресом получателя!');

$r = Mail::html($mdata['subject'], $body, $mdata['email_from'], true);//from to

if ($r) $_SESSION['submit_time'] = time();

if (!$r) return Ans::err($ans,"Не удалось отправить письмо из-за ошибки на сервере!");

return Ans::ret($ans, "Письмо отправлено!<pre><blockquote>".$data['text']."</blockquote></pre>");
