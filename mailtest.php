<?php
	
	require_once(__DIR__.'../infra/infra.php');
	ini_set("display_errors", 1);
	ob_start();
	$from='noreplay@'.$_SERVER['HTTP_HOST'];
	$headers='From: '.$from."\r\n";
	$headers.="Content-type: text/plain; charset=UTF-8\r\n";
	$headers.='Reply-To: aky@list.ru'."\r\n";
	//echo 'Нативная проверка<br>';
	//$r=mail('info@itlife-studio.ru','Проверка с сервера '.$_SERVER['HTTP_HOST'],'Текст проверочного сообщения',$headers);
	//var_dump($r);




	//return;//нельзя зачастую лимит стоит сколько писем за раз можно отправлять
	//echo '<br>Сложная проверка<br>';
	Path::req('-contacts/mail.php');
	$conf=Config::get();
	$admin=$conf['admin'];
	$ans=array();
	if(!$admin)return Ans::err($ans,'Не найден конфиг');
	if(!$admin['support'])return Ans::err($ans,'У администратора не указан email support');

	$bodydata=array(
		'host'=>$_SERVER['HTTP_HOST'],
		'date'=>date('j.m.Y')
	);
	Path::req('-infra/ext/template.php');
	$body=Template::parse('-contacts/mailtest.tpl',$bodydata);
	$subject='Тестовое письмо';
	$email_from='noreplay@'.$_SERVER['HTTP_HOST'];
	$r=infra_mail_toSupport($subject,$email_from,$body,true);
	
	if(!$r)return Ans::err($ans,'Ошибка. Не удалось отправить тестовое письмо');
	return Ans::ret($ans,'Тестовое письмо отправлено');