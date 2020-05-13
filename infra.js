import { Event } from '/vendor/infrajs/event/Event.js'
import { Session } from '/vendor/infrajs/session/Session.js'
import { DOM } from '/vendor/akiyatkin/load/DOM.js'
import { CDN } from '/vendor/akiyatkin/load/CDN.js'
import { Popup } from '/vendor/infrajs/popup/Popup.js'
import { Layer } from '/vendor/infrajs/controller/src/Layer.js'

window.contacts = {
	extlayer: {
		divs: {},
		tplroot: "start",
		external: '-contacts/contacts.layer.json',
		config: {}
	},
	show: async function (data) {
		await CDN.load('jquery')
		var layer = this.popup

		if (!layer.config) layer.config = {};
		layer.config.data = data;

		Popup.open(layer);


		Event.one('Layer.onshow', function () {
			Popup.memorize("contacts.show(" + JSON.stringify(data) + ")");
		}, '', layer);

	},
	popup: {},
	layer: {
		onlyclient: true,
		autofocus: true,
		div: "showContacts",
		divcheck: true
	}
}
contacts.extlayer.onsubmit = function (layer) {
	var config = layer.config;
	var div = $('#' + layer.div);
	if (!config.ans) {
		config.ans = {
			"result": 0,
			"msg": "Произошла ошибка.<br>Cообщение не отправлено..."
		}
	}
	if (config.ans.result) {
		div.find('textarea').val('').change();
	}
}
contacts.popup.external = contacts.extlayer;
contacts.layer.external = contacts.extlayer;

contacts.callback_layer = {
	"external": "-contacts/callback/layer.json"
}

DOM.race('show', async () => {
	await CDN.load('jquery');
	$('.showContacts[showContacts!=true]').attr('infra', 'false').attr('showContacts', 'true').click(function () {
		var data = $(this).data();
		if ($(this).data('text')) {
			if (!Session.get('user.text')) {
				Session.set('user.text', $(this).data('text'), false, function () {
					contacts.show(data);
				});
			}
		}
		if ($(this).data('replace')) {
			Session.set('user.text', $(this).data('replace'), false, function () {
				contacts.show(data);
			});
		} else {
			contacts.show(data);
		}
		return false;
	});



	let cls = cls => document.getElementsByClassName(cls)
	let list = cls('showCallback')
	
	for (let i = 0, l = list.length; i < l; i++) {
		let el = list[i]
		if (el.showCallback) continue
		el.showCallback = true
		el.addEventListener('click', async () => {
			let { Popup } = await import('/vendor/infrajs/popup/Popup.js')
			Popup.show(contacts.callback_layer)
		})
	}

});