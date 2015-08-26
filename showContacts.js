contacts={
	extlayer:{
		divs:{},
		external:'*contacts/contacts.layer.js',
		config:{}
	},
	show:function(){
		infra.require('*popup/popup.js');
		popup.open(this.popup);
	},
	popup:{},
	layer:{
		onlyclient:true,
		autofocus:true, 
		div:"showContacts",
		divcheck:true
	}
}
contacts.popup.external=contacts.extlayer;
contacts.layer.external=contacts.extlayer;

//infra.when(infrajs,'oninit',function(){//depricated
//	infrajs.checkAdd(contacts.layer);//должна добавиться после того как основные слои добавятся, и при этом участвовать в первой пробежке
//});
infra.listen(infrajs,'onshow',function(){
	$('.showContacts[showContacts!=true]').attr('nohref','1').attr('showContacts','true').click(function(){
		contacts.show();
		return false;
	});
});
