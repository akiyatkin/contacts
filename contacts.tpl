{root:}
	{infra.session.get(:safe.user,~true):start}
{title:}<h1>Форма контактов</h1>
{start:}
	{:title}
	{:body}
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
		<form action="?*contacts/cont.php" method="post">
			<div class="form-group">
				<label for="contactFace">Контактное лицо<span>*&nbsp;</span></label>
				<input type="text" class="form-control"  value="{name}" name="name" placeholder="Контактное лицо">
			</div>
			<div class="form-group">
				<label for="company">Организация</label>
				<input type="text" class="form-control"  value="{org}" name="org" placeholder="Организация">
			</div>
			<div class="form-group">
				<label for="email">Email<span>*</span></label>
				<input type="email" class="form-control" value="{email}" name="email" id="email" placeholder="Ваш почтовый адрес">
			</div>
			<div class="form-group">
				<label for="phone">Телефон<span>*</span></label>
				<input type="tel" class="form-control" value="{phone}" name="phone" id="phone" placeholder="Телефон для связи">
			</div>
			<div class="form-group">
				<label for="textArea">Текст письма<span>*</span></label>
				<textarea name="text" class="form-control" rows="3"></textarea>
			</div>
			{config.ans.msg:alert}
			<button type="submit" class="btn btn-default" onclick="if(window._gaq)_gaq.push(['_trackEvent','Кнопка','Оставить сообщение']);">Отправить</button>
		</form>
	</div>
	<script>
		if(window.infra)infra.wait(infrajs,'oncheck',function(){
			if(popup.st)infrajs.popup_memorize('contacts.show()');
			var layer=infrajs.find('unick','{unick}');
			layer.onsubmit=function(layer){
				var conf=layer.config;
				var div=$('#'+layer.div);
				if(!conf.ans){
					div.find('.answer').html('<b class="alert">Произошла ошибка.<br>Cообщение не отправлено...</b>');
				}
				if(conf.ans.result>0){
					div.find('textarea').val('').change();
				}
			}
		});
	</script>
{alert:}
<div class="alert {..result?:as?:ad}">{.}</b></div>
{as:}alert-success
{ad:}alert-danger
