{root:}
	{:start}
{title:}<h1>Форма для сообщений</h1>
{breadcrumb:}
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/">Главная</a></li>
		<li class="active breadcrumb-item">Форма для сообщений</li>
	</ol>
{page:}
	{:breadcrumb}
	{:start}
{form:}
	{:body}
	{:script}
{ans::}-ans/ans.tpl
{start:}
	{:title}
	{:body}
	{:script}
{body:}
	<div class="plugin_contacts">
		<style scoped>
			.plugin_contacts label span {
				color:red;
			}
			.plugin_contacts textarea {
				height:102px;
			}
		</style>
		<form action="/-contacts/cont.php" method="post">
			{:formbody}
			<div style="margin-bottom:10px">{~conf.recaptcha?:reCAPTCHA}</div>
			{config.ans:ans.msg}
			{:submit}
		</form>
	</div>
{submit:}<button type="submit" class="btn btn-success">Отправить</button>
{formbody:}
	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label for="contacts_name">Контактное лицо <span>*</span></label>
				<input id="contacts_name" type="text" class="form-control" value="{name}" name="name">
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="contacts_org">Организация</label>
				<input id="contacts_org" type="text" class="form-control" value="{org}" name="org">
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label for="contacts_email">Email <span>*</span></label>
				<input id="contacts_email" type="email" class="form-control" value="{email}" name="email">
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="contacts_phone">Телефон <span>*</span></label>
				<input id="contacts_phone" type="tel" class="form-control" value="{phone}" name="phone">
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="contacts_text">Текст письма <span>*</span></label>
		<textarea id="contacts_text" name="text" class="form-control" rows="3"></textarea>
	</div>
{~conf.contacts.terms?:terms}
{terms2:}
	
	<div class="custom-control custom-checkbox mb-2">
		<input class="custom-control-input" autosave="false" type="checkbox" name="terms" id="customCheck{id}">
		<label class="custom-control-label" for="customCheck{id}"> Я принимаю условия <a href="{~conf.contacts.terms}">политики конфиденциальности</a>.</label>
	</div>
{terms:}
	<div class="custom-control custom-checkbox mb-2">
		<input class="custom-control-input" checked type="checkbox" name="terms" id="customCheck{id}">
		<label class="custom-control-label" for="customCheck{id}"> 
			Я даю согласие на обработку персональных данных, согласно <a href="{~conf.contacts.terms}">политике конфиденциальности</a>.
		</label>
	</div>

{reCAPTCHA:}
	<input type="hidden" name="g-recaptcha-token" class="g-recaptcha-token">
	<script async type="module">
		import { reCAPTCHA } from '/vendor/akiyatkin/recaptcha/reCAPTCHA.js'
		import { Controller } from '/vendor/infrajs/controller/src/Controller.js'	
		import { Layer } from '/vendor/infrajs/controller/src/Layer.js'

		let div = document.getElementById('{div}')
		let tag = tag => div.getElementsByTagName(tag)[0]
		let form = tag('form')
		let layer = Controller.ids[{id}]
		
		let iscontext = () => {
			let layer = Controller.ids[{id}]
			if (!layer) return true
			return layer.counter == {counter}
		}

		Layer.hand('submit', async (l) => {
			if (!iscontext()) return
			if (l != layer) return
			let token = await reCAPTCHA.execute('contacts')
			let inp = document.createElement("input")
			inp.type = "hidden"
			inp.name = "g-recaptcha-token"
			inp.value = token
			form.appendChild(inp)
		})
	</script>
	{strrecaptcha:}recaptcha
{script:}
	<script>
		domready( function () {
			if (window.Event && window.Controller) Event.one('Controller.oncheck', function () {
				var layer = Controller.ids['{id}'];

				Once.exec('contacts.tpl', function () {
					Event.handler('Layer.onsubmit', function (layer) {
						var conf = layer.config;
						var div = $('#'+layer.div);
						if (!conf.ans) {
							conf.ans = {
								"result":0, 
								"msg":"Произошла ошибка.<br>Cообщение не отправлено..."
							}
						}
						if (conf.ans.result) {
							div.find('textarea').val('').change();
						}
					}, '-contacts', layer);
				});

			});
		});
	</script>
