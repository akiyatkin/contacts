{root:}
	Время: {time}<br>
	Организация: {org}<br>
	Контактное лицо: {name}<br>
	E-mail: {email}<br>
	Телефон: {phone}<br>
	Текст письма:<br>
	-------------------<br>
	<pre>{text}</pre>
	-------------------<br>
	Страница: <a href="{ref}">{ref}</a><br>
	IP: {ip}<br>
	Браузер: {browser}<br>
	<table>{utms::utm}</table>
{utm:}
	<tr>
		<td>{~date(:j F Y H:i,time)}</td>
		<td><a href="{referrer}">{referrer}</a></td>
		<td><a href="{href}">{href}</a></td>
	</tr>