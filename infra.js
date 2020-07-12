import { } from '/vendor/infrajs/memcode/infra.js'
import { } from '/vendor/akiyatkin/form/infra.js'
import { DOM } from '/vendor/akiyatkin/load/DOM.js'
import { Contacts } from '/vendor/infrajs/contacts/Contacts.js'

let cls = cls => document.getElementsByClassName(cls)
let ws = new WeakSet() 
DOM.done('load', () => {
	
	let list = cls('showContacts')
	for (let el of cls('showContacts')) {
		if (ws.has(el)) continue
		ws.add(el)
		if (el.tagName == 'A') el.dataset.crumb = 'false'
		el.addEventListener('click', async event => {
			event.preventDefault();
			let Session = (await import('/vendor/infrajs/session/Session.js')).Session
			if (el.dataset.text) {
				if (!Session.get('user.text')) {
					Session.set('user.text', el.dataset.text, false, function () {
						Contacts.show(el.dataset);
					});
				}
			} else if (el.dataset.replace) {
				Session.set('user.text', el.dataset.replace, false, function () {
					Contacts.show(el.dataset)
				})
			} else {
				Contacts.show(el.dataset)
			}
		})
	}

	list = cls('showCallback')
	for (let el of list) {
		if (ws.has(el)) continue
		ws.add(el)
		if (el.tagName == 'A') el.dataset.crumb = 'false'
		el.addEventListener('click', async event => {
			event.preventDefault();
			let { Popup } = await import('/vendor/infrajs/popup/Popup.js')
			Popup.show(Contacts.callback_layer)
		})
	}




})