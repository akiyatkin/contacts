<?php
namespace infrajs\contacts;
use infrajs\router\Router;
use infrajs\ans\Ans;
use infrajs\config\Config;
use infrajs\cache\Cache;

if (!is_file('vendor/autoload.php')) {
	chdir('../../../'); //Согласно фактическому расположению файла
	require_once('vendor/autoload.php');
	Router::init();
}

$conf = Config::get('contacts');

if (!$conf['yaCounter']) {
	$ans['class']='bg-warning';
	$yc = 'Не указан счётчик Яндекс.Метрики с целью contacts. Config.contacts.yaCounter';
} else {
	$yc = 'Яндекс.Метрика указана';
}

if ($conf['reCAPTCHA']) {
	if (empty($conf['reCAPTCHA_secret'])) return Ans::err($ans,'Для reCAPTCHA не указан secret.'.$yc);
	if (empty($conf['reCAPTCHA_sitekey'])) return Ans::err($ans,'Для reCAPTCHA не указан sitekey.'.$yc);
	
} else {
	$ans['class']='bg-warning';
	return Ans::ret($ans,'<a href="https://www.google.com/recaptcha/intro/index.html">reCAPTCHA</a> отключена.'.$yc);
}
return Ans::ret($ans, $yc);