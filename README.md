# Форма контактов для Infrajs
**Disclaimer:** Module is not complete and not ready for use yet.

## Установка через composer.json

```json
{
	"require":{
		"infrajs/contacts":"~1"
	}
}
```

## Использование

```html
<span class="showContacts">Форма контактов</span>
```

```html
<div id="showContacts"><!--Форма покажется тут--></div>
```


## Требования

- Сайт должен работать через [infrajs/controller](https://github.com/infrajs/controller)
- php > 5.4

## Параметры .infra.json

Можно настроить цель для метрики. Срабатывает при любой отправки формы и при успешной и при ошибочной, когда, например, не все поля заполнены. Информация о результате сохраняется в параметрах визита. При успешной отправке в параметрах визита будет ```{ result:true }```
Если всё настроено верно, то в консоли браузера будет сообщение о reachGoal.

```json

{
	"yaCounter":"Номер счётчика метрики",
	"yaGoal":"contacts"
}
```
