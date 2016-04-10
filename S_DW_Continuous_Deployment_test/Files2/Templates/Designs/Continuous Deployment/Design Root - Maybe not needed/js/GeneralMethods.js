
/* A simple cookie parser */
function getCookie(name){
	var pattern = RegExp(name + "=.[^;]*")
	matched = document.cookie.match(pattern)
	
	if (matched) {
	    var cookie = matched[0].split('=')
	    return cookie[1]
	}
	return false
}


/* Create and merge items from Json */
function CreateItemFromJson(Obj, DivId, Tmpl) {
	/* This part is about making the template replacer dynamic and easy to read */
	var Template = $(Tmpl).html();

	/* Dynamic replacing values in the template */
	for (Property in Obj) {
		Item = Obj[Property];

		var NameKey = "Obj."+Property;
		Template = Template.replace(new RegExp(NameKey, "gi"), Item);
	}

	$(DivId).append(Template);
}