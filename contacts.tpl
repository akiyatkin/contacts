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
	<script type="module">
		import { reCAPTCHA } from '/vendor/akiyatkin/recaptcha/reCAPTCHA.js'
		let context = div.firstElementChild
		reCAPTCHA.init(context, 'contacts')
	</script>
{script:}
	<script type="module">
		import { Form } from '/vendor/akiyatkin/form/Form.js'
		import { Autosave } from '/vendor/akiyatkin/form/Autosave.js'
		import { Goal } from '/vendor/akiyatkin/goal/Goal.js'

		let div = document.getElementById('{div}')
		let context = div.firstElementChild

		let tag = tag => div.getElementsByTagName(tag)[0]
		let form = tag('form')
		Submit.init(form, {id}).then( f => {
			let tag = tag => div.getElementsByTagName(tag)
			if (!context.parentElement) return
			let ta = tag('textarea')[0]
			ta.value = ''
			ta.dispatchEvent(new window.Event('change'))
		})

		Autosave.init("{autosavename}", "{div}");

	</script>
