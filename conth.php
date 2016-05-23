<?php
namespace infrajs\contacts;
use infrajs\path\Path;
use infrajs\ans\Ans;
use infrajs\load\Load;
use infrajs\mail\Mail;
use infrajs\template\Template;
use infrajs\router\Router;
use infrajs\config\Config;

if (!is_file('vendor/autoload.php')) {
	chdir('../../../'); //Согласно фактическому расположению файла
	require_once('vendor/autoload.php');
	Router::init();
}

$conf = Config::get('contacts');

$ans = array();

if (empty($_POST['name'])) $persona = '';
else $persona = $_POST['name'];


if (empty($_POST['phone'])) $phone = '';
else $phone = $_POST['phone'];

if (empty($_POST['email'])) $email = '';
else $email = $_POST['email'];

if (empty($_POST['text'])) $text = '';
else $text = $_POST['text'];

if (empty($_POST['antispam'])) $antispam = '';
else $antispam = $_POST['antispam'];
if (!$antispam) return Ans::err($ans, 'Не пройдена проверка антиспам.');

if (in_array('name', $conf['required'])) {
	if (strlen($persona) < 2) return Ans::err($ans, 'Уточние, пожалуйста, вашем имя!');
}



$is_email = Mail::check($email);
if ($is_email != true) return Ans::err($ans, 'Уточните, пожалуйста, адрес электронной почты!');

if (in_array('text', $conf['required'])) {
	if (strlen($text) < 5) return Ans::err($ans, 'Уточните, пожалуйста, текст письма!');
}

if (in_array('phone', $conf['required'])) {
	if (strlen($phone) < 6) return Ans::err($ans, 'Уточните, пожалуйста, номер телефона!');
}

	
session_start();
if (empty($_SESSION['submit_time'])) $_SESSION['submit_time'] = 0;			
if (time() - $_SESSION['submit_time'] < 60) return Ans::err($ans, 'Письмо уже отправлено! Новое сообщение можно будет отправить через 1 минуту!');
$_SESSION['submit_time'] = time();



$data=array();
$data['email']=$email;
$data['text']=$text;
$data['name']=$persona;
$data['post']=$_POST;
$data['org']=@$_POST['org'];
$data['phone']=@$_POST['phone'];
$data['ip']=$_SERVER['REMOTE_ADDR'];
$data['ref']=$_SERVER['HTTP_REFERER'];
$data['browser']=$_SERVER['HTTP_USER_AGENT'];
$data['time']=date("F j, Y, g:i a");



$maildir = Path::resolve('~.contacts/');	
if (!is_dir($maildir)) mkdir($maildir);

$mdata = array();
$p = explode(',', $data['email']);
$mdata['email_from'] = $p[0];
$mdata['subject'] = 'Сообщение через форму контактов '.$_SERVER['HTTP_HOST'];
if (trim(mb_strtolower($data['name'])) == 'itlife') {
	$data['text'] = print_r($mdata,true)."\n\n".$data['text'];
	$mdata['subject'] = 'ПРОВЕРОЧНОЕ '.$mdata['subject'];
	$mdata['testmail'] = true;
} else {
	$mdata['testmail'] = false;
}
$ans['testmail'] = $mdata['testmail'];

$body = Template::parse('-contacts/mail.tpl', $data);
if (!$body) $body = 'Ошибка. Не найден шаблон письма!';

if ($maildir) {
	$arg = $mdata;
	$folder = Path::theme($maildir);
	file_put_contents($folder.date('Y F j H-i').' '.time().'.txt',print_r($body, true)."\n\n\n\n\n".print_r($arg, true));
}

if (!isset($mdata['email_from'])) return Ans::err($ans, 'Ошибка с адресом получателя!');

$r = Mail::toAdmin($mdata['subject'], $mdata['email_from'], $body, $mdata['testmail']);

if (!$r) return Ans::err($ans,"Неудалось отправить письмо из-за ошибки на сервере!");

return Ans::ret($ans, "Письмо отправлено!<blockquote>".$data['text']."</blockquote>");