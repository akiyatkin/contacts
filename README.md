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
## Перезвонить
```js
Popup.show({
	"external":"-contacts/callback/layer.json"
});
```

### file=true
Опция позволяет прикреплять к сообщению файл, который будет сохранён в папке .contacts/ рядом с самим собщением.
Шаблон нужно вручную переопределить и добавить соответствующий input с name="file" и type="file". Дополнительно сообщение также нужно добавить в шаблон письма. В даннык к письму придёт параметр file который будет содержать путь до сохранённого файла. Ограничение на размер файла filesize в мегабайтах.

### data-text и data-replace
Атрибут у тега с ```showContacts``` 
 - ```data-text=""``` - добавляет сообщение в форму контактов если там ещё сообщения нет
 - ```data-replace=""``` - заменяет сообщение в форме контактов на новое