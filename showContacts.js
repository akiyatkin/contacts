window.contacts={
	extlayer:{
		divs:{},
		external:'-contacts/contacts.layer.json',
		config:{}
	},
	show:function(){
		var layer = this.popup;
		popup.open(layer);
		
		Event.one('layer.onshow', function () {
			infrajs.popup_memorize('contacts.show()');
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
	var conf = Config.get('contacts');
	if (conf.yaCounter) {
		var ya = window['yaCounter' + conf.yaCounter];
		if (ya) {
			console.info('reachGoal');
			ya.reachGoal(conf.yaGoal, config.ans)
		}
	}
}
contacts.popup.external=contacts.extlayer;
contacts.layer.external=contacts.extlayer;

Event.handler('Controller.onshow',function(){
	$('.showContacts[showContacts!=true]').attr('infra','false').attr('showContacts','true').click(function(){
		if($(this).data('text')){
			if(!infra.session.get('user.text')){
				infra.session.set('user.text',$(this).data('text'));
			}
		}
		contacts.show();
		return false;
	});
});