
let Contacts = {
	extlayer: {
		divs: {},
		tplroot: "start",
		external: '-contacts/contacts.layer.json',
		config: {}
	},
	show: async function (data) {
		await CDN.on('load','jquery')
		let Layer = (await import('/vendor/infrajs/controller/src/Layer.js')).Layer
		let Popup = (await import('/vendor/infrajs/popup/Popup.js')).Popup 
		var layer = this.popup

		if (!layer.config) layer.config = {};
		layer.config.data = data;

		await Popup.open(layer);
		
		Popup.memorize("import('/vendor/infrajs/contacts/Contacts.js').then(obj => obj.Contacts.show(" + JSON.stringify(data) + "))");

	},
	popup: {},
	layer: {
		onlyclient: true,
		autofocus: true,
		div: "showContacts",
		divcheck: true
	}
}
// Contacts.extlayer.onsubmit = function (layer) {
// 	var config = layer.config;
// 	var div = $('#' + layer.div);
// 	if (!config.ans) {
// 		config.ans = {
// 			"result": 0,
// 			"msg": "Произошла ошибка.<br>Cообщение не отправлено..."
// 		}
// 	}
// 	if (config.ans.result) {
// 		div.find('textarea').val('').change();
// 	}
// }
Contacts.popup.external = Contacts.extlayer;
Contacts.layer.external = Contacts.extlayer;

Contacts.callback_layer = {
	"external": "-contacts/callback/layer.json"
}

globalThis.contacts = Contacts
globalThis.Contacts = Contacts

export { Contacts }

