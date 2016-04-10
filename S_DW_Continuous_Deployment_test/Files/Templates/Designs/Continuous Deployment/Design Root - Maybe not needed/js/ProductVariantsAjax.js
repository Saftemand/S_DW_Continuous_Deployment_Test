/* CLASSES */
function VariantGroup(id, name) { this.Id = id; this.Name = name; this.Options = []; }
function VariantOption(id, name) { this.Id = id; this.Name = name; }
function VariantCombination(id) { this.Id = id; }
function VariantSelector() { this.Groups = []; this.Combinations = []; }

/* FUNCTIONS */
function ByGroupOrder(varid) {
	var vars = [];
	for (g = 0; g < Selector.Groups.length; g++) {
		for (o = 0; o < Selector.Groups[g].Options.length; o++) {
			for (v = 0; v < varid.length; v++) {
				if (Selector.Groups[g].Options[o].Id == varid[v]) {
					vars.push(varid[v]);
				}
			}
		}
	}
	return vars;
}


function PresetCombo(combono, value) {
	document.getElementById('COMBO' + combono).value = value;
	UpdateCombo(combono);
}


function CombinationExist(query) {
	found = false;
	for (ci = 0; ci < Selector.Combinations.length; ci++) {
		combis = Selector.Combinations[ci].Id.split(".");
		queryfoundincombination = true;
		for (q = 0; q < query.length; q++) {
			queryitemfoundincombination = false;
			for (cs = 0; cs < combis.length; cs++) {
				if (combis[cs] == query[q]) queryitemfoundincombination = true;
			}
			if (!queryitemfoundincombination) queryfoundincombination = false;
		}
		if (queryfoundincombination) found = true;
	}
	return found;
}


function FillCombo(combono) {

	ClearCombo(combono);
	
	var selectiontext = "Choose variant";

	var op = document.createElement("option");
	op.text = "@selectiontext";
	op.value = "";
	document.getElementById('COMBO' + combono).options.add(op);

	for (i = 0; i < Selector.Groups[combono].Options.length; i++) {

		option = Selector.Groups[combono].Options[i];
		includeoption = true;

		curcombination = [];
		for (g = 0; g < combono; g++) 
		{
			curcombination.push(document.getElementById('COMBO' + g).value);
		}
		curcombination.push(option.Id);

		includeoption = CombinationExist(curcombination);


		if (includeoption) 
		{
			var op = document.createElement("option");
			op.text = option.Name;
			op.value = option.Id;
			document.getElementById('COMBO' + combono).options.add(op);
			document.getElementById('COMBO' + combono).disabled = false;
		}

	}
}

function ClearCombo(combono) {
	while (document.getElementById('COMBO' + combono).options.length > 0) {
		document.getElementById('COMBO' + combono).options[0] = null;
	}
	document.getElementById('COMBO' + combono).disabled = true;
}

function UpdateCombo(combono) {
	if (combono < Selector.Groups.length - 1) {

		if (document.getElementById('COMBO' + combono).value != "") FillCombo((combono + 1));

		if (combono > -1) {
			fromcombo = (document.getElementById('COMBO' + combono).value == "") ? combono + 1 : combono + 2;
			for (c = fromcombo; c < Selector.Groups.length; c++) {
				ClearCombo(c);
			}
		}
	}
	else 
	{
		if (!presetting && (document.getElementById('COMBO' + (Selector.Groups.length - 1)).value != "")) 
		{
			id = "";
			for (c = 0; c < Selector.Groups.length; c++) {
				id += (c == 0) ? document.getElementById('COMBO' + c).value : "." + document.getElementById('COMBO' + c).value;
			}

			document.location.href = Page + "&VariantID=" + id;

			//Spinner
			var opts = {
			  lines: 9, // The number of lines to draw
			  length: 0, // The length of each line
			  width: 10, // The line thickness
			  radius: 18, // The radius of the inner circle
			  corners: 1, // Corner roundness (0..1)
			  rotate: 0, // The rotation offset
			  direction: 1, // 1: clockwise, -1: counterclockwise
			  color: '#000', // #rgb or #rrggbb or array of colors
			  speed: 1, // Rounds per second
			  trail: 35, // Afterglow percentage
			  shadow: false, // Whether to render a shadow
			  hwaccel: false, // Whether to use hardware acceleration
			  className: 'spinner', // The CSS class to assign to the spinner
			  zIndex: 2e9, // The z-index (defaults to 2000000000)
			  top: '50%', // Top position relative to parent
			  left: '50%' // Left position relative to parent
			};

			var target = document.getElementById('productinfo');
			var spinner = new Spinner(opts).spin(target);
		}
	}
}