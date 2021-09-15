{root:}
	<p>
		Время: {time}<br>
		Организация: {org}<br>
		Контактное лицо: {name}<br>
		E-mail: {email}<br>
		Телефон: {phone}<br>
		Текст письма:<br>
	</p>
	<pre>{text}</pre>
	{:ps}
{PHONE:}
	<p>
		Перезвоните по телефону
	</p>
	<pre>{phone}</pre>
	{:ps}
{utm::}-utm/layout.html
{ps:}
	<p>&nbsp;</p>
	<hr>
	<p></p>
	<div style="font-size: 80%;">
		{utms:utm.TABLE}
		<p>
			Страница: <a href="{ref}">{ref}</a><br>
			IP: {ip}<br>
			Браузер: {browser}
		</p>
	</tr>
