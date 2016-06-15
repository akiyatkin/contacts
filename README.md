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
	"yaCounter":"Номер счётчика метрики",
	"reCAPTCHA":false,
	"reCAPTCHA_secret":"Секретный ключ",
	"reCAPTCHA_sitekey":"Ключ для сайта"
}
```
Цель для метрики. Срабатывает при любой отправки формы и при успешной и при ошибочной, когда, например, не все поля заполнены. Информация о результате сохраняется в параметрах визита. При успешной отправке в параметрах визита будет ```{ result:true }```
Если всё настроено верно, то в консоли браузера будет сообщение о reachGoal.

В Яндекс.Метрике нужно создать JavaScript цель с идентификатором contacts.

В свойстве required указывается какие поля обязательны для заполнения. Шаблон исправляется отдельно, если нужно убрать звёздочки. Шаблон копируется в корень проекта в папку contacts.

### reCAPTCHA
Необходима получить secret и sitekey https://www.google.com/recaptcha/intro/index.html
