{root:}
	{infra.session.get(:safe.user,~true):start}
{start:}
	<style scoped>
		.plugin_contacts {
			
		}
		.plugin_contacts label {
		
		}
		.plugin_contacts label span {
			color:red;
		}
		.plugin_contacts textarea {
			height:102px;
		}
	</style>
	
	<h1>Форма контактов</h1>
	<div class="plugin_contacts">
		<form action="{infra.theme(:*contacts/cont.php)}" method="post">
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
			

			<!--
			<label>Контактное лицо<span>*&nbsp;</span></label><br> 
			<input value="{name}" name="name" type="text"><br />
			<label>Организация</label>
			<input value="{org}" name="org" type="text"><br />
			<label>Email<span>*</span></label>
			<input value="{email}" name="email" type="email"><br />
			<label>Телефон<span>*</span></label>
			<input value="{phone}" name="phone" type="text"><br />
			<label>Текст письма<span>*</span></label>
			<textarea name="text" cols=35 rows=5></textarea>
			<div class="answer"><b class="alert">{config.ans.msg}</b></div>
			<center class="sub_center">
				<input class="submit" value="Отправить" type="submit"> <br>
			</center>
			-->
			
		</form>
	</div>
	<script>
		infrajs.popup_memorize('contacts.show()');
	</script>
{alert:}
<div class="alert {..result?:alert-success?:alert-danger}">{.}</b></div>