window.contacts={
	extlayer:{
		divs:{},
		tplroot:"start",
		external:'-contacts/contacts.layer.json',
		config:{}
	},
	show:function(data){
		var layer = this.popup;
		
		if (!layer.config) layer.config = {};
		layer.config.data = data;

		popup.open(layer);

		Event.one('Layer.onshow', function () {
			infrajs.popup_memorize("contacts.show("+JSON.stringify(data)+")");
		},'', layer);
		
	},
	popup:{},
	layer:{
		onlyclient:true,
		autofocus:true, 
		div:"showContacts",
		divcheck:true
	}
}
contacts.extlayer.onsubmit = function (layer) {
	var config = layer.config;
	var div = $('#'+layer.div);
	if (!config.ans) {
		config.ans = {
			"result":0, 
			"msg":"Произошла ошибка.<br>Cообщение не отправлено..."
		}
	}
	if (config.ans.result) {
		div.find('textarea').val('').change();
	}
	/*
		Перенесено в шаблон
		var conf = Config.get('contacts');
		if (conf.yaCounter) {
			var ya = window['yaCounter' + conf.yaCounter];
			if (ya) {
				console.info('reachGoal');
				ya.reachGoal(conf.yaGoal, config.ans)
			}
		}
	*/
}
contacts.popup.external=contacts.extlayer;
contacts.layer.external=contacts.extlayer;


Event.handler('Controller.onshow',function () {
	$('.showContacts[showContacts!=true]').attr('infra','false').attr('showContacts','true').click( function() {
		var data = $(this).data();
		if ($(this).data('text')) {
			if (!Session.get('user.text')) {
				Session.set('user.text', $(this).data('text'), false, function(){
					contacts.show(data);
				});
			}
		}
		if ($(this).data('replace')) {
			Session.set('user.text', $(this).data('replace'), false, function(){
				contacts.show(data);
			});
		} else {
			contacts.show(data);	
		}
		
		return false;
	});
});