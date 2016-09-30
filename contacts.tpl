{root:}
	{:start}
{title:}<h1>Форма для сообщений</h1>
{form:}
	{:body}
	{:script}
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
		<form action="/-contacts/conth.php" method="post">
			
			{:formbody}
			{Config.get(:strcontacts).reCAPTCHA?:reCAPTCHA}
			{config.ans.msg:alert}
			<button type="submit" class="btn btn-default" onclick="if(window.ga)ga('send', 'event', 'Оставить сообщение', 'Клик');">Отправить</button>
		</form>
	</div>
{formbody:}
	<input id="contacts_name" type="hidden" class="form-control"  value="1" name="antispam">
	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label for="contacts_name">Контактное лицо<span>*&nbsp;</span></label>
				<input id="contacts_name" type="text" class="form-control"  value="{name}" name="name">
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="contacts_org">Организация</label>
				<input id="contacts_org" type="text" class="form-control"  value="{org}" name="org">
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label for="contacts_email">Email<span>*</span></label>
				<input id="contacts_email" type="email" class="form-control" value="{email}" name="email">
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="contacts_phone">Телефон<span>*</span></label>
				<input id="contacts_phone" type="tel" class="form-control" value="{phone}" name="phone">
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="contacts_text">Текст письма<span>*</span></label>
		<textarea id="contacts_org" name="text" class="form-control" rows="3"></textarea>
	</div>
{reCAPTCHA:}
	<div style="overflow:hidden;" id="g-recaptcha-{id}-{counter}" style="margin-bottom:10px"></div>
	<script>
		domready(function(){
			Event.one('reCAPTCHA', function () {
				grecaptcha.render('g-recaptcha-{id}-{counter}', {
					"sitekey" :"{Config.get(:strcontacts).reCAPTCHA_sitekey}"
				});
			})
		});
		
	</script>
{strcontacts:}contacts
{script:}
	<script>
		domready(function(){
			if(window.infra&&window.popup)Event.one('Controller.oncheck', function(){
				if (popup.st) infrajs.popup_memorize('contacts.show()');
				var layer=infrajs.ids['{id}'];
				layer.onsubmit = function (layer) {
					var conf=layer.config;
					var div=$('#'+layer.div);
					if (!conf.ans) {
						conf.ans = {
							"result":0, 
							"msg":"Произошла ошибка.<br>Cообщение не отправлено..."
						}
					}
					if(conf.ans.result){
						div.find('textarea').val('').change();
					}
					var config = infra.config('contacts');
					if (config.yaCounter) {
						var ya = window['yaCounter' + config.yaCounter];
						if (ya) {
							console.info('reachGoal');
							ya.reachGoal(config.yaGoal, conf.ans)
						}
					}
				}
			});
		});
	</script>
{alert:}
<div class="alert {..result?:as?:ad}">{.}</b></div>
{as:}alert-success
{ad:}alert-danger
