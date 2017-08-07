# Форма контактов для Infrajs

## Установка через composer.json

```json
{
	"require":{
		"infrajs/infrajs":"~1",
		"infrajs/contacts":"~1"
	}
}
```

## Использование с [infrajs](https://github.com/infrajs/infrajs)
```html
<script type="text/javascript" src="/-collect/?js"></script>
```

Форма во всплывающем окне

```html
<a href="/contacts" class="showContacts">Форма контактов</a>
```

Форма на странице

```html
<div id="form"></div>
<script>
	domready( function () {
		Event.one('Controller.onshow', function () {
			Controller.check({
				"div":"form",
				"tplroot":"form",
				"external":"-contacts/contacts.layer.json"
			});
		});
	});
</script>
```

## Тестирование

В браузере открыть адрес /-contacts/tester.php

## Требования

- php > 5.4

## Параметры .infra.json

```json

{
	"required": ["name","phone","text"],
	"reCAPTCHA":false,
	"reCAPTCHA_secret":"Секретный ключ",
	"reCAPTCHA_sitekey":"Ключ для сайта",
	"file":false
	"filesize":5
}
```
В Яндекс.Метрике и Аналитике нужно создать JavaScript цель с идентификатором contacts в Метрике и Категорией contacts в Analytics (Действие и Ярлык не указываются).

В свойстве required указывается какие поля обязательны для заполнения. Шаблон исправляется отдельно, если нужно убрать звёздочки. Шаблон копируется в корень проекта в папку contacts.

### reCAPTCHA
Необходима получить secret и sitekey https://www.google.com/recaptcha/intro/index.html

### file=true
Опция позволяет прикреплять к сообщению файл, который будет сохранён в папке .contacts/ рядом с самим собщением.
Шаблон нужно вручную переопределить и добавить соответствующий input с name="file" и type="file". Дополнительно сообщение также нужно добавить в шаблон письма. В даннык к письму придёт параметр file который будет содержать путь до сохранённого файла. Ограничение на размер файла filesize в мегабайтах.

### data-text и data-replace
Атрибут у тега с ```showContacts``` 
 - ```data-text=""``` - добавляет сообщение в форму контактов если там ещё сообщения нет
 - ```data-replace=""``` - заменяет сообщение в форме контактов на новое