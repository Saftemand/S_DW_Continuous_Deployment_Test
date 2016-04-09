contextAreaActive = true;
contextAreaName = "";
function setContextArea(currentState, name) {
	contextAreaActive = (currentState == 'False' ? false : true);
	contextAreaName = name;
}

function sort_init() {
	Position.includeScrollOffsets = true;
	Sortable.create("items", {
		onUpdate: function(element) {
			//sortSave();
		}
	});

}


function sortSave() {
    new Ajax.Request("/Admin/Content/Area/List.aspx", {
        method: 'get',
        parameters: {
            "sort": Sortable.sequence('items').join(','),
            "dt": new Date().getTime()
        },
        onComplete: function (transport) {
            if (parent.left) parent.left.location.reload(true); // From Conext -> page tree
            else parent.parent.left.location.reload(true); // From Modules
            location = "List.aspx";
        }
    });
}