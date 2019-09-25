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
{terms:}
	<div class="form-group">
		<input type="checkbox" name="terms"> Я принимаю условия <a href="{~conf.contacts.terms}">политики конфиденциальности</a>.
	</div>
{reCAPTCHA:}
	<div style="overflow:hidden;" id="g-recaptcha-{id}-{counter}"></div>
	<script>
		domready(function(){
			Event.one('reCAPTCHA', function () {
				var div = $('#g-recaptcha-{id}-{counter}');
				if (!div.length) return;
				grecaptcha.render('g-recaptcha-{id}-{counter}', {
					"sitekey" :"{Config.get(:strrecaptcha).sitekey}"
				});
			})
		});
		
	</script>
	{strrecaptcha:}recaptcha
{script:}
	<script>
		domready( function () {
			if (window.Event && window.Controller) Event.one('Controller.oncheck', function () {
				if (popup.st) infrajs.popup_memorize('contacts.show()');
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
