{cont::}-contacts/contacts.tpl
{root:}
<div class="popupblock">
	<style scoped>
		.popupblock {
			padding:20px;
		}
		.popupblock .logoblock {
			padding-bottom: 20px;
		}
		.popupblock h1 {
			font-size: 26px;
			margin-bottom: 15px;
		}
		.popupblock .form-control {
			width: 50%;
		}
	</style>
	{:logo}
	<h1>Заказать звонок</h1>
	<p>Оставьте свой номер и мы перезвоним в рабочее время.</p>
	<form method="post" action="/-contacts/callback/">
		<p><input name="phone" type="tel" class="form-control" placeholder="+7 (999) 999 99 99"></p>

			{~conf.contacts.terms?:cont.terms}
		<button style="margin-bottom:15px" type="submit" class="btn {config.btncls?config.btncls?:btncls} btn-lg">Жду звонка</button>
	</form>
	<script type="module">
		import { reCAPTCHA } from '/vendor/akiyatkin/recaptcha/reCAPTCHA.js'
		import { Context } from '/vendor/infrajs/controller/src/Context.js'
		import { Submit } from '/vendor/infrajs/layer-onsubmit/Submit.js'
		import { Autosave } from '/vendor/infrajs/layer-autosave/Autosave.js'

		let context = new Context("{div}")
		
		reCAPTCHA.init(context, {id})

		let tag = tag => context.div.getElementsByTagName(tag)[0]
		let form = tag('form')
		Submit.init(form, {id})

		Autosave.init("{autosavename}", "{div}");

	</script>
	{config.ans:ans.msg}
</div>
{btncls:}btn-primary
{ans::}-ans/ans.tpl
{terms:}
	<p style="font-size: 80%;">Нажимая кнопку «Жду звонка», Вы соглашаетесь на обработку <a href="/terms">персональных данных</a> в соответствии с ФЗ №152 "О персональных данных".</p>
{logo:}
	<div class="logoblock d-flex justify-content-between align-items-start">
		<div>
			<img class="img-fluid" style="max-height:50px" src="/images/logo.png">
		</div>
		<div style="font-size:18px; cursor: pointer; margin-top:-8px" onclick="Popup.close()"><i class="fas fa-times"></i></div>
	</div>