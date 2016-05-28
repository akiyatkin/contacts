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
if ($conf['reCAPTCHA']) {
	$date = date('d.m.Y');
	$js = Cache::exec(array(), __FILE__, function ($date) {
		return file_get_contents('https://www.google.com/recaptcha/api.js?onload=grecaptchaOnload&render=explicit&hl=ru');
	}, array($date));
	$js .= 'window.grecaptchaOnload=function(){ Event.fire("reCAPTHCA") };';

} else {
	$js = '/* reCAPTHCA отключена */';
}

return Ans::js($js);