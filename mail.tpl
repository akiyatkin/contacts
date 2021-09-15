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
	{:ps}
{PHONE:}
	Перезвоните по телефону<br>
	-------------------<br>
	<pre>{phone}</pre>
	-------------------<br>
	{:ps}
{ps:}
	<p></p>
	<hr>
	<p></p>
	<div style="font-size: 80%;">
		<table style="text-align:left">
			<tr><th>Дата</th><th>Запрос</th><th>Откуда</th><th>Куда</th>
			{utms::utm}
		</table>
		<p>
			Страница: <a href="{ref}">{ref}</a><br>
			IP: {ip}<br>
			Браузер: {browser}
		</p>
	</tr>
{utm:}
	<tr>
		<td style="vertical-align: top"><nobr>{~date(:d.m.Y H:i,time)}</nobr></td>
		<td style="vertical-align: top"><i>{q}</i></td>
		<td style="vertical-align: top"><nobr>{referrerhost}</nobr></td>
		<td style="vertical-align: top">{hrefpath}{hrefquery?:quest}{hrefquery}</td>
	</tr>
	{quest:}?