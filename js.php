<?php
namespace infrajs\contacts;
use infrajs\router\Router;
use infrajs\ans\Ans;
use infrajs\config\Config;
use akiyatkin\boo\Cache;

$conf = Config::get('contacts');

if ($conf['reCAPTCHA']) {
	$js = Cache::func( function () {
		return file_get_contents('https://www.google.com/recaptcha/api.js?onload=grecaptchaOnload&render=explicit&hl=ru');
	}, [], ['akiyatkin\boo\Cache','getDurationTime'], array('last friday'));

	$js .= 'window.grecaptchaOnload=function(){ Event.fire("reCAPTCHA") };';

} else {
	$js = '/* reCAPTCHA отключена */';
}

return Ans::js($js);